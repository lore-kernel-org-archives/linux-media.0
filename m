Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE02C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A02184C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553869490;
	bh=mRW7zouxAGhAXGVJRewMmfDZ2sBtgr9r20JU8ZuI/qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Mp2KG3kCPypYSy8SkrfEM8EUcqjsDqewFQJr6/ydoQgq8GxWyo0TrFtW75ds38Ibl
	 nkLcAJeM1nbYMfCrK/usvBbiGcMOnPI+HrvdhX30PWRxMTtVv6feNr1Y/jWzyvE/gi
	 4tGAa8zhfVSPyDfWoVgYfXfQMUH1sal1Z7BO4LQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfC2OYs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:24:48 -0400
Received: from casper.infradead.org ([85.118.1.10]:38114 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfC2OYs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 10:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7oS0OIOYJez44SZKVf42f4oqlEa8XjJtv70sTbxgb2I=; b=a4WDjgfEqFiMG/Kbspq8ub5R/K
        HUjCpvYpueKtr5W4L652V6qAYbZS0Pe7vm7wD1bduAjQwqMGM7gl9n9dMgkCyn1fI00jaigUP7pda
        fuBPZv0mlBfpdCNs1seSwlpUAZENjSC0ItfyPL9uo9PXWjaUuik3xqOCoLSX3RE016LeqPReVMQ/5
        CDJ8dF+R+iTcJcfEPXO0MfCQtpDdhFa8IHwDnbyjknf+iXTzI0fi0tCRxCaAd2y6yl4+KTv9GtdrI
        ZScPXPeAvurpM98VCfDVCFTDDgqjame/huLos7RZr83l3ja++tVhbo6wcdQYW5f9hTcNeJSzUg0FE
        p4lOwzlA==;
Received: from [179.183.99.176] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9sR2-0006Ay-QI; Fri, 29 Mar 2019 14:24:45 +0000
Date:   Fri, 29 Mar 2019 11:24:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] media: vim2m: Fix RGB 565 BE/LE support
Message-ID: <20190329112440.5fb2632c@coco.lan>
In-Reply-To: <4644eea9-b1d9-e94d-8529-13c0fd947974@xs4all.nl>
References: <a7cdf8b88dadb4c71dccb0afc22409cbd7ff4fe5.1553867066.git.mchehab+samsung@kernel.org>
        <4644eea9-b1d9-e94d-8529-13c0fd947974@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 29 Mar 2019 15:01:23 +0100
Hans Verkuil <hverkuil-cisco@xs4all.nl> escreveu:

> On 3/29/19 2:44 PM, Mauro Carvalho Chehab wrote:
> > The support for those two formats are archtecture-dependent.
> > Use the endianness to CPU macros to do it right.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  drivers/media/platform/vim2m.c | 30 +++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
> > index 3c3a6a03b948..243c82b5d537 100644
> > --- a/drivers/media/platform/vim2m.c
> > +++ b/drivers/media/platform/vim2m.c
> > @@ -302,7 +302,7 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
> >  	switch (in->fourcc) {
> >  	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
> >  		for (i = 0; i < 2; i++) {
> > -			u16 pix = *(u16 *)(src[i]);
> > +			u16 pix = le16_to_cpu(*(__le16 *)(src[i]));
> >  
> >  			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
> >  			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
> > @@ -311,12 +311,11 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
> >  		break;
> >  	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
> >  		for (i = 0; i < 2; i++) {
> > -			u16 pix = *(u16 *)(src[i]);
> > +			u16 pix = be16_to_cpu(*(__be16 *)(src[i]));
> >  
> > -			*r++ = (u8)(((0x00f8 & pix) >> 3) << 3) | 0x07;
> > -			*g++ = (u8)(((pix & 0x7) << 2) |
> > -				    ((pix & 0xe000) >> 5)) | 0x03;
> > -			*b++ = (u8)(((pix & 0x1f00) >> 8) << 3) | 0x07;
> > +			*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
> > +			*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
> > +			*b++ = (u8)((pix & 0x1f) << 3) | 0x07;
> >  		}
> >  		break;
> >  	default:
> > @@ -345,21 +344,26 @@ static void copy_two_pixels(struct vim2m_q_data *q_data_in,
> >  	switch (out->fourcc) {
> >  	case V4L2_PIX_FMT_RGB565: /* rrrrrggg gggbbbbb */
> >  		for (i = 0; i < 2; i++) {
> > -			u16 *pix = (u16 *)*dst;
> > +			u16 pix;
> > +			__le16 *dst_pix = (__le16 *)*dst;
> >  
> > -			*pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> > -			       (*b >> 3);
> > +			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> > +			      (*b >> 3);
> > +
> > +			*dst_pix = cpu_to_le16(pix);
> >  
> >  			*dst += 2;
> >  		}
> >  		return;
> >  	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
> >  		for (i = 0; i < 2; i++) {
> > -			u16 *pix = (u16 *)*dst;
> > -			u8 green = *g++ >> 2;
> > +			u16 pix;
> > +			__be16 *dst_pix = (__be16 *)*dst;
> >  
> > -			*pix = ((green << 8) & 0xe000) | (green & 0x07) |
> > -			       ((*b++ << 5) & 0x1f00) | ((*r++ & 0xf8));
> > +			pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |
> > +			      (*b >> 3);
> > +
> > +			*dst_pix = cpu_to_be16(pix);
> >  
> >  			*dst += 2;
> >  		}
> >   
> 
> Why not just deal with the bytes as u8 values? All the casts and endian
> conversions just make it unnecessarily complicated IMHO.
> 
> E.g. the last case can be replaced by this (if I didn't make any mistakes):
> 
>  	case V4L2_PIX_FMT_RGB565X: /* gggbbbbb rrrrrggg */
>  		for (i = 0; i < 2; i++) {
> 			u8 green = *g++ >> 2;
> 
> 			*(*dst)++ = ((green & 0x07) << 5) | (*b++ >> 3);
> 			*(*dst)++ = ((green & 0x38) >> 3) | (*r++ & 0xf8);
>  		}
> 
> I think that's much better.

I considered that. I opted to use the endiannes way because of two
reasons:

1) when the endiannes matches the CPU endiannes, the function does
nothing and GCC will optimize it. As this function is slow, as it should
be called for every single byte of the image, all optimizations are
welcomed.

2) Both LE and BE conversions are now identical:

   RGB16 -> RGB24:

	*r++ = (u8)(((pix & 0xf800) >> 11) << 3) | 0x07;
	*g++ = (u8)((((pix & 0x07e0) >> 5)) << 2) | 0x03;
	*b++ = (u8)((pix & 0x1f) << 3) | 0x07;

   RGB24 -> RGB16:

	pix = ((*r << 8) & 0xf800) | ((*g << 3) & 0x07e0) |(*b >> 3);

The only thing that differs now is the order where the bytes are read
or written.

IMO, having the same code for the conversion actually makes it a lot
less complex to understand and check its implementation.

Thanks,
Mauro
