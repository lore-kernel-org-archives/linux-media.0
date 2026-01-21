Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C633D6EC;
	Wed, 21 Jan 2026 02:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962849; cv=none; b=UFeS7xHOvuAgh2fQoJS5M2unbp5w4fvcc7ETGV+ShyEL2S5OrOcu2BYqZSOPRjJ5RylPUwhTFw8a3RpgCukbSHNFEla2HHy0aFpdRzDq+bOekyhzjfjjv3E/G23sX2KnUKf3xaJcT8JoBtOvMKf7V4lOkkGS6tfbNamxKhosHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962849; c=relaxed/simple;
	bh=QBNQ/I1r8NovuausWue8wwoPJ7os3wHapXP8evct0vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwJfTGSTcfH4hpWfhwNq9Wkftb4wqpk3LFFSavTRd9Psv6cC630NA7HV4LOA88ieGM6bCkGvxgxNw4JT7bo88zyIU/18He1BwguIXhmo4aFqBC17PBNX9MnDIatflXjcoTAk8Kn0VWdJj6VQBPNrPjuIXHWJ9zfJhVbM39Cb5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EIyCBy58; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EIyCBy58"
Received: from pendragon.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 50D492D7;
	Wed, 21 Jan 2026 03:33:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1768962812;
	bh=QBNQ/I1r8NovuausWue8wwoPJ7os3wHapXP8evct0vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIyCBy582wdwDT/LJgOB1qeQZ8wZqWbjw0jPIerrtHoeF8wOSiQK8c+0WhJRqzlLG
	 GSlzonrPYZiIitU7uTop3HBzIG5gp9UiY1kYE9E/lGnk7vtrnXKXvSP4c2SezWRVad
	 kkI07Skm3d7uLdw03lAnWhsIXGhmid6ouBRHnHHw=
Date: Wed, 21 Jan 2026 04:34:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: media: renesas,fcp: Allow three
 clocks for RZ/V2N SoC
Message-ID: <20260121023402.GA409142@killaraus>
References: <20251103194554.54313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251104120141.GC27255@pendragon.ideasonboard.com>
 <CA+V-a8sP6o2GUju2ub0q1exiV87zHrkTddvkv8GKR_7wBF+vSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8sP6o2GUju2ub0q1exiV87zHrkTddvkv8GKR_7wBF+vSA@mail.gmail.com>

On Mon, Jan 12, 2026 at 04:44:07PM +0000, Lad, Prabhakar wrote:
> On Tue, Nov 4, 2025 at 12:01 PM Laurent Pinchart wrote:
> > On Mon, Nov 03, 2025 at 07:45:54PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Update the FCP DT schema to permit three clock inputs for the RZ/V2N SoC.
> > > The FCP block on this SoC requires three separate clocks, unlike other
> > > variants which use only one.
> > >
> > > Fixes: f42eddf44fbf ("media: dt-bindings: media: renesas,fcp: Document RZ/V2N SoC")
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > > ---
> > > Note, there are no current users of the RZ/V2N FCP compatible string in
> > > the kernel tree.
> > > ---
> > >  Documentation/devicetree/bindings/media/renesas,fcp.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
>
> Can you please pick this patch.

Done. I'll send a pull request as soon as CI finishes.

> > > diff --git a/Documentation/devicetree/bindings/media/renesas,fcp.yaml b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > index cf92dfe69637..b5eff6fec8a9 100644
> > > --- a/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > +++ b/Documentation/devicetree/bindings/media/renesas,fcp.yaml
> > > @@ -77,6 +77,7 @@ allOf:
> > >                - renesas,r9a07g043u-fcpvd
> > >                - renesas,r9a07g044-fcpvd
> > >                - renesas,r9a07g054-fcpvd
> > > +              - renesas,r9a09g056-fcpvd
> > >                - renesas,r9a09g057-fcpvd
> > >      then:
> > >        properties:

-- 
Regards,

Laurent Pinchart
