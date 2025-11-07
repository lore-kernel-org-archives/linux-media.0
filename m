Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2B328B79
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533447; cv=fail; b=ipSN6jQTfO5T/g1ir1fQn8zW1Sf8xioGyt2J4sMeMASvwzAduRfP6TZAwVsZPtXdQ39+syggJdXSHuYpEu3UuvTZaAWuzpxxVE79LpIrzNNOcIxSPCGqmc+1AtALwg2MdVWry9sDKEgeohBevoYrYpyPTFvqAMz22Rnq6e68Fso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533447; c=relaxed/simple;
	bh=rnMR8XT8dxGxzpLMYtMfHz8J2PUjwPaDFFT/5Q/RQy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbzxXrSKo+ONXw+mXA1VagHqr3vlbsz0KeNT8+gnG329JATAMDU1gRPF/770cKpem5TI9DHciRwtVzZnAPY0GmUnt/ixrfwWALhQDyQyGfSwLBHz0hzQeaB4TTUAWt6v8sv8muNJpFnGpM1R9z9BBrgbvEKIz+/K2F79Zdgn//8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xc9dG0Z4; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xc9dG0Z4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAcUZ8zw3yfHDXy5dJFFJMZNo4NFjd8TN9cPZRy39unoJ7TMj6TmNn2HaytHc9QBAzZFQxvOtAAfLGDCnEd1djcxgf1DiqpR3pIv5dTR5+o+Ltk82pLoa+GK5p271Dh8qQt42+YsGvXjwC25IbyAi7BMOMEjOIit936KC0DYMx8o9cx0kcQkdRCOp/7xmieGtBvwdb6f2fiTnDy6m8pL47zWc94PKoyJG8TzE+kBMVIpphZyUgiRRQ/h/gnqFmIvyBvhdWa6odn0y3Qt85x7PsnFnilysbRWBmYMHtNRoo60lGZLFHU9XdENcz1xe5wqwKSx3iieGg3wemCcZRvZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1d4z/oxk4tYBBlPc8/W7nzBN7rYDHfDI51Ahva7Ok4=;
 b=bpKn9g53u1lHfV8Kq165C6oQVn+OJdb3SDpLEhHCB0tb0pM0qm3DufIk7ttb6eYry9HI2kchruv2Xoa53AGzzvI3uj3lzd31gcvCSMWji/21XZO+iOq7ho3ln4HmU4J5KcuTwN3G7v4WnKjDeUkU5Wk45dJK5O/5i5dCbhn6SF4gHfhi3scndP3/wYodeHoY75mL/GH1jdFG+6+erxIwk8l2h+ZVMLNhKfMOkSPbTsZDKkMuiBhLgImR8ptP4zmHruNLex4xYb3lZ9bSTTOx23o4+BgccNuJyyXiJbynwBtxm+Bp2Ndrdr+EFqNcdHvBi/H8xVz0NPv9Iqw0XGNBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1d4z/oxk4tYBBlPc8/W7nzBN7rYDHfDI51Ahva7Ok4=;
 b=Xc9dG0Z4A2NMsnuAeF9DglrDXFwjSfNoJXYvJqibtTGEGL59SGRJpVgHFHEbvgDOhv8TWXTiaV8RBBIyTF9QRmcr5I1QwRsvQcmUfVBNpIhB1yzYnOKJdYIxxqslvTayHGJD+S/MbBV0n0SvRWuwKB9vhEpXdjlJLtDYRgUlivuswcRK/qqGdlUDPbNtA60IqQ9LvdAI709MC2sXhuogTv6KjCpaDRMIOWo5rNJLSeypqvjdqZxmZKQcgRR4x+WeXZw+tx2Al53BCfDLR+qc3ia0vV2S0eO5rwaZqExkjRj4GaPyTGtZuaZP0QOVT8Mq+wNCsNWR9WmAZ+brRHcy2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:37:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:37:22 +0000
Date: Fri, 7 Nov 2025 11:37:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 5/6] media: imx-mipi-csis: Set all per-channel
 registers in one function
