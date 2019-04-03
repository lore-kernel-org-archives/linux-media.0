Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D8C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 20:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48502084B
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 20:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDCULq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:11:46 -0400
Received: from gofer.mess.org ([88.97.38.141]:49069 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCULq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 16:11:46 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8B9686020F; Wed,  3 Apr 2019 21:11:44 +0100 (BST)
Date:   Wed, 3 Apr 2019 21:11:44 +0100
From:   Sean Young <sean@mess.org>
To:     Peter Holik <peter@holik.at>
Cc:     linux-media@vger.kernel.org
Subject: Re: print frequency debug only if dvb_frontend_debug is enables
Message-ID: <20190403201144.vgn7ah2pr5edn4uk@gofer.mess.org>
References: <847c358871c711d2e8735a928cff1095.squirrel@webmail.it-technology.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847c358871c711d2e8735a928cff1095.squirrel@webmail.it-technology.at>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Mar 28, 2019 at 11:44:00AM +0100, Peter Holik wrote:
> Hi!
> 
> Every transponder switch from my vdr causes this debug message "frequency interval: tuner: ..., frontend: ..." in syslog.
> 
> I think this should only happen if dvb_frontend_debug parameter is set.
> 
> cu Peter

You need a Signed-off-by: line.

Please read

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

For how a patch should be submitted.

> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
> @@ -917,8 +917,9 @@
>  			 "DVB: adapter %i frontend %u frequency limits undefined - fix the driver\n",
>  			 fe->dvb->num, fe->id);
>  
> -	dprintk("frequency interval: tuner: %u...%u, frontend: %u...%u",
> -		tuner_min, tuner_max, frontend_min, frontend_max);
> +	if (dvb_frontend_debug)
> +		dprintk("frequency interval: tuner: %u...%u, frontend: %u...%u",
> +			tuner_min, tuner_max, frontend_min, frontend_max);

This should be replaced with dev_dbg(). Actually, all instances dprintk()
should be replaced with dev_dbg() and dvb_frontend_debug removed.
  
>  	/* If the standard is for satellite, convert frequencies to kHz */
>  	switch (c->delivery_system) {



Sean
