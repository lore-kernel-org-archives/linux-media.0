Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883B267B9B
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532103; cv=fail; b=i2LoobG6PLhmdVWBMctTeKCYYlbIwfdIekirl9F8+hVJsRtIOSLNyTGCggU1ULAaYdDIMEzWk1bkckGLXa5KsK7U0rAWJyFC/8JYGWEODw96O415IWTBn03DJICTVLgNXYYxzkP9RKenYmDu3Z9g0UcXQbnfDkX+ZS+1kYYRTcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532103; c=relaxed/simple;
	bh=gcUbQ+pvxpXjoWX0KNowZDF6FXG/KfZHZ0TmX8n82No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nAK9+0Z8406N+/FxECLcoFvTiS1Pv5B8yHv2/Zkai27bRZxzgpyg8WbinwU/9SA2YIyQmjxUhHyKjNSwsktL65SJ4VJjPic09G6JM/VdzkPqJ5ot6NH/n0th1eWVd27TBGtPz2ABJoG6wTYs+btS6xJb2jy5OoYIY8tWoT/rxmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kzQQT4Nl; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kzQQT4Nl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHAp2fAKMInWeu9VtNk00G2GoL4dP4ow5M02hV2LKFd14eTX2Wd6PGCtZo3y+GTKxQ/SGjISVXcloToz+92CdmmMMDZnsSSiEgOE2/JsyoJdFOkXf2XurKeBTbFIYRRqn2qrNAb2LiKkeCIP+QK2tBKKP67sDT00IzMn/pLQzp8BoKlQmvWCldSHHP2fy5fby+LFaNONHNSOjKaahhiOf3SwzB0umv96bfc/+Rhe6p6KP2CEAozIu9XUbknbtVa6Xia4JzfhIelFkLwQrQbYVkfX5IZgU4QIlSslMy+fG24mfYhr4fkD31SYURAKhH4d+mxShuGZ5XWGIAB5a67hqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK0Vi11kuAEf7covuZCNZtysVklQL9EdlnlCgRDHtUg=;
 b=n3cR8Clx3K+b3EIrexNzn/s0KYnpyhncI/ZKWiM0J5PPJK771EnM1ncRcp4bIBhiRK6/gIjyPMOJXAZukOXUCwV02qhS7Ny1/nm0eWy0Po3EqyDg+1oOpAtJmU6iZ7JvC+w/iGyJW6j4bPbfwyLK7XiaZ0YVS5eHnXDs/C4aAgLndg59uOC8c5w7i6w1QFz3yC54h9+7bLtMHXLQo4WU/KMmTBwUQlT1c+a5P/YYfR6R8OuDobudO2N6GYYiObrONuDDLcgPjhAQBo+YUUdSRRv64ZfDP6df9R+4b/9pydRwJdlpRiW7MZKTGFMWRBypjI/ig+O491iGSDbJi56FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK0Vi11kuAEf7covuZCNZtysVklQL9EdlnlCgRDHtUg=;
 b=kzQQT4NlcxKeVjnyM+3R5t5lAyT9keTtrrczqzapOsQ8JfwVdzSPjx/mAseKjAVOMD6dqxPwN/UfQpktdITBrGSNkl/xeG2zIbQ9+TIxCKL+eesO4Thgm8zGJw8Gfu2yaj86JpvPq6P7lfaLb2/s7JqmUizxtrzFCgrMh00aKFx56qgVvI866I6RCX5+xtDwVo0oNaMhhHMQky1du2nd/4TJ90YVMMCeyClhMsJCgjFnylwYbE8DbwLRry2SNWmxFwy3SDcWISP3llT3WKPtgWfe+M40hBI2VtgxP84uf99ptbZfMmv05sjELiNEqRrx7CEHdRalJONouVvAubwLYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DUZPR04MB9965.eurprd04.prod.outlook.com (2603:10a6:10:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:14:58 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:14:58 +0000
Date: Fri, 7 Nov 2025 11:14:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] media: imx-csi: use media_pad_is_streaming helper
Message-ID: <aQ4a+h8ufowiT+SD@lizhi-Precision-Tower-5810>
References: <20251107-media-imx-cleanup-v1-0-f82a693c28f4@pengutronix.de>
 <20251107-media-imx-cleanup-v1-3-f82a693c28f4@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-media-imx-cleanup-v1-3-f82a693c28f4@pengutronix.de>
