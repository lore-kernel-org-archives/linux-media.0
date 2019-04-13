Return-Path: <SRS0=a2si=SP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D68C10F11
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A9F20869
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="w9QqTojO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDMJIY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:08:24 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43537 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfDMJIY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Apr 2019 05:08:24 -0400
Received: by mail-lj1-f172.google.com with SMTP id f18so11007019lja.10
        for <linux-media@vger.kernel.org>; Sat, 13 Apr 2019 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wqo7GP+r9cteAauGeitA2Okx9BmpiuW2TKiTP2mUPnw=;
        b=w9QqTojOw/Znojg8zj0G/GSl//hvzk4zfARFiD5z6kwEMET9tngclJLx66n+yY1mtW
         ABNRpF0gvhyW7lLyXy6opHoU6R4k2kEUUlZppyyfChIwXCm72ub2hXsByABBsBslhc4c
         jmVqpIKNAs/Uk6x9KFtM/l+aDedRJbsBKNyzaRc1XwxpFiuWXgnIUup4YUMUUlSRoCbp
         VqkwS4BXfQ05hOpS2xVzd1QF1hfb7sL8IQxKjUDZme4x6URpTcXQGEF7DfsFBeb/qbFF
         vqtVCxFEsoSiiGY6w49CCbYGNg8AxbyjalxL6Ykvln/rPV66uM2iCb5aAqvf7mYOzevr
         KWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wqo7GP+r9cteAauGeitA2Okx9BmpiuW2TKiTP2mUPnw=;
        b=etpy+dUqN3RSTJKnjBzEeE7zlDm95HowuY5bzaN9V203raQuDyy+TfdfDwsIKLS2ED
         1quBo6AYRMDLPhv8XTxnxOmtHVT8bKCEoDG/vXMV0q/zW33FRkUgSncwetlpJKBf6WKA
         W7uEaNsEyv08XzqDJNfj1ZG2+B+koaW8o29rbjJv8IZfGo7geYPdW36+zHVlakhfI8eh
         bmsX7jEeU2JXXiroAQOdPze2E3c9HwiUowi8zOHUxLl9C2I9yC5W2/cwBrHvTckrjxJK
         7nbISZ+Wdab6kTOsasaz6j6SSAqNgdXBq2JapxD7XDAFcAiLkpcSR4LRtFM3tdpPBXsw
         v4Xw==
X-Gm-Message-State: APjAAAVhGjenAC8x7SpT6za5uyGtfIrla6fJTyxu1GeXo8ZyfN0Zd6l1
        z2Capi4DfJOGXLIL/WTSFaNw+A==
X-Google-Smtp-Source: APXvYqy6KnZwY1XdgrMNCfBgC7kvRYFFhoRXUysEI3O4FeCmAIFJ7ilSBWm67H64SWUTYTKCoPqAAQ==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr25663046ljg.161.1555146501715;
        Sat, 13 Apr 2019 02:08:21 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.47])
        by smtp.gmail.com with ESMTPSA id 7sm9498697lju.27.2019.04.13.02.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:08:21 -0700 (PDT)
Subject: Re: [PATCH 7/8] rcar-vin: Fold rvin_initialize_device() into
 rvin_open()
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-8-niklas.soderlund+renesas@ragnatech.se>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <24d3eaf1-62c7-96b9-9099-815f17377d4e@cogentembedded.com>
Date:   Sat, 13 Apr 2019 12:08:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412234359.5079-8-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 13.04.2019 2:43, Niklas Söderlund wrote:

> The function no longer serve a purpose as most tasks it performed have
> been refactored, fold what remains it into the only caller.

    What remains of it?

> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
