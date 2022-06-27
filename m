Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB62CCA47B
	for <linux-media@archiver.kernel.org>; Mon, 27 Jun 2022 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiF0Xau (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiF0Xat (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Jun 2022 19:30:49 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC792677;
        Mon, 27 Jun 2022 16:30:47 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id h5so7079103ili.3;
        Mon, 27 Jun 2022 16:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utd/78Oe9WLpqtkBg8+6vUI/ZzLUWo0rgucS0xuJ09w=;
        b=CN2UrSZTAnefIj7Cb7B+1B7S6XLoP4k3MBrO+7nUm5U3zK9dCbZeVgr5NeC5Z+CIon
         gWZtpOU4YJfJpGBb7vBt8QXyMSjtncxSoAdpYPiKzYl32uCnS7Z6i/GaFjIjN0xfQLha
         /vRM0fkscAh130fA+g5GgW45OxRt9pTrCkWtNNBej1tkTq2tAEd6JZ1R8VG6VSa7joZq
         AoqlIRTXaMksOdrWGXOKIW7Fpyyavu18GSfCBGsYf1/L+d1A8ZzWjXoaIcfjQvN4ggIQ
         I6qeTC+I5mBGiCFE54oVFYSu9/oaC0x3eupQlA0ByWGq9+aEWFfUN8l6aEog3PxNBSqo
         0j3Q==
X-Gm-Message-State: AJIora+Af/kcjOKa2ma9b0B/h6YtriEQozHzVPX6w0CxDSFK9K6JlDX6
        zjF6781uf+jeFCOKVmhGUQ==
X-Google-Smtp-Source: AGRyM1tpbiyf2wpA3zRzteOIPYl7Zmv4n+7qnLWQYCM2F2VnsqDpxO0fMpqhgqjFO4F2O/v0WfG31w==
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr8556536ilq.54.1656372646873;
        Mon, 27 Jun 2022 16:30:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q1-20020a02a981000000b0032b3a78178bsm5291025jam.79.2022.06.27.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:30:46 -0700 (PDT)
Received: (nullmailer pid 3169628 invoked by uid 1000);
        Mon, 27 Jun 2022 23:30:45 -0000
Date:   Mon, 27 Jun 2022 17:30:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: mt9p031: Add MT9P006 compatible
 string
Message-ID: <20220627233045.GA3169594-robh@kernel.org>
References: <20220618222255.478165-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618222255.478165-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sun, 19 Jun 2022 00:22:54 +0200, Marek Vasut wrote:
> Add compatible for MT9P006 sensor, which is older variant of MT9P031
> and compatible with this driver.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Stefan Riedmueller <s.riedmueller@phytec.de>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/media/i2c/aptina,mt9p031.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
