Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761FC10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 23:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E528620850
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDKXNn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:13:43 -0400
Received: from kozue.soulik.info ([108.61.200.231]:56152 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfDKXNn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 19:13:43 -0400
Received: from [IPv6:2001:470:b30d:2:c604:15ff:0:401] (unknown [IPv6:2001:470:b30d:2:c604:15ff:0:401])
        by kozue.soulik.info (Postfix) with ESMTPSA id 7B5381001DF;
        Fri, 12 Apr 2019 08:13:38 +0900 (JST)
Subject: Re: [PATCH v3 1/9] staging: video: rockchip: add v4l2 decoder
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Randy Li <randy.li@rock-chips.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        maxime.ripard@bootlin.com, joro@8bytes.org,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
References: <20190410124226.8612-1-ayaka@soulik.info>
 <20190410124226.8612-2-ayaka@soulik.info>
 <2b225e07b03359311c21ab2b3c41096a97beb338.camel@ndufresne.ca>
 <cc5816d8-43cb-aedc-e496-f92baf37e6b3@rock-chips.com>
 <88dc2edc5e6146d4dc0a8367b5bbe9aaa6241d0b.camel@ndufresne.ca>
From:   ayaka <ayaka@soulik.info>
Message-ID: <8efb73e4-5d6c-aec2-4255-64b6603d23d8@soulik.info>
Date:   Fri, 12 Apr 2019 07:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <88dc2edc5e6146d4dc0a8367b5bbe9aaa6241d0b.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 4/12/19 12:12 AM, Nicolas Dufresne wrote:
> Le jeudi 11 avril 2019 à 09:29 +0800, Randy Li a écrit :
>>> We agreed with Maxime and Ezequiel that there will be two distinct
>>> format, V4L2_PIX_FMT_H264_SLICE_RAW and V4L2_PIX_FMT_H264_SLICE_ANNEXB.
>>> And user-pace will take care of providing the right information.
>> I have no idea on what does the SLICE_RAW mean here.
> If you skip the NAL headers, SLICE_RAW is what is left. This is exactly
> what is passed in VAAPI, and what makes Rockchip HW difficult to
> support through this abstraction apparently. The rationale is that all
> the information that was in the rest of the bitstream is already passed
> in C structures. If this isn't the case, let me know, since it would be
> a bad name indeed.

Yes, it is called as AVC1 as usual. SLICE_RAW doesn't indicate anything, 
it can be AVCCC or something else.

You must follow a standard as there is.

>
> Paul asked us why not always required ANNEX-B with start code as a
> super set. This is not very efficient, since it means that whenever you
> have a stream from an ISOMP4 media, you endup having to convert the AVC
> headers into ANNEX-B start code, and you loose the optimization the AVC
> header provides (AVC format is basically just a NAL type and it's size,
> so you can navigate through the stream with very little reads). The

But if a frame is consisted with more than 1 slice, it won't work, 
although it is not supported by current V4L2 framework. Anyway the start 
code is necessary in Annex B of the H.264 SPEC or hardware can't handle 
more than 1 nal unit for any purpose.

Adding a 24bits or 32bits header won't cost much CPU time, much less 
than bitstream reconstruction.

Anyway you won't not only meet this problem with H.264 but also H.265.

> other thing is the memory alignment the require needs. I suspect that
I am sure bitstream doesn't required any memory alignment.
> if the HW require SLICE_RAW, you cannot just pass a random pointer
> offset. So you'd need another buffer the userspace data to. Hidden
I think you can, hardware usually has a register to let it skip a few 
bits of the input stream.
> copies in drivers are quite bad, it's better to leave it to userspace
> when we can in my opinion.
>
> Now that I'm saying that out-loud, I wonder how the "one v4l2 buffer
> per frame" restriction can be respected for SLICE_RAW. The receiver
> would have no way to know where each slices are. Isn't there a big flaw
> in this restriction ? Or did I miss-understood the format, and
> SLICE_RAW is a bad name ?
>
>> Annex B describe a byte stream format but it doesn't mean it should
>> ship slice data with SPS or PPS
> SLICE means it won't pass SPS or PPS in-band. Only slice NALs and per
> slice auxiliary data if there is any. Do Rockchip needs the original
> SPS/PPS bitstream ? If so, all of them ? or just the activated one ?
> And when ?

Yes, I though you know that, I talked with you before. I though that is 
why ezequiel want this.

But that SPS/PPS is not 100% compatible with ITU document.

>
>> The problem of bootlin demo is it follows Annex B but withou a start
>> code !!!!
> We'll fix that if we decide to use this for testing. It was all early
> and unspecified. SLICE_ANNEXB will have a start code of course, as I
Besides I found its SPS/PPS doesn't match the original file, I didn't 
make this clearly in the previous email.
> don't see how you can call this ANNEXB otherwise. And I'm pretty sure
> the reason Rockchip need it is to be able to split the slices (we need
> to keep in mind that multiple slices per frame is commonly used in
> video conference streaming). The format documentation should be really
> clear about what it is, and if another HW with another format comes
> that does not match, it should define and document a new format.
>
> cheers,
> Nicolas
