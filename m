Return-Path: <SRS0=wnq3=EF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3C0C4363A
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 11:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CE207DE
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604057583;
	bh=FgHWcJx3rJrGQTtvBACPLG9a8QgpndZWUehWpgRFymA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=KfO6WWqp2IqyeSkNMwVdQcaRVAr8MoEmiYl/N6eNZxAgzGLUgH4KLaNXVZYACY5oP
	 u0+Az6rbOGY4QOHul8L9JYgedFPl+k2VKKeLhuqj5wgys0lYA+CnsYOl70Y2cwIe9J
	 GcQ2f5HGNW7VillDK8w/ndtOsYppSiIH0PYSaQdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJ3Lcx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:32:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgJ3Lcx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Oct 2020 07:32:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id w14so6063418wrs.9;
        Fri, 30 Oct 2020 04:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hap6ztNwMjmpscZQ5TX7IlxwkAmalUa6Muelsp2kCkA=;
        b=tyqy9T5LP6CY7A1N5NG7X6I1NPC5kPC6n1qyDbRlQ+dHplZ9b05hiSZR4LjlkS2w+H
         0QXP3+dq33JSvChBqztuoOcW5A8J2RLlsMj9DCz09km7FXpBkmfqL1fS2gK2enS7kFq6
         aZExC9kVsVAKFW7nnRDEfT7rI1j3/fEjwzBDSKO2/mmYsr/gXGwIbV77elHQzdpJk6uy
         bRfmkzsBFFUqizcdgO9BovtNXx/KdqjHYSmyl6N8ik03ckrkMEKwmpN38zw/jyVvLEq7
         C9o9mLCBxdOt5RI3dX/Ow/ZxPC3xBFliHMSn2bxXDIvskJQcJo0zz4wkidWo55PFBJU3
         JrsQ==
X-Gm-Message-State: AOAM531K8oNMwVAZaIAZ3Diqw/M3ZhDF9JzSSmCtwOJ7E8NNC6qoLy/7
        nMJzQqmnK0V4M4GfQlDeIBk=
X-Google-Smtp-Source: ABdhPJzKlBaSS25MdiKT8LGCKeRmdbRIDx3zyM2O2N9VebtMjrl2esOMTev85oxF/KGyIEzyjATfeA==
X-Received: by 2002:adf:e490:: with SMTP id i16mr2707012wrm.178.1604057569279;
        Fri, 30 Oct 2020 04:32:49 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b7sm9560104wrp.16.2020.10.30.04.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 04:32:48 -0700 (PDT)
Date:   Fri, 30 Oct 2020 12:32:46 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: imx258: validate rotation only if it is
 provided
Message-ID: <20201030113246.GC36162@kozik-lap>
References: <20201005151559.12003-1-krzk@kernel.org>
 <20201005151559.12003-2-krzk@kernel.org>
 <20201028092343.GA100461@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201028092343.GA100461@kozik-lap>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Oct 28, 2020 at 10:23:43AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Oct 05, 2020 at 05:15:59PM +0200, Krzysztof Kozlowski wrote:
> > The sensor supports rotation by 180 degrees however the value of
> > "rotation" property should be validated only if it exists.  If
> > "rotation" is missing, do not fail the probe:
> > 
> >     imx258: probe of 3-001a failed with error -22
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This is actually a fix, so these should be added:
> Fixes: 17121d12a5c1 ("media: imx258: Check the rotation property has a value of 180")
> Cc: <stable@vger.kernel.org>
> 
> Best regards,
> Krzysztof

Please drop this patch. I misunderstood the comment.

Best regards,
Krzysztof
