Return-Path: <SRS0=ylfx=ST=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CAC10F12
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5300206BA
	for <linux-media@archiver.kernel.org>; Wed, 17 Apr 2019 10:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfDQKEY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:04:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40794 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQKEX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Apr 2019 06:04:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so448163ljq.7
        for <linux-media@vger.kernel.org>; Wed, 17 Apr 2019 03:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak+jmpp1HmYyAKt+dFTAzg8Ce6xo9KUHB/jOnf1cq/I=;
        b=lcmP3AEm9/ZZI3rXWl688gKnX5Pcgxb4AerqH5ATW8i0CG1xux3Vl+KCpDLzNGrrlx
         8RFp20o2FT7typEjgrFIqkSyUbflE6uyNiGrdQmkMpm+yz71C4BpVM3MaTKWjEGPbhLP
         CynUV8Q7kRetr/pLfVAH09kRxsmS3ylkjIm/Sz1ON/eWsGl7Pa5slTrlAZsulk5u3WHi
         TSsphUj6Ea6EDcdwuJmLPIN0bLa7kRDs9LPP75Hct/rl8d8GlELZWKzebFSg5YgTHCom
         O8fkAUQ1dYqUZvkUmpIkuPDYNQhKqTI+7mEUZEMFqE23r1DnrVejiZrnXopWRBT6Wsc1
         GF0g==
X-Gm-Message-State: APjAAAXu4eVmoQzkVp8OZvmLA7Jxi+k5JesNxx4WNXbV9YKuRu3++Emf
        ueH9s+/5uaOxQFfVd6oz2XPKlt3hvMd4px/xXDs=
X-Google-Smtp-Source: APXvYqw/48/eZ+PQ2999m/Ftbk8p//GNrFx70Uvhou+LlLZYfrGO5q+CL9G7Q9S+MVb2OWqtBVYFl1T2yvRZcZ+Lh9Q=
X-Received: by 2002:a2e:7c02:: with SMTP id x2mr7725639ljc.176.1555495460910;
 Wed, 17 Apr 2019 03:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190416120203.24028-1-ricardo@ribalda.com> <60e2fc3b-d31f-fd3e-0e1e-2467236dd4e8@redhat.com>
In-Reply-To: <60e2fc3b-d31f-fd3e-0e1e-2467236dd4e8@redhat.com>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Wed, 17 Apr 2019 12:04:04 +0200
Message-ID: <CAPybu_3Fe8ABY5B=iu7rxa+==oCzPiefrHat7drd7iPMvw1UqA@mail.gmail.com>
Subject: Re: [PATCH] libv4lconvert: Add support for V4L2_PIX_FMT_NV12
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Gregor Jasny <gjasny@googlemail.com>,
        linux-media <linux-media@vger.kernel.org>,
        Daniel Gomez <daniel@qtec.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans

On Tue, Apr 16, 2019 at 6:00 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> On 16-04-19 14:02, Ricardo Ribalda Delgado wrote:
> > NV12 is a two-plane version YUV 4:2:0, where the U and V components
> > are subsampled 2x2.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
>
> Your patch looks good to me, but it pushed the array-size of
> the supported_src_pixfmts array over 64 entries (right now it is
> exactly 64 entries big).
>
> Which breaks supported_src_formats as that is only 64 bits big:

Good catch. Thanks for detailed description. Will redo and send back


