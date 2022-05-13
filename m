Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794CC433F5
	for <linux-media@archiver.kernel.org>; Fri, 13 May 2022 16:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382365AbiEMQUs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 May 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382362AbiEMQUp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 May 2022 12:20:45 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A5E0F6
        for <linux-media@vger.kernel.org>; Fri, 13 May 2022 09:20:43 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id AB88C101BDF; Fri, 13 May 2022 17:20:41 +0100 (BST)
Date:   Fri, 13 May 2022 17:20:41 +0100
From:   Sean Young <sean@mess.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH] iguanair: no superfluous usb_unlink_urb()
Message-ID: <Yn6FWePGyTw+QwRH@gofer.mess.org>
References: <20220512125000.8340-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512125000.8340-1-oneukum@suse.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, May 12, 2022 at 02:50:00PM +0200, Oliver Neukum wrote:
> Unlinking yourself while the completion handler
> is running is a NOP. Drop it.

Applied, thanks!

Sean

> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/media/rc/iguanair.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/rc/iguanair.c b/drivers/media/rc/iguanair.c
> index c9cb8277723f..276bf3c8a8cb 100644
> --- a/drivers/media/rc/iguanair.c
> +++ b/drivers/media/rc/iguanair.c
> @@ -149,10 +149,8 @@ static void iguanair_rx(struct urb *urb)
>  		return;
>  
>  	ir = urb->context;
> -	if (!ir) {
> -		usb_unlink_urb(urb);
> +	if (!ir)
>  		return;
> -	}
>  
>  	switch (urb->status) {
>  	case 0:
> @@ -161,7 +159,6 @@ static void iguanair_rx(struct urb *urb)
>  	case -ECONNRESET:
>  	case -ENOENT:
>  	case -ESHUTDOWN:
> -		usb_unlink_urb(urb);
>  		return;
>  	case -EPIPE:
>  	default:
> -- 
> 2.35.3
