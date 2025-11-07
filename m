Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE1331A5B
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533392; cv=fail; b=lGPeA59ruaeFyBXTG6pl0ZwhsBIeEq5i2tAIqyqU2cEjq0r6j71ORToFE3KSJHtYbznE9NmUsKdPRAg103tGqMPOSsLPHF1zaPi0H+7cWS3Pcw4CYW55SFbDWNsweA/J5YR+BSMIt6a/7CNGgW2aHxHhwqf+94TmW9uFFhSynP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533392; c=relaxed/simple;
	bh=jhS2GlDEH7nsFU2NL3ZEfW0zrHDmDuomGEGOMUKB33M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jncT6XhHFwOBoN1PwJHKbVzI6pqlVKdExSF+Z/gyUY0+Ps5GA7egDrUkVtt8+KbJat74WID8jPdOs+xWIBwXw6m+8IooULO/QXGArCO1ecOatZVxsd7vyz5mXnKwcHW7GszOAC1salDRgc/+8UkkWF8Dus8ZqPENV7PCyM1ocrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JX7aC58Y; arc=fail smtp.client-ip=52.101.84.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JX7aC58Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE3MsWxwKr2MUS7a2EbxRGXJ/Nz03f9VZa3G5z+LFU/iV7orKeAAA7gCP6RVbqcgYsVZlVjh6K0mnOmbeUYRT42mbO5PPQbtr32NkCMnVgR4bQaRGGUOvAkMaZ8DG2Ffcg5Uyz0jdxkNz1FCQ6H6K2ged3Km8Gcf6MGwf+GmpPJKzQDTZgPQliz2L5j/YzQvsQkd+ADilqbAqd4rdJGgvKSBFL7Zua1XyzS/bEKgHH3bN7XS4PbqZrwcy7ygDrzEfADrWBjMk2+Yxq87tghYWbWcSgO6D5iD1ug3vRojOmfVyTDlWl8gfoAkmtXLfzYj2J7ZJ9MS+bj5ujRD0qOaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVgmDneioKeppZhrBwQU08L0mr5D6eNFWQjddaYPegg=;
 b=L/LV0fVxUMBjCJFRO3gqvgbtxjxXLxBIvYJrHOHqNqSS/sOnu17nzIgIvIJXfY8Sgk3jTPqmf+x9ktz5MxEV4bt6qg20QuayUxh4apj9XfwDW4BCtDxdDVmh5NpOeXtvE+gb5cNHLHvqiBueGFSB9yvVjWF19A0JdXM1HCRVPgjwq9FKsokmD6zFWTBXfFUHeggrFwdhJy+5MeY+ZuNZz3l8SUjGCYacRwH/0Ugn7FCLMxiEyfimdGZ5ZSJEN8S4C3GEchWox9O1dQEfym9IVD+nZoeswc6EHY9br6Ru90Z536HgsKDfXVKrpnNrjh1tGsOZBYprpj7wA+mlH1181A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVgmDneioKeppZhrBwQU08L0mr5D6eNFWQjddaYPegg=;
 b=JX7aC58YqY3xeytua56CoVJdmjtlMPOe5r/rCjum/BZqOSErGm5G4G3ts2XpdVJIJb0RSfJ+BVyWXnBB0lP9MvtSj3Qz03zbkL5ShWsNycL4PT/OFKDRyO+zw2ahGDZGjf6qfrfOriTXPGZHT1jH2l7mOsQZ4POYGiv0XjvgqC3WBSTu8MpVn1GtuIW6h5dKT9a/FG8TbMTAcRENHVCxbV4dCWz4a/4Qs9VSjDayMgbpIiO6uFJRaKVSyUsjo/ZFVwKMXtBxclo238mba7CC3fxuIO4xaWODSiGvGjUQpWHfMw0wKBeEMiGQG5PpbuDuMFyQXhnDzbBdi3lKnUCdIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:36:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:36:25 +0000
