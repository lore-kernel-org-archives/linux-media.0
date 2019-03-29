Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BEC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816E2184C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfC2OBb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:01:31 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:41716 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729803AbfC2OBa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 10:01:30 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9s4RhOtfQUjKf9s4UhwCON; Fri, 29 Mar 2019 15:01:29 +0100
Subject: Re: [PATCH] media: vim2m: Fix RGB 565 BE/LE support
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <a7cdf8b88dadb4c71dccb0afc22409cbd7ff4fe5.1553867066.git.mchehab+samsung@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <4644eea9-b1d9-e94d-8529-13c0fd947974@xs4all.nl>
Date:   Fri, 29 Mar 2019 15:01:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a7cdf8b88dadb4c71dccb0afc22409cbd7ff4fe5.1553867066.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJAeqstc4FSmg40rEwTDS4A2MooVYcj5pGqBQ/GZl6SWZeYHct6/FX0EbHk9HIKBUqBX9DAnLZypqT/UO5692OVF37J8YzUyYQ8FeYf/Gt0a5A2Zzeue
 PyKpml9m6BLWY7RQ94PN1fyApJ4c+O4owQsivCO+t2sV+IrwRXdrXDmXB3E9sPtSCYPeGLCzojBrfcz+c9yLNwFuH/r023CEPQ5DrI7y8ElBiRlC8jjYimDk
 OzCnx8ax20AgK0NdieLc1wCUSPntBKTB9wyPiS5Z9xgangf32g821y59i406sECG
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/29/19 2:44 PM, Mauro Carvalho Chehab wrote:
> The support for those two formats are archtecture-dependent.
> Use the endianness to CPU macros to do it right.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/platform/vim2m.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
> index 3c3a6a03b948..243c82b5d537 100644
> --- a/drivers/media/platform/vim2m.c
> +++ b/drivers/media/platform/vim2m.c
> @@ -302,7 +302,7 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
>  	switch (in->fourcc) {
>  	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
>  		for (i = 0; i < 2; i++) {
> -			u16 pix = *(u16 *)(src[i]);
> +			u16 pix = le16_to_cpu(*(__le16 *)(src[i]));
>  
>  			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
>  			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
> @@ -311,12 +311,11 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
>  		break;
>  	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
>  		for (i = 0; i < 2; i++) {
> -			u16 pix = *(u16 *)(src[i]);
> +			u16 pix = be16_to_cpu(*(__be16 *)(src[i]));
>  
> -			*r++ = (u8)(((0x00f8 & pix) >> 3) << 3) | 0x07;
> -			*g++ = (u8)(((pix & 0x7) << 2) |
> -				    ((pix & 0xe000) >> 5)) | 0x03;
> -			*b++ = (u8)(((pix & 0x1f00) >> 8) << 3) | 0x07;
> +			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
> +			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
> +			*b++ = (u8)((pix & 0x1f) << 3) | 0x07;
>  		}
>  		break;
>  	default:
> @@ -345,21 +344,26 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
>  	switch (out->fourcc) {
>  	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
>  		for (i = 0; i < 2; i++) {
> -			u16 *pix = (u16 *)*dst;
> +			u16 pix;
> +			__le16 *dst_pix = (__le16 *)*dst;
>  
> -			*pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> -			       (*b >> 3);
> +			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> +			      (*b >> 3);
> +
> +			*dst_pix = cpu_to_le16(pix);
>  
>  			*dst += 2;
>  		}
>  		return;
>  	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
>  		for (i = 0; i < 2; i++) {
> -			u16 *pix = (u16 *)*dst;
> -			u8 green = *g++ >> 2;
> +			u16 pix;
> +			__be16 *dst_pix = (__be16 *)*dst;
>  
> -			*pix = ((green << 8) & 0xe000) | (green & 0x07) |
> -			       ((*b++ << 5) & 0x1f00) | ((*r++ & 0xf8));
> +			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> +			      (*b >> 3);
> +
> +			*dst_pix = cpu_to_be16(pix);
>  
>  			*dst += 2;
>  		}
> 

Why not just deal with the bytes as u8 values? All the casts and endian
conversions just make it unnecessarily complicated IMHO.

E.g. the last case can be replaced by this (if I didn't make any mistakes):

 	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
 		for (i = 0; i < 2; i++) {
			u8 green = *g++ >> 2;

			*(*dst)++ = ((green & 0x07) << 5) | (*b++ >> 3);
			*(*dst)++ = ((green & 0x38) >> 3) | (*r++ & 0xf8);
 		}

I think that's much better.

Regards,

	Hans
