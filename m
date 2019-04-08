Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D0C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B22084F
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWx+8m6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDHGcw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:32:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46704 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHGcw (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 02:32:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so14776257wrw.13
        for <linux-media@vger.kernel.org>; Sun, 07 Apr 2019 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mKV/oUvezi5AXbutBhUDoU8zaOy+SaWaWGLGVIvOpNw=;
        b=HWx+8m6XlEFQ8SN8wXzYgcM2Maq9hx0T150V9KVDicBOFeIlWROnnbaBUJo4sz+g1O
         n1wR2dDBHrC3HGcoFeqYLVptcde2XoxuJoSqrSIgYl45W66XX4XEz2ubmppB9tWClvac
         fW9nI0ynAlwmXUFB/wl8pBfXd558tV3+EMHtvDgqy4MGcnM43Eu16viqfuKTHrrOo9Xk
         01TkXjPwmdhVjWcwbqPJVh3jXns/VNcTdDTJa7C47Z4sTDliOT202LP70bhshznl72Qk
         xXsVv/+rdjwKkuLG99SLzqtJIEdIPP5fBmZXcrNXmRg8T1rVsg6M2frEjgMwbi3ez4P6
         Fisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mKV/oUvezi5AXbutBhUDoU8zaOy+SaWaWGLGVIvOpNw=;
        b=BNrJM1a90iJKmUsv2hHydBXpftv5QTnWetmEmgEEKlh2P5nGM93avJEyVelYPT1lGI
         N+TUxuvY2wlGAQfPcWLawj6hN7Ro+b6FONswJhczzfmq4U4o3uH4iYwze8NILe7iIqEi
         59eU/zh2Ijokcw2BvN0arfVhrQfatFVNlYWjBIaavo+fT/3bMwWWkxlcPT3GzX59UpM1
         S11ClJEiPmk6avWLAI6auwyw/SbxXxqiO1Lht/OkJ0VMqz4qzzxC87BstmC5zrLg8Tnw
         v/BkswdErWM2NgroSLjenSCofNQvdCm5BCdeWxXqDFMRpFK1GjijodLVqXvbVVe7RM6z
         aQdg==
X-Gm-Message-State: APjAAAX5PXUIXXqVwdqKU+b6TrPZh1r3uLwTNE++hHq8iqVzPdZrqSTa
        Jrgjd6bKZwJN/mHMJOzAaqSOG2C9
X-Google-Smtp-Source: APXvYqwTBcNO99hy/dZj28zyLf9VLaudAuKcjga1kg/c3HuBZjRnka3r5e0uaLxhRWXPBLXbqb2NxA==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr3339949wru.125.1554705169759;
        Sun, 07 Apr 2019 23:32:49 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-1-12323-31.w90-91.abo.wanadoo.fr. [90.91.129.31])
        by smtp.gmail.com with ESMTPSA id 204sm18948375wmc.1.2019.04.07.23.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:32:49 -0700 (PDT)
Subject: Re: [Bug report] dvbv5-zap crash dvb-tool ARMHF builds
From:   Samuel CHEMLA <chemla.samuel@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Sean Young <sean@mess.org>, Gregor Jasny <gjasny@googlemail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
 <20190317065242.137cb095@coco.lan> <20190319164507.7f95af89@coco.lan>
 <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com>
 <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
 <20190321083044.621f1922@coco.lan>
 <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
 <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
 <20190325140838.71f88eac@coco.lan>
 <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
 <20190326132643.r3svehoa764xagje@gofer.mess.org>
 <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
 <20190326123115.5d83f450@coco.lan>
 <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
 <20190328161758.2da2bf4e@coco.lan>
 <CANJnhGfjgejV=Vsj06JDfkDCPQ5z5tm7-sT2fBn=ALxdrSaQAw@mail.gmail.com>
