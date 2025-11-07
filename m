Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013069.outbound.protection.outlook.com [52.101.72.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F42D7DFF
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531853; cv=fail; b=GEWg78+Ei7jkJ6yJqY9SDaOCT5tTxPlnmBuvk7x3A4Orh/dSvnzL7IHSguXXHx+nYCC3fXo/hxCZyYrGDNDZDp1JN59oVS1sfZnrlW+1ugEg/jkjEJyy0/1c87ApnjeOjWO/AVGYTs+OHdAEb2Gm8jXCTYNGTqW56J03aYgkVec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531853; c=relaxed/simple;
	bh=B75V/Xk2pBGOZqiPAXtJZPpL/fk/2wkLynk9B+m0vZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPlnkaAL7mA9hAhYAOaqWmqiqW717wN58M8hJNBA7r9jdD5v78WgtW8keHd9eJ5Pv4OSOg+vNi800rCxKenjePeMolOcI6qoNAzmlEgZTBzl5/TnMpA+Cn2g2vHrmu8XS2pKvFlFNwnlJBU5E2fiICoFgcB7nkAl7sB/1EF0qz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WnZ/+VUV; arc=fail smtp.client-ip=52.101.72.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WnZ/+VUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR6PnHun9YTdek4M6Kjp/DnJQ2MSL7kA4Da9IyrIEUG2IYyba6X3Oe+EnQZppbE4o6vEzx2T3r0Hk+kOr8fFzbrGnCbBIf4gCmq3Z+NTmoVtzPlyDJ1Ta5M8q8II1B6u7QpkYLv5Ot31tFxAsZ0IZbjTKtkO3RNgWxDLGns3DQgLcukiPdJRVKESuD9OH0gHT6T8Aj25n54R/+0quomvnew1tqAMUKZbOvkgnJ/H2d5VGlu6kuLijG+2hPQslG1VgeooutHdHh9p3S4HGRBvfRRH4PEgEgDxUQSfjKsIWwACzyMJKhBFeP5zaE2gPSMdlnDFl0qAUC46VeNoiwnRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNbm5M/50yaHoDp5XTlZKE4c1RlcfihjzhbMGfYEdq4=;
 b=slh+NyIteI/tiM4qVK76LFTnTfq0VMFDsmTBDP5I9Zz/c7NdC8/2+Dd7Np5TJ3FHDHzenrM+zFE2hsUlc7uWLEFfwhS6hdjdWLbgBC5d+zhmjg8VdBSay9LvvvhTI8lFphO4CxgYGTjThHTQiI7T8AbNL6ysRazJWi5fXe5Sa/Lz6ipxu+epA2UxejE4GQhE9E8ADsFOvJ2LX6+h/BybsJFsgahFUU5rp8zM+/RQOZCFd+NTid4I+9EMC8rfDRdQQ9bSK3rskdBazllwjabHGG56SNNlbl1vGussv+/6xVtqzUZg1a4xGzqGmN7t4p96714bOKeZEnRXHSUi+TLAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNbm5M/50yaHoDp5XTlZKE4c1RlcfihjzhbMGfYEdq4=;
 b=WnZ/+VUVX53P5oP+ca8eScm+zbcIdp+54N8zf7gX/M/+vW7MK8vm7Ot0jnRDbZHHPukhWKqQUkKfucJCBWCGG+PdyaxE1V1Hc2paGUzpSdL/ChwpsfDeVMFGJwXFthn5QT0WqY+zljkGP/+Sx9XZ9qkjnUs8/0EdJ2goMQI6kdVvKqKLJF7ZrAzWfYCeHmqiOK9fM/4/zrnETavCk9dHl4AtcjTT+v2Im8x0Oq/kmY5nG4dIrqYqX41iaFxRspblyZNXz7141Pq0Ee/ZDu/jhabpUgKx0DP164omj9QBfVg7KSxP12gOgf6zz5gZMx2QG2dYsSGSXq1JhIRmBL4fIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10110.eurprd04.prod.outlook.com (2603:10a6:150:1b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 16:10:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:10:48 +0000
Date: Fri, 7 Nov 2025 11:10:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] media: imx-csi: move media_pipeline to video device
Message-ID: <aQ4aAUZY4jrFKjwA@lizhi-Precision-Tower-5810>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
 <20251107-media-imx-cleanup-v1-1-f82a693c28f4@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-media-imx-cleanup-v1-1-f82a693c28f4@pengutronix.de>
X-ClientProxiedBy: PH7PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:510:33d::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10110:EE_
X-MS-Office365-Filtering-Correlation-Id: cd22d11b-990b-4b15-2922-08de1e183717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKN7RepJ89H5Q1ldr6yBRNqJO9u/NECqxc8Pn4mnBPWMtd9LfxmXQZLtvDuO?=
 =?us-ascii?Q?VV5JC9ps3tpSVD1XMfIrkL8cD/UlQSX61C4whWYU6+g1Y7nvuDiRR9i8Gc7M?=
 =?us-ascii?Q?B6EqGfz/zKi6y+zh0FaEsNNAtVCW6SoteK4kcHYtBjVypYVW1cbgCs0QcFIU?=
 =?us-ascii?Q?7NWgohHEY/l8JfBF5GfdflqOC6HZaynq+/iJIN8VW9ZEg/bNanVEYGfzYNsm?=
 =?us-ascii?Q?k5WFQbXf+tWvLg6MSzNadYwGh77R6uDTZr++8x49oV9jviEd5Wq4WstkCmj5?=
 =?us-ascii?Q?6E3BB+cwecqdFNt5N1donDiqJi95BwAnv7d8jeFSi1NakUTRAZmP94F6fIoq?=
 =?us-ascii?Q?/ktuJMDSIfjMQ/oDyt9FqbCA6pA7SH5onxYtObj3xTDL/M7aJPALRYRr8YC7?=
 =?us-ascii?Q?I0FS2AIj38pdW+d3QGXTnVcR4spoh6gYpMSoQf/NfwLeTB/Yn8Of66TtF73/?=
 =?us-ascii?Q?9Txqgn1GeRwShjwDz1daRDZ+43hchPPSyruCglCYvT0pLSb38n4n9wa/B2yl?=
 =?us-ascii?Q?3Zoumi9lJTJecL3lahXn7xAv9dG72b4HbduSxZm/ob3csEm+Q8I8I1Gs2xnR?=
 =?us-ascii?Q?NXNINVyUYPhf65KWqHVcB4gNpApf/GGo2ewl0dzY454QsFESkupXHXxTsTLs?=
 =?us-ascii?Q?bafN+6RReeQXKQQ8XWFMTMhBDL2geZddPfBRSgDR2G7oosAtb9YJsXOrg7BC?=
 =?us-ascii?Q?e2fgQNUSCutkFaJAF7dKDgfb63oJRccsy80h0kHy4HDZa88lUgYooOoN7BtX?=
 =?us-ascii?Q?wA3RcwsyQTTE+CjDpAlF7pdzVhzk8QyMW2ArUyY5bsxo72NZmrRZ0hal+X7M?=
 =?us-ascii?Q?GVjKJV+FtQtkWITiS5/Sn0ES+rI5ZsfXIoqrNIlTEiN56XIuvmY876FWpL/9?=
 =?us-ascii?Q?IaSoR3OfVbN3TRF/Lhxn5aO309Z/LsOul3nWiIZaPoHzZl0ouhSj2Mr5ymqB?=
 =?us-ascii?Q?4/FPeJdQWL1e/2/e9gvw18yBVegWicX9P4ote+/oYY+9Ro5/kSPZ3tGPpi+f?=
 =?us-ascii?Q?/BU9kt2S8DXjWOQmyiybd6bnGqaUnGq8oeNq14r2tmJ/fEDBmrc5zObtoJBJ?=
 =?us-ascii?Q?zCJlpKzOD2dm8DVXhBMD05pc8gq5R/b6tDXlCtnnoivK8RrDIOdpOc1k3Qkh?=
 =?us-ascii?Q?lICWL8w7RFcU0tqfanqJunRkcHZn3X/gIzZibDNUHc7C/rEZRfVapxp3EV7y?=
 =?us-ascii?Q?OF1kocgJzsDjpqp+shDcOfQBqTrsMlI34etw7kYkxiRUkPRmBteXnjJLOGEE?=
 =?us-ascii?Q?EfGky6scjH8YTxMauPn5YxSpNQEueI+lwyH1gCtAUvehDRX0474gnpRpi9ao?=
 =?us-ascii?Q?bQa0Vv7+/bVMCrnieYwAEqykD6Tr0w+NkSrO20F4QYy4+Y958SrTiC5+2+rT?=
 =?us-ascii?Q?NoX7V/UdiVMfnk8t9qP0W+BDBantgolRcDjhkfNuihZhTWhF6BU+J3EVcmSG?=
 =?us-ascii?Q?SyPSVIJR3F13Zimw2LBEXG82RkCalEfdDnVQOu0NJIldcVY+y7y8xRtKHHv8?=
 =?us-ascii?Q?F7zj7rRKrCshS4ulhQqZgDwmCVlKm0y17p3t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrKcPOPwkwvTH1GTeBTikhqZ2E1TMnGMMW53+wrPL10uqGjz8yJv8iABjAV3?=
 =?us-ascii?Q?qtJm6TPRHuYIS6+rYtSBeMmxabR3eAMX8c4PhVjORqerZ21U+ILExjyanmia?=
 =?us-ascii?Q?VWLP4Nkl+kIawfxXxLVLD3JhM/lT9zopq4EMY+Ac8zOnmHYnilal1pSGaqHB?=
 =?us-ascii?Q?X5v2DJfyQtgKW+Yau/2lqIs1wAjXjst7wJbAnxUkMsLAsoaoETypqun5a9yo?=
 =?us-ascii?Q?1udKE//igr6eETsDmRBWYifU+rIgqefwC7iLrjsAs7nrpoIWDUtvTTMUpW44?=
 =?us-ascii?Q?aoY1cp0Wa7hI3/+YCiDPZelAlp3EVf7lslzL4Xk28ljoMeeCVDHzWMBimxtQ?=
 =?us-ascii?Q?EAc+lcigH/yIgt0EcAiVXW11I9zSvjXXmyho09WEuZKAnpfoO20Lv6JwR5Nd?=
 =?us-ascii?Q?HoQpQAZsuS3RYxPznljYay1SMvTMM/qB0vuj8f0m/1/xCEzT48dVPwe/q0FB?=
 =?us-ascii?Q?Qo4yCJJN5wcaLnMjtH92oS1BAPFufVkOFwKRq5feDIUmoXNT2NX7/k+KK2qj?=
 =?us-ascii?Q?BwkqblhDelqYMETs0zgD+jCl08BXrzA+NCtYLzZgXgowuiAtUAjZV+nF2uEG?=
 =?us-ascii?Q?2C7iiIREiYeXWsaO+juGFv91jbHj2Ruf1lWmSDPdj0VfrUjDe95XGvxX4Sbb?=
 =?us-ascii?Q?rtKmlq3gv9rebuglFuJ4HGRc8orVGy7Y7vaWfQV7erkmwLR3cA2Qqq2i45MI?=
 =?us-ascii?Q?qWoPvNH6gJ5OGFemtN7vUDj4VsJSHHNAqg9QLdczlO/lSDR92YPrYW8BUsKH?=
 =?us-ascii?Q?LOjjm9FoHlTj3Q5fhNANZu5NinTth88DuBSdQGl3Zr1jmBrPWAH7LaquyWXr?=
 =?us-ascii?Q?QuSPpk7TL+Ssi5H6Vobcnsv1z2SH9/Cw5ffZ+2bslgol/aH2qzJVBXVFNTu6?=
 =?us-ascii?Q?hS9FgU4b1PywyVKwxtLLxghjR9Y3ra+OFsIfVkf/b1mfzFLTd8SZScsE1GCz?=
 =?us-ascii?Q?vORCGVufOeONQEFxkaca7F0OY1SXnUygO5N5jHiQ/5fIu0ozErLM8UtehGR6?=
 =?us-ascii?Q?dKizgebSPVlGeKwfKU1iGTBcDYwv76t0C+kZHyzFBz2InmADFgV5LMbIWtTK?=
 =?us-ascii?Q?yRFd9Uwr5zr8m5A+vU6QjwARuQDEAy4ndr0CgikRJr++46clKP6v3P3+6wYl?=
 =?us-ascii?Q?/KXyiEY5U29+ZNlJ3GrAJ7Ik9nYp+lWrKvYwBGPNF1XVA0RmSRc+wDAzYfp1?=
 =?us-ascii?Q?tdeG6/4p4QUBpb78A6s7S12yss/zLcEvQ13tCOk6E+aueSIaFdChcUh0KCPC?=
 =?us-ascii?Q?isHxPWZNMaja4ITJrZNTp/bvvxrzg898zaNnZVe+yPkZLGwiEmvChsRCwIk6?=
 =?us-ascii?Q?3N+oXAOGAqhKyDQhThIoF+7CNw4Cgfzaz5s8ZpHUARZcElDk7NxvYLEC50kA?=
 =?us-ascii?Q?j9klOj3geRgWS3o0N18g1TbGBdO0DZJzHzMn+5AVMT8hBDj4nLyvjMmRD6M0?=
 =?us-ascii?Q?GTWhHD6eLs+/6f3CwH+IVKaShSAI0damdzW6QzPpsDGfM6FH+Eecs/yNNH+o?=
 =?us-ascii?Q?o05YUeQV6FnvtpmxJhV9Fef/SBLoNHglSrGMTsZUTA3vaNZiluAHY3XqpQz1?=
 =?us-ascii?Q?JoNWewB0MGbVPXLegxKvO8l+m2mLcBBVXz+eoRZj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22d11b-990b-4b15-2922-08de1e183717
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:10:48.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpXL3dg+Sk6FNqyib2XYGPA7gBDky1Bs0ia3IcM8TsW0M6i2R1au0uiZsFwxkEWM6ToKU2nbqSOfwVaffWWzbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10110

On Fri, Nov 07, 2025 at 11:16:33AM +0100, Michael Tretter wrote:
> The imx-media driver has a single imx_media_device. Attaching the
> media_pipeline to the imx_media_device prevents the execution of
> multiple media pipelines on the device. This should be possible as long
> as the media_pipelines don't use the same pads or pads that be
> configured while the other media pipeline is streaming.
>
> Move the media_pipeline to the imx_media_video_dev to be able to
> construct media pipelines per imx capture device.
>
> If different media pipelines in the media device conflict, the
> validation will fail. Thus, the pipeline will fail to start and signal
> an error to user space.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/staging/media/imx/imx-media-capture.c | 8 ++++----
>  drivers/staging/media/imx/imx-media-utils.c   | 3 ++-
>  drivers/staging/media/imx/imx-media.h         | 7 ++++---
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index e9cef7af000a..bfd71d25facc 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -722,8 +722,8 @@ static int capture_start_streaming(struct vb2_queue *vq, unsigned int count)
>  		goto return_bufs;
>  	}
>
> -	ret = imx_media_pipeline_set_stream(priv->md, &priv->src_sd->entity,
> -					    true);
> +	ret = imx_media_pipeline_set_stream(priv->md, &priv->vdev,
> +					    &priv->src_sd->entity, true);
>  	if (ret) {
>  		dev_err(priv->dev, "pipeline start failed with %d\n", ret);
>  		goto return_bufs;
> @@ -749,8 +749,8 @@ static void capture_stop_streaming(struct vb2_queue *vq)
>  	unsigned long flags;
>  	int ret;
>
> -	ret = imx_media_pipeline_set_stream(priv->md, &priv->src_sd->entity,
> -					    false);
> +	ret = imx_media_pipeline_set_stream(priv->md, &priv->vdev,
> +					    &priv->src_sd->entity, false);
>  	if (ret)
>  		dev_warn(priv->dev, "pipeline stop failed with %d\n", ret);
>
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 1b5af8945e6b..f520529a7cfe 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -749,6 +749,7 @@ EXPORT_SYMBOL_GPL(imx_media_pipeline_subdev);
>   * Turn current pipeline streaming on/off starting from entity.
>   */
>  int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
> +				  struct imx_media_video_dev *vdev,
>  				  struct media_entity *entity,
>  				  bool on)
>  {
> @@ -762,7 +763,7 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
>  	mutex_lock(&imxmd->md.graph_mutex);
>
>  	if (on) {
> -		ret = __media_pipeline_start(entity->pads, &imxmd->pipe);
> +		ret = __media_pipeline_start(entity->pads, &vdev->pipe);
>  		if (ret)
>  			goto out;
>  		ret = v4l2_subdev_call(sd, video, s_stream, 1);
> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
> index f095d9134fee..8b65f79b125f 100644
> --- a/drivers/staging/media/imx/imx-media.h
> +++ b/drivers/staging/media/imx/imx-media.h
> @@ -104,6 +104,9 @@ struct imx_media_buffer {
>  struct imx_media_video_dev {
>  	struct video_device *vfd;
>
> +	/* the pipeline object */
> +	struct media_pipeline pipe;
> +
>  	/* the user format */
>  	struct v4l2_pix_format fmt;
>  	/* the compose rectangle */
> @@ -145,9 +148,6 @@ struct imx_media_dev {
>  	struct media_device md;
>  	struct v4l2_device  v4l2_dev;
>
> -	/* the pipeline object */
> -	struct media_pipeline pipe;
> -
>  	struct mutex mutex; /* protect elements below */
>
>  	/* master video device list */
> @@ -223,6 +223,7 @@ int imx_media_alloc_dma_buf(struct device *dev,
>  			    int size);
>
>  int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
> +				  struct imx_media_video_dev *vdev,
>  				  struct media_entity *entity,
>  				  bool on);
>
>
> --
> 2.47.3
>
