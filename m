Return-Path: <SRS0=wJ9n=2Q=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB6C2D0DA
	for <linux-media@archiver.kernel.org>; Thu, 26 Dec 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB792075E
	for <linux-media@archiver.kernel.org>; Thu, 26 Dec 2019 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLZR3j (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:29:39 -0500
Received: from gofer.mess.org ([88.97.38.141]:40563 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfLZR3j (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Dec 2019 12:29:39 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 09B34C637A; Thu, 26 Dec 2019 17:29:37 +0000 (GMT)
Date:   Thu, 26 Dec 2019 17:29:37 +0000
From:   Sean Young <sean@mess.org>
To:     Bodo Eggert <7eggert@gmx.de>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH] serial_ir: change "ignoring spike" to debug level
Message-ID: <20191226172937.GB24174@gofer.mess.org>
References: <20191225180256.4069-1-7eggert@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225180256.4069-1-7eggert@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On Wed, Dec 25, 2019 at 07:02:56PM +0100, Bodo Eggert wrote:
> At least on my system with a self-made IR receiver, my kernel log is filled with:
> serial_ir serial_ir.0: ignoring spike: 1 1 1419988034627194ns 1419956080709377ns
> 
> These messages happen at random and do not prevent the receiver from
> working. Also I cannot change the features of the IC, therefore they are not
> useful. Probably they are not useful at all.
> 
> However they fill the console, they accumulate and fill the dmesg log, by
> doing this, they prevent me from seeing important message.

I think this patch is right, but it needs a Signed-off-by: line.

See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Thanks,

Sean

> ---
>  drivers/media/rc/serial_ir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
> index 7652e982173f..d77507ba0fb5 100644
> --- a/drivers/media/rc/serial_ir.c
> +++ b/drivers/media/rc/serial_ir.c
> @@ -353,7 +353,7 @@ static irqreturn_t serial_ir_irq_handler(int i, void *blah)
>  			dcd = (status & hardware[type].signal_pin) ? 1 : 0;
>  
>  			if (dcd == last_dcd) {
> -				dev_err(&serial_ir.pdev->dev,
> +				dev_dbg(&serial_ir.pdev->dev,
>  					"ignoring spike: %d %d %lldns %lldns\n",
>  					dcd, sense, ktime_to_ns(kt),
>  					ktime_to_ns(serial_ir.lastkt));
> -- 
> 2.24.0
