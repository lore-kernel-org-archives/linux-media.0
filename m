Return-Path: <SRS0=ut6f=SS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4502C10F13
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81529206B6
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 16:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfDPQAV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:00:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33903 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQAU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Apr 2019 12:00:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id a6so7117100edv.1
        for <linux-media@vger.kernel.org>; Tue, 16 Apr 2019 09:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HlkeO+ulaIRwf2fAyd1A9+ODfG4jvFZCrIr/urQTKFM=;
        b=t3qoBG8E6XheiMNGhy0UaJdReqc7jQg4NzxFj7DWzi48lwEPP2FbsT9L7uN4ibVSl3
         77lotWQHD8VQwNRE2hNylyu2wGCb3RxLmFpZn3mlFtjxWNe95YLgKwYVDeCDUd61MFBB
         oWWlOQquFrOQJ8g+PtHcjTOAjA1WczeU5is+SvXg877jyUno85ZjpgbiBKcKHflWkLzb
         b8qaNRk78FRdiyq0/nIdOWiGhhvJLsn8wSRhm0KTpvdbHuzuwOnonAByMTHvM8xcuIv0
         pgl7BHmyfMqJ4hQ/CaNyf6uVHR1KpFTmWAtUDJM+rneAWgTHfa0OP954HIDOT8MvGVVP
         7Tog==
X-Gm-Message-State: APjAAAUFPVqPJu/kZcnTNENilUS3Byo4P2L7mTnMfnSCQFJ/Pk4sRoKJ
        D6Ql97nPm6xPIjxmPUg8Z0ChuA==
X-Google-Smtp-Source: APXvYqwofFeny34ABsPV1GBt6Ai+mMbJ8appgVqNAnw2j03WVYpLO/ST2QrZCQdIvZs/IhHlMUh8+Q==
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr44892604ejf.200.1555430418995;
        Tue, 16 Apr 2019 09:00:18 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k51sm3996615ede.40.2019.04.16.09.00.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:00:18 -0700 (PDT)
Subject: Re: [PATCH] libv4lconvert: Add support for V4L2_PIX_FMT_NV12
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media@vger.kernel.org, daniel@qtec.com
References: <20190416120203.24028-1-ricardo@ribalda.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <60e2fc3b-d31f-fd3e-0e1e-2467236dd4e8@redhat.com>
Date:   Tue, 16 Apr 2019 18:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416120203.24028-1-ricardo@ribalda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ricardo,

On 16-04-19 14:02, Ricardo Ribalda Delgado wrote:
> NV12 is a two-plane version YUV 4:2:0, where the U and V components
> are subsampled 2x2.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>

Your patch looks good to me, but it pushed the array-size of
the supported_src_pixfmts array over 64 entries (right now it is
exactly 64 entries big).

Which breaks supported_src_formats as that is only 64 bits big:

struct v4lconvert_data {
         int fd;
	...
         int64_t supported_src_formats; /* bitfield */


See e.g. :

                 for (j = 0; j < ARRAY_SIZE(supported_src_pixfmts); j++)
                         if (fmt.pixelformat == supported_src_pixfmts[j].fmt)
                                 break;

