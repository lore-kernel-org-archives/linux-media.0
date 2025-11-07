Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DD27FB2B
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532982; cv=fail; b=FrC1vLHbGg76Nb0sZZqSN09DDPpWOUZnzVI544zOLqX/LyL6ipp8z4vz/Cokapg6mOLzUr73rbI0BZoKFOJGdZf/NiRbQAp3kyQzPf0gy0JaMRCxIsud/Lk0zOSNAcqTql29FrbL2Sn/t624DE6MmDPlJWSXfsW0EETJ6Jqanuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532982; c=relaxed/simple;
	bh=N9SXGqL906W0bF2D7aoWxSECL7OiTMOGVTIPNrCNqoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AsBJ05A/3bVNr4+C7LEH/nKbH9MOF9lJ2vr5a3bwtHCegrS0NQdEHt2hEjuNYZDVghGqWus8Pv16Ch0cGv9rbNx3bV6st6yeck3Rg8TZWpjD540hPP562mYgiPvNm/JoNaH7U5AEt2VB+qPQGwx1UR4oarxxk6eyL0RzZuUEt58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=COwsFr7O; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="COwsFr7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTlMPj3vdaKjjkzvc4sL7GBvw/VjK4aRxxVWhAOvJYbU/J24arvVPeE5QUsTsUy7q9SJb1e9zQcWH0GTZz1NYC6Cuj5Ueaa8piPHRWWf+ENv1XjuotMjjdsxtHVKcThWL7rYezUDhOxazNHOa6zbYp8V3WAJ9UrF8OeY716a3QC4MwFdS3SpAbAFGbDPGm968XY9wZf6pDSIhiBojKaiJz2m9h8nyVFDUHV2lqU+64ckC1wTEWmJBwCl5q/ACqHD+NAiocOWcMuAs7s126oyNQtks/mXDsOpw6BZ44Rq+3SHzzsPjneooIHSv6KbZNUwTwbipxjNqyHhNo7U75w5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKi9iGJyyb+w/oHYcZvgugnPCYUVB0tZZGez7zIIHR4=;
 b=eGMwdXsBRd1EF5O2ZcwqvSW5jykcX60yLcr/Z1oJTx73th73KqWdsfOeS41WDb7mIazLonSE9he5XCvxYyycbCdVetryfkD7Er9t2VTRb/6QKLCEgTLsvUUTh/c/48taFEXEVvUgP2lTmunFpV+LeaRceYjyuVIK1JFWmQywWpU/M8J93SFpyPq3df3I4zUtUy/EhKvr5tM5YqYQqSOf0eyY6iTW4XFF237fhTpKsPWQ4ml2wVzwP7gk7ccCAFYYhZvYTvn9jo7pA57CjTIF3EPL3tCHXJNLc+fzYGjLsxeGEa3+1tZpIT4Yh+QT9Ah7WizTX81Z8SHTbksa8lT2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKi9iGJyyb+w/oHYcZvgugnPCYUVB0tZZGez7zIIHR4=;
 b=COwsFr7OlI1jg4WjygB7P5uaMzg1Cw8zCBu1e6t+JH0M0odJtnjyvmrHjosIWvGsYhXTfodFs5Sc3zFA7d+XIsTGmqIiEgQMOFn1pAHlJnOdCVJSlniQnEaDnHncS1MYJpUrAyXyI/CUI+OSKFnL0BIGVHnSXFCBI7EnqbqbSEuUK8JxddiLVoI8t8bHJPO+Qo4OLlTLv9TXnjPIa2bTtw+ixLVtnC4F/iWo7cruSm+VDy2mryHn/Kloi+Gp58ShpBEe8C3ZL3bCx1uw085/a2otuFc6joN5oPQEkQoIruj1pexwmZ9a6vxwWFoHucdXEW0vtAeviRWsfrr+Iq4O4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10519.eurprd04.prod.outlook.com (2603:10a6:150:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 16:29:36 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:29:35 +0000
Date: Fri, 7 Nov 2025 11:29:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 2/6] media: imx-mipi-csis: Switch to .enable_streams()
Message-ID: <aQ4eaPxL3n1I/95Y@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-3-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f09601-2935-46dd-fc7a-08de1e1ad6e6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?rflwhjbzKC8FAt2x57Emx4Z3SlN9Vcjx/CMW2tr/FjpvSf6lMfj2cDodTxf2?=
 =?us-ascii?Q?ddVTmByqJ0EdQJBx8Ndv1qKtJhsepXW8/X0+zXT0zxfKLZQ4kdUuPp+F1SS+?=
 =?us-ascii?Q?prnD+ThecEld6dem0RqoKhpA02iDwzrcV1psPZEhMsTb4FfveVBgiLn8DvZG?=
 =?us-ascii?Q?oqqjLxJne9AwKDP09pFdRx3rjkZyC0yNxfW8QOsdLj3cd2smPhGNArphIjd0?=
 =?us-ascii?Q?WomEz0EwIsw0ZN3Mc2EQK3Nlv4f3oWM/STFZC76qN3BI677uQDMaiBMsTHOW?=
 =?us-ascii?Q?LQkYOPXv6RestlbJjItq8BR9jxz6XVE/EodpO42EQm/QYR5gQDtfIS5D0EhM?=
 =?us-ascii?Q?Bso1LLA1BtyXJrTiMQL7xBxF1En9uC7P/MvQVuZnMjOkMC6U6whWp97Tjhlv?=
 =?us-ascii?Q?dQpJQQMRMy+uujXjE/c+i1dIJuE7jH2RjPz+ODoI+F69n5fujLmOTWaPlScI?=
 =?us-ascii?Q?Y+ds0B1R65cpfckyLWsfjwuHOruw5XA950qdu4vK13EA2vpO2KzS+NS8k6vz?=
 =?us-ascii?Q?xmAMbptAwnH5fbyT/zjLSra51Bx0DdIrl6vtcsdcS5HhE9aaBSeU/+HqiM3J?=
 =?us-ascii?Q?QVAnaI3LetfEMRIWvbJXJOGQlFZv0XoEka7WUzDOmOtVKXc6bgR7YGM5SPaT?=
 =?us-ascii?Q?SQXvlOCytFAFFux01SuIWL7qDnim94/urWdK8X+1VtT37gMuu4kvrmmuGONc?=
 =?us-ascii?Q?qgpv9ViX7DHOs/9ksk8UUjMje9odJEmBUeVLk5xWjeGisbFlgES2FK1hysPu?=
 =?us-ascii?Q?v3a7M3EVwogXi6P6ikNIFgLVwer9llkLiaLF9b9KbZFww88QgKLYLw5bpBLb?=
 =?us-ascii?Q?OEfAnwnRyDjdwzL0XfC7gptXLUPyAoJHP/PrpLyH12eeyUB9k/PWFdlLooNc?=
 =?us-ascii?Q?ZZsZfjCXcIHYrkU8Pr07KQnThu++3npR1rS2RDSKvtu8G9KcZ+AxEfh83P6M?=
 =?us-ascii?Q?YffRst1z7tLSohVT3fN2Aqdc7oWeqnK5IMtR2lHXaXt9BY8BDe04z2/S4kQc?=
 =?us-ascii?Q?hclqfcqOlC+Gs6UVMqbxYzUcXj+ZGdHEhfve2QOsZdbzQjKpOh+DeTeTqVkD?=
 =?us-ascii?Q?ddG3sz87sVRImFVCPczGyhxM7eHZUpXDAoK5uA1GfIwQGM5r/YGsoH2T9L28?=
 =?us-ascii?Q?KgHMt/bcZp5ZCxVhLU7IheV0Ac6ND0WLIRvtEDShxxF4EQsnJ06a9I9f+9Ro?=
 =?us-ascii?Q?HMMrb9PpvI9ar4TdedhvtEQ4KqwxfYAzXBbOb4K9g07hxNvc/EI9045ifwAq?=
 =?us-ascii?Q?L09ntMXRinOhwuMt6rTXd3qqrLL7KO9sQDDn/ZifS21i18q1En5EOTiXCsEc?=
 =?us-ascii?Q?K1g5tQFsnr6lTZePM4UsF2D9cjKdyegGbm4s0C2LK+aE694iGh/cuoIJa2Ca?=
 =?us-ascii?Q?RcU5s3dXtuWZvkXI8DziA4pxzqlQtpKWXpI9dsAFEe3BLfg2eZtAj9wmQVrH?=
 =?us-ascii?Q?u4StyTwC4m6ozcClHFf0cZjxpUOik0DAm3CGs3j/rSxFXjzYlNM+ncr3D8Az?=
 =?us-ascii?Q?UmpZcdlCDFCBnYWaLmvv2KadaYZ9/9pF8HAY?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?W2LxpfFptUKe33b9sp+DTDUMwykb7Q8NVPctCsbblcuCunfErTQJLlfh1IoN?=
 =?us-ascii?Q?jnQdW7cMD8tZ1AsOBPCRU01KtOv2eVMGC9c+zhmvzRNWIMiU9Tn70PoQHsj9?=
 =?us-ascii?Q?vn2FTWfFfIxrfPZJdhf19wTL0QrEvBYgxtWMlAtJuGHsIlopC1GkDnL0tMAs?=
 =?us-ascii?Q?1AuPb3Nka9mQ1ZxahzrJp4fjCSEdGFe8Kk0B5ZFO5Ohm7UxWZU1xv6ooK7Id?=
 =?us-ascii?Q?ZDfhJAy7GhnXNlLM/L9jpqlhRwcC0IFjtzkalXijhy3c/F/gNs6tKAKYbJuK?=
 =?us-ascii?Q?saI8IMr4kIW3JTxtwHJ/sd5eRPkiz78xiDRAExn39YW71Ow+XbQjp7GQVfrP?=
 =?us-ascii?Q?4fNMU+NQ/wTCCxPHzPZKZWcB0GFJ9SDYGCng3NfM37lDSEB6iomlKwZTmaff?=
 =?us-ascii?Q?45ntLBPNKnZBbUdOBi+8HInKzpxSx5z/N8kgdfRZAjbYkXOZgJo7ZCi8t6T3?=
 =?us-ascii?Q?otux93VMf2vx+aFwabBoE8IYNX4/qSizmaQi3CYj2CjxCP1otn8QbEd0+z5E?=
 =?us-ascii?Q?Bv9rTmEQwcvAX2svRfsismB1Tg7Ewh5NKk4o9vpKzMjLnF8+GuQ6cryb168V?=
 =?us-ascii?Q?hYo9s6lO5/qr7tNMToCdFPZldTfM3ordCgHEH1u7aBglDirx9M1sUQTe2Hpq?=
 =?us-ascii?Q?paxzSvQcIgHHYD0XtPBv0mUVvn/UXV7ib+D0n4TIajnXdghpcNHuKD54JJwu?=
 =?us-ascii?Q?8nxIAyN/d8n5dvYahVMbmmstcbF/xshHxMatPFvv3jO2fw0baMPrz19i0bbm?=
 =?us-ascii?Q?9PzwHjcs2z//oKXor0plvGOop26TQ6eGpmMRFK8riff7xGBz2faBIh+cctAP?=
 =?us-ascii?Q?VTk+po+zFUY51MOSe8GyCQnJEXUWka+hmrmNE7wjRdVuBv/fUBRmjKcehJMM?=
 =?us-ascii?Q?mCqsOlIe6zr9HMi9PNMcfO0z2UAukS03ZhvI966TrE1Yb6Reo4KSvu8vYajb?=
 =?us-ascii?Q?YEqaudAxDlldaS3TMvjRO+uR1QO8fREIoaTRVa64hAUigYWnQysdSvdqLPXv?=
 =?us-ascii?Q?obe4xCbD0XvYLL7FCvOytc9QMa869oXD9S2M7jzLsF+08cQUGmVlcXFd/JEE?=
 =?us-ascii?Q?lvBvUsQD4rvxoCzdK77nn5eFOOGMIbIlYD6FmhgDzDAzEigubuM/q56HyWaK?=
 =?us-ascii?Q?CnRj8MjfMIgMPiuvo9mJbEINqrCzIWFqOmpvRevvQ4fcFYQXOLAQOGoQ29Vx?=
 =?us-ascii?Q?3ymV35srf68+rBWkLvHkuJPxpwf8S4rcQOW6AOPRMNpw7nVYW01PoHvkvgdg?=
 =?us-ascii?Q?wjMh9wogmfc47LXun0f1iyz0s32EGvSqSKsdT0AHOorDFDnaWtI1jtTedZ/q?=
 =?us-ascii?Q?r73tuY6YGdySRHxU3sIsfMK0QjNzs8P/REhSxKwitZBc4q6XOVmQ1oo8DWIs?=
 =?us-ascii?Q?JLsyCplZYmA2qgjE7mGzXc9rpXhxTTfs5ljJn1b5mCI9idjoPiPzQILWsK5t?=
 =?us-ascii?Q?MsHviPolNdfP8/xNr8fOGV/RbSZXOWZIFIjbDF6bD5ALkc4zMHiOe1efN49z?=
 =?us-ascii?Q?V5sVdR7t8WB0rexyTja1YYh8BlZ2iS8GzkAenwklkUlYms7HOjsJAI5HPK8a?=
 =?us-ascii?Q?0BeVDFcR37juKMe1LMc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f09601-2935-46dd-fc7a-08de1e1ad6e6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:29:35.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zo6ndonOLLL3jdo7z12OWA9F8UsjWl50p7FDMMhQ6slaGnPtezmvGcz8GcG9O1P407XM3fFVFEHfazjzBW1i3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10519