Date: Fri, 7 Nov 2025 11:36:18 -0500
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
Message-ID: <aQ4gAuYsS5jlw/Cv@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-4-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2710b95b-6497-4bd3-e209-08de1e1bcb49
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?tEs5bS+RG6ArN/AkC0eVW2v2umqXlswaonK2kK0LIhIYn2Izt40qxxSRTYyT?=
 =?us-ascii?Q?rwOR+nuHAnF1YDBXZsH+Nrl6KBKKNLNZVBxYeNxpKdj0UVIvgbhFe04t98nx?=
 =?us-ascii?Q?4Tchf6bvKnJBcBx/VsJ2tiHD9JnzG1jVjVSNiwoDP0ZFojRVrbx7kAnI4td9?=
 =?us-ascii?Q?elBHzOpl6pZMOrqjyJ1/GokY4qhYeg0jYmoeWZKyDwCqXlGiYGhyEqD9OB8L?=
 =?us-ascii?Q?6dThjdsgnP4K6x+fPtKTSm7LOgbe6MvcjmXG1c+01QMyh5lUbZeEs5WY7n7G?=
 =?us-ascii?Q?oPoxqV6aB4U6xf90mrqldl7feSYOHABB9t6pA1asY5pw6pW+qpSuJRt7MLBt?=
 =?us-ascii?Q?k7Oq1ninQjH20SDS7Z0drqNyuuWV7FcSBboTbX0anLNedds3wd4hm+3pbtBh?=
 =?us-ascii?Q?I4hNCyhaeulyH1q0pVIMfMsRm7A4c3JPrsJB3kOxY4p8Tf0iJlCBzXWKukHc?=
 =?us-ascii?Q?MMkKpuly3GTfd0coei1hScTh9jV6li2oH92jnF6GDztIcQTMMrO6RmVy6cNs?=
 =?us-ascii?Q?qQBzYyAGtk3Sxz2+FCaofYSnNH3DsnnZaLCWbKzqNPq0Q6mU6075s8dlj0Ms?=
 =?us-ascii?Q?10r+2M4HdriR7p/kGphN5r3zNH6LvARP8VuaQkURoajJHPJU4mRgmYosI77u?=
 =?us-ascii?Q?2xtADdLdHrXrlf3AOPuRVCtgZ76NZsFJ9adu/QYF96iWelovCMHX/pQJF7Wk?=
 =?us-ascii?Q?O3AIWYJmSm1D+3PcELmziVf95YW/ECa7yK+aj3Br8RDpcxTJetzPN7bU5GMe?=
 =?us-ascii?Q?/Mkvi5zyzsZKqPLOzwA1pq1JL5XnIU4BsEmxt/9mEJDhqyYUNYXziFDY6AsO?=
 =?us-ascii?Q?HtX+JOpyuaOVvwiza8vt7N5/3nTuCNATjfKoigjHdNnf6C2MWXdxNlznW3tn?=
 =?us-ascii?Q?vgQgLCH4lZ3h9SM0SzMs6aeDmdFNsIKSa+RhP1w9EgTqeLp7PoAx+XS6cszq?=
 =?us-ascii?Q?KJlKfHU33HvFNAwpwOONZMZvz8CjXIFnCzoF1kvZ780D60q9eJxTnZE9neE5?=
 =?us-ascii?Q?QiPY94aTZ4xU2VEiq7ipyB25s/94Mer8bR3GF8SIefbg8Iatezvnox6ZXkOE?=
 =?us-ascii?Q?SRoFh78ipjkD3ses2/LR4X5YUXdklfNSHdnOcepFyyAqroc9syOnD2YNfeWQ?=
 =?us-ascii?Q?gKbYpfLP8IepzkPQJ/7T/WqMSTcYlNyuHMj8GREprCsyFJbMOzPNK8XnkX/o?=
 =?us-ascii?Q?vpAW1HVTCnbIYPRAvjP1OTmMRYqqIGKf15FDPWt+o53vQ3asIwDxu/lqNhas?=
 =?us-ascii?Q?toHZKsO0Vn/YKAcVviJemBaY9pK1xfZO6Wzu2cx0wsXn5Iy8dsOhsPbLhMmb?=
 =?us-ascii?Q?FBOHlJH6nATg3xIvf+bE5SvATRyik0bdpD5cXmwILF9ebCpju/1W2/tLgZ2N?=
 =?us-ascii?Q?y0vC9cq9dCS2cTNhmDpIERB9VirqPhwrENy1yNRp1Va8K+5nf/7Z+hUsRw9Q?=
 =?us-ascii?Q?WCu3xzIF74QDWBeZYobVCLsgvdRfPpxeE+34en63zNRgWoVENYppynv46j4F?=
 =?us-ascii?Q?oq7Xnvmtp2xtAPBpkleTBreZ+w4dEX/lpPKB?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SupUbSbG0b0Ea7qkZ2YC14o5MqsbyDqiHyCPXziUoLkSV+ueGGzvqBHhVa3j?=
 =?us-ascii?Q?TLuIIKI6L9Og1leRDz2glYm/KyFEw2V9pCVPoQkZ4tx/zS4ySGtSU7hQpTOy?=
 =?us-ascii?Q?zi88oRH0TaKA/+4/L56c+XyLCoG7Z9zGAIqcZ75sOI2uSwkQBiwSOPVYnQo4?=
 =?us-ascii?Q?UIU+a4Nxx8blw/EalEppZwqRwxqlzzssMMqUT4bGpezxJMM6mt3DjNytY0lw?=
 =?us-ascii?Q?DTcsczdE3RLbDddH0f/V6hf1biHsQkOMbzoO3mJX59561VtjXCf/obi/nwok?=
 =?us-ascii?Q?v788QG+axY/B4dUlnatC2eyd3aKaLnmOkp8qDFH/uxBkcaO3i0cQkd42yAqV?=
 =?us-ascii?Q?GxuDMnX1k9KOnjKmebVqorq653ivr895Dh0ChdNFnmBwDWIIv87Mt8Wu4nbX?=
 =?us-ascii?Q?2Ro/71DDSRiWBBiEtAHG3khU92xG4cIhujh2QshfCgV/r6BsJgVTxaXvoALA?=
 =?us-ascii?Q?EqsRk7FnZKSfBdJTRw08rWa4NEi7ava8yTZYeIzGBhFfHdupyZfYqeaJKlZC?=
 =?us-ascii?Q?dAG8hXRL4z5Nwzoek73fkxnAHdbz8d/ez3dm5QG0JObD8/LqEQ82sVNONLwT?=
 =?us-ascii?Q?su6Wq0Re+3M72im0R2NYM/lDCq/Lujzxott/h0ZpPwPprBFHS3ludmK4Tn4a?=
 =?us-ascii?Q?JklW85tMY8roATXFDW8Gl92g5WtJ3KrzmD3bzWWmONfb37WBl7NTTPLpGsv+?=
 =?us-ascii?Q?ejwBZqVH+/70LeLPVs+hNh0u+m11NTHJI1NBhCdccqsYCKsrnCScQkKCsJpy?=
 =?us-ascii?Q?2vnuAovqJksK+K1culi2BYsbB09JrGOWx9T5h1szJIJvJMM6GBzqnjT3vcSj?=
 =?us-ascii?Q?3SITfc5V8diSQ1/pqX7vRz+6nuKLBE89avTQPPeknWAyuDEDzpVCFadA/9KG?=
 =?us-ascii?Q?s6zV08OV0QoxoaRLpUvL/AfwjNXYFbgGAK6PA4PgBXLz8p0vd2I4H9gih9SP?=
 =?us-ascii?Q?HnFZpw4Ezo6h+1B7R049ODP0baKvHjGQQI9kzWFndx1qveihBGqCFRabNq2i?=
 =?us-ascii?Q?PvyrLmm0ISN+zRco8uc7jiDRMGOXEg2sk48qjMrPDOX5cjPTy1Z8sm9HVqXr?=
 =?us-ascii?Q?6At3pAVyirQOqb80N2VVWf4llyHcNRJp1FbqWXdyCuYlzkaphj/PEbr6xcY9?=
 =?us-ascii?Q?h8K2t/4cgzn36pXuJGvJ6Rx31pN9r4YffiUE/gU8ZmTVfG2ih0UcLNQa3lsd?=
 =?us-ascii?Q?2tXBT66IMEzOAW8a0lMOZU/fLgoHCrf3UTPTTFsqCQu5mIuwL3Fv5NVqXF1j?=
 =?us-ascii?Q?M2yvLDUFVZpwW+SD24ctCh/A6FKjmO+2Cx9IrNLtl4Azodpcdeka3+3+2Wmz?=
 =?us-ascii?Q?CFK5Dtqm+K15DcDULp0BL7aabIBj3MVVGJxhn68rn+7o+qkMPnW6TjTc+Jck?=
 =?us-ascii?Q?3tcDokej9M8wfGG3BOH+YkU9L3Hpg62bTXeqm61/uh2D9CvSKmYlMvC6vCdM?=
 =?us-ascii?Q?99gLckHM/dK7pe7g2vaSUh1kEny4YeCa2vK0yHVY6KdqJI4QxirtK/7r5ymi?=
 =?us-ascii?Q?6emugsbRitZUO8Z6bGwPTgGD2HTQ3WXt7eVi5yzE/HnfvBbAgYWSefTGUSk/?=
 =?us-ascii?Q?YSnXvO22LbSugIlWL/E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2710b95b-6497-4bd3-e209-08de1e1bcb49
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:36:25.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj6AgyZaejPdlReFEKELKWTLTeMtHmQABbQWv1l8dxJfex65gDUDYnQGtbheybWag3oRR5qOwbS6HID14YBmuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

