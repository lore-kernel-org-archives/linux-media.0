Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BB3C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE55120830
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 13:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfDJNxb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:53:31 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:59864 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbfDJNxb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 09:53:31 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EDfMhlB4sNG8zEDfNh1LvR; Wed, 10 Apr 2019 15:53:29 +0200
Subject: Re: [PATCH 10/10] media: coda: require all decoder command flags to
 be cleared
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
 <20190408123256.22868-10-p.zabel@pengutronix.de>
 <1554829061.5799.7.camel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c8624e76-e4cf-24eb-f398-59f8cfe1e984@xs4all.nl>
Date:   Wed, 10 Apr 2019 15:53:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554829061.5799.7.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMTmgy/VZCYFXxLuH9DhaRyV/1omRCoiYvIz8VR5tiqDUF5WR/ISKjaepANpGVt1nHSnxVD8sqDBKLN6x/KNNja8eNryWc51KhAgMJ4n1THhEmVIPzmZ
 hx3fUi6r0odGqdnQTYn7ToKw1tApejbuNU54nzHnDYVUcyEMzOBzpv2leUIXespSnuPurGndcw8JM8T5ayjKNgmB/u8DUckFP1m3E7novNT04Cymn/HvgH24
 ZqC0pnCiqx/eKxH3nMdu1BqEeEMwQrxvyJxvV5Sgg1v7JpGwU0IVZp4Iq+KD9fpHlVQVaotkqdvIHABIarNvWEc28wenQVR8x2TB01KxC7l0fbb+504bg/8B
 ImW5AhTO
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/9/19 6:57 PM, Philipp Zabel wrote:
> On Mon, 2019-04-08 at 14:32 +0200, Philipp Zabel wrote:
>> The memory-to-memory stateful video decoder interface documentation
>> requires the decoder stop command initiating the drain sequence to have
>> flags set to zero.
>> Stop to black makes no sense as stopped memory-to-memory decoders do not
>> produce any frames, and stopping immediately can be achieved by stopping
>> the output video queue with VIDIOC_STREAMOFF.
>>
>> The mute audio start command flag serves no purpose as the coda driver
>> does not handle any audio formats, and does not support playback at
>> non-standard speeds.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  drivers/media/platform/coda/coda-common.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
>> index 318f0be103bb..96798f98734a 100644
>> --- a/drivers/media/platform/coda/coda-common.c
>> +++ b/drivers/media/platform/coda/coda-common.c
>> @@ -1050,10 +1050,10 @@ static int coda_try_decoder_cmd(struct file *file, void *fh,
>>  	if (dc->cmd != V4L2_DEC_CMD_STOP)
>>  		return -EINVAL;
>>  
>> -	if (dc->flags & V4L2_DEC_CMD_STOP_TO_BLACK)
>> +	if (dc->stop.pts != 0)
>>  		return -EINVAL;
>>  
>> -	if (!(dc->flags & V4L2_DEC_CMD_STOP_IMMEDIATELY) && (dc->stop.pts != 0))
>> +	if (dc->flags != 0)
>>  		return -EINVAL;
> 
> This change currently causes a v4l2-compliance failure
> 
>                 fail: v4l2-test-codecs.cpp(104): ret != 0
>         test VIDIOC_(TRY_)DECODER_CMD: FAIL
> 
> because it still expects V4L2_DEC_CMD_STOP_IMMEDIATELY to be supported.

I've fixed this in my v4l-utils work-in-progress branch:

https://git.linuxtv.org/hverkuil/v4l-utils.git/log/?h=vicodec

But I want to hold off on this patch a little bit.

I think we need to add helpers for the try_en/decoder_cmd ioctls
to v4l2-mem2mem.c since it will be the same for all codecs.

I also had to fix vicodec since the checks it did weren't complete:

https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=vicodec&id=4e95bff9a15b63179fab20ac2113c238dc20665b

Regards,

	Hans
