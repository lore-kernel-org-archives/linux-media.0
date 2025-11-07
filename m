Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549C329396
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541077; cv=none; b=tVi98lZ+degqc3djAIg9seq3RwYPW0Ul/gZandgHSS4kuGRx0KT9tUIdvSDjolfWtFBS6i0ByGsi8ijYvPadVyEm6vE79P6qu0y0tB68AGJSY0sKOzkRiLKIdT/5PPaAH4SOq+7D2AQcW/Gi2E2ashNUjrzkd3Ksiyx7jeW2MkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541077; c=relaxed/simple;
	bh=27RUtw6Eea5nu4M4bsLtRDG2tXxgGK12MfBmueOq/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK96o0TjhAn7mSpwMNrD40JTafiJ4Hz2hLho/bC54Z9V5DpqPzqtKC7KVWA7rrGDBKyqm/Eiz7WG49knfTiYHsFmecvoPrBxnsfWlYq/RZkIsGX+syI/mJDoyHa19M9s0QG7JDPALU7kV9v8bIKBqzafKMSBQkKY66emX8ahabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iAepoCfQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iAepoCfQ"
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 94650111F;
	Fri,  7 Nov 2025 19:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762540958;
	bh=27RUtw6Eea5nu4M4bsLtRDG2tXxgGK12MfBmueOq/RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAepoCfQEx2k7T4QACua9ihSdZe2S0fehDHxBkuyIFwCsmZF9oqHTVVuS2PuFEHcS
	 V9bpU4KfZ52OM4YAok2suAWnxBRrLOOEU2cvaeFlWSu3wRwPic7sPss8DU/1ORYScv
	 eUYjSzABqy3ttzhoh8TOX0rgc1N+Ciu1mD4hkXpQ=
Date: Fri, 7 Nov 2025 20:44:29 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 1/6] media: imx-mipi-csis: Add VC-related register
 fields
Message-ID: <20251107184429.GF5558@pendragon.ideasonboard.com>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-2-laurent.pinchart@ideasonboard.com>
 <aQ4cKf3y1zqwBmar@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ4cKf3y1zqwBmar@lizhi-Precision-Tower-5810>

On Fri, Nov 07, 2025 at 11:19:53AM -0500, Frank Li wrote:
> On Fri, Nov 07, 2025 at 03:58:08AM +0200, Laurent Pinchart wrote:
> > The CMN_CTRL and ISPCFG registers have fiels related to virtual channel
> > handling. In CMN_CTRL, the INTERLEAVE_MODE field is 2 bits wide, and
> > controls filtering by DT, VC or both. The VC number is then set in the
> > ISPCFG.VIRTUAL_CHANNEL field.
> >
> > Expand the definition of the register macros to support those features,
> > and set the VC ID to 0 explicitly instead of relying on the default
> > register value. This prepares for VC filtering but does not modify the
> > driver's behaviour.
> >
> > While at it, use GENMASK in the last few register mask macros that don't
> > use it.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/media/platform/nxp/imx-mipi-csis.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> ...
> >
> >  	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
> > -	val &= ~MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK;
> > +	val &= ~(MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK |
> > +		 MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_MASK);
> > +
> >  	val |= MIPI_CSIS_CMN_CTRL_LANE_NUMBER(lanes - 1);
> > +
> >  	if (csis->info->version == MIPI_CSIS_V3_3)
> >  		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT;
> > +
> 
> above two empty line is not related this patch

It's just a matter of giving the code more room to breathe. I can move
them to patch 6/6 if you prefer.

> >  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
> >
> >  	__mipi_csis_set_format(csis, format, csis_fmt);

-- 
Regards,

Laurent Pinchart
