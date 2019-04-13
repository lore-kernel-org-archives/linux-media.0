Return-Path: <SRS0=a2si=SP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C286CC282CE
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F3C2084E
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="GvvkzFa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDMSZM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Apr 2019 14:25:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35319 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfDMSZM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Apr 2019 14:25:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so3285449ljc.2
        for <linux-media@vger.kernel.org>; Sat, 13 Apr 2019 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjIZTwZg8SXO39vuwb21QIdVckr/1sLw4gqIIi2Nzxw=;
        b=GvvkzFa1QYGysxd5ruKdiYP0dJ8WzsyjTRI+96xCFH300hoU3KQr/q3zutrwcEcRR2
         qBzZPQRB+Y2b+h8mlEUVpqoAzfRdcTyF41epkOe2x4YSb7nvvaAO1+sSWNLFMFMDeNQs
         2U/pvjlqJaOR0ZAGoT/++b2kuXgiHZGNsV6G8jCpp2kBaL0gVFWWM7URMcI4tMLvy5FO
         q+ZhlChUOaql73KHfctCytgzMLbSUjC5b5v8aV5sXDroTtplu4sB2CZonieK5cPpzoOO
         /seDdKesQP17wiFCrVifUd9/sRhYjCOH76vm1o7gJWw1uED15nZs697bk9asbR6KS/ik
         HQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bjIZTwZg8SXO39vuwb21QIdVckr/1sLw4gqIIi2Nzxw=;
        b=tPz064aiCfcKD7dellNk/OQ4LINVsH0U7HfdoXut9ELItG8o4j/3Rf/LeuQqFXW/Zk
         MzRIiF/c/DOdZSqj0Xw78tCfyfSfSxVECufvgn+mhS0hMVTVTSUwrAaQXz6Xm8D1DrZi
         gR088XpEHLJwBzASiIzecYHqG6OjFlw3ABuZ468PRxnqO4vtsxTwTcSbCbjslgk5wORn
         4j5a3pXE8nHz6FtK5ByTDk8SyFXmJ6l0whcy3kjkQkr9mcHh1cOLkR8NhZmJUsSJB9ob
         KnETcM0gU6CR9xfFKC3vvruaXNW76s4Z/VnChTxQS8+/kiLM/yIDqUaNi1xkyy5UMZbX
         iyTw==
X-Gm-Message-State: APjAAAU5Hej9N5daVNDikzTdSPlw/you8w7rDfqZaQ2+k+HKRI0+f9HG
        U6a1aIw+5dsfdANxvu/QuL3eY1ubTR8=
X-Google-Smtp-Source: APXvYqz+LKWYHcbco0HSwSjUYFCZRL7mpH9Bbfr0NnH+CTxcMCT1HddlIhManCY5PmIMnUCmHpih7w==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr33871847ljh.17.1555179909978;
        Sat, 13 Apr 2019 11:25:09 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.44])
        by smtp.gmail.com with ESMTPSA id q29sm8985499ljc.8.2019.04.13.11.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 11:25:09 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a77980: Add "renesas,id" to
 VIN
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au, geert+renesas@glider.be
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20190412113832.30075-1-jacopo+renesas@jmondi.org>
 <20190412113832.30075-3-jacopo+renesas@jmondi.org>
Organization: Cogent Embedded
Message-ID: <9797b2c6-58b0-954c-0d8d-f60c95ebc8e1@cogentembedded.com>
Date:   Sat, 13 Apr 2019 21:25:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190412113832.30075-3-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 04/12/2019 02:38 PM, Jacopo Mondi wrote:

> Add the "renesas,id" property to VIN nodes in the R-Car V3H R8A77980
> device tree.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> 
> I do not have a V3H board to test on, but I suspect VIN failed to probe
> on V3H before these 2 patches.

   Yes, probably. The upstream patch wasn't ever runtime tested, so this
went unnoticed. The BSPs use the old soc_camera driver.

> If that's the case, these patches would merit
> Fixes: 3182aa4e0bf4 ("arm64: dts: renesas: r8a77980: add CSI2/VIN support")

   I'm OK with that.

> Sergei, do you still have a V3H board around? Could I have your Tested-by
> tag if things are fine now?

   I have V3H Stater Kit on my desk but I don't think it has VINs wired to
anything...

> Thanks
>   j

MBR, Sergei
