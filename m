Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19095280033
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533657; cv=fail; b=SxJRCCERra0L3zoaRuxDM2ul72Imy57V0jnihCNudwVDCC0IEj76lz2QxWg1fl00iwCC2oSiWJnzxHfUFf4rCuKf40AZhNMsA2eXzEDd0L5UnqbJTQEo6D2wr1J6wBU63ZEZPnUy8Aoz94s0R90gNt5k57Cbf54rAHKzTFDmIo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533657; c=relaxed/simple;
	bh=pBc16yzPT7LL07LwiKEuaLty6+Cmkx/+2URJP2qf7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NA6sCby78dEOZlE3FzqfgQPGNdD7afMLuQ0FCl6/CAn1SXQL1YVhTql9u/ctfsDtswr0we256hFjkz0Ivz1guC3uqN2fS2IrFfQCa0bfjfgKVwy+UJyPIQQiDbc+mGGjl9vqTNuM+bwuFRUHn3meCxJcBB1Qh2GOrEl716ztCLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GLvlcJN1; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GLvlcJN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwREphn+dwkgwywMVmaqYBBA0pAb+UcuPbEBmdn5ywFuwTkixovh2Rt+eIWEck8fykNSgB9oc7l2LD3LuSrbnYPRWiKMwJUJT1yndTQsWrCvZh7rqXm13QLu03S8YYwFaLrlGL5tLyY8ttE7GhNJb0cNi1JggQP9clKuG+cFnCfarF0vSrZEjspGwVwMBLK15671hJSx6wgKHjEMM5CBSC26sN3o65G8pXL3urQSe8cPlEFRfCe8q+A3KyFE+Jp0gw4mIDdpFYZgYxnif5bqTNV6LLaFHTfc0jlsYQDMpnOJkoN81UrmN5UmYWVG7QmGui1f0Sqvg9hRS4ddO9WqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzZyeMgVQADPOokrrFiFD3dSWESDVgkYu9skczacOwU=;
 b=X6Jk4F/Iwj8ASBoviPLTkzK2anskhlRcHSuHB4eTcVkwzUDHLvSdgkddDzrMTLYINyihijTxqLixeTyBP9LtZX0+L8ZGlueDBtIby7DNybWY1hkcH84ZsHUyIczgZR3SoX4wiT9aZcdXPT/g+wvAh4wsGP5rXGo+iF7V7Z7ImC71OUdNCgIPTTgVPCFm4/WWeB4Su/n5Tob1xzX8Go3DwRavL+YhdReNmEljTaFR+Vtz4l63pra5rnWKnauz5Jyj7gcM8jq83pNckcaGH6x5e9Nt0/EN/JHSIjab6agmxA1HQk6Lyl5Uc5AM6CHvaKn8Bu/d2uNouF9iSygNzsSrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzZyeMgVQADPOokrrFiFD3dSWESDVgkYu9skczacOwU=;
 b=GLvlcJN18b9xQtN9NpT+GT2Xj/4a6aQVSPJKDskYCGYGH2PpOdsaB7QI+vpsMpGleQ5fsvdtNIUIjZmXOPZ7JPwnVqGREoPJ4cAoLhiSVviwlxDTMIUjDHdU2y4UyI3xqx/tsqweS/ANBZ7rgmjjvJS5v3iuI6W3J/0EN7cz9p0RpJcPfmq0TI8TSyjpHLB+Aq/SKwiFjpSBTbi/PPCJvgmV089BVFmjNA0z9YrUPI3Tcxj6wbi2ICLH8axlTP2m3TBr8nCLhvHwjh6GAm5qxzQpZwv5O2Siwo3c6aLWtiTg0XDGIpL656JRmfWyGXyo2IckqFQa3J41QCg1e311bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10388.eurprd04.prod.outlook.com (2603:10a6:10:568::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 16:40:51 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:40:51 +0000
Date: Fri, 7 Nov 2025 11:40:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 4/6] media: imx-mipi-csis: Group runtime parameters in
 structure
