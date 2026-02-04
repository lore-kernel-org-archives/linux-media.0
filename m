Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80903232395;
	Wed,  4 Feb 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211704; cv=none; b=NhFk3qqfA3yvxpJK0g7begdOwHDbSj/OZZAfbFOU8WZjc8qxhMCA4v1h7Cq9Mg0++SVIOMMwca+MC2a35QznSUfY9tNRAuRG2vXQ4skt+i96MhtKbX+eBIPqlPo1CwFjLc5DFlFfIYI42NSGANv0f0L+Au6nvgKKYZ3iXBM0F+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211704; c=relaxed/simple;
	bh=N7u+XCuPg7ooZrjh/omtH2eXFLHztWNIiAKaMOIHINs=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qtjSNXhE7JEwZrwUVaBYpLQ2P+C54jQGdKnVvLwu64psqSgEQXFSp3VX1oEzKeULxcmnbmeN1mxoNxossjfUioMWvqv2SrQeCiafBsnvfXl8PUe+n4ghExDN+vQz3cJTQxKB6rLzBJC+7Pf2hFcL1YnErL8GRJ9a6KlFWTn7z8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=S/MilP84; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="S/MilP84"
Received: from thinkpad.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E385833;
	Wed,  4 Feb 2026 14:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770211660;
	bh=N7u+XCuPg7ooZrjh/omtH2eXFLHztWNIiAKaMOIHINs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=S/MilP8496uV47zy5etQsOQ8A/t2OeFeRCLJY75Bs1RTYIRWoSN5/tGuzPU+F00kO
	 rQdT83agQrysXHwyRZFCOzEjAhzRelxztWx5t+IXmn1jOjXm4zFSNail7heqAcwlXr
	 4Y04R+hkNPcdT6kEcQMN9K6IhcLPJ9s+W2thFYDY=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260204113710.GA156228@killaraus>
References: <20260204112506.3706049-1-isaac.scott@ideasonboard.com> <20260204112506.3706049-4-isaac.scott@ideasonboard.com> <20260204113710.GA156228@killaraus>
Subject: Re: [PATCH v1 3/6] media: rkisp1-isp: Add target_format
From: Isaac Scott <isaac.scott@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dafna@fastmail.com, mchehab@kernel.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 04 Feb 2026 13:28:19 +0000
Message-ID: <177021169954.3716406.14336965804921334134@isaac-ThinkPad-T16-Gen-2>
User-Agent: alot/0.10

Hi Laurent,

Thank you for the review!

Quoting Laurent Pinchart (2026-02-04 11:37:10)
> On Wed, Feb 04, 2026 at 11:25:03AM +0000, Isaac Scott wrote:
> > In passthough mode, we want to make sure the output format of the ISP is
> > identical to the input format. Add logic to ensure the format we
> > configure the output of the ISP with is the sink format when we are in
> > bypass, and the source format if we are not.
>=20
> I don't think that's right. In bypass mode, userspace needs to configure
> the same format on the image sink and image source pads of the ISP, and
> not set any cropping. The crop rectangle on the source pad should
> contain the information you need.
>=20

Yes, that makes sense. I suppose the idea here was to "enforce" it, but
perhaps we shouldn't be potentially overwriting a format userspace is
setting. I'll take another look for v2.

Best wishes,
Isaac

> > Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
> > ---
> >  drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/driv=
ers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > index f636d738b7e8..716bd7f3c66d 100644
> > --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > @@ -175,9 +175,10 @@ static void rkisp1_gasket_disable(struct rkisp1_de=
vice *rkisp1)
> >  static void rkisp1_config_ism(struct rkisp1_isp *isp,
> >                             const struct v4l2_subdev_state *sd_state)
> >  {
> > -     const struct v4l2_rect *src_crop =3D
> > +     const struct v4l2_rect *target_crop =3D
> >               v4l2_subdev_state_get_crop(sd_state,
> > -                                        RKISP1_ISP_PAD_SOURCE_VIDEO);
> > +                     (isp->rkisp1->in_bypass ?
> > +                             RKISP1_ISP_PAD_SINK_VIDEO : RKISP1_ISP_PA=
D_SOURCE_VIDEO));
> >       struct rkisp1_device *rkisp1 =3D isp->rkisp1;
> >       u32 val;
> > =20
> > @@ -185,10 +186,10 @@ static void rkisp1_config_ism(struct rkisp1_isp *=
isp,
> >       rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_MAX_DX, 0);
> >       rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_MAX_DY, 0);
> >       rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_DISPLACE, 0);
> > -     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_H_OFFS, src_crop->left);
> > -     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_V_OFFS, src_crop->top);
> > -     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_H_SIZE, src_crop->width);
> > -     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_V_SIZE, src_crop->height);
> > +     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_H_OFFS, target_crop->left);
> > +     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_V_OFFS, target_crop->top);
> > +     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_H_SIZE, target_crop->width=
);
> > +     rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_V_SIZE, target_crop->heigh=
t);
> > =20
> >       /* IS(Image Stabilization) is always on, working as output crop */
> >       rkisp1_write(rkisp1, RKISP1_CIF_ISP_IS_CTRL, 1);
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
