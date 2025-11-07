Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239732E147
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531954; cv=fail; b=e0s5HthSfYXfTzYlDg0n4V4MJd99148ScKzWUe7RfaZb3SkDXSQFFbPOb/TsGelD48A9GX/R/kWGgsDSOFro3V0d84KCRf1C04EumZWvXg0ZFM6ypH0aARCg/e07cA9NZ124fHLMAmeLBMbyhOztxkcjBpTBlVFOmudbYFPAfVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531954; c=relaxed/simple;
	bh=92u03GB8+7MYW39DXR7h/QnQiRpBCvbJ4YH6CjDDYC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IF1zKfSKzwXAGAGdvwKBuiZZkTczszKpDLMpvLFvjGb9hhpPASajEaLSdwbOlAzwNFlS/qsSgcFERB2ZaOrdj0s7Q7vQdxcGwEIp4r5XfN32F5L5V6WbIKbthRTwSVcqX0O+fZNs2xbe1jwPVWtmBM/hjhOGnBFpy6Vh0PLQaQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EsFwkiju; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EsFwkiju"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN/b07Qq7ZZElPDvxmf+IUE2yJea0KUdxJw2fdelYoTfF7z7wD8uN/voiz27yw4WRsAJP7RAGcCk33wY2H8ui1Y5fUscPWEVzhus4Qic3wnZFlSHoE2uBTCTovSC9xsHO+Y4QHxMsukkOMsVLwLioYXxpeodkqSaHt1OfCvCSZslNHKaTEEgrCkx5uPqv0x41Aa9TRYB3HDT6H4Ge2TTI0Duj6MIRAHTB2/3i+igeKic5tNmX07czC1/ouWWCfhX87OXyAIH+V96qX1QKaOJCAhihiCZWTtG7d9O0gxD4sLUu4vFLfF7iA9/s3vp9B5IB5757YeLM3ATcVCOMhSMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BjlJkEW18yzjm4VlW1UDtPJuiv6WWtwVaBLxMnBPdU=;
 b=ym6sncp/y1jQrSjSc9+hA+V2V2PQl5V0fQXdJChWl7mn0hfdtrC5aUznCWop/gqbsDcm0RH9Lofg5pG34nkJggpYEm2sShe1E+y1JRvJp5M3YhNsdTvNHAYh6/i98WXvIAUkZMlPWSebblbJyJORwZw0IW3bDF9sPJbZP74418zmAfu53lfkra5Vn/iVmIyy2gr07qPo6Zh1GjwNJwJs03fEgxDjcHwfna/mkGEYZGQXy7KbwtTA/DkAR3wscHAJOf/eeiJXb/AG3+tvvJMtNHK0Z56Uc1maFuwC61xT0GVFqmprlhEvgT2miLqKCcMfwxr8L58gXteZk4gSF2UiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BjlJkEW18yzjm4VlW1UDtPJuiv6WWtwVaBLxMnBPdU=;
 b=EsFwkijuL9xvzEhC99p+Smk7MQfGHwNiJOUg1h5EVbAvf3yjyvnOT3M3ccnWWlI591nFYth6yeUQP2Uz5GWKnDHSH1tMu6lwu1BGa5I5Hh6YLDdNx0Csob3m1YRYawZ8DMDsVCRdmkNhKlW1ONXul11HQ62hcZsfRfDqZidPNR3vUQGF06QFCEANVbPo5ULk6Su+1InNOQtt4nxiH9ky75/iBK5gZDHD5Gnkd3cD0sk0cV/1MCbPHsNPLBCfhEQrJK2t0YHhcHdzQf5bWLS4v9eeazbRrztrDKwfFwft4juoyMu/oVvlGFNT5r5mGkBvr5JdUSK6db3tdrTOVdr6PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10110.eurprd04.prod.outlook.com (2603:10a6:150:1b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 16:12:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:12:29 +0000
Date: Fri, 7 Nov 2025 11:12:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/3] media: imx-csi: explicitly start media pipeline on
 pad 0
