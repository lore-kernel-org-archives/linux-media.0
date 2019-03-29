Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4C0C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CBA2070B
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfC2QHN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:07:13 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:53701 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729785AbfC2QHM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 12:07:12 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9u26hPax8UjKf9u2Ahwh78; Fri, 29 Mar 2019 17:07:10 +0100
Subject: Re: [PATCH] media: pixfmt-packed-yuv.rst: fix PDF output
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <07f6590e6ed365bfe0bf5770c3a1e987fa32a657.1553875482.git.mchehab+samsung@kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <c93595fd-f69d-a837-9267-7da7c69ae931@xs4all.nl>
Date:   Fri, 29 Mar 2019 17:07:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <07f6590e6ed365bfe0bf5770c3a1e987fa32a657.1553875482.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBCpc2Cbn6Md9fa9Wd36i+PzYbGzrL+l7ZWcV4l3zh0vSD2qHoKF0HfQy2HlbZ26Q5yWsFCkvRm1UFyJ6NtYS9ysy1vFuf+zDAMDzgjUEmS+F+rPwzhA
 7R43wif6xMuFnGYyczJYrcxznCLqNXbxSgD2wRHYWlGx/qsAg2yl8jY4+fsYXqbX3HneDsH3C8tATIAoXOrO+c74l9FrONBZvkjWHtXmkK7HsYoZ1yIofk9m
 2kbHSb8DuisYjU63nmrOBgsKdmEdwBFhleEn3bBlKPSXfNdnNvLaQoXE9tNIcezJ
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/29/19 5:04 PM, Mauro Carvalho Chehab wrote:
> Some lines inside this table has more than 34 columns, with is what
> it is expected, according with .. tabularcolumns:: definition.

You probably mean:

Some lines inside this table has more than 34 columns, which isn't what
is expected, according to the .. tabularcolumns:: definition.

Regards,

	Hans

> 
> That causes the PDF output to fail.
> 
> This patch ensures that all columns will have exactly the same
> size, merging the unused ones using :cpan:
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../media/uapi/v4l/pixfmt-packed-yuv.rst      | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
> index 7fcee1c11ac4..9d2b281f06a2 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
> @@ -44,6 +44,7 @@ component of each pixel in one 16 or 32 bit word.
>        - :cspan:`7` Byte 2
>  
>        - :cspan:`7` Byte 3
> +
>      * -
>        -
>        - 7
> @@ -81,6 +82,7 @@ component of each pixel in one 16 or 32 bit word.
>        - 2
>        - 1
>        - 0
> +
>      * .. _V4L2-PIX-FMT-YUV444:
>  
>        - ``V4L2_PIX_FMT_YUV444``
> @@ -103,7 +105,9 @@ component of each pixel in one 16 or 32 bit word.
>        - Y'\ :sub:`2`
>        - Y'\ :sub:`1`
>        - Y'\ :sub:`0`
> -      -
> +
> +      -  :cspan:`15`
> +
>      * .. _V4L2-PIX-FMT-YUV555:
>  
>        - ``V4L2_PIX_FMT_YUV555``
> @@ -126,7 +130,8 @@ component of each pixel in one 16 or 32 bit word.
>        - Y'\ :sub:`0`
>        - Cb\ :sub:`4`
>        - Cb\ :sub:`3`
> -      -
> +
> +      -  :cspan:`15`
>      * .. _V4L2-PIX-FMT-YUV565:
>  
>        - ``V4L2_PIX_FMT_YUV565``
> @@ -149,7 +154,9 @@ component of each pixel in one 16 or 32 bit word.
>        - Cb\ :sub:`5`
>        - Cb\ :sub:`4`
>        - Cb\ :sub:`3`
> -      -
> +
> +      -  :cspan:`15`
> +
>      * .. _V4L2-PIX-FMT-YUV32:
>  
>        - ``V4L2_PIX_FMT_YUV32``
> @@ -190,7 +197,7 @@ component of each pixel in one 16 or 32 bit word.
>        - Cr\ :sub:`2`
>        - Cr\ :sub:`1`
>        - Cr\ :sub:`0`
> -      -
> +
>      * .. _V4L2-PIX-FMT-AYUV32:
>  
>        - ``V4L2_PIX_FMT_AYUV32``
> @@ -231,7 +238,7 @@ component of each pixel in one 16 or 32 bit word.
>        - Cr\ :sub:`2`
>        - Cr\ :sub:`1`
>        - Cr\ :sub:`0`
> -      -
> +
>      * .. _V4L2-PIX-FMT-XYUV32:
>  
>        - ``V4L2_PIX_FMT_XYUV32``
> @@ -272,7 +279,7 @@ component of each pixel in one 16 or 32 bit word.
>        - Cr\ :sub:`2`
>        - Cr\ :sub:`1`
>        - Cr\ :sub:`0`
> -      -
> +
>      * .. _V4L2-PIX-FMT-VUYA32:
>  
>        - ``V4L2_PIX_FMT_VUYA32``
> @@ -313,7 +320,7 @@ component of each pixel in one 16 or 32 bit word.
>        - a\ :sub:`2`
>        - a\ :sub:`1`
>        - a\ :sub:`0`
> -      -
> +
>      * .. _V4L2-PIX-FMT-VUYX32:
>  
>        - ``V4L2_PIX_FMT_VUYX32``
> 

