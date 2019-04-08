Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A566C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624982147A
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfDHQVX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:21:23 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:55708 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfDHQVW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 12:21:22 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DX1MhVVKgNG8zDX1NhncYJ; Mon, 08 Apr 2019 18:21:21 +0200
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
 <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
 <20190408072854.13077345@coco.lan>
 <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
 <20190408131055.22eb3a46@coco.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cf4fedd4-5fb1-b919-7ea8-8cb84d7e634e@xs4all.nl>
Date:   Mon, 8 Apr 2019 18:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408131055.22eb3a46@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKxyFxj2rhXbfyDE2akD/ahzWabJTd2irx7b/NcwEyEdbUp4VDQ67jJGw/+FYgGJJafXh0b61+0OSay6pc8UOg4r0bE2eMpti9zZ9GzoDYxskuxJdbli
 iyEHdEkRZ++zyNQZ0JJRcLYb7KMe3sGT2iIqiQbeVT+VjYxN+NunG1sLhW7a5P+H/bofyeGiHcy/Wq33Q9fk8hMIspypWGlDaryF/Fv3otAwexWzSV9cc3DH
 olOSrZ8nWBeidry/aR/3exQmHtC8bbpPvj3EgCrj/tXf9R/58BOLqXVYZrBoK/JPW1WuM97bt589EETBuu5g2Ss/x3ZxKRWnDJihUjLqv65GFTZrzJifMyDp
 avModr1F
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 6:10 PM, Mauro Carvalho Chehab wrote:
> Em Mon, 8 Apr 2019 12:44:18 +0200
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> 
>> On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote:
>>> Em Mon, 8 Apr 2019 11:05:20 +0200
>>> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
>>>   
>>>> Hi Philipp,
>>>>
>>>> On 4/8/19 10:45 AM, Philipp Zabel wrote:  
>>>>> Hi,
>>>>>
>>>>> not sure if anybody finds this as useful as I do to spot compliance
>>>>> failures and warnings in a sea of OKs more easily, but this patch adds
>>>>> some color escape codes to the output of v4l2-compliance. It marks "OK"
>>>>> green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
>>>>> terminal. I would have preferred to mark warnings yellow, but that
>>>>> doesn't work well on black-on-white terminals.    
>>>>
>>>> Hmm, I hate colors myself :-)
>>>>
>>>> So I would prefer if an option is added to explicitly enable colors. And the
>>>> check for stdout can be replaced by a check for this new option.
>>>>
>>>> Also, the same option and behavior should be added to cec-compliance as well.
>>>>
>>>> I propose the option -C, --show-colors.  
>>>
>>> Just my two cents here: I guess most people love colors for warnings
>>> (I do), and this has becoming more popular on gcc - and it is already
>>> a default for dvb tools, with is part of v4l2-utils.
>>>
>>> So, IMHO, it would make more sense to have colors enabled by default,
>>> and provide, instead, either an option to disable or to have an env
>>> var that would control it.  
>>
>> If we do that then it needs to be the same for all utils. I could live
>> with a env variable.
> 
> Fully agreed on that. We should handle it the same way on all apps.
> 
>> I just tried to run dvb-fe-tool (no arguments), and I get a warning
>> in a brown/orange color, but after that my cursor turns the same color.
>> Does it properly go back to black?

Ah, it appears to be a side-effect of not-quite-right PS1 prompt sequence
that I had in my .bashrc. So dvb-fe-tool seems to do the right thing after
all.

Regards,

	Hans

> 
> Hmm... good point. It should, but this is something that I usually don't
> really test here, as my prompt is colored:
> 
> 	PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
> 
> so if it doesn't reset the terminal, I wouldn't notice.
> 
> Just did a quick test here. Colors are being reset with Mate terminal:
> 
> <colored prompt> $ PS1="\w \$ "
> ~ $ dvb-fe-tool 
> Device Montage Technology M88DS3103 (/dev/dvb/adapter0/frontend0) capabilities:
>      CAN_2G_MODULATION
>      CAN_FEC_1_2
>      CAN_FEC_2_3
>      CAN_FEC_3_4
>      CAN_FEC_4_5
>      CAN_FEC_5_6
>      CAN_FEC_6_7
>      CAN_FEC_7_8
>      CAN_FEC_8_9
>      CAN_FEC_AUTO
>      CAN_INVERSION_AUTO
>      CAN_QPSK
>      CAN_RECOVER
> DVB API Version 5.11, Current v5 delivery system: DVBS
> Supported delivery systems: 
>     [DVBS]
>      DVBS2
> Frequency range for the current standard: 
> From:             950 MHz
> To:              2.15 GHz
> Tolerance:       5.00 MHz
> Symbol rate ranges for the current standard: 
> From:            1.00 MBauds
> To:              45.0 MBauds
> SEC: set voltage to OFF
> ERROR    FE_SET_VOLTAGE: Operation not permitted	# printed in RED
> 
> ~ $ dvb-fe-tool -a 2
> WARNING  device dvb2.frontend0 not found		# printed in YELLOW
> ~ $ 
> 
> With both the above cases, the prompt return to black and white.
> 
> Perhaps the terminal you're using are not properly handling the
> color reset command. I saw in the past some broken terminal emulations
> where resetting the colors only work if it also prints something after
> the color reset command with a "\n" at the end.
> 
> Thanks,
> Mauro
> 

