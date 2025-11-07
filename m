Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7B27B32B
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547950; cv=fail; b=ZLiaxNEQOTIIk+QLlMFSx1Guole0FA0PUToWqYp5m2X1zJTz+mME5zHIu9rlVBnUjRzsNMaLZ8Z5GAZvDQHpTaiTHdS4lK66IKtkV4g44XUMlx9bZyEcc1yZCsTbVi8xApd9FzPRfBjkkn4aeSk1fJpg2ZKITHTz6heJOXgbKig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547950; c=relaxed/simple;
	bh=Y2StE8d4Mo0PGRlJ4c+8dCoa66RKyYo/avlPs28U7Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EnIqwMBHtGv9JZ1nn0mvoYEhpdKLKyRyH5wCNMjwERI060M8fCl636yoVC3jDwBiOzA48B8OcoYRlSTfVWrGYOH+X8mtkc/4lh3gmrwXisk0SW8Vy86L6iojcOlULLMwvFdp0cG2BQXvacydSH9QcEPavPOjZn4hvvpyrLZx+BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iX7Y7RYV; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iX7Y7RYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkamcAwezBx/hnEplIeChcfZa6weHVq7G0uXoVNJMRMGRhIuppchtX4qdOJr4zgrXvc2VLjoJgiN35c5H/BSO8+P5KtWYqAzybWKSUZ6Gp1EqW/IIwXOTFZKhJhihXl8QdjXp9Gzao2ouDsPcWIjgCQBBamCCN2vBW9WVToIQxCSAxQ9+McnWlSZuF87TnEB0wAfsdDv/mAtNjj4w0QX6znnpSW2ZxrvkpqamhCduZg0TzeocFz7dYxOfwF3mvDQuo9CRl4IyPRvudBSkHrN60QU9T57BKqx3enp252Ia3eL/qAlu9mw0E7hVmhFRLFcpANl2ESlnZqMedbIvzqoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SCwfl1Vy054blkjWh9uwxa0v9+w+KyUs/CkhPERbCw=;
 b=DZppfWiwHdMMeTwQXyh6uMQP56fo9eq2hb93PoyR+rzxFt87TLScv49HWCpxRwZLRb62TEgx8ooONU0ixBavctu+b7g/lOeGOV5V4njqjqPBb0gaECYhHgU+ejqPEMWiQl+i1RfsTzEH0Jf0m1xMa6NhttLZbWCD5/RjOnzy/CXubEBdReCtjR+4bLgSWYb158/jIsRQgZr28ZEXUPHA86pYwhzptnkppzB2Cofs6QNXP79Qwl2eli8m5U37PZd0yNPSm8w7oqvqhss3i8M+CyzqNqeuEAWL58S0EsmXlM4vwRceEUkBxxpvfB/lOFtd8940kbEewhwxG3u3N9cEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SCwfl1Vy054blkjWh9uwxa0v9+w+KyUs/CkhPERbCw=;
 b=iX7Y7RYV4qNGvgxNM6sN2BOmkhrFPLdNIsOccdTeTiOqwZIgMPJi3pQ3HsWmWhGrRZVMjafxS7uV5+gRix2O98tZWn9ORLxT95Y85lhs1JSYYZa48UZC2L8nHAw+QDOTZNtfjhmPegO7xV6pLNSkpJcmitLHlAoWDaCBfjHbXUK924rDpCPA/qOIA0scQncRt72pFNFuXfbCIrBBCkj81QozwwU0kIhmdcsaiEfB2Cr0LBlQ09n/SpQgD4SPob7F64IJ3qwlI8QrqutjwmEi1oqzaNACNJSYBfCzEAHdlWXiFViBi6BLqbk2xI/5tnG7iZDhhsrTxxic7vPT4aMCDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:39:04 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:39:04 +0000
Date: Fri, 7 Nov 2025 15:38:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 3/6] media: imx-mipi-csis: Implement the
 .set_routing() operation
