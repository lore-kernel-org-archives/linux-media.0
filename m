Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B353C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C36E208E3
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDHKoW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:44:22 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:54274 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfDHKoV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 06:44:21 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DRlChT8wuNG8zDRlDhlRVH; Mon, 08 Apr 2019 12:44:19 +0200
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
 <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
 <20190408072854.13077345@coco.lan>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
Date:   Mon, 8 Apr 2019 12:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408072854.13077345@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL8GiyGmARz/v9LWmR7YCe4RzsWIJgwnuqKjlXq6JclN+RrR9OAIblkzJlqS0gsRA+WApkeWpd0OaN1LWANboAdEkPpfZFibLIq+V+/VZhlPogh1rCUR
 StKY1plEmi/B8LuFe6rIsqA/Fa1uNx5B0olzC5YoxASiTveIuVuIaTOG3dntKPDegiC67oUwC6XQF0LfB40b4F4CKE2pdHS2IFtgZBaMlWV8Nm266nzRTY1g
 b4lyKeF+1M6X/xZdFiJFsfbcHF4Uqr9lgjoxrH0yaQFKhjNAMfOe3LoNtolpCKwoHWQ5/uhNfjLs86oA43PrrD1KboWJD8Ox6+atBjZDEFAk2LYQjPYdhgmG
 e6gGCS6Q
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote:
> Em Mon, 8 Apr 2019 11:05:20 +0200
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> 
>> Hi Philipp,
>>
>> On 4/8/19 10:45 AM, Philipp Zabel wrote:
>>> Hi,
>>>
>>> not sure if anybody finds this as useful as I do to spot compliance
>>> failures and warnings in a sea of OKs more easily, but this patch adds
>>> some color escape codes to the output of v4l2-compliance. It marks "OK"
>>> green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
>>> terminal. I would have preferred to mark warnings yellow, but that
>>> doesn't work well on black-on-white terminals.  
>>
>> Hmm, I hate colors myself :-)
>>
>> So I would prefer if an option is added to explicitly enable colors. And the
>> check for stdout can be replaced by a check for this new option.
>>
>> Also, the same option and behavior should be added to cec-compliance as well.
>>
>> I propose the option -C, --show-colors.
> 
> Just my two cents here: I guess most people love colors for warnings
> (I do), and this has becoming more popular on gcc - and it is already
> a default for dvb tools, with is part of v4l2-utils.
> 
> So, IMHO, it would make more sense to have colors enabled by default,
> and provide, instead, either an option to disable or to have an env
> var that would control it.

If we do that then it needs to be the same for all utils. I could live
with a env variable.

I just tried to run dvb-fe-tool (no arguments), and I get a warning
in a brown/orange color, but after that my cursor turns the same color.
Does it properly go back to black?

Regards,

	Hans

> 
>>
>> And don't forget to update the man pages for both utils!
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>> regards
>>> Philipp
>>>
>>> Philipp Zabel (2):
>>>   v4l2-compliance: use warn() in warn_once()
>>>   v4l2-compliance: add colors
>>>
>>>  utils/v4l2-compliance/v4l2-compliance.cpp | 11 ++++++++---
>>>  utils/v4l2-compliance/v4l2-compliance.h   | 22 +++++++++++++---------
>>>  2 files changed, 21 insertions(+), 12 deletions(-)
>>>   
>>
> 
> 
> 
> Thanks,
> Mauro
> 

