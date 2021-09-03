Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F74C433F5
	for <linux-media@archiver.kernel.org>; Fri,  3 Sep 2021 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A887E60E77
	for <linux-media@archiver.kernel.org>; Fri,  3 Sep 2021 10:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349056AbhICKMC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349006AbhICKMB (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 3 Sep 2021 06:12:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EFBE601FA;
        Fri,  3 Sep 2021 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630663862;
        bh=/7OPMHyqDFeQeZbGTvfWjtzxc9g2MvAMhh4CdXl7IZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/cragPoCyyqr4DP9nR/mDCR8SaO0DAmpUrl2rnZ4XkgshsiA6KchJo61lm3f80gj
         x3kuQ0n6w1fgcxTkKREQIoUub4eCGQ7N1Fk7nwFqETcCi5jg6vGawmq5JnG+8o88+s
         0qLxU0hPDasKlOmvJg2DfxoGQfd83jEKUXjgv8JamxxJNefP7aHHJbmLLUN0awPA35
         2kWRn6pRsyaoAi2cwshy4wwlBA3WDNSY0NkmUv5LLwK5262hs/D6/rsMT+SrxWODLr
         Q97A5DhDgZdmQhxV+y/PUrDQ7JHtxwjXpx3lWnPZqDeV0QMivxwnseGYdXsOg/3zr+
         SUdyjWfuN9xmw==
Date:   Fri, 3 Sep 2021 12:10:57 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v10 13/21] media: uvcvideo: Use control names from
 framework
Message-ID: <20210903121057.7279d964@coco.lan>
In-Reply-To: <20210618122923.385938-14-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
        <20210618122923.385938-14-ribalda@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 18 Jun 2021 14:29:15 +0200
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 9cdd30eff495..28ccaa8b9e42 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -40,7 +40,13 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  		return -ENOMEM;
>  
>  	map->id = xmap->id;
> -	memcpy(map->name, xmap->name, sizeof(map->name));
> +	/* Non standard control id. */
> +	if (v4l2_ctrl_get_name(map->id) == NULL) {
> +		map->name = kmemdup(xmap->name, sizeof(xmap->name),
> +				    GFP_KERNEL);

Where are you de-allocating it at driver removal/unbind?

Thanks,
Mauro
