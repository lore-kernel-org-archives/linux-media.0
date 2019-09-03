Return-Path: <SRS0=mWeH=W6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0408C3A5A2
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2022DBF
	for <linux-media@archiver.kernel.org>; Tue,  3 Sep 2019 08:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfICIex (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:34:53 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:34441 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfICIew (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 3 Sep 2019 04:34:52 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 54H1iGBbexNy054H4icrBn; Tue, 03 Sep 2019 10:34:51 +0200
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: hdpvr.ko kernel 5.3-rc6
To:     Scott Doty <scott@ponzo.net>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <7530b881-c7d0-74fd-dfeb-5e001d8b2266@ponzo.net>
 <5a6ab1fe-9776-961d-970b-5b3dbea12da1@xs4all.nl>
 <839e8ded-dfe5-9fc9-1573-2d64aa547e1c@ponzo.net>
 <00b89589-5558-f8a1-3fb7-c631002e11bd@xs4all.nl>
Message-ID: <152b2b02-67be-a5ba-6283-1b81d59c145f@xs4all.nl>
Date:   Tue, 3 Sep 2019 10:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00b89589-5558-f8a1-3fb7-c631002e11bd@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPcGLor8Pu4T7H3sx+/JI2/eCovGmrDnjbeNIWZtgS0WYYfXky43xjJBxQhUQ/auJcZjbdtR5s6lEVNgtqZ3Pbagnl/d6C7xJDwM4tgV5SK3xyKLxrBF
 lLh3R5rt3QreBp7crNDz2R9t27nVbCJAg+XUvdC8fO4/a1yHNVT1s+9k5dT+B59rTqADe3JOEHYn+wxBqtvaDbamYxWUbYnKct0=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 9/3/19 8:35 AM, Hans Verkuil wrote:
> On 9/3/19 5:45 AM, Scott Doty wrote:
>> On 9/2/19 12:31 AM, Hans Verkuil wrote:
>>> Hi Scott,
>>
>> Hi Hans!  Thank you for the speedy reply. :)
>>
>>> The only non-trivial change in hdpvr in 5.3 is this commit:
>>>
>>> commit 6bc5a4a1927556ff9adce1aa95ea408c95453225
>>> Author: Hans Verkuil <hverkuil@xs4all.nl>
>>> Date:   Thu Jun 20 07:43:41 2019 -0400
>>>
>>>     media: hdpvr: fix locking and a missing msleep
>>>
>>> Try reverting it and see if it makes a difference.
>>
>> I should mention that I haven't tried this driver for over a year,
>> so it's not just the change to 5.3 that we would be talking about.
>>
>> Tried reverting the commit and built Linux 5.3-rc7+ -- alas, it didn't
>> change anything.
>>
>>>
>>> Also test with 'v4l2-ctl -d /dev/videoX --stream-mmap' and see if it
>>> keeps streaming buffers or if it also stalls.
>>
>> That doesn't seem to work:
>>
>> $ v4l2-ctl -d /dev/video2 --stream-mmap
>> New timings found
>> VIDIOC_REQBUFS: failed: Inappropriate ioctl for device
> 
> That's weird. I'll dig out my hdpvr later this week and test as well.

Never mind, hdpvr uses read(), not streaming I/O. Of course this
doesn't work...

Just plain 'cat /dev/videoX >x.mpg' will do.

> 
>>
>> I suspect I might have to do a git bisect to find where the problem started.
> 
> That would certainly help.

If you can at least narrow down what the first kernel version is that broke
hdpvr? That should help a lot.

BTW, you specified H264 in the vlc command line, but hdpvr only supports MPEG.
So that's weird.

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 