Message-ID: <aQ4hDMxRHZCJFyxU@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-5-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-5-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: SJ0PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10388:EE_
X-MS-Office365-Filtering-Correlation-Id: eb31d112-668f-4961-297f-08de1e1c699c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yYbw8omT1CVWqOKquo0qSATtuSFxKelasNPzHMMNAf8x4iyYO15HD9eXRb4s?=
 =?us-ascii?Q?YyOCkkBVZpMi5GaccRJ0LRj1GFseF+vIjRt8fccRXUSfD5McBN8MF33pua52?=
 =?us-ascii?Q?MFrEz1znLHiXA0RTmkxOu2wrJI5ilbOxEPag06WcYYIi4cCq1GHfnpXkiVUf?=
 =?us-ascii?Q?diGx+m5BqKaOkHDWqY+tnA2Gqi9wndz4M9gf5pHQgTR+73fwYzwmnSme1VDA?=
 =?us-ascii?Q?ikGZRZb34WfHhTWM3hhe5NSI2sGYzo6UqeBPbNAs8zZb5B4l8SNXVWAUnj9l?=
 =?us-ascii?Q?ORqwVohhOu8rXHDnuMIcjvFV3/NOo3uAvSvSG3KV9zt7FziLpu0hyk86DT6B?=
 =?us-ascii?Q?+BiDrNOBPYWZY5lARuMnwgy11rW/lD9H8cDeKSa539z3APFH7UtTTzOMmDKe?=
 =?us-ascii?Q?JRGCwiPhhOvA/l+uzm3dMO2TC8nWpuRHSVj3YtNBl726553r2g++uQxVV7WQ?=
 =?us-ascii?Q?O1zspPtgDi0LFdYqGmno34DzWvFGhk7zPmB6RnS0s/f+N9S/rYKVrNVHbNNA?=
 =?us-ascii?Q?nzMO+Qwj0HK8Zmm1eGxr5crOb+8l5MMqhwpelgNNj1EWprpV5U/PtaZSOJH2?=
 =?us-ascii?Q?NWZpluGsK2DFXJ2sY7TELYKvclJHswZPVCN3pZDrcvI9wzOtctLa13W87NhC?=
 =?us-ascii?Q?3tPMV1pORw41WRNOBf8zpemKm6bIsOgw3YrzvT5GI7CCMcHD+Tzi/HKRxcG6?=
 =?us-ascii?Q?2q7mC/aqS6hC148iT2pN7WrqOopqM/KZHXsM7IicPZfhG/wyV9yH7zSok/t/?=
 =?us-ascii?Q?/qw0C51/XWy8NMnsYss5JBIm9RDK7SDf8lObJEH+BFriBIoJFI/ueg45zFWo?=
 =?us-ascii?Q?kIz0EHeAS97/OIL6gfOptrfzm5DTIRIzymXCAUMtE9EOGw96BCsYmnMLaPj4?=
 =?us-ascii?Q?iVREQBqiY8l5EJvjM44g+Ykluvwz6aNUTayqCUy3o7pRlxVfFMv2pp1iIx7e?=
 =?us-ascii?Q?TNE8qblY66ct4+FRwADFkFApxuSRsqi3oKWyQSgbEjhOi5wghTl/i1XF6VO9?=
 =?us-ascii?Q?LRoMRSmybMacYo37bDpfHyXBDh8KiKRI6TOPbgy7ab4eZgPK4FxjI0qN3emX?=
 =?us-ascii?Q?x8x9LUoFpaKjWpPJxUKdHWZwI1oVVeNGrf4mtjNdh9dB1sl5JFP00U3nvYhD?=
 =?us-ascii?Q?K4146Et9YzwwdBYP5JlAyITmJGWTcXMASMI57ydNaiagq3u/3SfFBIOf372c?=
 =?us-ascii?Q?N8oN52S/qlmC4jkeLr1objBcY3tXhIbSx+TOGjXIGilJUH3/toULMcgfa66n?=
 =?us-ascii?Q?pMDA1Xt/PJ129RZYDwKXwUIcePNfSi+LWZXenzgvrUf89CXjaVezb7NVMhbz?=
 =?us-ascii?Q?/US2gxVEkCSgamlda+Eo2nnKZvo++Sjt6pIlzcghVNryyVx0N0R4YoSzCO1H?=
 =?us-ascii?Q?8m+a0MY77Q6pp3rnJXOKePjSQMmV+B8gHigNZuIagmTZiSRecmFI09HN/ffh?=
 =?us-ascii?Q?j+WDgxmo0g9jQ9jqIJyEjPWCm+fJFAB2MLGvUNs3dMAZfWE3SPF0SHpzntbI?=
 =?us-ascii?Q?Zqe183W3mC9lK4Ey2x3s77ahzPKd0FF0oA6x?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?LrTxnu3AR4NSt04RdiaclhnwkVFDD8RdFls1jhoJtprKzuLREUHf+C2Xs3bj?=
 =?us-ascii?Q?J4243ZgZFrZxLI1QnWeZk59j90hvxLaKCBcPANwhekpn5Rf0j7+7YpA0O1/j?=
 =?us-ascii?Q?jBznHgat15Od/5502Ux4KT83952mR9e9+fXC4nagCH3ThFz/1Q9bjtaz616g?=
 =?us-ascii?Q?bCiYVKeaFghkR2sK9uhWNkRzl44rjbWxo+nadE0DgUi43yQQMXt7YEdDcla6?=
 =?us-ascii?Q?tJb9R7XT0qgkCddGNRKJAh+skoWLJBzoHu6qcL1rBBdgyfOyEWR7I1Rw54yV?=
 =?us-ascii?Q?OXZu/EHiAKcnWKDpuCaclx28QbjE1H5LdExGxIIFT0OH5EOC3KER2Wbstn0t?=
 =?us-ascii?Q?86xhvhv5k50cmHl7i0NRq2CQt1TtxRntnXE4hWCepgM0tK/04kn2Hfjur5EN?=
 =?us-ascii?Q?qUv3YuFnA4Vb7GN08jLNGE1+xF9v/sHfdfHCUZIUXPoUGo7nZAXYgCB5FSV9?=
 =?us-ascii?Q?BJ2vx0WcpHiQoYoRSUiHgQP8dsdaN66T6RBq+EgsMu9x3ZCs7Xfr95hw/zvJ?=
 =?us-ascii?Q?EyFpNdjSCXUnlUKWruLbjj3Br20Wu1Gf/mhUOyeIT0EQymuK5eOKXaVW4TbF?=
 =?us-ascii?Q?5UFmWzj0OCC4rEZ2qRJxEVW+eU/PBXt9fQJPUf1Xr5MVExfg2fjRGFtll1WG?=
 =?us-ascii?Q?6S0CbMx1rMOpIm5bKuLr7Fqth68/rlpMNm/TERLzQDZYVF2P9nv3SGK2xNsl?=
 =?us-ascii?Q?skV+uhM5K5nuwHDDVOkQJ6yaJXtwDumXUm+2OlciDApdZwIVyex3/otrT8FU?=
 =?us-ascii?Q?PTmLzOPOqaZ3Yg97pQT3lyx+ZKhJ1iXaRMXgK+1waTc4pNN4NiwHU/8LVV3Q?=
 =?us-ascii?Q?hmJJaOGsYGst088xE3kNeZyVIm94E1lbSrFX1Xzb2HkqxIu/eNkEScQEmVWB?=
 =?us-ascii?Q?lo6fQu89q8OvRTVOpgAUoAaj5ZerfFrJXNQ/T9eBa954BbNfTLSTlAa+sZnB?=
 =?us-ascii?Q?5QBI51ZGd4PzD8Vl2GJGLMrEmLunviB1TdfyMkCcEFEes9ZIa15pgFlcUrrU?=
 =?us-ascii?Q?yFh6pHBqWbJCdFIQovO69ophPHLycBiI7xnIKcqI0bVOabLP+YtySVruLWtd?=
 =?us-ascii?Q?96s9W8clf0UkfDDHFy2ZnAHEX+ar5hcVRgOXIRrzt/6g22DChfHlez2z8YxK?=
 =?us-ascii?Q?ufl8Y09N2CT2QogE15HGvbN5yc1FPygGwsx+K81gj2//oLTsBbACvoKn7P+8?=
 =?us-ascii?Q?zN4QUne82akTdrRCaHCik6V+Vahy6OeXS/NpzoHwcAmSQjk3OjrFXZUcSB0O?=
 =?us-ascii?Q?T1AW7dhdYhIOBPUaOgUdM9V4GX15UVpUp7qm7G1afuGOjq+3qIJ7pUooVB4c?=
 =?us-ascii?Q?tfNW9UwzdJDhm+P6PsCNCOghxKNahMzuirTY18HqSm9OeIrKv5b2N34cvjOC?=
 =?us-ascii?Q?k2n281Fj3VeCfPlZrUaZpHIdwfHDePxAS1BAwGB31vZFtrYOr2swH8pedBlj?=
 =?us-ascii?Q?72C4gEQ6YP+MuWGH/fhXI5CXh3CXsZkR3tnNS5zZUL6O/l8H28wEjGBjM3l4?=
 =?us-ascii?Q?0hY8rKQYrPzR9cg8N9GGgknML+SAitruQOcz4o8nB117ztwfP2HL41V6Lqxw?=
 =?us-ascii?Q?ttJrTLPblwzmpFK6MZv0cvrmP2x+jUwBO81HdRN3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb31d112-668f-4961-297f-08de1e1c699c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:40:51.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jsdNvGi53LLenOTLW6Sy8tE05SzfuGPg48wPve2pvOkBPDKDA2vY2aMlAc9bWeDOrpQ0faclIir7NDCkDWhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10388