Message-ID: <aQ4gOqoV8tM65ojJ@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-6-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-6-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe9df89-73ba-4e31-dd2b-08de1e1bed02
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?KSGAc8ytoGmgWQou/5avSFEMVPFT4wMpiGgCdFdAe71I/0CTwM6QVjvTjSSh?=
 =?us-ascii?Q?lap2lnLnjlpbAJAXMvixfUqEXKZUl16gapPGy/yrI1cyu9LOMwhuwHUUszKH?=
 =?us-ascii?Q?smtFkz83CJry+0+iu31SFYfEHTqSI+MmG1EWtA5xeAdajyaDjOrHvYM+d1yu?=
 =?us-ascii?Q?14lPDKUJuXL0gS5S4B3l0H6x4NOhwOLMINja3VhXXoviKIfgNyyFzE6GkdVP?=
 =?us-ascii?Q?2tYchCQWHuNUU410+p1GRjgwUMq4UXuACue82zXtOEbgikHDKXCQLRLRhpPm?=
 =?us-ascii?Q?h2N2qTPvvd2K2Q1sYfMGAbvKEDlvilodZl9FzpwwPRpKy4dsksQodqXMNHoF?=
 =?us-ascii?Q?15FP3nqXca+hfG8iFwOjtMP2UTx0/dtsvHP83M/wI/0ovg3GLmcauAHgs1Lt?=
 =?us-ascii?Q?UGUBZRNXXE3sXp3d0t+LdWkE++8RsHqU47bACmLDxD6Orw0YPVlFBpGbc9Sf?=
 =?us-ascii?Q?dxM8ya9oMDLgUhHXhmCSxBkaHeHn1HLDZUV+5u4eLn+UN6G9ksN/7wJR9lOA?=
 =?us-ascii?Q?xbgkbx23uGHaVbJ9VXB0wZCjLTDcBPHiny+ZoCoLqHRQR19i+Yl8vAZSCUKa?=
 =?us-ascii?Q?l1vdOTqJo7Fs2M7Fv3XqihhPvimHRQgzJrfTijyfZzGfqpXl8SQ6O5IkQ5wZ?=
 =?us-ascii?Q?wXHFU4jFYWi+9YvjyqFkQVd+k6cFnN5ajDHIvWwisl5rvaD5zML1RpqbM2Y8?=
 =?us-ascii?Q?Ugdm62U6XfEM8Bcgu6Uhvr3vTp+/Ktjvxu0PNzi8QXyGPH5n6mBi4w6VgRU2?=
 =?us-ascii?Q?bb1WrtT00sTZa20fViDW3nrzaONJLLozDyrl7YuIsL/c+Ss20/rlbNQhReDw?=
 =?us-ascii?Q?rozXTk10BK3IgSCLKN/NEhWDwV3vUDWp4gsXsZwoDvG3+oc44SfmY5FG4bOk?=
 =?us-ascii?Q?eadeP1jdUI+oxIc1tGSMZDECbq3NUsKabMyVjFIyx/qWxODF1xm5JZRVxYpU?=
 =?us-ascii?Q?05rbg90sFZmU+cX61wBhrm/kwINdph4c0wB74NOHBCR6qPVvRxNZrLB28MF3?=
 =?us-ascii?Q?kO+zbmJt5xZ1WtzvvT63zo2l9o/5C2QoRlgSm3/NgJIZ/9uMVZDRc27RuVuk?=
 =?us-ascii?Q?PuxvOrRDA+pbwptipsCBzkc7UFHQH0ZdqHdGnQubidD/xs3MTcBYw/bkxJAd?=
 =?us-ascii?Q?IBS1QSFBNGhQqdDEMi1p3YilfjFoOrTKSqC+c/SmZmN3tpbp/l7RznXWhbQi?=
 =?us-ascii?Q?dfm7WDFLvNaCBciKy4Ow8N5Qt/UQRq3TSnNmCMjWO6bK+T/pgK7j3kWuwHhy?=
 =?us-ascii?Q?HEqQ8Yl97lKqY2xU3SuOr7AbZ7fphri2Rn5euM+KY6/pJF/QqQ0n/RVnMFJJ?=
 =?us-ascii?Q?+YhHNOoSN35wv4pPhx6eIO/S6YBfyoaV6jG88a05bzZZKW4MCMcNXE+R5bW+?=
 =?us-ascii?Q?NSBy4KpY7hs35jVeWBsDPjig30f5AAbzcX25gdBh8KOZDwjuulf8tbCJQdww?=
 =?us-ascii?Q?iw7Dp3mcIuupM9lvsRpRR6f33FgpRkEZpj5ZnGkRWHhgHAulKUZZ2+ODoPkn?=
 =?us-ascii?Q?x7gw65bL2bpJ5KmCFazjIDxjKyxf6mNuPFd5?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?xjkz0txbPmva/VQSXj2HxpWX9E4s058IApo/BfT+8Kqv9r7iDZ/J5/RcnT8u?=
 =?us-ascii?Q?HB8iguaMoPP1ILUiLJKO3C03cgoChYLz5QvcpKZFubz3CtUyegfoKGP/MHy/?=
 =?us-ascii?Q?8Id8VABRIMg+A46v5Z4fJFyBMKhieVAGM46+LB/irZLaGfGukimXjkIj542R?=
 =?us-ascii?Q?s7QQm6fXwHZV5t0YrJJ93S070G2MidB+r1QpfnEMPXs0OtEg+cdIuMnW/d7z?=
 =?us-ascii?Q?iW+6Oo6Z1imgsgTMdklfKop+o2bfNyR1xgR8vROjh0K4ajLT2SdKLjahFC31?=
 =?us-ascii?Q?KXPk1aacQAWZ1FFWOGISzwC5jKtFSvqXTZdFntwvBvKo95PugHci8UIiRVj2?=
 =?us-ascii?Q?wlbmzsel1sdwSjLHt3AuPlVRamARpM+RKbjscAs8dCzDI0wfb2VKSlZzzmqM?=
 =?us-ascii?Q?42tOc8y1Ob+s1F7YL9EO3tA7VeilyeSFv1INlaznNJ6CvTWrtfgS8C8ZYMmU?=
 =?us-ascii?Q?SWE6LA+5PlgyWV2KZwF/JUbb7JaE28+tb3Cr9/X4R13xCR2Eh7pp+HVmcXaP?=
 =?us-ascii?Q?6gvqaRci7Ei2TZVLy+zkzm7p0snQZuy/bjfwgM3N/cblXQTS35rUIGtfOoVf?=
 =?us-ascii?Q?4ImhwBZmIXWmKGDqH42OBE7RRjvzi32z9icGKO/Llhl5Rp6GmKOMNTamqU8r?=
 =?us-ascii?Q?9fKR+L+mIT9Dg7Wxff8XDZ02u8l+g2e1Rq1Tlvl1FKQFmpG5w14wWwoAShtC?=
 =?us-ascii?Q?vQ59MMig2HfPyIJa2mDO5LsjjRGLy1IwNQ6ymiGndsKnNyHqeKLtS/9LdSrn?=
 =?us-ascii?Q?1lFXqDjNkMkNymerqCHdSFy01lLxKjgS3Cr/J+UWpguEMXOZ/sEHm26APJpb?=
 =?us-ascii?Q?zpAX2LStEXS+f71FCmI6H+bQm0URhDm+sF5rP9W4F5iTxsQWsxgRt3VO1tgN?=
 =?us-ascii?Q?81FnmGViw7VHpiMNryL874NaU5U12vuqekx41vuNV+xEzm5ce/MxQnN0OrAW?=
 =?us-ascii?Q?5szNXU8gbr3Ha5in0hVF3CoOZrTUihQjGY87l04mFyXmBaD9dlxVgHguQzle?=
 =?us-ascii?Q?tMBPtSqp+nGKEUyRSxuJwplIjjziwLt/AEya6QeqWJJozrbuYx0Xq9+2j2a4?=
 =?us-ascii?Q?ZpTqN6GhgCbhzjW5bmJiTeJnEhuZgzsGx+Ja855IG8joyKxak+BUee9uvsGO?=
 =?us-ascii?Q?5PuTu3Pk+fVGkOvJyC1YI3V7E6gFEUFcTNhZYTLVACOdJWcPgP2x5ye80RPg?=
 =?us-ascii?Q?sPYKG/sJZpBx7bggj8c0H2KNE7eS5hez8uc3f/5u2mu6Sj+kphM0krZaa6wO?=
 =?us-ascii?Q?oTT4mJVaph8BB8UHrldXAZ0BeUcbz4WW3N2UC7isUdx1BNo0NzMDhVdmGxzP?=
 =?us-ascii?Q?bM2MymPJOTMmdYHdUQgMA0ASpJhKvnSqhxbpGTiqIsbgHKiE91vLdfsagIrR?=
 =?us-ascii?Q?0W1lAk3POO9e+HTtk2pdyEDnpseO3ODnywEbDIHP+DtsPl7WJpC/EsAWPJzU?=
 =?us-ascii?Q?XQe6EctwmitIe8Feq48VTtHhpOBG9iorQm7o0AeXNz1qKecxJGGIw8JvuQ/j?=
 =?us-ascii?Q?Y5Sxztj77DA+FmVF3tl8ng0fNfDHJ3FMi+UvtrZSVaQAIaYlkNUB4U9Wu7T2?=
 =?us-ascii?Q?8TU96qqOql00YYAcQwwLMNgzeL4Y2cWwkc9r5L+2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe9df89-73ba-4e31-dd2b-08de1e1bed02
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:37:22.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaRZE1/YZnDx3WyBT8QU33g2940LJ1i2MPl/rroei8nj87h2hjKmdTrvbmQi4Jc4/oVp2vvCMy4+y3C1WvAKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

