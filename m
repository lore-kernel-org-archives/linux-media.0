Return-Path: <SRS0=AJrZ=SI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D39C10F06
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7968921855
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 07:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554534572;
	bh=du7CsEalDHqypjqbZIO1Z2zxG1NwQqTQ9aBhEKKi69Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pSy7Br6hPKA4rB5A9LbCAnVvDQgnbslbs5HDf/16+BqfTwMRNsjFmQXLLndaf52bq
	 6+bkhdLb4/XxNqq2x9RfqphdSMLwoczjjg0SBsGdF1bvo8qKXjHjHsvym8s5TtXO02
	 4Rb7XkBGPelEvxNoHmFB53xYW+KWazm3/h9N3Rsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDFHJb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:09:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37010 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDFHJb (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 6 Apr 2019 03:09:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so4259711pgc.4;
        Sat, 06 Apr 2019 00:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JTOvhqFuYxhmN2RdqP1V1OyLovKb2sADnmPi8oTzFU0=;
        b=Iep3melAv6gngGoesHsb5AmvLMGNxdCoumvQ/wC6zYyvHN7RnImRZdFycxh9fILwB8
         DB5di+Hlr4ji0NNclwpKacNAzNCBLAPXDi1fb3DJwvSh2I5iPbRaG/Yr2A7/1mO93D8T
         3oQ7qMuCKavsclRxRso28yGPrFi3kH7cHk1xmbmSQmgHxhOurZXexHMlgLjB1DpD2WCU
         M6Jm84jmp6tpPsiYotSDC6P8B1uvJAaXbJVx0x9lr+xK5fn2flTsMHZCgI4+iUmR6ZGO
         CrEBrRx+bF2iO5AjVilsp4zgTbhomZlzylN0YMcYiU9IbLzqKNUf2Ri1vMIUSeQh7RXM
         m+dQ==
X-Gm-Message-State: APjAAAXMIGm3+lUr2ODCGREqqNQK02YqQUGNe5GhHcbz4IOuTcbUL4WK
        1glZ2NNTovUTBZ/346Bctw==
X-Google-Smtp-Source: APXvYqzhSJtkF68SMXsLvfVkcFztYQ6kfMQ5wBSlwpQfBwQ6/kdhI6YA23t5P7P2ybhwqeSoejJI5A==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr16678748pga.37.1554534570199;
        Sat, 06 Apr 2019 00:09:30 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id w23sm25621491pgj.72.2019.04.06.00.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 00:09:29 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:09:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 10/13] media: dt-bindings: tvp5150: cleanup bindings
 stlye
Message-ID: <20190406070927.GA3106@bogus>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-11-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405060317.11240-11-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri,  5 Apr 2019 08:03:14 +0200, Marco Felsch wrote:
> Use underlines to highlight optional and required properties. This is
> quite common for all bindings. Align descriptions and start sentence
> with uppercase letter. Also reword the usage of the required
> endpoint properties for the output port in case BT.656 should be used.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/media/i2c/tvp5150.txt | 30 +++++++++++--------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