Message-ID: <aQ5Y3Qb/6OdQViOS@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>
 <aQ4gAuYsS5jlw/Cv@lizhi-Precision-Tower-5810>
 <20251107183014.GC5558@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107183014.GC5558@pendragon.ideasonboard.com>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: a09ddb75-7e59-469c-810e-08de1e3db0ab
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?3qp/JEMtW9qHnYlT5x5EIHM7xpsi+zKsC9BB0/Ws9MMaVMcgA68BtjnMtFVN?=
 =?us-ascii?Q?pWPcWemQleuMrxH/D323xxcOMVZuOrUDazIa8q4e43SPO9kAPtA9I5z+wHYi?=
 =?us-ascii?Q?yBWcFKWv7CPOOcLGK2/kDTUaWmDfXk39g/lqkDAZYEFyjZQ2vhG3S0KLZs4u?=
 =?us-ascii?Q?weqa0ekkoYjJwvcF5nGLe032fKMSUj626DEPkLhlHiOPYSX2+cxKAvOONPQ9?=
 =?us-ascii?Q?/R8y8T7nuTwID7nyXcwvIoumMiDCqDWcRKndVMCYmd+v/9SBojHkfOft9lLg?=
 =?us-ascii?Q?bK9fMR9wOvgoO7R0CIKjH+hOjMfJLmusChM0FU+zBJXbpeqmt6shTEbZ+d9y?=
 =?us-ascii?Q?XmQr2DE6ycblpj5ZIZ8NfTZsaX3llHj8D5BJJGqwRNGZliOU6/W2OXfu1xHD?=
 =?us-ascii?Q?YDvvxEH2//DZV08BxExoFiJTvdED3Q97nZWjW5obNdcZpm0kGaAD0ItCE0yP?=
 =?us-ascii?Q?2X21bqzfSRGpCGF5pAMpL84Esr0VYXpwKBWwIviwVRw1ZfZb8fpiK9/+B5Za?=
 =?us-ascii?Q?U9ogdrG+zclNYYRC2egEitVFj2ijyKfUB91uFjb0Gg1/9BXWn8cHzfnAoZYC?=
 =?us-ascii?Q?BMPOp9U8/5fDkHdgICJVeEms8ap6JKaVr1qULGpys1fALXJ+pcR+E2qxqErt?=
 =?us-ascii?Q?Gj4I8TVzfhsJyNH1ZKNZi8SaEozIDLYoBATHe0MINzk/Ef1WL2aJrhFyREfH?=
 =?us-ascii?Q?+7CdcuB2ZdZDpOgOAv64Sg6EUm7M5sPkCNfriCDaxRLgw6/uQVLC/G5C9GLH?=
 =?us-ascii?Q?n3znFfa6PAHKG3uKv2EhSdjDV7PaQuD2Q49ktdYxPGp84xcNDHUjjJ5/g2F5?=
 =?us-ascii?Q?IVo1mtL1buAwPeTsizV5y0qJGfB4jlvlAwoIPJy7mbWV2dHdETs0B3f1NqeP?=
 =?us-ascii?Q?hNyJxcKqAlvgF8+ii+oUDi+QJuVZwwpcxZ1RTzDDnC3wgiUNj2CoY7xA4/Pk?=
 =?us-ascii?Q?tx70oyD5pHGdqhE42pBypZWfZ1Tl1ZptVaRjLL1NUZiNNoKueGla6cNHd41n?=
 =?us-ascii?Q?DAq0z8RAwpyzckWAxa1OKwsvfLujc6pAcSHW+5NPr7xG31rVNFOESzmoBaBa?=
 =?us-ascii?Q?q7KPnHR+wOzzB2fINoneU42VJArBZ0lGO+XLMlG+KrywuuHOZyc2gKhtjB8d?=
 =?us-ascii?Q?08RzMvWNxy6D95UcAtAOxcveLnWe7VUMNHz7Pq1mjxxUVqJzyENjHcYKdzes?=
 =?us-ascii?Q?c9ZcgJCPmTBRjtbkoYKxQ6Jj4Qg279Jmxf8eBPEuEjzsqaiK2D3v8tYz5S0m?=
 =?us-ascii?Q?8+eqw4aylhjBI+WSIhjYqRSxyD36z40LUNSvQIUCZ7RT3ufdMbO+iTWcRrj/?=
 =?us-ascii?Q?wzN/4gbVi1JPZQylMa0bS0knEA04Cp/CVUB9bhX8BFUW2zXE1RiSidHn44z3?=
 =?us-ascii?Q?nkgn7jpsQFG5lWYZonxG0Gj0dLCiyz8ApbeUobCKooXEcMhW6vaOosISdNSJ?=
 =?us-ascii?Q?M2CkkKdOxkd/N94xe65+hhFY0jtPxK3mWlsWPSLEIWDhRfXniF8v6nxGCdIX?=
 =?us-ascii?Q?Y7bYfdrwPryi0x/2PDjVR1eO1st5AZUPc1EV?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?9HYs9ouYU43PtjDfhDck4uaVdBSo+9n2kQ23Rzq6vxWb/tcv2N3iaK5BjKlc?=
 =?us-ascii?Q?vWd3awkEn4mB/fbbKC+hKR3Mxap/KIvs4P97PXoGi74hfZWFGoPOELbOyAXg?=
 =?us-ascii?Q?byDMvmBQEmD02wyn/ZhAHqTaLXo9QYZnf7JmNv6+JxABadVRfPoxNN8QbQzQ?=
 =?us-ascii?Q?+o4CjV1r1lW6ZnoRgSJzRdH+gA4EpZ5zBKd9F5Q+JwTQ2v9EicE6DssWxOXx?=
 =?us-ascii?Q?KWwliUfl97OHv1+aa1fnurOCayrWxnBA0xwFDmolKKBjGVe5+pt8VPSasR5g?=
 =?us-ascii?Q?s/7B63apxEE67YoINMW7F2gfOiPVRN2hcuXL4TIPSXNWCwSXlVO25/PYXd19?=
 =?us-ascii?Q?dgLz/aieRNC25zwKe9qfYwWgG7Fl/GcRCEKxXsJ4rtdx/yZk/LzkSMrRTnmy?=
 =?us-ascii?Q?bnAmRvHiUqkdKZOhRSQccC526+ffKaMbt28kd08n0Iy3dGfqZ/tiVhFK2Tke?=
 =?us-ascii?Q?C3q5zL7WaeGz66qXZ+gAmSUGMYT9F07iOtHls+DrFZ2VIIXPvPhw26cVfCaI?=
 =?us-ascii?Q?OOvxSiZnKU3lvsUNGjtCmXQ1ZPZdx5QgJBImp099mudWChIMUvRzfMf1yRc5?=
 =?us-ascii?Q?pBV+3T5Mccxr5ec15ZnMJvsJo3vYla+dNLf9hDpENhyDX0vGgQAkyJHWNLpk?=
 =?us-ascii?Q?p6SRqxVoeAYyQhJIv67VasivVKxm6SUSMiEZu7WExmz+/UKcZ/H3N5V0qJEp?=
 =?us-ascii?Q?CVIKSwF5K3TCfYfwpyQoBeaOZgkdjSGpdCM8JfrwT8yHykYt+fP+50nsBJ2P?=
 =?us-ascii?Q?jAaaqARs39J/bQ8/kaHS+14IZdJvwWhGBe/Ht9w9NOAiiVxKfA2z+nDLE3c3?=
 =?us-ascii?Q?rA07DIYULVFAPsxBUHGEkL5XrBQtLO0bjFWA02XS6itDi3lRbsU6pf/ga5ya?=
 =?us-ascii?Q?Tj57s0fSvGLlsPVM4vrJK2KIP3H8MiFaBReXmNDKKDaHz6jmR5/fcCEfKjwD?=
 =?us-ascii?Q?zGfb8FMj1C9lAFqOafa0uIJfmUE1BoadX4oX3CRyd//wjVcfAsaFcKQiYDmP?=
 =?us-ascii?Q?FN0aPZ/0SJ+4tpxEHTBrjjeW0iXr9VvPe/EAMaVERkh7iST7KupWaMiua3iV?=
 =?us-ascii?Q?Tfm9baWCJQQV7tJC7BZkmtNkxzS03IPvjDj6+2AdSzoMDDt6023dwT12iNjU?=
 =?us-ascii?Q?vQRxyU9gqUnbPTu9Z/PU22WndjWX11AWzjRPolhONUDgmydAf9Zbr2/Nkp4L?=
 =?us-ascii?Q?BQjbKG5mYqy269ywOjX+ONM9cXCSkRgqIHjcx6BbE9hKVJ+p3TMM6e04+AXk?=
 =?us-ascii?Q?fxr/gpGvoWq6wx14PnS0J0of+bu1lM+DntH/NhqDgU471R9vcnuzA52f7dAC?=
 =?us-ascii?Q?du7F/3C1pla6Rj5bjxCsubVNwaA02JdPWH9GlyJH6HNjDxi5dSkf8aCoJ75G?=
 =?us-ascii?Q?8eHIK/MwXID1sr+I19thN14ob9n20h9VQCxhl0ehKEzNtgQvO3GuNp/TA7d9?=
 =?us-ascii?Q?cG+EIpXIlDn1AZE46gs8Y8c3UIeQWoHvt7k02EkSc5qau5NMFQH6DHdKkqZ/?=
 =?us-ascii?Q?sY5+emCE42gXyCHFHuQUmj6dfzN5Eg57C1DCxVr885bhCl1qYlgMhXAV1yha?=
 =?us-ascii?Q?cHVikPK8AU8TY1B9mqY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09ddb75-7e59-469c-810e-08de1e3db0ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:39:04.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITHgJtzXSm+IqO9bzHNY4uNUgOYxWpPGCZylhZr+W8qRkvPYFxLoXz6xkMGqmzW/PqkAANvllPFCpU8rTV0iWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