Message-ID: <aQ4aZXvS4y3u5N/A@lizhi-Precision-Tower-5810>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
 <20251107-media-imx-cleanup-v1-2-f82a693c28f4@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-media-imx-cleanup-v1-2-f82a693c28f4@pengutronix.de>
X-ClientProxiedBy: SJ0PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10110:EE_
X-MS-Office365-Filtering-Correlation-Id: da71986f-e04b-43be-5bfc-08de1e1872ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ys/MSkdIGYvHI6IzABfaDOVew9EQruvgraNADewHjHGU5YYiBX1Tmqul7uf2?=
 =?us-ascii?Q?yifzhDrtc6T3rv0qQ/E7vJmPIB0XzQSwvPyqoCtbH2PrX0SyvOIl0mDQWf3g?=
 =?us-ascii?Q?Iq2AGMq4Ryyv41q4bBonYaZ3959nPnlpVGb5K3c73d+XlItDzRP7UlXgl7rX?=
 =?us-ascii?Q?DKyP2u9mkwMEpXq6mALuh/jIwKCbI/1jVmGDz0D8ExpY3FOl9T0O4bLrV/3E?=
 =?us-ascii?Q?f6vw/7dhGfQ2EDoJfwjB4CyL0l080jAxqbZEWPjYqodQsUv6WDVEwyq3fkKY?=
 =?us-ascii?Q?peWPVpvuS6YNmuX8V1WA2dU36oWNex8DJyy/xy9WDdDHFkiOF8iuQIflLztL?=
 =?us-ascii?Q?vhIIuQtqGiB+dEgddAxC+nkkCf5+Z4QGGnsWdkM70bvWPtNdcceT+9PyqxqA?=
 =?us-ascii?Q?t7iR1fNug+5KH2hQ5jY7ojDHTkYV9QF1XaZX4e/cGYclXBncuv1hfYBM5W4e?=
 =?us-ascii?Q?9KubtH4jrzEyBbNAINKYm1l07JkgAE3PZKKwU1jIYRNgAI1ev4jo0hS98oZa?=
 =?us-ascii?Q?owtCWI0+CjTRV+BaZpFykZnOKAMjQguh3L/tVLHFzlxQnkiXkKEeOtlaqha6?=
 =?us-ascii?Q?l3rvIeTe4lRUvp6gFL3WhJV8qMZFRV4KxHimJLCdOsJ5GUXD0YrU3fWGHIuk?=
 =?us-ascii?Q?nA3zXkGL1NymdOVq+EPuVIPOx2LKAuYPh5p6vmhHp9H5lgSi8B8USJ0avFWL?=
 =?us-ascii?Q?oqMgon1v2YzCDTeuouiJH3R+F/WbcAj0ZyLXMnXaTZZqo1KyPS7yN8bHnNax?=
 =?us-ascii?Q?FwL5eCVEzE8gFuHevUXN8AgBK5czz8KNTJadHetVZqKuA2UJy3SNdL06YAQl?=
 =?us-ascii?Q?nxlnhmUYWp9Un3s/royNfplUtKa70AT8mEcCL558xBVdOzrQOrc71FRLOVe6?=
 =?us-ascii?Q?ailR5fVRRL+UpNqsMocdI1EtJz8XZkTzanfbd5GciNVEAFAQINjB1yO6SviT?=
 =?us-ascii?Q?gvlR6AVNegGeWvVHD7G7JH1KN0m3VDxCvCdGLSFXYjVpKMmaXyo0MY8gf9L2?=
 =?us-ascii?Q?Q25IQIuGUWmmmSyrByl9TPfSWQpE+2V+rEPssYufGYTFHumrfaSYf3v7VFYu?=
 =?us-ascii?Q?/vVhVDVFRYU/YG9M0QlAGr4CcXVqWUdNPdjuGqAR8KU0GW2YAgUwvXILgyd8?=
 =?us-ascii?Q?WoWWH0eK8mjMqQeNUmPkwKCuYLOlldzAoHT9JNDFNY20ccviDd1+eTEj1Yvn?=
 =?us-ascii?Q?R5DZCfGahWECOhODX/DvvAcYWLAO/aeCrgQmKmA2aJu9NuBYQ8fvFqKn6m3V?=
 =?us-ascii?Q?pGC2fZ1xt0hVt8wEl0jjtulN+hbK/aGluP0fhgZzWwsR7daBuEqFmXW3DtHV?=
 =?us-ascii?Q?KaQvY/WeYjuf010pWoP7KQSYvnp5+tgjj+OkiJdY+wu4jPhiUXYeM2+fPSGo?=
 =?us-ascii?Q?XXUIGPI/hh5R6N/Lta6HkTewYtlpWK5uU/kq++sv+Hv7qsMeXaU4D0sF9HVg?=
 =?us-ascii?Q?m7Jjoac1a0u/A+Fw2K+adrakPwcYygDuvdCY4HWN+QcGRQSIWsGZysdYnbdy?=
 =?us-ascii?Q?AX1vCR9twioDwlI/WNfMrFECdAKctCduhLh7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tq4+EJ/wSN/Asmt6HKecsQai22yO1WN8F0NxGrL28f74cIP3Sm8uIIGFkPE4?=
 =?us-ascii?Q?WUKPhRuBS3z/5IokIOwW4bLf4ID9M95vlHh3aGsxWH8pOdhKRCqdYhr4i+qX?=
 =?us-ascii?Q?S8iwmLUc+R2pNssMR5gLPWAetazU+wonOhrW3PZnf2hcwP5tFZkM3OK98HyL?=
 =?us-ascii?Q?3MU/jCBXS27ygj6R02FIvaCjIEqXzhHFP/7DSwVXoJxq03GdcnxIxWwX2IYf?=
 =?us-ascii?Q?BzPIVdzKDk15sAbuN1F+OxzkXAz/vOTjoIgN44kawST4RQWX4Vh6nK20hPa4?=
 =?us-ascii?Q?TukeXB/2m50lpMY5n/3lTYfB/urjKeJajvJZt7bTm6v5BlYbvEP+xiz95qUV?=
 =?us-ascii?Q?PlfDx6iBlOuvfdu1gRIjaC67X9kirsu3nheDcGAEK10B8SuoCh0l7ER71raf?=
 =?us-ascii?Q?RFpg+1+0F7TYxz2jdcg/82JDIAAZB7asnpsS0RduML4YAxGpxyXJFn/sKevm?=
 =?us-ascii?Q?uqOsLf2nIuJwWt3w2iXjehbvNhcU0Y5XJEdXLBCwPheQfaQPRchHOP5BF1WC?=
 =?us-ascii?Q?mxFrvjw9Hs1RCrdr3oFU9LOD4j86MPW8m0+tKzUxxy1hsRReM/7UPXW48abw?=
 =?us-ascii?Q?YYPTDgaUVUTUP76wcqlXKQQ10LMPCwxSvThHfC1ud9RG4ubsk7Xzp5ovf20I?=
 =?us-ascii?Q?XvCPAgLef8flkQ5PTD8yKSHAl1csYrcUGtQi+1rXHPMEd/wXIwLqisffbdTm?=
 =?us-ascii?Q?9zOocX1z+eVV/KfZshLNvuAy+Puk5wlAzlrsIFqjazq+lYNTaUNONEp9QlyO?=
 =?us-ascii?Q?LnyoQgHesLDVxRrZQrUObpPrkiB8bLTJ6W+QxwwBQlwje+rPpLKTtuMRN99W?=
 =?us-ascii?Q?YJRkmsdCZ15uUbxPpNhWPXn6i/D88UFGbA0uX1R66c6f5VaN6zPHAHQdy1OX?=
 =?us-ascii?Q?LrBsyqJaggNTYyenJcas5MlZV2zkMQlvR9H9BHOwQ1633yXMksTJiYSgL3wd?=
 =?us-ascii?Q?ctPW0Gipn5TXKJ6yO+sRr8lpzcg/M7nPPZn5Q7rvvVyoI/MWvfvlQOQpgtEg?=
 =?us-ascii?Q?DH37XimQrmWVxeSMMKgdK6cjUaALevl0o7zKdBREdVzDjx2HwZWPfT2iO2x3?=
 =?us-ascii?Q?Eyq0OYCXUPXA6YuetVjIGQKhuobh9FBEz4fV7joYMhR5HveAs7kVDfHgY3YB?=
 =?us-ascii?Q?CQQWy+wbzsVtvET3g1iccAGgyJYiOTKJWfaP5zz+jNyX1DvKbX5x3rN4Iyar?=
 =?us-ascii?Q?ZUL1+CyNAWvpGZoDYM9XNC2nZPdwLnToDtHqiGG3yhvqPVc+JNgxCUsFZj76?=
 =?us-ascii?Q?aaiEJi1Kpq62+JCPsjNxT0InwzwL/PhMGOpnevWKvc6nohxjRqA3Z5bPQ89n?=
 =?us-ascii?Q?uDtCS1/P+8RkwReDd/4i+xhHv6KBM6nQ6jQm/92rYwy/2GbdVon6YEJRrRIy?=
 =?us-ascii?Q?JNfo4irhLdze5SpgN/welfupwIyLcyck6i+FpFbfOyj5kMrDissokbVScEhO?=
 =?us-ascii?Q?RV5adoIOLkhK02HCKOZ4N3erPYFMpV4UN9ncmhmEJ/Ur+RiNKsTLD74khQFX?=
 =?us-ascii?Q?IIWauFKZPNBizrIylvMtVDBUR6TrfwxoExaRWTu+0fXbqvrecz+hJtVn+1U4?=
 =?us-ascii?Q?UW9JtgNaQ0D0oYuM2gg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da71986f-e04b-43be-5bfc-08de1e1872ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:12:28.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaY0hxSx3xJpBvNqx+DxtdASh/SOmL8nFmk26OvZyyIlNV+x8PoJLuFfH73mZsUsism3hjhT/rbDTjAo9bsUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10110