Message-ID: <2b407745-4a47-1312-5e0c-08fb3d342325@gmail.com>
Date:   Mon, 8 Apr 2019 08:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANJnhGfjgejV=Vsj06JDfkDCPQ5z5tm7-sT2fBn=ALxdrSaQAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 01/04/2019 20:58, Samuel CHEMLA wrote:
> Le jeu. 28 mars 2019 à 20:18, Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> a écrit :
>> Em Thu, 28 Mar 2019 19:48:35 +0100
>> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>>
>>> Hi,
>> Please, don't top post.
>>>
>>> 1) I did reproduce the bug with a serial console, but the serial
>>> console was also frozen, and there was no message before freeze.
>> The only way for a machine to freeze even on serial console is due to
>> a very serious Kernel or hardware bug, like a bad lock/semaphore.
>>
>>> 2) I also tried a powered USB HUB but it didn't change anything.
>> Ok.
>>
>>> 3) I tried DVBJet, from https://github.com/lightful/DVBdirect , it is
>>> a tuner that directly does ioctl on linux kernel DVB device.
>>> I couldn't reproduce the issue with DVBJet.
>> I don't know DVBJet. If it uses the same Kernel drivers, maybe
>> it could then be a race issue: send commands on a slower way to
>> the Kernel would be solving the issue.
>>
>>> It's been running for almost 48Hrs now, without a crash.
>>> I collect all PIDs on the multiplex, just like dvbv5-zap, so the USB
>>> port is solicited at it's maximum.
>>>
>>> That makes me think it is not a hardware issue.
>>> I'm pretty sure dvbv5-zap can still improve, and it already did when
>>> you fixed: struct arguments args = {};
>> Everything can be improved, but the thing is that we need first to
>> discover the root cause :-)
>>
>> Can you post on pastebin (or equivalent) the dmesg with the
>> DVBJet running? Maybe it could be printing some Kernel messages
>> that might help to discover what's going wrong.
> Here is the dmesg: https://pastebin.com/3XRim4XL
> Just look at the code, it's quite straightforward, just a few ioctl.
>
>> Btw, could you also apply this patch:
>>          https://patchwork.linuxtv.org/patch/55274/
> OK, I'll give it a try and provide feedback

I tested you patch against 4.14.98 which is the current raspbian kernel, 
but it didn't change anything...