On Fri, Nov 07, 2025 at 08:30:14PM +0200, Laurent Pinchart wrote:
> On Fri, Nov 07, 2025 at 11:36:18AM -0500, Frank Li wrote:
> > On Fri, Nov 07, 2025 at 03:58:10AM +0200, Laurent Pinchart wrote:
> > > To prepare for multi-stream support, implement the .set_routing()
> > > operation. The routing table is currently hardcoded to a single route.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > >  drivers/media/platform/nxp/imx-mipi-csis.c | 73 ++++++++++++++++++----
> > >  1 file changed, 60 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> > > index f142e79acbcf..f4b19576a235 100644
> > > --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> > > +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> > > @@ -1154,6 +1154,52 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
> > >  	return 0;
> > >  }
> > >
> > > +static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
> > > +				   struct v4l2_subdev_state *state,
> > > +				   struct v4l2_subdev_krouting *routing)
> > > +{
> > > +	static const struct v4l2_mbus_framefmt format = {
> > > +		.width = MIPI_CSIS_DEF_PIX_WIDTH,
> > > +		.height = MIPI_CSIS_DEF_PIX_HEIGHT,
> > > +		.code = mipi_csis_formats[0].code,
> > > +		.field = V4L2_FIELD_NONE,
> > > +		.colorspace = V4L2_XFER_FUNC_709,
> > > +		.ycbcr_enc = V4L2_YCBCR_ENC_601,
> >
> > Is it same as  V4L2_MAP_YCBCR_ENC_DEFAULT(fmt.format.colorspace)
> >
> > > +		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
> >
> > Is it same as
> > 	V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt.format.colorspace,
> >                                             fmt.format.ycbcr_enc);
> >
> > > +		.xfer_func = V4L2_XFER_FUNC_SRGB,
> >
> > Is it same as
> >        V4L2_MAP_XFER_FUNC_DEFAULT(fmt.format.colorspace);
>
> Yes, they're the same.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> > > +	};
> > > +	int ret;
> > > +
> > > +	ret = v4l2_subdev_routing_validate(sd, routing,
> > > +					   V4L2_SUBDEV_ROUTING_NO_1_TO_N);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Only a single route is supported for now. */
> > > +	if (routing->num_routes != 1 ||
> > > +	    !(routing->routes[0].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
> > > +		return -EINVAL;
> > > +
> > > +	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mipi_csis_set_routing(struct v4l2_subdev *sd,
> > > +				 struct v4l2_subdev_state *state,
> > > +				 enum v4l2_subdev_format_whence which,
> > > +				 struct v4l2_subdev_krouting *routing)
> > > +{
> > > +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> > > +
> > > +	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csis->source.enabled_streams)
> > > +		return -EBUSY;
> > > +
> > > +	return __mipi_csis_set_routing(sd, state, routing);
> > > +}
> > > +
> > >  static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
> > >  				    struct v4l2_subdev_state *state,
> > >  				    u32 pad, u64 streams_mask)
> > > @@ -1240,22 +1286,22 @@ static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
> > >  static int mipi_csis_init_state(struct v4l2_subdev *sd,
> > >  				struct v4l2_subdev_state *state)
> > >  {
> > > -	struct v4l2_subdev_format fmt = {
> > > -		.pad = CSIS_PAD_SINK,
> > > +	struct v4l2_subdev_route routes[] = {
> > > +		{
> > > +			.sink_pad = CSIS_PAD_SINK,
> > > +			.sink_stream = 0,
> > > +			.source_pad = CSIS_PAD_SOURCE,
> > > +			.source_stream = 0,
> > > +			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> > > +		},
> > >  	};
> > >
> > > -	fmt.format.code = mipi_csis_formats[0].code;
> > > -	fmt.format.width = MIPI_CSIS_DEF_PIX_WIDTH;
> > > -	fmt.format.height = MIPI_CSIS_DEF_PIX_HEIGHT;
> > > +	struct v4l2_subdev_krouting routing = {
> > > +		.num_routes = ARRAY_SIZE(routes),
> > > +		.routes = routes,
> > > +	};
> > >
> > > -	fmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
> > > -	fmt.format.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt.format.colorspace);
> > > -	fmt.format.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt.format.colorspace);
> > > -	fmt.format.quantization =
> > > -		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt.format.colorspace,
> > > -					      fmt.format.ycbcr_enc);
> > > -
> > > -	return mipi_csis_set_fmt(sd, state, &fmt);
> > > +	return __mipi_csis_set_routing(sd, state, &routing);
> > >  }
> > >
> > >  static int mipi_csis_log_status(struct v4l2_subdev *sd)
> > > @@ -1297,6 +1343,7 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
> > >  	.get_fmt		= v4l2_subdev_get_fmt,
> > >  	.set_fmt		= mipi_csis_set_fmt,
> > >  	.get_frame_desc		= mipi_csis_get_frame_desc,
> > > +	.set_routing		= mipi_csis_set_routing,
> > >  	.enable_streams		= mipi_csis_enable_streams,
> > >  	.disable_streams	= mipi_csis_disable_streams,
> > >  };
>
> --
> Regards,
>
> Laurent Pinchart