                 if (j < ARRAY_SIZE(supported_src_pixfmts)) {
                         data->supported_src_formats |= 1ULL << j;

I believe this is best fixed by a preparation patch which introduces the
bit-ops from the kernel for this:

include/asm-generic/bitops/non-atomic.h:

static inline void __set_bit(int nr, volatile unsigned long *addr)
{
         unsigned long mask = BIT_MASK(nr);
         unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

         *p  |= mask;
}

static inline void __clear_bit(int nr, volatile unsigned long *addr)
{
         unsigned long mask = BIT_MASK(nr);
         unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

         *p &= ~mask;
}

static inline int test_bit(int nr, const volatile unsigned long *addr)
{
         return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

So you will have to change your patch into a 2 patch patch-set with
the first patch introducing  set_bit / clear_bit / test_bit helpers
modelled after the kernel and changing the declaration of
supported_src_formats to:

	unsigned long supported_src_formats[128 / BITS_PER_LONG];

Thanks & Regards,

Hans









> ---
> The code has ben tested with qv4l2 and vivid.
> v4lconvert_nv12_to_yuv420 has not been tested!!, any suggestions for
> how to do it?
> 
> Thanks!
>   lib/libv4lconvert/libv4lconvert-priv.h |  6 +++
>   lib/libv4lconvert/libv4lconvert.c      | 19 +++++++++
>   lib/libv4lconvert/rgbyuv.c             | 56 ++++++++++++++++++++++++++
>   3 files changed, 81 insertions(+)
> 
> diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
> index a8046ce2..c45b086e 100644
> --- a/lib/libv4lconvert/libv4lconvert-priv.h
> +++ b/lib/libv4lconvert/libv4lconvert-priv.h
> @@ -285,6 +285,12 @@ void v4lconvert_hm12_to_yuv420(const unsigned char *src,
>   void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
>   		int width, int height, int bgr, int Xin, unsigned char hsv_enc);
>   
> +void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
> +		int width, int height, int bgr);
> +
> +void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
> +		int width, int height, int yvu);
> +
>   void v4lconvert_rotate90(unsigned char *src, unsigned char *dest,
>   		struct v4l2_format *fmt);
>   
> diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
> index 78fb3432..2111d19f 100644
> --- a/lib/libv4lconvert/libv4lconvert.c
> +++ b/lib/libv4lconvert/libv4lconvert.c
> @@ -116,6 +116,7 @@ static const struct v4lconvert_pixfmt supported_src_pixfmts[] = {
>   	{ V4L2_PIX_FMT_SN9C20X_I420,	12,	 6,	 3,	1 },
>   	{ V4L2_PIX_FMT_M420,		12,	 6,	 3,	1 },
>   	{ V4L2_PIX_FMT_HM12,		12,	 6,	 3,	1 },
> +	{ V4L2_PIX_FMT_NV12,		12,	 6,	 3,	1 },
>   	{ V4L2_PIX_FMT_CPIA1,		 0,	 6,	 3,	1 },
>   	/* JPEG and variants */
>   	{ V4L2_PIX_FMT_MJPEG,		 0,	 7,	 7,	0 },
> @@ -902,6 +903,24 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
>   		}
>   		break;
>   
> +		/* NV12 formats */
> +	case V4L2_PIX_FMT_NV12:
> +		switch (dest_pix_fmt) {
> +		case V4L2_PIX_FMT_RGB24:
> +			v4lconvert_nv12_to_rgb24(src, dest, width, height, 0);
> +			break;
> +		case V4L2_PIX_FMT_BGR24:
> +			v4lconvert_nv12_to_rgb24(src, dest, width, height, 1);
> +			break;
> +		case V4L2_PIX_FMT_YUV420:
> +			v4lconvert_nv12_to_yuv420(src, dest, width, height, 0);
> +			break;
> +		case V4L2_PIX_FMT_YVU420:
> +			v4lconvert_nv12_to_yuv420(src, dest, width, height, 1);
> +			break;
> +		}
> +		break;
> +
>   		/* compressed bayer formats */
>   	case V4L2_PIX_FMT_SPCA561:
>   	case V4L2_PIX_FMT_SN9C10X:
> diff --git a/lib/libv4lconvert/rgbyuv.c b/lib/libv4lconvert/rgbyuv.c
> index 02c8cb5b..bfe3b15f 100644
> --- a/lib/libv4lconvert/rgbyuv.c
> +++ b/lib/libv4lconvert/rgbyuv.c
> @@ -845,3 +845,59 @@ void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
>   			src += bppIN;
>   		}
>   }
> +
> +void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
> +		int width, int height, int bgr)
> +{
> +	int i, j;
> +	const unsigned char *ysrc = src;
> +	const unsigned char *uvsrc = src + width * height;
> +
> +	for (i = 0; i < height; i++) {
> +		for (j = 0; j < width; j ++) {
> +			if (bgr) {
> +				*dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
> +				*dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
> +				*dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
> +			} else {
> +				*dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
> +				*dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
> +				*dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
> +			}
> +			ysrc++;
> +			if (j&1)
> +				uvsrc += 2;
> +		}
> +
> +		/* Rewind u and v for next line */
> +		if (!(i&1))
> +			uvsrc -= width;
> +	}
> +}
> +
> +void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
> +		int width, int height, int yvu)
> +{
> +	int i, j;
> +	const unsigned char *ysrc = src;
> +	const unsigned char *uvsrc = src + width * height;
> +	unsigned char *ydst = dest;
> +	unsigned char *udst, *vdst;
> +
> +	if (yvu) {
> +		vdst = ydst + width * height;
> +		udst = vdst + ((width / 2) * (height / 2));
> +	} else {
> +		udst = ydst + width * height;
> +		vdst = udst + ((width / 2) * (height / 2));
> +	}
> +
> +	for (i = 0; i < height; i++)
> +		for (j = 0; i < width; j++) {
> +			*ydst++ = *ysrc++;
> +			if (((i % 2) == 0) && ((j % 2) == 0)) {
> +				*udst++ = *uvsrc++;
> +				*vdst++ = *uvsrc++;
> +			}
> +		}
> +}
> 
