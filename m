Return-Path: <SRS0=AJrZ=SI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F5C10F06
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 07:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F9D21855
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554534615;
	bh=rd6P22i2NOf9Ezd1lb+zT22MEG2oLSN6p77sYG1cXyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WEgrHRDtsb57bjmz5p8fX13NwMCI9zJpfdJbOeZ5aPiCqO1IRN/bglpXCD5t0R7BT
	 Q29HXlx1+aT2iG0OKC5GrbS/S2Qk9BdVqx4p8OjftY5DMOKSvz7yu+NAsMj4Q7J3AO
	 fLDoA3ze5VpPAhM93Q9J6BG/jsLcrgxiV9JBKP1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfDFHKP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:10:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39833 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDFHKO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 6 Apr 2019 03:10:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so4254600pga.6;
        Sat, 06 Apr 2019 00:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTxQ/08AE31H+HR7A+WDOdM/S6xSFWWFaxwJPQ7V8pg=;
        b=ppsGGsLYSogvF7tDxbXSQifX5QxgCGLhRczzfM44SvzN1zrsrRV9f9sEFIGj9+LJWw
         zS+ewYBuLOvNooN9QWv9y7UtTjc1c+aq3UDAHc8B8hdOwyJQ6OtLgj3MYAq0fiXH6EAF
         nLiV+263Igj+t/oKEJAjvx/00AcjCAVZ0woSoQOQGsrM5cxo0T4WHT+0NJjnT9qhVzFj
         wkoP/uIrLDzqUcty0pyKncHSKhc0/oCd77Zc6NOO4vSBOyLNFljLV03DS1gF/51nF54q
         i+OHFW0UyJVfsTcvtso4GcbkXLTFexaq1ApFxG56VmzKXbVMOZnzgpBeJ3dYllx+H/O6
         gIQw==
X-Gm-Message-State: APjAAAXpJVlCEdJmT9arf5xJiwynnxq1R0+VvFQ8pAJVrjmbQnU5kZd5
        cWPfqgzgVty+zfw78m4jFQ==
X-Google-Smtp-Source: APXvYqwJJtnRU4prTVy0UdFZB6fm55YGJRyOMsU1yzBTbmWyu/W+QViy8UFkIBg9+AOiPMQSqdA4Ww==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr17148218pfd.24.1554534613880;
        Sat, 06 Apr 2019 00:10:13 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id 20sm32029313pfn.131.2019.04.06.00.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 00:10:13 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:10:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, jacopo+renesas@jmondi.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de, javierm@redhat.co,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 11/13] media: dt-bindings: tvp5150: add optional
 tvnorms documentation
Message-ID: <20190406071011.GA4447@bogus>
References: <20190405060317.11240-1-m.felsch@pengutronix.de>
 <20190405060317.11240-12-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405060317.11240-12-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri,  5 Apr 2019 08:03:15 +0200, Marco Felsch wrote:
> Document the optional binding to limit the possible tv-norms on the
> input connectors.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/media/i2c/tvp5150.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
