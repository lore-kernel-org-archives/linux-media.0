Return-Path: <SRS0=rYAI=SU=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34008C10F0E
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 11:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4A214DA
	for <linux-media@archiver.kernel.org>; Thu, 18 Apr 2019 11:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbfDRLVf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:21:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42042 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLVf (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Apr 2019 07:21:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so2499168wrx.9
        for <linux-media@vger.kernel.org>; Thu, 18 Apr 2019 04:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpavdf0LKKlgfhSeCm9yOUc8wExflWyg9Bv9+jWrQuI=;
        b=dAvvewipuCYY32mTdewFkC4DxnyhMnTvIm6RseL62qY01yRLfKsrc2POTsswLPi9Qi
         puJ94Bd0uLhD9TCOY13u+9+icOdWJWFpWeRXRCe6IQ/4UyCDmIp7p1p7yuOIYeWo7yqi
         izI9FiGiZ/2JDPtW0knPh30Fbi7SBrj3C1tBxU6OTy8pHy2S49anSvkoZjmMvaWKNw3D
         5VgXGu4kQOMf8BGCixyFusGCSh1OmxI4vGpX0Omcf8Y+rx7AXI8V/9FauyIJ0bJbnmzq
         AiYHTPjz3O9hWVdoRux+JdfSl0XZveIlpSVjmqls3rJMQf56a+CyW3sba99f8RXgq/kU
         qR/w==
X-Gm-Message-State: APjAAAVWKGCXS5mg78z12nAc+WULRughgRdFojNN5kBB6vS5Y/NCEnKm
        uYjiDfV2T3V+nprN/0pJ7BPXSQ==
X-Google-Smtp-Source: APXvYqy4xCMDxcuQApAzdV2Z4JYwDqoNE+vTjbJ6fTZzVDRS0/n5F1nOVBNIS29eDPDVWZC6V8oTmA==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr7936288wrs.206.1555586491920;
        Thu, 18 Apr 2019 04:21:31 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h10sm2133127wrs.27.2019.04.18.04.21.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 04:21:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] libv4lconvert: Port supported_src_formats to
 bit-ops
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media@vger.kernel.org, daniel@qtec.com
References: <20190416120203.24028-1-ricardo@ribalda.com>
 <20190417114135.5987-1-ricardo@ribalda.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8168fd98-6deb-dc63-8d00-38987482a414@redhat.com>
Date:   Thu, 18 Apr 2019 13:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417114135.5987-1-ricardo@ribalda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 17-04-19 13:41, Ricardo Ribalda Delgado wrote:
> We have passed the barrier of 64 supported formats, therefore a int64_t
> is not enough for holding the bitfield.
> 
> Instead use bit-ops ala kernel.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>

Thank you.

I've dropped the unnecessary __prefix from the bitop functions and
I've pushed both patches to the upstream master branch now.

Regards,

Hans



> ---
>   lib/libv4lconvert/libv4lconvert-priv.h |  3 +-
>   lib/libv4lconvert/libv4lconvert.c      | 40 ++++++++++++++++++++++----
>   2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
> index a8046ce2..5286a9b1 100644
> --- a/lib/libv4lconvert/libv4lconvert-priv.h
> +++ b/lib/libv4lconvert/libv4lconvert-priv.h
> @@ -38,6 +38,7 @@
>   #include "tinyjpeg.h"
>   
>   #define ARRAY_SIZE(x) ((int)sizeof(x)/(int)sizeof((x)[0]))
> +#define BITS_PER_LONG (8 * sizeof(long))
>   
>   #define V4LCONVERT_ERROR_MSG_SIZE 256
>   #define V4LCONVERT_MAX_FRAMESIZES 256
> @@ -55,7 +56,7 @@ struct v4lconvert_data {
>   	int flags; /* bitfield */
>   	int control_flags; /* bitfield */
>   	unsigned int no_formats;
> -	int64_t supported_src_formats; /* bitfield */
> +	unsigned long supported_src_formats[128 / BITS_PER_LONG];
>   	char error_msg[V4LCONVERT_ERROR_MSG_SIZE];
>   	struct jdec_private *tinyjpeg;
>   #ifdef HAVE_JPEG
> diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
> index 78fb3432..0607cc8b 100644
> --- a/lib/libv4lconvert/libv4lconvert.c
> +++ b/lib/libv4lconvert/libv4lconvert.c
> @@ -32,6 +32,29 @@
>   #include "libv4lsyscall-priv.h"
>   
>   #define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +#define BIT_MASK(nr) (1UL << ((nr) % BITS_PER_LONG))
> +#define BIT_WORD(nr) ((nr) / BITS_PER_LONG)
> +
> +static inline void __set_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p  |= mask;
> +}
> +
> +static inline void __clear_bit(int nr, volatile unsigned long *addr)
> +{
> +	unsigned long mask = BIT_MASK(nr);
> +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +
> +	*p &= ~mask;
> +}
> +
> +static inline int __test_bit(int nr, const volatile unsigned long *addr)
> +{
> +	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> +}
>   
>   static void *dev_init(int fd)
>   {
> @@ -231,7 +254,7 @@ struct v4lconvert_data *v4lconvert_create_with_dev_ops(int fd, void *dev_ops_pri
>   				break;
>   
>   		if (j < ARRAY_SIZE(supported_src_pixfmts)) {
> -			data->supported_src_formats |= 1ULL << j;
> +			__set_bit(j, data->supported_src_formats);
>   			v4lconvert_get_framesizes(data, fmt.pixelformat, j);
>   			if (!supported_src_pixfmts[j].needs_conversion)
>   				always_needs_conversion = 0;
> @@ -316,8 +339,15 @@ int v4lconvert_supported_dst_format(unsigned int pixelformat)
>   
>   int v4lconvert_supported_dst_fmt_only(struct v4lconvert_data *data)
>   {
> -	return v4lcontrol_needs_conversion(data->control) &&
> -		data->supported_src_formats;
> +	int i;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(data->supported_src_formats); i++)
> +		if (data->supported_src_formats[i])
> +			break;
> +	if (i == ARRAY_SIZE(data->supported_src_formats))
> +		return 0;
> +
> +	return v4lcontrol_needs_conversion(data->control);
>   }
>   
>   /* See libv4lconvert.h for description of in / out parameters */
> @@ -334,7 +364,7 @@ int v4lconvert_enum_fmt(struct v4lconvert_data *data, struct v4l2_fmtdesc *fmt)
>   
>   	for (i = 0; i < ARRAY_SIZE(supported_dst_pixfmts); i++)
>   		if (v4lconvert_supported_dst_fmt_only(data) ||
> -				!(data->supported_src_formats & (1ULL << i))) {
> +		    !__test_bit(i, data->supported_src_formats)) {
>   			faked_fmts[no_faked_fmts] = supported_dst_pixfmts[i].fmt;
>   			no_faked_fmts++;
>   		}
> @@ -490,7 +520,7 @@ static int v4lconvert_do_try_format(struct v4lconvert_data *data,
>   
>   	for (i = 0; i < ARRAY_SIZE(supported_src_pixfmts); i++) {
>   		/* is this format supported? */
> -		if (!(data->supported_src_formats & (1ULL << i)))
> +		if (!__test_bit(i, data->supported_src_formats))
>   			continue;
>   
>   		try_fmt = *dest_fmt;
> 