On Fri, Nov 07, 2025 at 03:58:10AM +0200, Laurent Pinchart wrote:
> To prepare for multi-stream support, implement the .set_routing()
> operation. The routing table is currently hardcoded to a single route.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 73 ++++++++++++++++++----
>  1 file changed, 60 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index f142e79acbcf..f4b19576a235 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1154,6 +1154,52 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
>  	return 0;
>  }
>
> +static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
> +				   struct v4l2_subdev_state *state,
> +				   struct v4l2_subdev_krouting *routing)
> +{
> +	static const struct v4l2_mbus_framefmt format = {
> +		.width = MIPI_CSIS_DEF_PIX_WIDTH,
> +		.height = MIPI_CSIS_DEF_PIX_HEIGHT,
> +		.code = mipi_csis_formats[0].code,
> +		.field = V4L2_FIELD_NONE,
> +		.colorspace = V4L2_XFER_FUNC_709,
> +		.ycbcr_enc = V4L2_YCBCR_ENC_601,

Is it same as  V4L2_MAP_YCBCR_ENC_DEFAULT(fmt.format.colorspace)

> +		.quantization = V4L2_QUANTIZATION_LIM_RANGE,

Is it same as
	V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt.format.colorspace,
                                            fmt.format.ycbcr_enc);

> +		.xfer_func = V4L2_XFER_FUNC_SRGB,

Is it same as
       V4L2_MAP_XFER_FUNC_DEFAULT(fmt.format.colorspace);

Frank
> +	};
> +	int ret;
> +
> +	ret = v4l2_subdev_routing_validate(sd, routing,
> +					   V4L2_SUBDEV_ROUTING_NO_1_TO_N);
> +	if (ret)
> +		return ret;
> +
> +	/* Only a single route is supported for now. */
> +	if (routing->num_routes != 1 ||
> +	    !(routing->routes[0].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
> +		return -EINVAL;
> +
> +	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mipi_csis_set_routing(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_state *state,
> +				 enum v4l2_subdev_format_whence which,
> +				 struct v4l2_subdev_krouting *routing)
> +{
> +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> +
> +	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csis->source.enabled_streams)
> +		return -EBUSY;
> +
> +	return __mipi_csis_set_routing(sd, state, routing);
> +}
> +
>  static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
>  				    struct v4l2_subdev_state *state,
>  				    u32 pad, u64 streams_mask)
> @@ -1240,22 +1286,22 @@ static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
>  static int mipi_csis_init_state(struct v4l2_subdev *sd,
>  				struct v4l2_subdev_state *state)
>  {
> -	struct v4l2_subdev_format fmt = {
> -		.pad = CSIS_PAD_SINK,
> +	struct v4l2_subdev_route routes[] = {
> +		{
> +			.sink_pad = CSIS_PAD_SINK,
> +			.sink_stream = 0,
> +			.source_pad = CSIS_PAD_SOURCE,
> +			.source_stream = 0,
> +			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> +		},
>  	};
>
> -	fmt.format.code = mipi_csis_formats[0].code;
> -	fmt.format.width = MIPI_CSIS_DEF_PIX_WIDTH;
> -	fmt.format.height = MIPI_CSIS_DEF_PIX_HEIGHT;
> +	struct v4l2_subdev_krouting routing = {
> +		.num_routes = ARRAY_SIZE(routes),
> +		.routes = routes,
> +	};
>
> -	fmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
> -	fmt.format.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt.format.colorspace);
> -	fmt.format.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt.format.colorspace);
> -	fmt.format.quantization =
> -		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt.format.colorspace,
> -					      fmt.format.ycbcr_enc);
> -
> -	return mipi_csis_set_fmt(sd, state, &fmt);
> +	return __mipi_csis_set_routing(sd, state, &routing);
>  }
>
>  static int mipi_csis_log_status(struct v4l2_subdev *sd)
> @@ -1297,6 +1343,7 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
>  	.get_fmt		= v4l2_subdev_get_fmt,
>  	.set_fmt		= mipi_csis_set_fmt,
>  	.get_frame_desc		= mipi_csis_get_frame_desc,
> +	.set_routing		= mipi_csis_set_routing,
>  	.enable_streams		= mipi_csis_enable_streams,
>  	.disable_streams	= mipi_csis_disable_streams,
>  };
> --
> Regards,
>
> Laurent Pinchart
>
