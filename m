Return-Path: <SRS0=qP1p=XM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC2EC4CECD
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24CA214AF
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568753571;
	bh=sEXHckyL/cCH0O4C1qWMPq6O/5tY+bGXgQqUyzTzH0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W/RascH6gRB6o5P2yY5/se23l0Ri6gTV5lplw30GrnzPz88/NPP0ilmr38kpkKZNQ
	 KHKR8WUbsRFre0xvk1cvIIMsZZkxustnsfaC2jrWaTWK2qz1ODOxts9A8h3p7Xz01I
	 4EMlukNVrwKNvP0O3DsFdr8B9C0DcKPjeqJ8kRDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfIQUwq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:52:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47039 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQUwo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Sep 2019 16:52:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so1191911otl.13;
        Tue, 17 Sep 2019 13:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMeEne97qv8JgyDBdhgCgz19g4bKacaJieBUVcMpack=;
        b=mlqpZK9xthaMKikW8riP5E+V89oPda99k4GJuxJSH/yjmdYzJiBP7UsX1e9YS9A5u0
         h5dwb+pCPNf0mC/pzvVb4pa4tOaA3rcdjcA3s0/6wrAsqiMbWHEinbibT322RDBCJrv1
         MOMwK/CuCgO+3e18sYI2G/59xO0H9mxuqfoC2N1OCXb273y+GVkidlTQRUH+I/F2aHzA
         bvnwC9B0NYa5hBvUBBHDIdSTXxKFc57K8NtH6vtqKCDBmZ4qW7ahUM+f8Eknfy4UM2Cp
         +2IIYJHjD5TBaEbFyPINuW4grvp2/om6CW1XLnGhRf6tykAxVflM7fdocGvqkpQDp+jW
         OBNw==
X-Gm-Message-State: APjAAAXW/1I4XRvA8e8qP78NXSTOZcFXnRJH+93oCNL6+Ig/hNoRJq22
        AALwApcwTZSwpPlghbcoGA==
X-Google-Smtp-Source: APXvYqzRKAYZIfGsZkV4fCugV4JzQs8fH0BJsUQ19vkI9qCJna0q4Qb3+RlGtktm94O7IeQFbkDXJg==
X-Received: by 2002:a05:6830:124f:: with SMTP id s15mr611563otp.95.1568753564008;
        Tue, 17 Sep 2019 13:52:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v132sm1162365oif.34.2019.09.17.13.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:52:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:52:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Kotas <jank@cadence.com>
Cc:     maxime.ripard@bootlin.com, mchehab@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rafalc@cadence.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
Subject: Re: [PATCH v2 1/3] media: dt-bindings: Update bindings for Cadence
 CSI2RX
Message-ID: <20190917205242.GA15921@bogus>
References: <20190905105601.27034-1-jank@cadence.com>
 <20190905105601.27034-2-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905105601.27034-2-jank@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 5 Sep 2019 11:55:59 +0100, Jan Kotas wrote:
> This patch adds a DT bindings documentation for
> Cadence CSI2RX v1.3 and v2.1 controllers.
> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  Documentation/devicetree/bindings/media/cdns,csi2rx.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
