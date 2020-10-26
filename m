Return-Path: <SRS0=KMyM=EB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88780C4363A
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC352224A
	for <linux-media@archiver.kernel.org>; Mon, 26 Oct 2020 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603725009;
	bh=vDJsq6s+sm0BoC7/Z8ArMwgyLamltjg3bCr2GKFecnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltKreg8Bj7goT7AnPQ5p0tzEZpMws5Gs6n3zbHI3go7l5Kb4rN/7MU76ThJLsFg1H
	 KnskX1BKJ0RDl9VqRarg3w4u8FNWJL6CSJfhCHXXpLEZX+Q6MgyWET+VwYzjLAut67
	 RTwKEqBwDmymS0hq11tKXUl3Sl9vdGhe2X4z9wEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783338AbgJZPKI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:10:08 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:37843 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783320AbgJZPKI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Oct 2020 11:10:08 -0400
Received: by mail-oo1-f67.google.com with SMTP id f25so144257oou.4;
        Mon, 26 Oct 2020 08:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6ueP1HO8JqUsL70C3bBNVjuPSpEsQMvHNQvx7gaX2c=;
        b=g0ZytXDrZWBQZCH+ESWl4YnDLdRMPMd2nYS4Yr3Pt1XqPgBk6Gv09skyXy06HKXx25
         WEF6rEiCEhL/pSJr0WaGeivigyyXMYpr3E61Cfvru6F85KCirgRlvgKmVCeipbd/0f3p
         wmU/0LQgcov+XSFuXfc97KMhmdKM/EqfGRr+ipgquX5RCSkJHwE9R0VuIjZhBxDjosAs
         8CtsdEzdYxTjV2MAjqAtp5DoAdUIEX5INwJQdHbNmMGvyWV07PKND5LFDXFBy8XXr+2o
         mh7fW/T+1uVmnhdeDWq182WUsjn1hseUPQJcqqG/BEe2WnxqgsILWt4T3nJAQMh7NHW6
         mXxw==
X-Gm-Message-State: AOAM532Xvq3fPVUlqErDxv0MAUOUCkfeC3QeRuLNBicVtKdy8S7IGGec
        l7uQLCnVnkf7BN/13hdIVA==
X-Google-Smtp-Source: ABdhPJwOao0i1aYUgzOXxNaz3urRathZzBUqu7c76rfe8Qr9S7poEniKetfix+mcJYzja757X3t2og==
X-Received: by 2002:a4a:af03:: with SMTP id w3mr12603860oon.93.1603725005757;
        Mon, 26 Oct 2020 08:10:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm3569197otj.57.2020.10.26.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 08:10:05 -0700 (PDT)
Received: (nullmailer pid 166281 invoked by uid 1000);
        Mon, 26 Oct 2020 15:10:04 -0000
Date:   Mon, 26 Oct 2020 10:10:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, sakari.ailus@linux.intel.com,
        Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v6 3/3] dt-bindings: imx7-mipi-csi2: convert bindings to
 yaml
Message-ID: <20201026151004.GA166226@bogus>
References: <20201021212543.1920793-1-rmfrfs@gmail.com>
 <20201021212543.1920793-4-rmfrfs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021212543.1920793-4-rmfrfs@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 21 Oct 2020 22:25:43 +0100, Rui Miguel Silva wrote:
> Convert imx7 mipi csi2 bindings documentation to yaml schema, remove
> the textual document and update MAINTAINERS entry.
> 
> Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> 
> v5 -> v6:
>   Jacopo Mondi:
>   Patch 3/3:
>     https://lore.kernel.org/linux-media/20201021155016.bs2n5ixuhxwjzjy2@uno.localdomain/
>     - fix capital MIPI CSI-2 and i.MX in description
>     - add maxItems in clocks
>     - add Jacopo Reviewed-by tag
> 
>  .../bindings/media/imx7-mipi-csi2.txt         |  90 ---------
>  .../bindings/media/nxp,imx7-mipi-csi2.yaml    | 173 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 174 insertions(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/imx7-mipi-csi2.txt
>  create mode 100644 Documentation/devicetree/bindings/media/nxp,imx7-mipi-csi2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