On Fri, Nov 07, 2025 at 03:58:11AM +0200, Laurent Pinchart wrote:
> The mipi_csis_set_params() functions programs the hardware with a mix of
> parameters computed earlier when starting streaming and stored in the
> mipi_csis_device structure, and parameters retrieved from pad formats
> passed to the function through the whole call stack.
>
> Multi-channel support will require computing and applying more
> parameters. To prepare for that, refactor the code and store all
> parameters in a single mipi_csis_params structure, and pass it to
> functions as appropriate to replace the other arguments.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 72 +++++++++++++---------
>  1 file changed, 43 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index f4b19576a235..9dd264af181f 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -333,6 +333,19 @@ struct mipi_csis_info {
>  	unsigned int num_clocks;
>  };
>
> +struct mipi_csis_channel_params {
> +	unsigned int data_type;
> +	unsigned int width;
> +	unsigned int height;
> +};
> +
> +struct mipi_csis_params {
> +	u32 hs_settle;
> +	u32 clk_settle;
> +
> +	struct mipi_csis_channel_params channels[MIPI_CSIS_MAX_CHANNELS];
> +};
> +
>  struct mipi_csis_device {
>  	struct device *dev;
>  	void __iomem *regs;
> @@ -355,8 +368,6 @@ struct mipi_csis_device {
>
>  	struct v4l2_mbus_config_mipi_csi2 bus;
>  	u32 clk_frequency;
> -	u32 hs_settle;
> -	u32 clk_settle;
>
>  	spinlock_t slock;	/* Protect events */
>  	struct mipi_csis_event events[MIPI_CSIS_NUM_EVENTS];
> @@ -587,8 +598,7 @@ static void mipi_csis_system_enable(struct mipi_csis_device *csis, int on)
>  }
>
>  static void __mipi_csis_set_format(struct mipi_csis_device *csis,
> -				   const struct v4l2_mbus_framefmt *format,
> -				   const struct csis_pix_format *csis_fmt)
> +				   const struct mipi_csis_channel_params *params)
>  {
>  	u32 val;
>
> @@ -611,26 +621,36 @@ static void __mipi_csis_set_format(struct mipi_csis_device *csis,
>  	 *
>  	 * TODO: Verify which other formats require DUAL (or QUAD) modes.
>  	 */
> -	if (csis_fmt->data_type == MIPI_CSI2_DT_YUV422_8B)
> +	if (params->data_type == MIPI_CSI2_DT_YUV422_8B)
>  		val |= MIPI_CSIS_ISPCFG_PIXEL_MODE_DUAL;
>
> -	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(csis_fmt->data_type);
> +	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(params->data_type);
>  	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
>
>  	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(0), val);
>
>  	/* Pixel resolution */
>  	mipi_csis_write(csis, MIPI_CSIS_ISP_RESOL_CH(0),
> -			MIPI_CSIS_ISP_RESOL_VRESOL(format->height) |
> -			MIPI_CSIS_ISP_RESOL_HRESOL(format->width));
> +			MIPI_CSIS_ISP_RESOL_VRESOL(params->height) |
> +			MIPI_CSIS_ISP_RESOL_HRESOL(params->width));
>  }
>
>  static int mipi_csis_calculate_params(struct mipi_csis_device *csis,
> -				      const struct csis_pix_format *csis_fmt)
> +				      const struct v4l2_subdev_state *state,
> +				      struct mipi_csis_params *params)
>  {
> +	const struct v4l2_mbus_framefmt *format;
> +	const struct csis_pix_format *csis_fmt;
>  	s64 link_freq;
>  	u32 lane_rate;
>
> +	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> +	csis_fmt = find_csis_format(format->code);
> +
> +	params->channels[0].data_type = csis_fmt->data_type;
> +	params->channels[0].width = format->width;
> +	params->channels[0].height = format->height;
> +
>  	/* Calculate the line rate from the pixel rate. */
>  	link_freq = v4l2_get_link_freq(csis->source.pad, csis_fmt->width,
>  				       csis->bus.num_data_lanes * 2);
> @@ -653,30 +673,29 @@ static int mipi_csis_calculate_params(struct mipi_csis_device *csis,
>  	 * (which is documented as corresponding to CSI-2 v0.87 to v1.00) until
>  	 * we figure out how to compute it correctly.
>  	 */
> -	csis->hs_settle = (lane_rate - 5000000) / 45000000;
> -	csis->clk_settle = 0;
> +	params->hs_settle = (lane_rate - 5000000) / 45000000;
> +	params->clk_settle = 0;
>
>  	dev_dbg(csis->dev, "lane rate %u, Tclk_settle %u, Ths_settle %u\n",
> -		lane_rate, csis->clk_settle, csis->hs_settle);
> +		lane_rate, params->clk_settle, params->hs_settle);
>
>  	if (csis->debug.hs_settle < 0xff) {
>  		dev_dbg(csis->dev, "overriding Ths_settle with %u\n",
>  			csis->debug.hs_settle);
> -		csis->hs_settle = csis->debug.hs_settle;
> +		params->hs_settle = csis->debug.hs_settle;
>  	}
>
>  	if (csis->debug.clk_settle < 4) {
>  		dev_dbg(csis->dev, "overriding Tclk_settle with %u\n",
>  			csis->debug.clk_settle);
> -		csis->clk_settle = csis->debug.clk_settle;
> +		params->clk_settle = csis->debug.clk_settle;
>  	}
>
>  	return 0;
>  }
>
>  static void mipi_csis_set_params(struct mipi_csis_device *csis,
> -				 const struct v4l2_mbus_framefmt *format,
> -				 const struct csis_pix_format *csis_fmt)
> +				 const struct mipi_csis_params *params)
>  {
>  	int lanes = csis->bus.num_data_lanes;
>  	u32 val;
> @@ -692,11 +711,11 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
>
>  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
>
> -	__mipi_csis_set_format(csis, format, csis_fmt);
> +	__mipi_csis_set_format(csis, &params->channels[0]);
>
>  	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL,
> -			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(csis->hs_settle) |
> -			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(csis->clk_settle));
> +			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(params->hs_settle) |
> +			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(params->clk_settle));
>
>  	mipi_csis_write(csis, MIPI_CSIS_ISP_SYNC_CH(0),
>  			MIPI_CSIS_ISP_SYNC_HSYNC_LINTV(0) |
> @@ -771,11 +790,10 @@ static int mipi_csis_clk_get(struct mipi_csis_device *csis)
>  }
>
>  static void mipi_csis_start_stream(struct mipi_csis_device *csis,
> -				   const struct v4l2_mbus_framefmt *format,
> -				   const struct csis_pix_format *csis_fmt)
> +				   const struct mipi_csis_params *params)
>  {
>  	mipi_csis_sw_reset(csis);
> -	mipi_csis_set_params(csis, format, csis_fmt);
> +	mipi_csis_set_params(csis, params);
>  	mipi_csis_system_enable(csis, true);
>  	mipi_csis_enable_interrupts(csis, true);
>  }
> @@ -1216,13 +1234,9 @@ static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
>
>  	/* Start the CSIS with the first stream. */
>  	if (!csis->source.enabled_streams) {
> -		const struct v4l2_mbus_framefmt *format;
> -		const struct csis_pix_format *csis_fmt;
> +		struct mipi_csis_params params;
>
> -		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> -		csis_fmt = find_csis_format(format->code);
> -
> -		ret = mipi_csis_calculate_params(csis, csis_fmt);
> +		ret = mipi_csis_calculate_params(csis, state, &params);
>  		if (ret)
>  			return ret;
>
> @@ -1232,7 +1246,7 @@ static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
>  		if (ret < 0)
>  			return ret;
>
> -		mipi_csis_start_stream(csis, format, csis_fmt);
> +		mipi_csis_start_stream(csis, &params);
>  	}
>
>  	ret = v4l2_subdev_enable_streams(csis->source.sd,
> --
> Regards,
>
> Laurent Pinchart
>