On Fri, Nov 07, 2025 at 11:16:34AM +0100, Michael Tretter wrote:
> entity->pads is an array that contains all the pads of an entity.
>
> Calling __media_pipeline_start() or __media_pipeline_stop() on the pads,
> implicitly starts the pipeline with the first pad in this array as
> origin.
>
> Explicitly use the first pad to start the pipeline to make this more
> obvious to the reader.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/staging/media/imx/imx-media-utils.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index f520529a7cfe..6d69f69c16c1 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -755,6 +755,7 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
>  {
>  	struct v4l2_subdev *sd;
>  	int ret = 0;
> +	struct media_pad *pad;

nit: move struct media_pad *pad; before int ret = 0; for better read

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>  	if (!is_media_entity_v4l2_subdev(entity))
>  		return -EINVAL;
> @@ -762,17 +763,19 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
>
>  	mutex_lock(&imxmd->md.graph_mutex);
>
> +	pad = &entity->pads[0];
> +
>  	if (on) {
> -		ret = __media_pipeline_start(entity->pads, &vdev->pipe);
> +		ret = __media_pipeline_start(pad, &vdev->pipe);
>  		if (ret)
>  			goto out;
>  		ret = v4l2_subdev_call(sd, video, s_stream, 1);
>  		if (ret)
> -			__media_pipeline_stop(entity->pads);
> +			__media_pipeline_stop(pad);
>  	} else {
>  		v4l2_subdev_call(sd, video, s_stream, 0);
> -		if (media_pad_pipeline(entity->pads))
> -			__media_pipeline_stop(entity->pads);
> +		if (media_pad_pipeline(pad))
> +			__media_pipeline_stop(pad);
>  	}
>
>  out:
>
> --
> 2.47.3
>
