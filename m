Return-Path: <SRS0=i11G=A2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9077DC433E1
	for <linux-media@archiver.kernel.org>; Wed, 15 Jul 2020 10:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D375206D5
	for <linux-media@archiver.kernel.org>; Wed, 15 Jul 2020 10:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgGOKHw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgGOKHv (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Jul 2020 06:07:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3AC061755
        for <linux-media@vger.kernel.org>; Wed, 15 Jul 2020 03:07:51 -0700 (PDT)
Received: from [IPv6:2804:14c:483:73a8::1001] (unknown [IPv6:2804:14c:483:73a8::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8A0272A0A6B;
        Wed, 15 Jul 2020 11:07:47 +0100 (BST)
Subject: Re: [PATCH 1/4] media: staging: rkisp1: cap: don't set next buffer
 from rkisp1_vb2_buf_queue
From:   Helen Koike <helen.koike@collabora.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
References: <20200714123832.28011-1-dafna.hirschfeld@collabora.com>
 <20200714123832.28011-2-dafna.hirschfeld@collabora.com>
 <c4dd300d-4dab-8c5a-e2c3-2d0ba042dc8d@collabora.com>
 <5b31b7cb-0eb4-5623-9527-b55952a939a2@collabora.com>
Message-ID: <4a715814-2971-e9fd-3cb2-3646e6c14b19@collabora.com>
Date:   Wed, 15 Jul 2020 07:07:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5b31b7cb-0eb4-5623-9527-b55952a939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 7/14/20 12:11 PM, Helen Koike wrote:
> 
> 
> On 7/14/20 9:48 AM, Helen Koike wrote:
>> Hi Dafna,
>>
>> On 7/14/20 9:38 AM, Dafna Hirschfeld wrote:
>>> The function 'rkisp1_vb2_buf_queue' sets the next buffer directly
>>> in case the capture is already streaming but no frame yet arrived
>>> from the sensor. This is an optimization that tries to avoid
>>> dropping a frame.
>>> The call atomic_read(&cap->rkisp1->isp.frame_sequence) is used
>>> to check if a frame arrived. Reading the 'frame_sequence' should
>>> be avoided outside irq handlers to avoid race conditions.
>>>
>>> This patch removes this optimization. Dropping of the first
>>> frames can be avoided if userspace queues the buffers before
>>> start streaming. If userspace starts queueing buffers
>>> only after calling 'streamon' he risks frame drops anyway.
>>>
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>> ---
>>>  drivers/staging/media/rkisp1/rkisp1-capture.c | 13 +------------
>>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/rkisp1/rkisp1-capture.c b/drivers/staging/media/rkisp1/rkisp1-capture.c
>>> index 793ec884c894..572b0949c81f 100644
>>> --- a/drivers/staging/media/rkisp1/rkisp1-capture.c
>>> +++ b/drivers/staging/media/rkisp1/rkisp1-capture.c
>>> @@ -743,18 +743,7 @@ static void rkisp1_vb2_buf_queue(struct vb2_buffer *vb)
>>>  		     ispbuf->buff_addr[RKISP1_PLANE_CB]);
>>>  
>>>  	spin_lock_irqsave(&cap->buf.lock, flags);
>>> -
>>> -	/*
>>> -	 * If there's no next buffer assigned, queue this buffer directly
>>> -	 * as the next buffer, and update the memory interface.
>>> -	 */
>>> -	if (cap->is_streaming && !cap->buf.next &&
>>> -	    atomic_read(&cap->rkisp1->isp.frame_sequence) == -1) {
>>> -		cap->buf.next = ispbuf;
>>> -		rkisp1_set_next_buf(cap);
>>
>> Doesn't this mean we'll always drop the first frame? Since the first user buffer will only be configured to
>> the hardware after receiving the first frame? So the first frame will always go to the dummy buffer, no?
> 
> I see this is actually solved in the last patch of this series.
> 
> Maybe this can be re-order, so this patch is after 4/4.
> 
> With or without this re-ordering:

As discussed throught chat, this is not an issue, since we have a minimum amount of buffers that need
to be queued before starting the stream, so we'll never have frame_sequence == -1 (which represents the first frame)
with an empty queue, so no patch re-ordering is needed.

Regards,
Helen

> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> 
> Thanks
> Helen
> 
>>
>> Thanks
>> Helen
>>
>>> -	} else {
>>> -		list_add_tail(&ispbuf->queue, &cap->buf.queue);
>>> -	}
>>> +	list_add_tail(&ispbuf->queue, &cap->buf.queue);
>>>  	spin_unlock_irqrestore(&cap->buf.lock, flags);
>>>  }
>>>  
>>>
