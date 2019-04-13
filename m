Return-Path: <SRS0=a2si=SP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1733C282CE
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D420869
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="norNS0rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfDMJF7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:05:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32804 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMJF7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Apr 2019 05:05:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so11053929ljc.0
        for <linux-media@vger.kernel.org>; Sat, 13 Apr 2019 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WWH7mxjg+xLc8yXeDuubFsNCyMvo0N23UkrS73ckmSQ=;
        b=norNS0rCUZ74CmvB+jbHTzFOaN6cM2yOQT9E5zlI/oDeYd0dqjQlK029J0FWMPMXip
         MhBJ+cZPCwBWEEcaeEsIO557P3vMAg7IgybSL0OMzwqRSjw+jq3xyWIt1XA6dMZtURnb
         QCFrpxCWXx+tp8tTIJQAdE29plMoC3OZJwBeW+Cp/m71rkSEIQ5YDTQef5W7TfsVXTBH
         nu7+nXPQWHQtKxIqmD3NkslQMsleD79OSQ0CWEtCdhAkGylvmynqJiSE6D/AgaumYmT1
         J1Ghf7+FGCaKKvYB35V9lp3fP4JCJQ5niPYcWakpLO5UKbztV2InxovDZm0n+sAum4AB
         bY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWH7mxjg+xLc8yXeDuubFsNCyMvo0N23UkrS73ckmSQ=;
        b=hX0b3BHGu2DAaVdxMnZYRpYbhdv4+vS1C3XMq4/nUvdRarmqYlkSZXPf7olN6pwR1p
         A5QmxWGmPxtj5l4r36Uo27K4FLxwM5mdNszPL1GbSunDpXRYd5wTPhP5hq8g67lmA9e/
         JP7/U3HAw6dy6wM/pbYF2kOyh3h8MDMySfCDI4mWGa/Am0/B5oFr8qCmXs4hAX2Ltduo
         5RI02Qmn7+KEXHW2fBrCeKtpbGsWk+/Z5WLfBSla/NywoJpDJlLf9IMJ8CD6EMg1I1xp
         367+Kswq13op3iH8l/plFTJ+cx6CrAz1i7Y5fZqKQjFXbvBT8gBpMzjBKzlEhxVSm/b+
         +nlw==
X-Gm-Message-State: APjAAAXIVkt6qSdrnQ/n72OE5RO8FUadkQTQGSKRllVoriMlN/Kon+gi
        E8UAM2je/bauR+pVkMy8ZnIHJVqPBW4=
X-Google-Smtp-Source: APXvYqx6/uHTeN5LtIVxsXu3LFk6NdQE9U4X+v2MFgwz0dLSxmIyTvzYimIiuCeMiQfZKxEaxEHcyg==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr23366707ljl.7.1555146357515;
        Sat, 13 Apr 2019 02:05:57 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.47])
        by smtp.gmail.com with ESMTPSA id w3sm8760660lji.59.2019.04.13.02.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:05:56 -0700 (PDT)
Subject: Re: [PATCH 5/8] rcar-vin: Move pm_runtime_{get,put} out of helpers
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-6-niklas.soderlund+renesas@ragnatech.se>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <79674484-ad51-ebf9-d5e2-997a4f2a5ed0@cogentembedded.com>
Date:   Sat, 13 Apr 2019 12:05:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412234359.5079-6-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello!

On 13.04.2019 2:43, Niklas Söderlund wrote:

> The helpers rvin_power_{on,off} deals with both VIN and the parallel

    Deal?

> subdevice power. This makes it hard to merge the Gen2 and Gen3
> open/release functions. Move the VIN power handling directly to the
> open/release functions to prepare for the merge.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
