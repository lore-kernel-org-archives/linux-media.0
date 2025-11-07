Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64225B69F
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532412; cv=fail; b=jie50aw17RT4uZOmiw301ULKV5InMXKK0kgoRLv5JrZnCLSFxA/h33ttVfJQ6skPC6rPL8j7qpoRwCtbBwgw8IWAqDPhG/v9O/OihuEvc+cNARM3W8Zm6xm1ihUj3h+hwgqJdBYQVKWD4KUnGxDpvo8TC9+H3y4huTE2CwpIy4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532412; c=relaxed/simple;
	bh=9vol91peoVKf1xiV2dxxjQ83B/nbXpnEJ2QugIarIDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mm7zZ6mvAo7EMHi5RxUE4nGVgsL9Cj5gR9fVI8+pms4pN0xs/JKBW+LqFZ2TThsAfbacSKra23EK/WaC9XqQZPSPTSdhtSHgNAYOU1ncEI+rSrlqA47Maihx2f0QvRrNe9fOWLvY7EJi90gsq/9czHevvRKa/vCRFfsNPEiHh/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FzR8X9yZ; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FzR8X9yZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpKi85wY5USM1mlzUlRPGzBRgH4lVuaDRdPR/L/fUJLl3EoNV6pMneCY1ZWaDmyCwnXDc4kBEh+azd1I7cTYf6wzDHpyf5oRyzi6s1CRQmeE3vYuCdSxrwKpNn0mnNLaVqvOATlGAT5LwgGPj55uynBxbBYO2vfqbOJV/qgbgg8PcJ6s8uoPo43Y4yT+OLmjS8OrsoekxAbMpaLca6aqXSHEPmTMZq+rMF9Xov/qjMZl0Lvm8Eat90j+RYCQYdG6VDqSKfpOxrgdF1EqL6VKyEujo7wLs4C6PQbCb0o5j6izrn1ggIF/Swm58T0WSVGILFZgOurNU5Q47BYxfBbXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LwupEAODIE2YW9Ub1sxFipU4S2Zg9fIyXhcStvDYoM=;
 b=rrvMWNUm+sK7mXdPHVGkUGNPc28/OfsgWZg4XFSl2m2IqAy24N6iznV5WXrO0h712AV3r362FVj7NPRNq+kfFtbzHdbSunuLIRv+IQVkM4Q2yExZVoUynjVpYLDIX5jT1/ijLUiGehLPP/OQ5xfHNjgx+Oxp4yLgtfLp7n1F2WByHK3ZQnZAXiuNY6h6dgenW4H9jY0zviNoJHPvSFIfZFwdbiWNBSFXtvCzUTqoS8o+zpxMn6DtbUdQMmDIyAhtQ2u86nLSgIIqU1LVAWYwSMM9URg5AW7UhSmVl+Yn3a+t/n9SlkalvqUwkmJjPzEAT1n26ftaPLjP2MHuzOW9yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LwupEAODIE2YW9Ub1sxFipU4S2Zg9fIyXhcStvDYoM=;
 b=FzR8X9yZ1JB/sbgJuzfMebyJGxBrGjU3afDfsdVqbIK/+QRBktLvx+idxdCzs0G5U0XE2/i82wdDhEpVhgZExzW1ENPAmdHDOZ7tsyNlnQcpGBElduRpBmZIwqkosOM1FyDfB0HS/yFKlIXewOwqLvUm8y47IDmrmLj5ai0tlX/jNMUZW+Alx3bonJg/pgmZqApmDl6XvIKBsvBulYkeZzQGfpKmUPKW6F+bkD8woqCjcWxxQSgfopIlEfG6rsUMYaTAvH1oC7fdAgvLnBAsW/RDkSk1c38P+gEFYLDNsoUVOl6sVQliK+eUt/rW3VgFozw+SFa+T9GYeaRpM/vqSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DUZPR04MB9965.eurprd04.prod.outlook.com (2603:10a6:10:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:20:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:20:01 +0000
Date: Fri, 7 Nov 2025 11:19:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 1/6] media: imx-mipi-csis: Add VC-related register
 fields