On Fri, Nov 07, 2025 at 03:58:12AM +0200, Laurent Pinchart wrote:
> The __mipi_csis_set_format() function programs most of the per-channel
> registers, with the exception of the MIPI_CSIS_ISP_SYNC_CH register. To
> prepare for multi-channel support, move programming of that register to
> the function, and rename it to mipi_csis_set_channel_params() to clearly
> indicate its purpose.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/media/platform/nxp/imx-mipi-csis.c | 23 +++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 9dd264af181f..d8c11223ed0a 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -597,13 +597,14 @@ static void mipi_csis_system_enable(struct mipi_csis_device *csis, int on)
>  	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL, val);
>  }
>
> -static void __mipi_csis_set_format(struct mipi_csis_device *csis,
> -				   const struct mipi_csis_channel_params *params)
> +static void mipi_csis_set_channel_params(struct mipi_csis_device *csis,
> +					 unsigned int channel,
> +					 const struct mipi_csis_channel_params *params)
>  {
>  	u32 val;
>
>  	/* Color format */
> -	val = mipi_csis_read(csis, MIPI_CSIS_ISP_CONFIG_CH(0));
> +	val = mipi_csis_read(csis, MIPI_CSIS_ISP_CONFIG_CH(channel));
>  	val &= ~(MIPI_CSIS_ISPCFG_PARALLEL | MIPI_CSIS_ISPCFG_PIXEL_MODE_MASK |
>  		 MIPI_CSIS_ISPCFG_DATAFORMAT_MASK |
>  		 MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL_MASK);
> @@ -627,10 +628,15 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
>  	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(params->data_type);
>  	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
>
> -	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(0), val);
> +	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(channel), val);
> +
> +	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(channel),
> +			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
> +			MIPI_CSIS_ISP_SYNC_VSYNC_SINTV(0) |
> +			MIPI_CSIS_ISP_SYNC_VSYNC_EINTV(0));
>
>  	/* Pixel resolution */
> -	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(0),
> +	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(channel),
>  			MIPI_CSIS_ISP_RESOL_VRESOL(params->height) |
>  			MIPI_CSIS_ISP_RESOL_HRESOL(params->width));
>  }
> @@ -711,17 +717,12 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
>
>  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
>
> -	__mipi_csis_set_format(csis, &params->channels[0]);
> +	mipi_csis_set_channel_params(csis, 0, &params->channels[0]);
>
>  	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL,
>  			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(params->hs_settle) |
>  			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(params->clk_settle));
>
> -	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(0),
> -			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
> -			MIPI_CSIS_ISP_SYNC_VSYNC_SINTV(0) |
> -			MIPI_CSIS_ISP_SYNC_VSYNC_EINTV(0));
> -
>  	val = mipi_csis_read(csis, MIPI_CSIS_CLK_CTRL);
>  	val |= MIPI_CSIS_CLK_CTRL_WCLK_SRC(0);
>  	val |= MIPI_CSIS_CLK_CTRL_CLKGATE_TRAIL(0, 15);
> --
> Regards,
>
> Laurent Pinchart
>