>
> struct v4lconvert_data {
>          int fd;
>         ...
>          int64_t supported_src_formats; /* bitfield */
>
>
> See e.g. :
>
>                  for (j = 0; j < ARRAY_SIZE(supported_src_pixfmts); j++)
>                          if (fmt.pixelformat == supported_src_pixfmts[j].fmt)
>                                  break;
>
>                  if (j < ARRAY_SIZE(supported_src_pixfmts)) {
>                          data->supported_src_formats |= 1ULL << j;
>
> I believe this is best fixed by a preparation patch which introduces the
> bit-ops from the kernel for this:
>
> include/asm-generic/bitops/non-atomic.h:
>
> static inline void __set_bit(int nr, volatile unsigned long *addr)
> {
>          unsigned long mask = BIT_MASK(nr);
>          unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>
>          *p  |= mask;
> }
>
> static inline void __clear_bit(int nr, volatile unsigned long *addr)
> {
>          unsigned long mask = BIT_MASK(nr);
>          unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
>
>          *p &= ~mask;
> }
>
> static inline int test_bit(int nr, const volatile unsigned long *addr)
> {
>          return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
> }
>
> So you will have to change your patch into a 2 patch patch-set with
> the first patch introducing  set_bit / clear_bit / test_bit helpers
> modelled after the kernel and changing the declaration of
> supported_src_formats to:
>
>         unsigned long supported_src_formats[128 / BITS_PER_LONG];
>
> Thanks & Regards,
>
> Hans
>
>
>
>
>
>
>
>
>
> > ---
> > The code has ben tested with qv4l2 and vivid.
> > v4lconvert_nv12_to_yuv420 has not been tested!!, any suggestions for
> > how to do it?
> >
> > Thanks!
> >   lib/libv4lconvert/libv4lconvert-priv.h |  6 +++
> >   lib/libv4lconvert/libv4lconvert.c      | 19 +++++++++
> >   lib/libv4lconvert/rgbyuv.c             | 56 ++++++++++++++++++++++++++
> >   3 files changed, 81 insertions(+)
> >
> > diff --git a/lib/libv4lconvert/libv4lconvert-priv.h b/lib/libv4lconvert/libv4lconvert-priv.h
> > index a8046ce2..c45b086e 100644
> > --- a/lib/libv4lconvert/libv4lconvert-priv.h
> > +++ b/lib/libv4lconvert/libv4lconvert-priv.h
> > @@ -285,6 +285,12 @@ void v4lconvert_hm12_to_yuv420(const unsigned char *src,
> >   void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
> >               int width, int height, int bgr, int Xin, unsigned char hsv_enc);
> >
> > +void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
> > +             int width, int height, int bgr);
> > +
> > +void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
> > +             int width, int height, int yvu);
> > +
> >   void v4lconvert_rotate90(unsigned char *src, unsigned char *dest,
> >               struct v4l2_format *fmt);
> >
> > diff --git a/lib/libv4lconvert/libv4lconvert.c b/lib/libv4lconvert/libv4lconvert.c
> > index 78fb3432..2111d19f 100644
> > --- a/lib/libv4lconvert/libv4lconvert.c
> > +++ b/lib/libv4lconvert/libv4lconvert.c
> > @@ -116,6 +116,7 @@ static const struct v4lconvert_pixfmt supported_src_pixfmts[] = {
> >       { V4L2_PIX_FMT_SN9C20X_I420,    12,      6,      3,     1 },
> >       { V4L2_PIX_FMT_M420,            12,      6,      3,     1 },
> >       { V4L2_PIX_FMT_HM12,            12,      6,      3,     1 },
> > +     { V4L2_PIX_FMT_NV12,            12,      6,      3,     1 },
> >       { V4L2_PIX_FMT_CPIA1,            0,      6,      3,     1 },
> >       /* JPEG and variants */
> >       { V4L2_PIX_FMT_MJPEG,            0,      7,      7,     0 },
> > @@ -902,6 +903,24 @@ static int v4lconvert_convert_pixfmt(struct v4lconvert_data *data,
> >               }
> >               break;
> >
> > +             /* NV12 formats */
> > +     case V4L2_PIX_FMT_NV12:
> > +             switch (dest_pix_fmt) {
> > +             case V4L2_PIX_FMT_RGB24:
> > +                     v4lconvert_nv12_to_rgb24(src, dest, width, height, 0);
> > +                     break;
> > +             case V4L2_PIX_FMT_BGR24:
> > +                     v4lconvert_nv12_to_rgb24(src, dest, width, height, 1);
> > +                     break;
> > +             case V4L2_PIX_FMT_YUV420:
> > +                     v4lconvert_nv12_to_yuv420(src, dest, width, height, 0);
> > +                     break;
> > +             case V4L2_PIX_FMT_YVU420:
> > +                     v4lconvert_nv12_to_yuv420(src, dest, width, height, 1);
> > +                     break;
> > +             }
> > +             break;
> > +
> >               /* compressed bayer formats */
> >       case V4L2_PIX_FMT_SPCA561:
> >       case V4L2_PIX_FMT_SN9C10X:
> > diff --git a/lib/libv4lconvert/rgbyuv.c b/lib/libv4lconvert/rgbyuv.c
> > index 02c8cb5b..bfe3b15f 100644
> > --- a/lib/libv4lconvert/rgbyuv.c
> > +++ b/lib/libv4lconvert/rgbyuv.c
> > @@ -845,3 +845,59 @@ void v4lconvert_hsv_to_rgb24(const unsigned char *src, unsigned char *dest,
> >                       src += bppIN;
> >               }
> >   }
> > +
> > +void v4lconvert_nv12_to_rgb24(const unsigned char *src, unsigned char *dest,
> > +             int width, int height, int bgr)
> > +{
> > +     int i, j;
> > +     const unsigned char *ysrc = src;
> > +     const unsigned char *uvsrc = src + width * height;
> > +
> > +     for (i = 0; i < height; i++) {
> > +             for (j = 0; j < width; j ++) {
> > +                     if (bgr) {
> > +                             *dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                             *dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                             *dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                     } else {
> > +                             *dest++ = YUV2R(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                             *dest++ = YUV2G(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                             *dest++ = YUV2B(*ysrc, *uvsrc, *(uvsrc + 1));
> > +                     }
> > +                     ysrc++;
> > +                     if (j&1)
> > +                             uvsrc += 2;
> > +             }
> > +
> > +             /* Rewind u and v for next line */
> > +             if (!(i&1))
> > +                     uvsrc -= width;
> > +     }
> > +}
> > +
> > +void v4lconvert_nv12_to_yuv420(const unsigned char *src, unsigned char *dest,
> > +             int width, int height, int yvu)
> > +{
> > +     int i, j;
> > +     const unsigned char *ysrc = src;
> > +     const unsigned char *uvsrc = src + width * height;
> > +     unsigned char *ydst = dest;
> > +     unsigned char *udst, *vdst;
> > +
> > +     if (yvu) {
> > +             vdst = ydst + width * height;
> > +             udst = vdst + ((width / 2) * (height / 2));
> > +     } else {
> > +             udst = ydst + width * height;
> > +             vdst = udst + ((width / 2) * (height / 2));
> > +     }
> > +
> > +     for (i = 0; i < height; i++)
> > +             for (j = 0; i < width; j++) {
> > +                     *ydst++ = *ysrc++;
> > +                     if (((i % 2) == 0) && ((j % 2) == 0)) {
> > +                             *udst++ = *uvsrc++;
> > +                             *vdst++ = *uvsrc++;
> > +                     }
> > +             }
> > +}
> >



--
Ricardo Ribalda
