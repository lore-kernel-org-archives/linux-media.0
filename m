Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC4BC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835052082E
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfDJQY6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:24:58 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:36197 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729881AbfDJQY6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 12:24:58 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EG1vhm9c0NG8zEG1wh2DzC; Wed, 10 Apr 2019 18:24:57 +0200
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-7-p.zabel@pengutronix.de>
 <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
 <1554906176.3765.9.camel@pengutronix.de>
 <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5feecd0e-5c7b-27fe-84a0-0bffb04128df@xs4all.nl>
Date:   Wed, 10 Apr 2019 18:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <863e842a16db5ee6b10a2fd149119ae41ce26de6.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMsCGHalEk/S1U35u7Zv2sRG4toNkE9QNGHNl6kQO0fJNJozEAvK2YYBEW07h87KvRhsm7Ba4qL6WymRfx/dqe3JchLq9UXjBgWTjazfmh48djMSrHAq
 IZLerCmnkbLjmlNs1b99nn4qs3CSkIl10DUZ5+oogCe8RI3/pEIGzVOt5zoLPuhm3zF0BK+wt8t+d68nV/0oOQ6iiDJ/ooetkv7iEh14ICA/naT6ZOcxb2Tu
 9AS9k1tYnbpBbMOgnzfF3sT81tQ/8Rae5rhiBfV/ea34jkKfJ6ANBSsIveGIYExWVkJ5ZirsbI+mUChd1iAIi/Dn5YjSmBUnkOxGp3syM0a+zHZtxUTPQ0cj
 LO7mJ9ClMgfMNdHfn7X7W0drJbEuCw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
> Le mercredi 10 avril 2019 à 16:22 +0200, Philipp Zabel a écrit :
>> On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
>> [...]
>>>> @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
>> [...]
>>> Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
>>> I'd remove it altogether.
> 
> It does make sense, since framerate is the only information that can be
> used to produce a specific bitrate. If you don't enumerate the rates,
> then you may endup with a miss-match of what userspace wants, which
> will result in a different rate then what the user-space anticipated.
> That being said, I expect these intervals to be really wide. Venus HW
> uses a Q16 internally, which is precise enough that we could just
> ignore the interval.

So the problem is that for an encoder where you desires a specific
constant bitrate, the encoder also needs to know the framerate.

And the driver then would have to support ENUM_FRAMEINTERVALS and the
S_PARM ioctl so userspace can set the framerate.

For decoders this would not make any sense AFAIKS, so this is encoder
specific.

Do I understand this correctly?

What should the default framerate be? 24 or 29.97 fps?

This should be documented in the stateful encoder spec. I never realized
that this would be needed...

Philipp, based on this information I would say that ENUM_FRAMEINTERVALS
can stay in the coda drivers, but for encoders only.

Regards,

	Hans

> 
>>
>> It returns the range supported by the frame rate registers that can be
>> set for constant bitrate encoding. I think the idea was to let the
>> GStreamer v4l2 elements know about possible frame rate range.
>> I think I should be able to remove it without any negative effects.
> 
> As long as we can still set the framerate.
> 
>>
>> regards
>> Philipp