X-ClientProxiedBy: BYAPR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:74::36) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DUZPR04MB9965:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edbb3db-427c-4936-d6e6-08de1e18cbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeuBhAaOt/jG4JNXZUuv8AihVAiwN3Zmnj7VqBL97Mp3Y7DnuooRsUyE+L2y?=
 =?us-ascii?Q?tRbBfg20VtZV6K71aE8ACrLJOXsYDU70Zlpu1m8srIJKU5R96mKbUteePAK9?=
 =?us-ascii?Q?10yYFQRXwuWE7vIpQOAEeHTHYbIw/ant+shhqEDgDWzF/myHVuiZy+o2723M?=
 =?us-ascii?Q?5jK+Gs+l2B1Yi/8cDHrJD147IJ5ukL6MRN8ugC5gFBe6+dReu+NvlfZ53Nq8?=
 =?us-ascii?Q?s/cKKaFlT0nBgInkBLQG2zXEbSSM5tBOHytFVrcvKwJJG9q6Q2WUtwWQQuCw?=
 =?us-ascii?Q?tx0pWJ9OfQhhppg1jOqthcWz+dF8rfD8biNXjzOTi4l52FXB+I2Gac6GDCI5?=
 =?us-ascii?Q?kJ45M5X0vCGjw0XdlHt8AA+9Nh7FHnoenSnetdqPfARzsUuZqdYV1yGyf0oU?=
 =?us-ascii?Q?ntAmhQVnvq1Me3NxO5D11xMajUg57Tt4BxpYUQGVqi7NKvO8DsWiBFjhEg57?=
 =?us-ascii?Q?fcuAyWpUEcbzT1sL6TnFzIhEXlw0Dn1AXv76jC3JsW8JO0v6ao3+hyz9Ag0d?=
 =?us-ascii?Q?UqSG5I2zFkhu+PF9nSONP4+sEo0sLEEzjx/H4ZrwNEd4c20J3uA3B6gpAV/R?=
 =?us-ascii?Q?OMTlign2zcLXl69AUchjm9t+K9v0u5jq8FCGtxACOx8ktA4Avabs0/OtWTGb?=
 =?us-ascii?Q?27shypUeLOFOQrV/wn9mMjacHmf/9X+mKKIaBYGVNX52D94r0uBDUjLMINsf?=
 =?us-ascii?Q?lPVFqFqPUOmXTvAsL1QIRrVkSMK+/wL4TEvuYaXSY5SMTlccNoqHHF632lsb?=
 =?us-ascii?Q?CKC3LEhQjKUWrxnIbaTH97FGZgVWTfQ6YHrKXzgGW8ompQwnWEMNP1X2DQfi?=
 =?us-ascii?Q?1Xvl6Aova5KHIrIwC8TcWnNu1mZ+m19c5g/gte0vgVBS5uabIsLfqT0vC7K1?=
 =?us-ascii?Q?eOOCpVe+ZgtwP5YGYHESTKRjW3JcQ0fZEnC2wwvxZKFKAXCppG2tFi+xcGT7?=
 =?us-ascii?Q?7dPMmyFXZaxbioXpzW7Y1Yitq3UxPO5HVp+vftAFS9dH7V5TOOUvgYMh8KdW?=
 =?us-ascii?Q?9BPZKkLkBB5IHHb/G6jU/d7yW/QlAFykPCO5BRPQZd9VgZIlQ2WKadKk9/zx?=
 =?us-ascii?Q?ivxuPxAwUvfcQ8CRZuCoD5a5dnf3TFNrFJjrZ81j3LysOTd6NLI/QU4pxJnP?=
 =?us-ascii?Q?DPYEUm1u5CtCPAl5wvf1Xys4g93vnxTzsftMKhVTNb7cLUI9yTLlj3pj892Q?=
 =?us-ascii?Q?9oL+31BMafCpQGz7e5QgPtDwscgJcc9DamyjFM725gJBpP6xzflp6REsipZa?=
 =?us-ascii?Q?uc+IriVc81ewescQcGoEPYPRfgS7B+ZwKL13Dkl+/O30N1MHAnRyzdPfs2TJ?=
 =?us-ascii?Q?87CvY1ysJ3ACKfVVtyfrQKbfNW4M+9e99fIfHi6TO43VLorjyOt24kbtpJYl?=
 =?us-ascii?Q?v0Wjq0Mh5YGqjQRi0n/433uY4ek10s1ftEUKOCvODw3tOgpbUs0clSD43UFm?=
 =?us-ascii?Q?ffUrMbHUlQYmSIa/tXJooMdjseNK+w/wEpq0N356XXCW+B0HHYvMCy0Z1/IB?=
 =?us-ascii?Q?HnrYB4GrErXUJLfEAiZQ26/IkhG/LnuAiu+W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wpdMEmD0OAHDiKAZVAotMaNpVATesElOvrgA9IKf3bALpfVUMKbGqJlX2Ulg?=
 =?us-ascii?Q?degsLa+uiSCR3s4gzpQw8eKKmXiHNTnOiF/+RY0X15f8TlaVYYqEXa/LOFs7?=
 =?us-ascii?Q?IRwasvtGRRPejybhjSa42rpdhcPj0d5z2SyIeZOV5TspmqSOFjwHW9gx+hBg?=
 =?us-ascii?Q?B9Lt7GJ/mgHsxbLLZfPPyMZc2nAv2Q2coapljLtNZQRbkZCUboTLWOOE4zCD?=
 =?us-ascii?Q?2us2emFCXHNWUlptMustfCesC/EmzpxNaEkKC3d8nzUW5j9gsZPEFRwT0sx2?=
 =?us-ascii?Q?uEfs1ReSnCCn08KiFR8QcxW9m7n+ltVDM6OrV7YwbvyhvtzzTtvzvh4aB1o/?=
 =?us-ascii?Q?BpHz1Fo8/NAQWIomeYXz2LOJoiVU4ON4QQBoGlD7ch8Qj1yEwhttcdSRctjG?=
 =?us-ascii?Q?m8vsTFvlo52dVXb3tjmMJN1fxugTnoXj4ybpWUhd9lvZpNoWVS2Rql4jWNJF?=
 =?us-ascii?Q?52VrQosZ+wUoHN+Udbopgl4uoyIhv0T9EPb3ps7BAPtluVishkEUGlvso1yT?=
 =?us-ascii?Q?bVBxYryKHz/asx2CIAst3Ed0xDUpWSFa+Rfdsqjt5aLxvebcUfIkpzE88T1H?=
 =?us-ascii?Q?waO9Br/vGJZksiPTzCzXmqvLYBGL9QMaavd5xCWNOekat6Xz2CU2v13QJlHh?=
 =?us-ascii?Q?Ln2sPZlHFD2fqzOjlCggqyVXTuxKo08C7pnGz7FZ0JjWOrbLqfEx8hPlnHdh?=
 =?us-ascii?Q?vgRubwBntaWkVgVN8jLxJw01x+eI/y57VMKCb8M5srN55EXknFQLaNgfeP/2?=
 =?us-ascii?Q?OARP5QCa+CcmKLT+2Qk7PDpIs8KYYH86wd/HJBed+BaFqaN7b/rro2ryE0xa?=
 =?us-ascii?Q?JO2IpDsDIVeze7CCBpXE/I6LSHqjLdyn3smRzEgmiaNIA4Vrsox1YgUp58Xm?=
 =?us-ascii?Q?vhBcTAsNPJhwvgDqMMOAAPjDF1Vpj8eZG2Jj/rKVNAZFdXopLBH7neth9nbj?=
 =?us-ascii?Q?0PNnksl0VGF6MXrmp/LpoeGQftR2vUzArNB6HP1d/M3sGLNGitki9U7bCHvA?=
 =?us-ascii?Q?Pg1Gum30KNgMPLTtqOc+8YReFy5VG3xg0Q4bQuyteAchdf66eI8AJc4SR5zI?=
 =?us-ascii?Q?JzCbQcct2lcBWoPKFy0uypY5kKQH0TjU7dMRaEqRJI+mnnn/L3zJKSWkWeIc?=
 =?us-ascii?Q?2ElJCcOFqxBKeFNmGiOF7r/TdxwvXa90iyxKA4WrSRYuXGL2CjcpXMx2pWgv?=
 =?us-ascii?Q?uwk8GEWD48UZIzqyGlo7rx6nqTYYlVyaz4m25ff9+M3zFuVQyX1YVrw6yJwv?=
 =?us-ascii?Q?btlUHek/2rTU6co+uY2qtQwWhK3yIUplxoWTUL+3nmwhKV0vktjZk271VF7a?=
 =?us-ascii?Q?v43G3B1CxjvpxX/CvVmG1IIGt1ExheSM6DgoFmP/9QCs9BcJdUB2XrV9f0Mp?=
 =?us-ascii?Q?AvD3SRocF8/qAPIseS2DnAEi+fCzBaVFGDJacH1585KK5Cp1UlFwFYD9K45e?=
 =?us-ascii?Q?NEx7Jd/B/fHPgydirg+/N11IdxGp4IJ3UfLzyO73VFSu/oo5geUsjP0u5mWM?=
 =?us-ascii?Q?fRn4taxAjt7UVGn6pXj0yspiYiCb0OEvQ0t9LXKiyDbw1YfyPYdd+NjMAIVp?=
 =?us-ascii?Q?dhzlx/iu/u9h9XDzNQcZCLKNIWuypjBRHl7yipFz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edbb3db-427c-4936-d6e6-08de1e18cbb0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:14:57.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LD4xPoNlanDU+m6scV87vHybyV/TFBYvp047AskTj9vt7FyKsT6reiSKUDCDZjn1Oc56NdGOlh9cLuEEu5b8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9965

On Fri, Nov 07, 2025 at 11:16:35AM +0100, Michael Tretter wrote:
> The media_pad_is_streaming helper is explicitly for checking, if a pad
> has been started with media_pipeline_start. Use it instead of relying on
> the implicit knowledge, that a pad that has a pipeline is streaming.

Suggested commit message:

The media_pad_is_streaming() helper is explicitly intended to check
whether a pad has been started with media_pipeline_start(). Use it
instead of relying on the implicit assumption that a pad with a
pipeline is streaming.

Frank

>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/staging/media/imx/imx-media-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
> index 6d69f69c16c1..4ea9b3fc59d0 100644
> --- a/drivers/staging/media/imx/imx-media-utils.c
> +++ b/drivers/staging/media/imx/imx-media-utils.c
> @@ -774,7 +774,7 @@ int imx_media_pipeline_set_stream(struct imx_media_dev *imxmd,
>  			__media_pipeline_stop(pad);
>  	} else {
>  		v4l2_subdev_call(sd, video, s_stream, 0);
> -		if (media_pad_pipeline(pad))
> +		if (media_pad_is_streaming(pad))
>  			__media_pipeline_stop(pad);
>  	}
>
>
> --
> 2.47.3
>
