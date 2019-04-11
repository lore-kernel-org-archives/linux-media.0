Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E40C10F14
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A822184B
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkJC2Sl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDKLw5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:52:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47060 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDKLw5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 07:52:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so6905253wrw.13
        for <linux-media@vger.kernel.org>; Thu, 11 Apr 2019 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ru0cSaqimKC+/zOpg6nW/FjnBy/AP6CFKrOSGBhR3+A=;
        b=dkJC2Sl/zy30Xhb4DiXa8lN9Rvl/UABpBnojBLXKEBqqjbq4SXNEAL9bjB9rxe4teD
         qkUAJrSVGBedgCH3Jt4MRfa8QjnCzPdui7NmhimfuvFWhhIB8gYuzM8Q6fMxoPvwv81b
         y8P7m2J534Y//8H0mnHm/dxAqDMWKhw3MJT6req/H9/Ln8jpGY43FEv1rf1512qUK29+
         Kae3XbVoQkBJsaLvQeTBIpP2mpT2AHvTUCjb55n/krE+fwZ+XCq+lphWC9aHGRiA8Mf2
         2BhBTMKs/64xKCJUC4FpiAjtrCfLw0iVmgnI8wwY0J2bT6rx+/xBHKBIuHnK3BHoL97h
         qRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ru0cSaqimKC+/zOpg6nW/FjnBy/AP6CFKrOSGBhR3+A=;
        b=n0t7u/TJF2vz00sfzMOZZqhOdXa3v/P3EkY1utiBJlXaqFv/FtyEcmqimVpzEtUJQZ
         RQhJ3s6AUbHQDUba+x570YJ3TjCNrQRTxUBFcuthnKmAoF3vmZvbZxjbWUgW7Lei4W0/
         FlJ1DtWdCSZPhkbftOXQPqizG3L4mB50KtNxrIP2UjmC+PdHEPzxB43f78x0ItUOwJKs
         PTnlo07dximaaMhXdLAgpveDaRpBlENiohyNjvkSJ/+iVL1b6xtanOvtGnbAhWlr2vRk
         iYmTr5YjyH52GwpQaM8QDJTVOpRCgTwzOpP/OJlTkT89fajNBBGB/Goal6HhG6RMnwZd
         lT7w==
X-Gm-Message-State: APjAAAWvZF1AVL3PtoaHwxAtS2xBIaAxN+P5G0XVrmybmJlx4lijJECj
        ZXcHkCCTcCdFjMX9HbjUNJ0=
X-Google-Smtp-Source: APXvYqwhvHY+r6VUCjN7t6jcQh9iZWCYTvGJJI1gDc/BVfKn8r6TbOyeQjyx7LLt5zITpUlO6mxkXA==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr19152074wrq.209.1554983574922;
        Thu, 11 Apr 2019 04:52:54 -0700 (PDT)
Received: from ?IPv6:2a00:23c5:f786:ec00:1128:f7da:df35:f704? ([2a00:23c5:f786:ec00:1128:f7da:df35:f704])
        by smtp.googlemail.com with ESMTPSA id 84sm9120634wme.43.2019.04.11.04.52.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:52:54 -0700 (PDT)
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-7-p.zabel@pengutronix.de>
 <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
 <1554906176.3765.9.camel@pengutronix.de>
 <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
 <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl>
 <1554970925.6389.1.camel@pengutronix.de>
 <36f792a8-7680-100f-09a4-b9315177c791@xs4all.nl>
From:   Ian Arkver <ian.arkver.dev@gmail.com>
Message-ID: <92d1b31b-7849-9e36-3222-f846cc3f65df@gmail.com>
Date:   Thu, 11 Apr 2019 12:52:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <36f792a8-7680-100f-09a4-b9315177c791@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 11/04/2019 11:18, Hans Verkuil wrote:
> On 4/11/19 10:22 AM, Philipp Zabel wrote:
>> On Wed, 2019-04-10 at 18:24 +0200, Hans Verkuil wrote:
>>> On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
>>>> Le mercredi 10 avril 2019 à 16:22 +0200, Philipp Zabel a écrit :
>>>>> On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
>>>>> [...]
>>>>>>> @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
>>>>>
>>>>> [...]
>>>>>> Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
>>>>>> I'd remove it altogether.
>>>>
>>>> It does make sense, since framerate is the only information that can be
>>>> used to produce a specific bitrate. If you don't enumerate the rates,
>>>> then you may endup with a miss-match of what userspace wants, which
>>>> will result in a different rate then what the user-space anticipated.
>>>> That being said, I expect these intervals to be really wide. Venus HW
>>>> uses a Q16 internally, which is precise enough that we could just
>>>> ignore the interval.
>>>
>>> So the problem is that for an encoder where you desires a specific
>>> constant bitrate, the encoder also needs to know the framerate.
>>>
>>> And the driver then would have to support ENUM_FRAMEINTERVALS and the
>>> S_PARM ioctl so userspace can set the framerate.
>>
>> Ah right, that was it. Encoding works fine without ENUM_FRAMEINTERVALS,
>> as coda has no meaningful frame rate limitations. I had implemented
>> S_PARM since it is required for CBR encoding, and v4l2-compliance then
>> complained about ENUM_FRAMEINTERVALS missing:
>>
>>    cde29ef313de ("[media] coda: Use S_PARM to set nominal framerate for h.264 encoder")
>>    07b6080d4e6d ("media: coda: implement ENUM_FRAMEINTERVALS")
> 
> And I think that's right. If you advertise framerate support, then
> userspace needs to know about the capabilities.
> 
> I do think ENUM_FRAMEINTERVALS should return some sane values. Right now
> coda advertises 1/65535 fps to 65535 fps (or thereabout).
> 
> I would probably return 1 fps to 200 fps (200 Hz is the highest framerate
> defined by CTA-861-G).
> 
> This can also eventually be a helper function in v4l2-mem2mem.c since I expect
> this to be the same for all (?) encoders.
> 

While an i.MX wouldn't be my 1st choice for encoding a high framerate 
video, it could probably be done. This is a value for the bitrate 
control algo, afaics, not a statement of real time performance.

If an arbitrary limit is imposed then userspace would just need to work 
around it by adjusting the target bitrate for corner cases like this.

Regards,
Ian

>>
>>> For decoders this would not make any sense AFAIKS, so this is encoder
>>> specific.
>>
>> Hmm, not necesarily. I hadn't thought about that before, but if the
>> decoder supports frame skipping this could be used to advertise
>> available reductions in frame rate.
> 
> That assumes that you want to use S_PARM for that as well. And does the decoder
> provide the framerate encoded in the bitstream to the driver? Using S_PARM for
> this only works if the driver can know the encoded framerate.
> 
> Anyway, this is probably something to discuss once a driver supports frame
> skipping for the decoder.
> 
>>
>>> Do I understand this correctly?
>>>
>>> What should the default framerate be? 24 or 29.97 fps?
>>
>> Driver specific? Max nominal real time capable frame rate? 30 fps?
>>
>>> This should be documented in the stateful encoder spec. I never realized
>>> that this would be needed...
>>>
>>> Philipp, based on this information I would say that ENUM_FRAMEINTERVALS
>>> can stay in the coda drivers, but for encoders only.
>>
>> Ok.
>>
>> regards
>> Philipp
>>
> 
> Regards,
> 
> 	Hans
> 
