Return-Path: <SRS0=15sK=ZE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855FC43331
	for <linux-media@archiver.kernel.org>; Tue, 12 Nov 2019 09:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867BA206BA
	for <linux-media@archiver.kernel.org>; Tue, 12 Nov 2019 09:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLJx0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:53:26 -0500
Received: from gofer.mess.org ([88.97.38.141]:42017 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfKLJx0 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Nov 2019 04:53:26 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id CE6AFC633D; Tue, 12 Nov 2019 09:53:24 +0000 (GMT)
Date:   Tue, 12 Nov 2019 09:53:24 +0000
From:   Sean Young <sean@mess.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
Subject: Re: [PATCH 5/5] dvb-usb/dvb-usb-urb.c: initialize actlen to 0
Message-ID: <20191112095324.GD19449@gofer.mess.org>
References: <20191112092228.15800-1-hverkuil-cisco@xs4all.nl>
 <20191112092228.15800-6-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112092228.15800-6-hverkuil-cisco@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Nov 12, 2019 at 10:22:28AM +0100, Hans Verkuil wrote:
> This fixes a syzbot failure since actlen could be uninitialized,
> but it was still used.
> 
> Syzbot link:
> 
> https://syzkaller.appspot.com/bug?extid=6bf9606ee955b646c0e1
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reported-and-tested-by: syzbot+6bf9606ee955b646c0e1@syzkaller.appspotmail.com
> CC: Sean Young <sean@mess.org>

Thanks, looks good.

Acked-by: Sean Young <sean@mess.org>

Sean

> ---
>  drivers/media/usb/dvb-usb/dvb-usb-urb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb-urb.c b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
> index c1b4e94a37f8..2aabf90d8697 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb-urb.c
> +++ b/drivers/media/usb/dvb-usb/dvb-usb-urb.c
> @@ -12,7 +12,7 @@
>  int dvb_usb_generic_rw(struct dvb_usb_device *d, u8 *wbuf, u16 wlen, u8 *rbuf,
>  	u16 rlen, int delay_ms)
>  {
> -	int actlen,ret = -ENOMEM;
> +	int actlen = 0, ret = -ENOMEM;
>  
>  	if (!d || wbuf == NULL || wlen == 0)
>  		return -EINVAL;
> -- 
> 2.24.0