Message-ID: <aQ4cKf3y1zqwBmar@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-2-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-2-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DUZPR04MB9965:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ae259a-4c21-4b81-19d0-08de1e198097
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?B24EO1shkDD0hvHO/kv8Us4faQJaC3EuflPb8lQ7fQOCy6Ql6M4l2IRYxiXV?=
 =?us-ascii?Q?JRvgtydPUyVsfiziMYy43OfdMDhgTjxbFqm1cTx2dlUrWjdUtEPbVAmqWGgH?=
 =?us-ascii?Q?nMsJpXPi7iPrvK4xw55lPSd3HrKllXRPgzXGORodo1WWl3rV06NjzSIsGnhl?=
 =?us-ascii?Q?98YYGvW6VeA7TAHeLetcPnZ0qvVQ3eyCtKNSIDl/DSQOHx0qMrt7X/9M2+xz?=
 =?us-ascii?Q?qtn1BbaAL1T+ZRllwWropKs/sWheB8d0y8AQSkcEzY75keuc4BTaPFtgUnPO?=
 =?us-ascii?Q?DgPhpLlETKv3ggj1VTHBWuWkbyLDeDI1wl22jfBFqMFh5ASmVZJmNpQHUPXj?=
 =?us-ascii?Q?eIGqsyazFBKEeCuM3uzjBk3s7g3KgHSoRuWztERHmlAgldzgbJ8cCNJNn8cD?=
 =?us-ascii?Q?/dFv+Cjdk1jXEeiymcYAdEUCEFw9H9D2jzd3RuFSA0/n26BGCUfpuZljM+7k?=
 =?us-ascii?Q?q3J/LgJ3FrPX5+aNEzMO5QaC+uq7zcN/ovDtWsHwdAMqCADjhQVqqwSc40kj?=
 =?us-ascii?Q?OUG+iYDQLLJXQMQ1I2d5ejAebUeiPLNTpsJHmGhxk4HKRhjpCFRKg8aRwPLz?=
 =?us-ascii?Q?T5fuTvQCtTCnd0TyyPRrBB8NmDe8nTNEp3fYXM3upd8s8eL9xqK3u/M2vwHT?=
 =?us-ascii?Q?gWWhXdb2Tp1o1eXGlvT/X4RPI06E8nDbcGjhNlf/MsWgxWFakilIMz9rZPUq?=
 =?us-ascii?Q?3GYXkaG1HJgtZdiBzKVV/eEts2FuTUda6l9cpjgjb7f1ySqaDTfJ1kraoUx8?=
 =?us-ascii?Q?A4LsfHrMBNGvfRikiIFWlrDQTnWiHg7YSlFsB+lfBFIqyyBgHeQ4Vr2m0C86?=
 =?us-ascii?Q?8KuhhfT/Uh73WxTxnrBmD75oPXAJPGzHzdDXGw9qRteuwOTBvA8Bd26p964C?=
 =?us-ascii?Q?qYP9d5VHLd8EwC3WIbcT7t5zEmaGzDFXsFvrsS+ZretlFMg1ubPWHIukMeeU?=
 =?us-ascii?Q?R7bDxix+2fJxLdLt/wgBaCjiMt7qnSxwSCxPm9HIXzduKvgMKHoU8LLVgsZ6?=
 =?us-ascii?Q?kH2so156QHr/HJA/C+kjp4TGy5IvouAdRMtYVKcyHtodILqg8z4e/yzDgJbP?=
 =?us-ascii?Q?CwT42Ni/XdgwZwthlmgO+WbSdivM+InFxYLQPM5Fx7lAyuDvg+mH23onOfmD?=
 =?us-ascii?Q?c4TqTIrehc64HmuXTR35FlModbkROwk3ELbu3YuyOton5c5Y1xRV6c/16ajX?=
 =?us-ascii?Q?dKiYlqfXGUsJ3o39caOsCnlxqpvqY0kzI59usiz92gE0B93KOH5dsAXiBhxO?=
 =?us-ascii?Q?cBOYA3QmpeKMNEsl+EfUp3/YGzfN9X+gtDhMvLLXNUTlyj9sK/KB7ThJFWqf?=
 =?us-ascii?Q?E/vZjpcT5RCzWCWP5i1bw0xi6ROmmXHiX9IwxOpBr28Ug926jxJsU9CTEUxI?=
 =?us-ascii?Q?hFR5K2Vm8SoBOyNRK/mId2B7W76Y3LtwmGJkJiowDGNBV0qfnBv9xz/+l3T3?=
 =?us-ascii?Q?7w5nZZlDcQxSnFHHXGLI4ROrjoHgmqhYtTgQ5OjsT91daKKd0dl2YeTdb4Kk?=
 =?us-ascii?Q?5bLm5GrtETCzxgqt1LnMpXT0RXxN8HVriufp?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jeCeZOsomNLbNLloaR6qY2WG/EthHvNMkAF6DfabkuHCuRVogvcwCy6bo8AU?=
 =?us-ascii?Q?ipc7DHcjFyyOaS2d/KSW1XE86JGn2hOlyPYFn7SVrWQUmg55YS5zsR4opyay?=
 =?us-ascii?Q?RA1Al4rVnohsmlTY1FiB1itEYbKiwgmtnqLdQsHA1ArwbrXXBlVE7F9Bix0z?=
 =?us-ascii?Q?FjJI/otyaHSyZOwtfLKAbw1yRGtGKLa59+5dlTBtQmXizb1EUYher05po+Mu?=
 =?us-ascii?Q?0j3/IFTHwEcccG79bF+woLw81ALuBLTPMPIb5B+VAwhINHduQHeOhO2RwbSd?=
 =?us-ascii?Q?5NnghrvdddJ+20gPqvKNHYLti+p+NPro706DP3b3WiB3gdVzmp8kV/I6tzU+?=
 =?us-ascii?Q?2LN5IdKJZAQn9WCC00KtTitcaKdlCNZt25L3EtymavWc9lQdcQEiX4rJ0nRZ?=
 =?us-ascii?Q?IRea40Ytei14DFAj+a8IbKd5Pj9yy3RhPhKBBewJcgRCd/pvK9s+PW7KXB1A?=
 =?us-ascii?Q?cCD6qeON/9t0+N6MQhIngcVDkGI/siJZa/Ip+HEPH3RXp2IjMkddmNdFflFP?=
 =?us-ascii?Q?R24UMwpkTgZdRAIgYJmUSRSGiBcSEdG7NAYs1Z8LEzfZo3k+F1H0pKPt86kg?=
 =?us-ascii?Q?iZ0SWzR1Bh/AfdZLVwXadQKqeROgEu6KtNQuuMJeLASO8+qGBT6s4xsRdl4c?=
 =?us-ascii?Q?aK73nes73/TVw4ZoI71tkqTnCLWf6uqyMu3OWrEKSAoy8lXNeZVZkHjrfY6+?=
 =?us-ascii?Q?ggNzqx8pYMpUJV3tRk9n0BQySlcbe5ssVRAOvx0wn2LghxjnnNheMoUAIzYF?=
 =?us-ascii?Q?SXzwCdlHgZ+r6WSaPo1g94M/hhzidJIuWkB4zDDcjj7H5Xm0Szdt4V8zhBCK?=
 =?us-ascii?Q?6F4TLS6z04ccj8EFkPig3IdPsFQcF0cgqSNTTOgBM0ptVCtH1wmnqIYcQtbK?=
 =?us-ascii?Q?SrZU3PbMKATZSLlparqT78U6mH6NUATTLmLXzP7P5+zql0HpiiER+rI9Rq9r?=
 =?us-ascii?Q?vUxBnTs+H/XhM+5ouSe9m/z+tTMcmpQrgYS5mVw8KIw7ewBVnHhRkvcK9g6X?=
 =?us-ascii?Q?GQxSvNmUC7uPZvrCV89z+a4lYplcHSkN+GaUhvi2DH6VcUV4dON86HHPEW7b?=
 =?us-ascii?Q?WtG3FHuuN3eheOFtbtS3T0YuDPLiZESDuA3+E/mT6NlFK1uDODmLzT6vZmqg?=
 =?us-ascii?Q?L2Q5FUCI2U5AsuOcjM+WZM+X4Gk254x46oxgAHvQrtNjRE2vvSropBWm/gub?=
 =?us-ascii?Q?yab3qOPyZoAJ+YmA2GybypVMxebqmFhPdOPnmiwNrlNgNiJtpPpNgksJ/a6R?=
 =?us-ascii?Q?j1FYV/kCbHT9Au7KC2Gfi/spmBu0v0JCSSTK3Myhnw3Sg4Y5aMghiC3ZC92P?=
 =?us-ascii?Q?YNnvtE32k/jpKbQ3Dd+WuRiicLaeP0Qtcu/YSi0lI6tHVkjoVir/MJCkm6kN?=
 =?us-ascii?Q?QXC2eZfHE+ku8wW57dniBZgBI38HvOSue2+NlwhFAxpa3y+zpy7hhswl/kGT?=
 =?us-ascii?Q?p/JD0+CjEodmHOW7U5Bs4xh9j+gZeYxv5LJqJhRGiNrE/rY5tOps0xmuDwoD?=
 =?us-ascii?Q?i3OgdDMrPgctll/P01QiiBVjnjBxYqjxr5JBX++s/iVlF1aTWu2uqmkfNGNF?=
 =?us-ascii?Q?T8JyibNq/Xz/QaJvfFFZ5GBc+jQaRFXJ0ezpsvJr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ae259a-4c21-4b81-19d0-08de1e198097
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:20:01.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIiouWPOgZwXL3YeKgUd0MunU8PfZpiTvE1CM+JHffIEpbnJTZFqJ9YxW+NtVicp7KJJk2uwyUNyRggVISvYWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9965

On Fri, Nov 07, 2025 at 03:58:08AM +0200, Laurent Pinchart wrote:
> The CMN_CTRL and ISPCFG registers have fiels related to virtual channel
> handling. In CMN_CTRL, the INTERLEAVE_MODE field is 2 bits wide, and
> controls filtering by DT, VC or both. The VC number is then set in the
> ISPCFG.VIRTUAL_CHANNEL field.
>
> Expand the definition of the register macros to support those features,
> and set the VC ID to 0 explicitly instead of relying on the default
> register value. This prepares for VC filtering but does not modify the
> driver's behaviour.
>
> While at it, use GENMASK in the last few register mask macros that don't
> use it.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
...
>
>  	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
> -	val &= ~MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK;
> +	val &= ~(MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK |
> +		 MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_MASK);
> +
>  	val |= MIPI_CSIS_CMN_CTRL_LANE_NUMBER(lanes - 1);
> +
>  	if (csis->info->version == MIPI_CSIS_V3_3)
>  		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT;
> +

above two empty line is not related this patch

Frank
>  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
>
>  	__mipi_csis_set_format(csis, format, csis_fmt);
> --
> Regards,
>
> Laurent Pinchart
>
