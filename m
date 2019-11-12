Return-Path: <SRS0=15sK=ZE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF95C43331
	for <linux-media@archiver.kernel.org>; Tue, 12 Nov 2019 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B6F20656
	for <linux-media@archiver.kernel.org>; Tue, 12 Nov 2019 09:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLJvb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:51:31 -0500
Received: from gofer.mess.org ([88.97.38.141]:37827 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfKLJvb (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Nov 2019 04:51:31 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 22D08C633D; Tue, 12 Nov 2019 09:51:30 +0000 (GMT)
Date:   Tue, 12 Nov 2019 09:51:30 +0000
From:   Sean Young <sean@mess.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/5] dvb-usb/digitv: initialize key[]
Message-ID: <20191112095130.GC19449@gofer.mess.org>
References: <20191112092228.15800-1-hverkuil-cisco@xs4all.nl>
 <20191112092228.15800-5-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112092228.15800-5-hverkuil-cisco@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Nov 12, 2019 at 10:22:27AM +0100, Hans Verkuil wrote:
> The key array was not initialized to 0, leading to a syzbot failure.
> 
> Syzbot link:
> 
> https://syzkaller.appspot.com/bug?extid=6bf9606ee955b646c0e1
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reported-by: syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
> CC: Sean Young <sean@mess.org>

Same as:

https://patchwork.linuxtv.org/patch/59984/

Sean
> ---
>  drivers/media/usb/dvb-usb/digitv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
> index dd5bb230cec1..72b22409880a 100644
> --- a/drivers/media/usb/dvb-usb/digitv.c
> +++ b/drivers/media/usb/dvb-usb/digitv.c
> @@ -231,7 +231,7 @@ static struct rc_map_table rc_map_digitv_table[] = {
>  static int digitv_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
>  {
>  	int i;
> -	u8 key[5];
> +	u8 key[5] = { 0 };
>  	u8 b[4] = { 0 };
>  
>  	*event = 0;
> -- 
> 2.24.0
