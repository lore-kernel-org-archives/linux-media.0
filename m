Return-Path: <SRS0=54rz=5Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72016C2D0F4
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21F2075E
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY4OiLCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgDHTvj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:51:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33376 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgDHTvj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 8 Apr 2020 15:51:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id c138so3573371pfc.0
        for <linux-media@vger.kernel.org>; Wed, 08 Apr 2020 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BwBHyjrnhK5i94XeQ97pTdTRTna9pGu9RDfl2PJdlW4=;
        b=BY4OiLCwMZTQQW9vJWA0iubNkkP49YgvW6xfIAFpl+bEOIu1vn7FTXSd4gW7W9m46m
         94eDs74FDck3o9rnTg3POm+F8f9EpG3hvrieGGefvYvMUWVN37gVn7h4iexdxsYyW/IL
         yU2i+8Yw1ewe7SL6wOAi1I/3X1X8YCI+dIA6WDC4RAlMNBt/d66AvCn0/vKMJ0NHbcQk
         aBO8OHcCRBZK1z2iGFqVm6uS1KnAQUUUfeu1LOXyzK2N3CuFObx49uW9WqBCKu2YP9IT
         GbOf88b+sX92Kn8K+duPYwafpd9ioNqw3qNNTbfMi6x4nE/+xoBEG7ner4H4tSD8ebfp
         Knvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BwBHyjrnhK5i94XeQ97pTdTRTna9pGu9RDfl2PJdlW4=;
        b=RgjsrpXqIIldV3zyDTED2KjuRtCdwUzRv1l/VzOZrU0Hl70KXXyWYAf9Vptdw2XXH7
         BkMYu671KasJ4YCA/oSyYWc9fXkXJlQEQInSK9y+g/DOGSLuhhAU/8d4puYEDKAypYkk
         T/aeLAOrRgUp+pg2JfnBOBz/6sQDEdHO25jwUl+QX/kjyYtMwrXRpl0BpvrVQAUwRplv
         XjMPvDMDiZYpDq3MNJJ3wAW8t5NzkG6/MDW0S0pHGQYQOZl1mNEwvOqqjt5ueML2tTgU
         rGroJGnldsCTGPNATXG6ZtPg37xRnlsBIVzNs5T/+gbcqwVuihsaUQmOWjdcKhhNzo9N
         /bzQ==
X-Gm-Message-State: AGi0PubUmXiNbbNfhh4KZHGCGbtQ+uNJ5UO84gf0jfYmosJWz8sNTmkB
        Y3Ap9NCVzdMhHpM9YSQMRy6SwncDeUM=
X-Google-Smtp-Source: APiQypI4MSohJ0KtkmGJc1Y2VEQNFHrsrm0OP+WCxmZJbMvDDvEerFHu+4rExBGla7FoOp293GlMDg==
X-Received: by 2002:a63:2642:: with SMTP id m63mr8406179pgm.258.1586375496577;
        Wed, 08 Apr 2020 12:51:36 -0700 (PDT)
Received: from [192.168.1.104] (c-107-3-184-99.hsd1.ca.comcast.net. [107.3.184.99])
        by smtp.gmail.com with ESMTPSA id b124sm17422257pfa.34.2020.04.08.12.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 12:51:35 -0700 (PDT)
Subject: Re: [PATCH 1/4] media: imx.rst: Fix the MIPI CSI-2 virtual channel
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>
References: <20200408123215.2531-1-festevam@gmail.com>
 <c069af02-af3c-9527-eed4-839681c73ce6@gmail.com>
 <CAOMZO5BN6igxVGRnOnftv=PGZWi=2Qb2Th0fhBon93Fk-zWj+w@mail.gmail.com>
 <a23d2559-5498-75bb-0bce-3bc11bb6b5ae@gmail.com>
 <CAOMZO5BoD4K9Z7GCZHtrWDkYre3aFNd6YdDkUfKB1xVwdjaNzg@mail.gmail.com>
 <CAOMZO5AQKQhE4THON2LGtN-Btmz=E_AbYpFxi6KV3TpTdBWOzA@mail.gmail.com>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <09a8b94a-9175-b9b3-1000-50a308e6526a@gmail.com>
Date:   Wed, 8 Apr 2020 12:51:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AQKQhE4THON2LGtN-Btmz=E_AbYpFxi6KV3TpTdBWOzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 4/8/20 12:33 PM, Fabio Estevam wrote:
> On Wed, Apr 8, 2020 at 4:28 PM Fabio Estevam <festevam@gmail.com> wrote:
>
>> Should I change the Gstreamer pipeline?
> It works if I use the v4l2convert element:
>
> gst-launch-1.0 -v v4l2src device=/dev/video1 ! v4l2convert ! kmssink

I think that works because the csc-scaler mem2mem driver is able to 
provide the frame dimensions that kmssink requires, but I don't think 
you need v4l2convert, I think this should work (use can-scale=false):

gst-launch-1.0 v4l2src device=/dev/video1 ! kmssink connector-id=54 
name=imx-drm sync=0 can-scale=false

but use the connector-id for your display.

Steve

