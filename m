Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA7C43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 11:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3D8206C1
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 11:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b+1A76ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfD1LRS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 07:17:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36332 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfD1LRS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 07:17:18 -0400
Received: from pendragon.ideasonboard.com (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 232872D1;
        Sun, 28 Apr 2019 13:17:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556450236;
        bh=d8Qpe9g1sUuyq2gdGVv1YTl0pLxsYj68hVn+duguwiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+1A76ua1SEyiVpwIcOUJDmgqo8MnH8ZobK7CKnfIYQ+wGLAkqKT601JOlHTcEnIX
         MFyuauSorrJrKz+mMi+1iuBitqKbhb/ib9n1y/oK84QUR5uS3viqz4vzsAnVb6jiUg
         D1rpLmZpVhhONPFOhM968oNyqRGhj5HtYHoGcYCQ=
Date:   Sun, 28 Apr 2019 14:17:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Torleiv Sundre <torleiv@huddly.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH] media: uvcvido: Include streaming interface number in
 debugfs dir name
Message-ID: <20190428111704.GA12066@pendragon.ideasonboard.com>
References: <20190428052113.32650-1-torleiv@huddly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190428052113.32650-1-torleiv@huddly.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Torleiv,

Thank you for the patch.

In the subject line uvcvido should be written uvcvideo.

On Sun, Apr 28, 2019 at 07:21:13AM +0200, Torleiv Sundre wrote:
> uvcvideo creates a debugfs directory based on the device bus number and
> device number. If a device contains more than one uvc function, the
> creation of the second and following debugfs directories will fail and
> print an info message like this:
>   "uvcvideo: Unable to create debugfs 3-2 directory."
> 
> This patch includes the uvc streaming interface number in the debugfs
> directory name, to make sure it is unique. The directory name format is
> changed from "<busnum>-<devnum>" to "<busnum>-<devnum>-<intfnum>"

Good idea. Please see below for a few comments.

> Signed-off-by: Torleiv Sundre <torleiv@huddly.com>
> ---
>  drivers/media/usb/uvc/uvc_debugfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_debugfs.c b/drivers/media/usb/uvc/uvc_debugfs.c
> index 77e7c2419b9b..6e244acb80ab 100644
> --- a/drivers/media/usb/uvc/uvc_debugfs.c
> +++ b/drivers/media/usb/uvc/uvc_debugfs.c
> @@ -84,7 +84,8 @@ void uvc_debugfs_init_stream(struct uvc_streaming *stream)
>  	if (uvc_debugfs_root_dir == NULL)
>  		return;
>  
> -	sprintf(dir_name, "%u-%u", udev->bus->busnum, udev->devnum);
> +	sprintf(dir_name, "%u-%u-%d", udev->bus->busnum, udev->devnum,
> +		stream->intfnum);

intfnum should never be negative, I would thus use %u instead of %d.
Furthermore, the dir_name buffer is 32 bytes long, so if something
really wrongs happen and the three variables end up being very large,
sprintf could overflow (10 chars for each value, 2 for the dashes, 1
for the ending \0). I propose extending dir_name to 33 bytes, and using
snprintf() instead of sprintf() to be on the safe side.

 {
 	struct usb_device *udev = stream->dev->udev;
 	struct dentry *dent;
-	char dir_name[32];
+	char dir_name[33];

 	if (uvc_debugfs_root_dir == NULL)
 		return;

-	sprintf(dir_name, "%u-%u", udev->bus->busnum, udev->devnum);
+	snprintf(dir_name, sizeof(dir_name), "%u-%u-%u", udev->bus->busnum,
+		 udev->devnum, stream->intfnum);

 	dent = debugfs_create_dir(dir_name, uvc_debugfs_root_dir);
 	if (IS_ERR_OR_NULL(dent)) {

With those changes,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If you're fine with the changes there's no need to resubmit, I'll apply
the modified patch.

>  
>  	dent = debugfs_create_dir(dir_name, uvc_debugfs_root_dir);
>  	if (IS_ERR_OR_NULL(dent)) {

-- 
Regards,

Laurent Pinchart