On Fri, Nov 07, 2025 at 03:58:09AM +0200, Laurent Pinchart wrote:
> To prepare for multi-stream support, switch from the legacy .s_stream()
> operation to the .enable_streams() and .disable_streams() operations.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 146 ++++++++++++---------
>  1 file changed, 87 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 42b1ec8eed96..f142e79acbcf 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -350,6 +350,7 @@ struct mipi_csis_device {
>  	struct {
>  		struct v4l2_subdev *sd;
>  		const struct media_pad *pad;
> +		u64 enabled_streams;
>  	} source;
>
>  	struct v4l2_mbus_config_mipi_csi2 bus;
> @@ -1019,64 +1020,6 @@ static struct mipi_csis_device *sd_to_mipi_csis_device(struct v4l2_subdev *sdev)
>  	return container_of(sdev, struct mipi_csis_device, sd);
>  }
>
> -static int mipi_csis_s_stream(struct v4l2_subdev *sd, int enable)
> -{
> -	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> -	const struct v4l2_mbus_framefmt *format;
> -	const struct csis_pix_format *csis_fmt;
> -	struct v4l2_subdev_state *state;
> -	int ret;
> -
> -	if (!enable) {
> -		v4l2_subdev_disable_streams(csis->source.sd,
> -					    csis->source.pad->index, BIT(0));
> -
> -		mipi_csis_stop_stream(csis);
> -		if (csis->debug.enable)
> -			mipi_csis_log_counters(csis, true);
> -
> -		pm_runtime_put(csis->dev);
> -
> -		return 0;
> -	}
> -
> -	state = v4l2_subdev_lock_and_get_active_state(sd);
> -
> -	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> -	csis_fmt = find_csis_format(format->code);
> -
> -	ret = mipi_csis_calculate_params(csis, csis_fmt);
> -	if (ret < 0)
> -		goto err_unlock;
> -
> -	mipi_csis_clear_counters(csis);
> -
> -	ret = pm_runtime_resume_and_get(csis->dev);
> -	if (ret < 0)
> -		goto err_unlock;
> -
> -	mipi_csis_start_stream(csis, format, csis_fmt);
> -
> -	ret = v4l2_subdev_enable_streams(csis->source.sd,
> -					 csis->source.pad->index, BIT(0));
> -	if (ret < 0)
> -		goto err_stop;
> -
> -	mipi_csis_log_counters(csis, true);
> -
> -	v4l2_subdev_unlock_state(state);
> -
> -	return 0;
> -
> -err_stop:
> -	mipi_csis_stop_stream(csis);
> -	pm_runtime_put(csis->dev);
> -err_unlock:
> -	v4l2_subdev_unlock_state(state);
> -
> -	return ret;
> -}
> -
>  static int mipi_csis_enum_mbus_code(struct v4l2_subdev *sd,
>  				    struct v4l2_subdev_state *state,
>  				    struct v4l2_subdev_mbus_code_enum *code)
> @@ -1211,6 +1154,89 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
>  	return 0;
>  }
>
> +static int mipi_csis_enable_streams(struct v4l2_subdev *sd,
> +				    struct v4l2_subdev_state *state,
> +				    u32 pad, u64 streams_mask)
> +{
> +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> +	u64 sink_streams;
> +	int ret;
> +
> +	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
> +						       CSIS_PAD_SINK,

Original code use hardcode BIT(0), I think keep the same logic with original
code in this type patch to easy review.

Add bitmask enabled_streams should be following patch.

Frank

> +						       &streams_mask);
> +	if (!sink_streams || !streams_mask)
> +		return -EINVAL;
> +
> +	/* Start the CSIS with the first stream. */
> +	if (!csis->source.enabled_streams) {
> +		const struct v4l2_mbus_framefmt *format;
> +		const struct csis_pix_format *csis_fmt;
> +
> +		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> +		csis_fmt = find_csis_format(format->code);
> +
> +		ret = mipi_csis_calculate_params(csis, csis_fmt);
> +		if (ret)
> +			return ret;
> +
> +		mipi_csis_clear_counters(csis);
> +
> +		ret = pm_runtime_resume_and_get(csis->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		mipi_csis_start_stream(csis, format, csis_fmt);
> +	}
> +
> +	ret = v4l2_subdev_enable_streams(csis->source.sd,
> +					 csis->source.pad->index, sink_streams);
> +	if (ret) {
> +		if (!csis->source.enabled_streams) {
> +			mipi_csis_stop_stream(csis);
> +			pm_runtime_put(csis->dev);
> +		}
> +
> +		return ret;
> +	}
> +
> +	mipi_csis_log_counters(csis, true);
> +
> +	csis->source.enabled_streams |= streams_mask;
> +
> +	return 0;
> +}
> +
> +static int mipi_csis_disable_streams(struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *state,
> +				     u32 pad, u64 streams_mask)
> +{
> +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> +	u64 sink_streams;
> +
> +	sink_streams = v4l2_subdev_state_xlate_streams(state, CSIS_PAD_SOURCE,
> +						       CSIS_PAD_SINK,
> +						       &streams_mask);
> +	if (!sink_streams || !streams_mask)
> +		return -EINVAL;
> +
> +	v4l2_subdev_disable_streams(csis->source.sd,
> +				    csis->source.pad->index, sink_streams);
> +`
> +	csis->source.enabled_streams &= ~streams_mask;
> +
> +	/* Stop the CSIS with the last stream. */
> +	if (!csis->source.enabled_streams) {
> +		mipi_csis_stop_stream(csis);
> +		pm_runtime_put(csis->dev);
> +
> +		if (csis->debug.enable)
> +			mipi_csis_log_counters(csis, true);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mipi_csis_init_state(struct v4l2_subdev *sd,
>  				struct v4l2_subdev_state *state)
>  {
> @@ -1263,7 +1289,7 @@ static const struct v4l2_subdev_core_ops mipi_csis_core_ops = {
>  };
>
>  static const struct v4l2_subdev_video_ops mipi_csis_video_ops = {
> -	.s_stream	= mipi_csis_s_stream,
> +	.s_stream		= v4l2_subdev_s_stream_helper,
>  };
>
>  static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
> @@ -1271,6 +1297,8 @@ static const struct v4l2_subdev_pad_ops mipi_csis_pad_ops = {
>  	.get_fmt		= v4l2_subdev_get_fmt,
>  	.set_fmt		= mipi_csis_set_fmt,
>  	.get_frame_desc		= mipi_csis_get_frame_desc,
> +	.enable_streams		= mipi_csis_enable_streams,
> +	.disable_streams	= mipi_csis_disable_streams,
>  };
>
>  static const struct v4l2_subdev_ops mipi_csis_subdev_ops = {
> --
> Regards,
>
> Laurent Pinchart
>
