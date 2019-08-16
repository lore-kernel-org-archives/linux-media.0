Return-Path: <SRS0=dofk=WM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB7C3A59D
	for <linux-media@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224412171F
	for <linux-media@archiver.kernel.org>; Fri, 16 Aug 2019 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565989282;
	bh=c6NQDNnc/i85WP3fIZEeBh9bDBka+iawFPAqtLQA59Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EZuAT3eNUsNCl2cpE3KwV9x58CSTcENNy6Z/jFqlWYodl31WkIX6inPSHSHmeqgIw
	 Wxr+m5Dgtj2O1luDTc6HlsXy3Br/QTg/+o13/cE7xJqhirs3z6HYRV+QdNCrq7Sxqp
	 vWVWdKSFdv65S7b6zf50IvjBPS3LD/Lc8jlc5TII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHPVBV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:01:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41207 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVBV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 16 Aug 2019 17:01:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so5761842oia.8;
        Fri, 16 Aug 2019 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uh4pN3vCs38E9+F3bdhotAeZpSJVUEJkKLuiueorFIQ=;
        b=YPafPTddeXXPHgR63UsGUD9a3pAafIgCWL+PSSnIkg87bIyZRHKsrmoUDxuV/NY5+y
         eMWH/EnaU5EmR3Uaddic7YllbEuI7uVb+lsGbVHwsEkB5hkswsOGo5uVimGlKdAD55/2
         FyGycoQOlZbvKM5x2Z+pIwfIaOiROm4p7mowRQBl1va0Dgp9wM0Mn8TRa5HZu2Iio/sL
         3Et93cDNsV4HUjDpbIfH136rM2PDX+SmheJCHydvAKg5QJlL4QdsKJrOcUP3olkYRWRi
         PZFWbWoS/EIwyf7nWge47h1ilAZF2LuYmhYtiAufVhmZm3QttZscvClFSBLOKP0/7wXG
         VrPQ==
X-Gm-Message-State: APjAAAVt4D6pgPRK7wHiVYjZqpNFiBRvqhSOjDf+oal/zx3zNRe9jAun
        muSyjTkismwErVjzLyLixg==
X-Google-Smtp-Source: APXvYqzWyHEpQUmf+fGfLZnmmzPEvHVnwsKpHXdfg9JtH/oDnqolnyH+TEPa9AToELNvPjVP8Qp1kg==
X-Received: by 2002:aca:f05:: with SMTP id 5mr6393588oip.168.1565989280053;
        Fri, 16 Aug 2019 14:01:20 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id n109sm2644208ota.36.2019.08.16.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:01:19 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:01:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v7 06/13] media: dt-bindings: tvp5150: Add input port
 connectors DT bindings
Message-ID: <20190816210117.GA17941@bogus>
References: <20190815115747.24018-1-m.felsch@pengutronix.de>
 <20190815115747.24018-7-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815115747.24018-7-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Aug 15, 2019 at 01:57:40PM +0200, Marco Felsch wrote:
> The TVP5150/1 decoders support different video input sources to their
> AIP1A/B pins.
> 
> Possible configurations are as follows:
>   - Analog Composite signal connected to AIP1A.
>   - Analog Composite signal connected to AIP1B.
>   - Analog S-Video Y (luminance) and C (chrominance)
>     signals connected to AIP1A and AIP1B respectively.
> 
> This patch extends the device tree bindings documentation to describe
> how the input connectors for these devices should be defined in a DT.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v7:
> Hi Rob,
> I droped your r b tag because I changed the bindings in this
> patch version. Please can you have a look on it again?
> 
> - fix missing AIP1B svideo connection (description and examples)
> 
> v3:
> - remove examples for one and two inputs
> - replace space by tabs
> 
> v2:
> - adapt port layout in accordance with
>   https://www.spinics.net/lists/linux-media/msg138546.html with the
>   svideo-connector deviation (use only one endpoint)
> ---
>  .../devicetree/bindings/media/i2c/tvp5150.txt | 112 ++++++++++++++++--
>  1 file changed, 105 insertions(+), 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

