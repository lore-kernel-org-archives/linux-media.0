Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99289C433EF
	for <linux-media@archiver.kernel.org>; Mon, 27 Jun 2022 15:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiF0Pnf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiF0Pnd (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Jun 2022 11:43:33 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399D13F32
        for <linux-media@vger.kernel.org>; Mon, 27 Jun 2022 08:43:32 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id f10-20020a4aa68a000000b0042579cb6238so1959659oom.7
        for <linux-media@vger.kernel.org>; Mon, 27 Jun 2022 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jeCZll6JIiupq6wXz3EXbwPbyMk1/Nh9Hz5APWhATh4=;
        b=Z4Fe5PDuAC7IWtUkQe0UlZIuJiyPoJwRad/UP9chj4hlqNmV/aImccqAgc+gNQAjLd
         0HbJgHLMPWR+IFgoxxgYGcOBiPaaEBtQkPIr8arM4TbGv1k7BSCihk33MDFJCOT5YqR/
         722gGgGVGvPNrND/4NkYz/Xg8WOM7xyaKvhV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeCZll6JIiupq6wXz3EXbwPbyMk1/Nh9Hz5APWhATh4=;
        b=21TP8rdUGnjPAHLoliU7dRaTtQ3SAEz9/hA1zzALCVA6iqxs/3kYBLZcbP0LC0lGKc
         akvLssb03+DtZ2X355YeVg5/EhRL2++ICAD7UyAHY2mM4Ab3DFe1TuQR6/B0iezRhOaq
         mpWXf5g0skIuWnPMb0AuHWJfZx8Jgy6uLuxAuJYwA6lccWFjB15KlMtHcYyJ99XX/l7q
         aRkleIUMtEQ4wCOPw4i0JQNRE1C6z0LYchhp976szZN3goUrmbESkFGwFq2fO+Aow5l2
         DKVgPpwYiP//b3t6WRwI3LRS+u83zHqlkhQKDjLIBbqfZnU3T9Km4bT/7uhcZLy4YRCs
         3TeQ==
X-Gm-Message-State: AJIora+TLOrqY2IhnCYFV+phgT2VbARXDNRRRdrb9Rp87I8F5B/mcFQS
        g/JPhpL2DjgRMPyl83ELvogBZatf4k1ufA==
X-Google-Smtp-Source: AGRyM1uMw2tTloL/XMNSBy0j68LymUcxe/OES9u8zQFjwvzsmGnr0U96XIS4ReOMLmHtXL9WlKcxBg==
X-Received: by 2002:a4a:9250:0:b0:425:796d:84c9 with SMTP id g16-20020a4a9250000000b00425796d84c9mr6054316ooh.65.1656344611753;
        Mon, 27 Jun 2022 08:43:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 22-20020aca1116000000b003263cf0f282sm5487511oir.26.2022.06.27.08.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:43:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] media: vimc: add ancillary lens
To:     Yunke Cao <yunkec@google.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220617015745.3950197-1-yunkec@google.com>
 <20220617015745.3950197-2-yunkec@google.com>
 <177345ff-f601-e440-31e0-2c967736af6b@linuxfoundation.org>
 <CANqU6Fed=E1ogvR1ccwJA9bR_9VxU4QPd6PjvBAyRrMeQuRWfg@mail.gmail.com>
 <610bc1b9-c013-46d7-4446-5a5eab4c2569@linuxfoundation.org>
 <CANqU6Fcspk-CWi3xYfUBg80vUWb1ZhJhr8G6YF9Nna6nrq_17Q@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5ec4238c-080f-f2e6-9b30-6595f9afe92a@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 09:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANqU6Fcspk-CWi3xYfUBg80vUWb1ZhJhr8G6YF9Nna6nrq_17Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 6/26/22 7:30 PM, Yunke Cao wrote:
> Hi Shuah,
> 
> Thanks for the pointers.
> 

>>
>> Why is this necessary? How did you test this change? How could
>> one use this feature?
>>
> 
> Add lens to vimc driver and link them with sensors using ancillary links.
> Provides an example of ancillary link usage.The lens supports
> FOCUS_ABSOLUTE control.
> 
> Test example: With default vimc topology
>> media-ctl -p
> Media controller API version 5.18.0
> …
> - entity 28: Lens A (0 pad, 0 link)
>               type V4L2 subdev subtype Lens flags 0
>               device node name /dev/v4l-subdev6
> - entity 29: Lens B (0 pad, 0 link)
>               type V4L2 subdev subtype Lens flags 0
>               device node name /dev/v4l-subdev7
>>   v4l2-ctl -d /dev/v4l-subdev7 -C focus_absolute
> focus_absolute: 0
> 

Send me v3 with all of this information in the commit log and add
this to document as well.

thanks,
-- Shuah