>
>> It is probably unrelated, but this is the kind of bug that could cause
>> such issues.
>>
>>>
>>> Regards
>>>
>>> Le mar. 26 mars 2019 à 16:31, Mauro Carvalho Chehab
>>> <mchehab+samsung@kernel.org> a écrit :
>>>> Em Tue, 26 Mar 2019 16:10:33 +0100
>>>> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>>> Earlier you said "random hangs are back". When this happens, does the whole
>>>>>> device become unresponsive or just dvbv5-zap?
>>>>> The device completely freeze, you can't even switch numlock on/off.
>>>> dvbv5-tools can't hang the machine. this is very likely happening due to
>>>> a Kernel crash.
>>>>
>>>>> I said "the issue is back", it is because I **thought** it was gone.
>>>>> To be more precise:
>>>>> - on raspberry zero W, the issue is gone since Mauro's patch
>>>>> (https://git.linuxtv.org/v4l-utils.git/commit/?id=22b06353227e04695b1b0a9622b896b948adba89)
>>>>> - on raspberry 2, the issue, it is still there and the patch has no
>>>>> effect (the issue was and is still there)
>>>> RPi2 has a serious issue with their USB ports: on devices that require
>>>> more than a few mW to work, it causes several device disconnection and
>>>> re-connection, as it cannot sustain the required 5V.
>>>>
>>>> Depending on how fast this happens, it could be triggering some Kernel
>>>> bug.
>>>>
>>>> That affects most V4L and DVB devices. You should either use a powered
>>>> USB 2.0 hub (with may be problematic, as the USB host driver on RPi
>>>> has issues - and may cause data loss on high sustained ISOC traffic,
>>>> specially when used with hubs) or a device that has its own power
>>>> supply, like DVBSky T680C or S960.
>>>>
>>>>>> Since this issue is "back",
>>>>>> I wouldn't be surprised this is unrelated to the fixes in 1.12.7 and 1.16.4.
>>>>> The issue doesn't appear anymore on raspberry zero W since Mauro's commit.
>>>>> So it did improve on that platform.
>>>>>
>>>>>> It would be useful to see the output from dmesg (best thing would be after
>>>>>> the issue occurs).
>>>>> You can't, device is frozen.
>>>>> Logs are not flushed to disk, and journalctl -f freeze before showing anything
>>>> You can use a serial port in order to get the logs. On a serial console,
>>>> use something like:
>>>>
>>>>          # dmesg -n 8
>>>>
>>>> In order to make sure it will display all Kernel messages at console.
>>>>
>>>>>> Also what dvb hardware are you using?
>>>>> I reproduced it with different two tuners: rtl2832U from RTL-SDR.COM
>>>>> and a TerraTec Cinergy T Stick+
>>>> None of them supports an external power supply.
>>>>
>>>>> You can found all the details here:
>>>>> https://bugs.launchpad.net/raspbian/+bug/1819650
>>>>>
>>>>>
>>>>> Sam
>>>>>
>>>>>
>>>>> Le mar. 26 mars 2019 à 14:26, Sean Young <sean@mess.org> a écrit :
>>>>>> Hi Sam,
>>>>>>
>>>>>> On Tue, Mar 26, 2019 at 08:35:44AM +0100, Samuel CHEMLA wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>>
>>>>>>> I am struggling with valgrind because it always complain with either :
>>>>>>>      ASan runtime does not come first in initial library list; you
>>>>>>> should either link runtime to your application or manually preload it
>>>>>>> with LD_PRELOAD
>>>>>>>      -> When I LD_PRELOAD, I'm getting a segfault, but I couldn't find
>>>>>>> any core dump
>>>>>>>
>>>>>>> or, if I link statically libasan with -static-libasan:
>>>>>>>      Shadow memory range interleaves with an existing memory mapping.
>>>>>>> ASan cannot proceed correctly. ABORTING.
>>>>>>>      ASan shadow was supposed to be located in the
>>>>>>> [0x00007fff7000-0x10007fff7fff] range.
>>>>>>>
>>>>>>>
>>>>>>> I retested again on my raspberry zero W, and I confirm i cannot
>>>>>>> reproduce the hang.
>>>>>>> Your fix did work on that device.
>>>>>>> I am testing with same OS (raspbian with latest updates, same kernel),
>>>>>>> same configure options, same USB dongle... :-(
>>>>>>> The only differences are CPU architecture (armv6 vs armv7), memory
>>>>>>> constraints, and I was not using the same channels.conf, I'll fix that
>>>>>>> today and re-check
>>>>>> Earlier you said "random hangs are back". When this happens, does the whole
>>>>>> device become unresponsive or just dvbv5-zap? Since this issue is "back",
>>>>>> I wouldn't be surprised this is unrelated to the fixes in 1.12.7 and 1.16.4.
>>>>>>
>>>>>> It would be useful to see the output from dmesg (best thing would be after
>>>>>> the issue occurs).
>>>>>>
>>>>>> Also what dvb hardware are you using?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> san
>>>>>>
>>>>>>>
>>>>>>> Sam
>>>>>>>
>>>>>>> On 25/03/2019 18:08, Mauro Carvalho Chehab wrote:
>>>>>>>
>>>>>>> Em Mon, 25 Mar 2019 17:33:30 +0100
>>>>>>> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>>>>>>>
>>>>>>> Hi guys,
>>>>>>>
>>>>>>> I'm afraid I'm coming with sad news.
>>>>>>> I just tried both stable-1.12 and stable-1.16 on a raspberry pi 2, and
>>>>>>> random hangs are back (see https://bugs.launchpad.net/raspbian/+bug/1819650
>>>>>>> ).
>>>>>>> I previously test both branches on a raspberry zero and issues were gone
>>>>>>> (same raspbian version).
>>>>>>> There may be more memory issues somewhere...
>>>>>>>
>>>>>>> Could you test it with valgrind?
>>>>>>>
>>>>>>> Sam
>>>>>>>
>>>>>>> Le jeu. 21 mars 2019 ŕ 20:59, Gregor Jasny <gjasny@googlemail.com> a écrit :
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> On 21.03.19 12:30, Mauro Carvalho Chehab wrote:
>>>>>>>
>>>>>>> I went ahead and cherry-picked the relevant patches to -1.12, -1.14 and
>>>>>>> -1.16, and tested both dvbv5-zap and dvbv5-scan with all versions. So,
>>>>>>>
>>>>>>> we can
>>>>>>>
>>>>>>> release a new minor version for all those stable branches.
>>>>>>>
>>>>>>> After the patches, on my tests, I didn't get any memory leaks or
>>>>>>> double-free issues.
>>>>>>>
>>>>>>> I issues a new 1.12, 1.14, and 1.16 release.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Gregor
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Mauro
>>>>
>>>>
>>>> Thanks,
>>>> Mauro
>>
>>
>> Thanks,
>> Mauro

