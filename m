Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA84C10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 10:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B8120818
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDKKS2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:18:28 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:35971 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfDKKS2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 06:18:28 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EWmnhjR9jiLOmEWmohATRh; Thu, 11 Apr 2019 12:18:26 +0200
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
To:     Philipp Zabel <p.zabel@pengutronix.de>,
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <36f792a8-7680-100f-09a4-b9315177c791@xs4all.nl>
Date:   Thu, 11 Apr 2019 12:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554970925.6389.1.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBFzF5d26lIMfib8y1OIKagHsrb5QoJiqNQLw6zbl1Ll4nkhaN+JxFqjrsIqBsJkYnsHaQnpSjppqf6sUu/My4iVPxyh6BKAwgf+AORb02SowCTtR55G
 JC6CztXKQIl1BA62Stb0fo4VYtCvXkDui2qM4KWKcYYOqfKt73+3wcQIuiUPRCvboOh+0Xx5mc400ZJZx/tpA8OignIJQVcAnq0w1nIZkCYE9SHl/07SjOUF
 i+mggM8CUpxDA8s7AoCOgYed7L1G0cLReRWUibu8z17gtcNc67HHBE52xvHrFUI8aS6yz7FJ/4Y67+e2Si/zxuEzXzTM2BGOVM4Gqnre9uPBObENTBCbi1yS
 3+zjmwFE5sv/uBAYGK8zbwjmffRAoA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/11/19 10:22 AM, Philipp Zabel wrote:
> On Wed, 2019-04-10 at 18:24 +0200, Hans Verkuil wrote:
>> On 4/10/19 6:11 PM, Nicolas Dufresne wrote:
>>> Le mercredi 10 avril 2019 à 16:22 +0200, Philipp Zabel a écrit :
>>>> On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
>>>> [...]
>>>>>> @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
>>>>
>>>> [...]
>>>>> Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
>>>>> I'd remove it altogether.
>>>
>>> It does make sense, since framerate is the only information that can be
>>> used to produce a specific bitrate. If you don't enumerate the rates,
>>> then you may endup with a miss-match of what userspace wants, which
>>> will result in a different rate then what the user-space anticipated.
>>> That being said, I expect these intervals to be really wide. Venus HW
>>> uses a Q16 internally, which is precise enough that we could just
>>> ignore the interval.
>>
>> So the problem is that for an encoder where you desires a specific
>> constant bitrate, the encoder also needs to know the framerate.
>>
>> And the driver then would have to support ENUM_FRAMEINTERVALS and the
>> S_PARM ioctl so userspace can set the framerate.
> 
> Ah right, that was it. Encoding works fine without ENUM_FRAMEINTERVALS,
> as coda has no meaningful frame rate limitations. I had implemented
> S_PARM since it is required for CBR encoding, and v4l2-compliance then
> complained about ENUM_FRAMEINTERVALS missing:
> 
>   cde29ef313de ("[media] coda: Use S_PARM to set nominal framerate for h.264 encoder")
>   07b6080d4e6d ("media: coda: implement ENUM_FRAMEINTERVALS")

And I think that's right. If you advertise framerate support, then
userspace needs to know about the capabilities.

I do think ENUM_FRAMEINTERVALS should return some sane values. Right now
coda advertises 1/65535 fps to 65535 fps (or thereabout).

I would probably return 1 fps to 200 fps (200 Hz is the highest framerate
defined by CTA-861-G).

This can also eventually be a helper function in v4l2-mem2mem.c since I expect
this to be the same for all (?) encoders.

> 
>> For decoders this would not make any sense AFAIKS, so this is encoder
>> specific.
> 
> Hmm, not necesarily. I hadn't thought about that before, but if the
> decoder supports frame skipping this could be used to advertise
> available reductions in frame rate.

That assumes that you want to use S_PARM for that as well. And does the decoder
provide the framerate encoded in the bitstream to the driver? Using S_PARM for
this only works if the driver can know the encoded framerate.

Anyway, this is probably something to discuss once a driver supports frame
skipping for the decoder.

> 
>> Do I understand this correctly?
>>
>> What should the default framerate be? 24 or 29.97 fps?
> 
> Driver specific? Max nominal real time capable frame rate? 30 fps?
> 
>> This should be documented in the stateful encoder spec. I never realized
>> that this would be needed...
>>
>> Philipp, based on this information I would say that ENUM_FRAMEINTERVALS
>> can stay in the coda drivers, but for encoders only.
> 
> Ok.
> 
> regards
> Philipp
> 

Regards,

	Hans
