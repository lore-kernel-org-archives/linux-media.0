Return-Path: <SRS0=aREJ=UZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8261C48BD6
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0FF2063F
	for <linux-media@archiver.kernel.org>; Wed, 26 Jun 2019 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfFZOzx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:55:53 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:59119 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfFZOzw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 Jun 2019 10:55:52 -0400
Received: from [192.168.2.10] ([46.9.252.75])
        by smtp-cloud9.xs4all.net with ESMTPA
        id g9KthYHHcSfvXg9KwhLLYN; Wed, 26 Jun 2019 16:55:51 +0200
Subject: Re: [PATCH] drivers/media: don't set pix->priv = 0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>
References: <2269be5f-c57a-a63b-9603-63e02de6767e@xs4all.nl>
 <20190626135512.GB5015@pendragon.ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9e7a0dbc-1917-a562-83c1-26b9be09e4f8@xs4all.nl>
Date:   Wed, 26 Jun 2019 16:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190626135512.GB5015@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNFHC+hjstIRQSClRTrFllyCzJMVTICQ/kPx0unVObdeALXcG15GkLv4Eg0sCPKlx2gmORsJorddOs6bJlr1ixKwm5xgxLs3T0nm4Aor0anry/LwMOje
 Yh5zEnlDOP906yc2xm4FhUTzl3sYGDSeE1PlBBdsHwoyyRk1XB3Oz4JqeaBcX25qG57N2hrsBNhp0IVv/39YJuD2DSosWbxK+rZPdDP4DxGOUpCj4eMWfa1a
 D/NzM8Tfxs2Bjqbw9clfJD/JqWGFjaNosFYeNxx8d4k=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 6/26/19 3:55 PM, Laurent Pinchart wrote:
> Hi Hans,
> 
> Thank you for the patch.
> 
> On Wed, Jun 26, 2019 at 11:58:02AM +0200, Hans Verkuil wrote:
>> The priv field of struct v4l2_pix_format shouldn't be set by drivers,
>> it's set by the v4l2 core instead to V4L2_PIX_FMT_PRIV_MAGIC.
>>
>> Drop this from the few media drivers that still do this.
>>
>> Note that the gspca patch is slightly more involved since some of the
>> sub-gspca drivers use the priv field internally.
> 
> Do they use it in a non-standard way towards userspace, or just for
> communication with the gspca driver within the kernel ? In the former
> case, are you aware of applications using that ?

It's totally internal to the gspca driver.

In any case, priv is always overwritten with V4L2_PIX_FMT_PRIV_MAGIC
by the v4l2 core so you can't use it in a public API anyway.

Regards,

	Hans

> 
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> For everything but gspca,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

