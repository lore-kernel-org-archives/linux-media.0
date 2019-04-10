Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A8C10F14
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BD420818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oj3dV0sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfDJOF6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:05:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35734 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfDJOF5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 10:05:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3AE5ZQU106522;
        Wed, 10 Apr 2019 09:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554905135;
        bh=7kJabIkqehzwzCr0GfdO606b8GtduLrExnAaosatFwI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=oj3dV0sqLvQZ1r/5XQnw3KkvDmfIvrnhKORk4G4phFzWa6k5sYbA7f2fJdq9knTst
         SRs5XHdbhcYn9IQAMdP82aDZwTurq6BFtLoM0ZddkXnhKT3O4HxgcYo0UOM1n57FHh
         eDthNT4jKDiNKyvh9rfxpImc8IXtjIqgTI2vXcAc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3AE5ZMv069534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Apr 2019 09:05:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 10
 Apr 2019 09:05:34 -0500
Received: from DLEE103.ent.ti.com ([fe80::b585:e28:33f:1ca0]) by
 DLEE103.ent.ti.com ([fe80::b585:e28:33f:1ca0%18]) with mapi id
 15.01.1713.004; Wed, 10 Apr 2019 09:05:34 -0500
From:   "Scheurer, Amber" <amber@ti.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?iso-8859-1?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Parrot, Benoit" <bparrot@ti.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Andrzej Hajda" <a.hajda@samsung.com>
Subject: RE: [EXTERNAL] Re: [PATCH] media: omap_vout: potential buffer
 overflow in vidioc_dqbuf()
Thread-Topic: [EXTERNAL] Re: [PATCH] media: omap_vout: potential buffer
 overflow in vidioc_dqbuf()
Thread-Index: AQHU74s6wpq2f+a2KU+qdL664QWGa6Y1kcuA///b6FA=
Date:   Wed, 10 Apr 2019 14:05:34 +0000
Message-ID: <18d5658c970a454b9a0e71fb24055c1f@ti.com>
References: <20190409112924.GA13643@kadam>
 <eb4fe291-85b5-540b-c210-5e9fb051f2cc@xs4all.nl>
 <20190410111415.GB31633@kadam>
In-Reply-To: <20190410111415.GB31633@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.117.99.194]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I think you might have the wrong Amber copied on this email.=20

Amber

-----Original Message-----
From: Dan Carpenter [mailto:dan.carpenter@oracle.com]=20
Sent: Wednesday, April 10, 2019 6:14 AM
To: Hans Verkuil
Cc: Mauro Carvalho Chehab; Scheurer, Amber; Niklas S=F6derlund; Philipp Zab=
el; Parrot, Benoit; linux-media@vger.kernel.org; kernel-janitors@vger.kerne=
l.org; Andrzej Hajda
Subject: [EXTERNAL] Re: [PATCH] media: omap_vout: potential buffer overflow=
 in vidioc_dqbuf()

On Wed, Apr 10, 2019 at 12:50:31PM +0200, Hans Verkuil wrote:
> On 4/9/19 1:29 PM, Dan Carpenter wrote:
> > diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/pl=
atform/omap/omap_vout.c
> > index 37f0d7146dfa..15e38990e85a 100644
> > --- a/drivers/media/platform/omap/omap_vout.c
> > +++ b/drivers/media/platform/omap/omap_vout.c
> > @@ -1527,8 +1527,6 @@ static int vidioc_dqbuf(struct file *file, void *=
fh, struct v4l2_buffer *b)
> >  	unsigned long size;
> >  	struct videobuf_buffer *vb;
> > =20
> > -	vb =3D q->bufs[b->index];
> > -
> >  	if (!vout->streaming)
> >  		return -EINVAL;
> > =20
> > @@ -1539,6 +1537,8 @@ static int vidioc_dqbuf(struct file *file, void *=
fh, struct v4l2_buffer *b)
> >  		/* Call videobuf_dqbuf for  blocking mode */
> >  		ret =3D videobuf_dqbuf(q, (struct v4l2_buffer *)b, 0);
>=20
> We need a:
>=20
> 	if (ret)
> 		return ret;
>=20
> here. Or alternatively, add 'if (!ret)' around the next five lines.
>=20
> b->index is only valid if the videobuf_dqbuf call returned 0.
>=20

Doh.  Thanks.

regards,
dan carpenter

