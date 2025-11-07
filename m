Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D879224AEF
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534094; cv=fail; b=fCnuOABxqcY2wb56q0/hG6lX4p84s/c2+a9i28J1I0Anvkyhj2tiLwUCI6w35q0ki/GJARRWK6uOfQFxZa6/Rskxr/F88B6NJ5eJ97J5SffAooXYQs/iyK+N8YoxP6sOKinB1sTU2/WDTEwGSXC9ey2vSB6uZmJqlLSQg4qTOrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534094; c=relaxed/simple;
	bh=DHP0kuSTGhyq4IKe54q3r/L0L5MIMuaKbqSWhZJ9qWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZT3S2333jmJt6ya8pzphqy5Bf1w8sB/R9hyGjV6qecRS09VDZGqQ7H+nFlUO68pgIJwh/FA4PnFXhRitEoko6SY/tGbdxuF5bIAovv/sRa9ZdIcoF65XBeVQ0MINWlSuAFve3B0fPXxvuoLgoIzxxI3Gi5h28LFBx+alhQvPOmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B1bkHOBN; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1bkHOBN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDHJTdME3lXqLS4xFOkGTaXlmP68f4Bug0A5Zn8B+7AIHYZbpClo/sjqkefzw9Q/qY5lF7xCYHYVRKfDH5ni+lzbNj7qdZQAHN7Yb2hx90HbFiZRG+gvbL8vF96Use0Kg0sJzBURQ02Pp6z8I2on9A0EPkTYvrKvBnbtspCiRdy3Mggtvrdxfj26lP1djO6FFo1PkrveW2qJGGKa0P6W0AgKm8DN4Nr55N5EC70YCgLXg688hVDmvzduu6X6TZBGww+b85fhYtmm+NGp6j3iQMjlg8jywRN++i5Fv348qOSrsgjCwk+0hNrOShiOHDTS+CWQkFf9epJx/vbI2JGEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPkFx1U4uD3GH7t6AXoyzZh75P4ab+TN8Xb9cDpd8Nw=;
 b=e6kp74vOhEbrIfqNXKxs3Fo0rwW96igy4ktKKmxruPd979DidfqozVfx5IVbxqRqULaCTGKXWHrmoUou8zdSv9Qq0rjRk82b5qm+15s02zP1yCOWO7Y60PJZoy83nodEBFBQXvDurMCrnxqB/8L5ybBIhw5qG/p0eiSzoh5K5h4wxwUzryJCGjESwmic+ckES1oIizP4UX3Wc/63C+h3nsLAtIcTOQAzdsS9Hb2PnNZHt5sbQ7uTqsZ9mq7+D9VAmT43Ai3pvdwc97OogZB8FnQ08HVOuv/GemIGMtLzb34o5P6xX5TdAcmSJeHjyiP2HZD2Ocjvoko8oMxQ9NEBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPkFx1U4uD3GH7t6AXoyzZh75P4ab+TN8Xb9cDpd8Nw=;
 b=B1bkHOBNnlL6St3lv6mf6oNyCNUVq2JURXdr/iW0zrDoE5Mg/Q/WfCGrmjO45RyFV5HOCx/ZVLREBCR18noC27M72dT2UkZpWRdTAcETY6ER8j4iEptyhHGe/E43lCmX1iYB/xMNwqrSk14bnL5mVBnqTx2zA5nIFK50GxAdCqIkhs4+e+DI2bAc/CzTQMkXLir2c+GOKKLr75oSDfRU//AMcQ/tYQuYsXCd2UMexQPsCm9xFUgQTPa4Tj/vVO48Ai0KSQWjNR2BidXpV+M7qBwJb5ZyaMPe143Kt33SKutrv0dGrF0THlPOcHGp230szoJAv1PsCOGapZvZSFH5yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB10388.eurprd04.prod.outlook.com (2603:10a6:10:568::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 16:48:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:48:08 +0000
Date: Fri, 7 Nov 2025 11:48:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	guoniu.zhou@nxp.com
Cc: linux-media@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev, Stefan Klug <stefan.klug@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v1 6/6] media: imx-mipi-csis: Add multi-channel support
Message-ID: <aQ4iwFHVoweNl/mS@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-7-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107015813.5834-7-laurent.pinchart@ideasonboard.com>
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB10388:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cea6d9c-9d1f-4c69-ebcf-08de1e1d6dfe
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Me93YoPMh+x1S4/D1f/G9kLEO3Ps4NfGXJUlT93PoyrEQ1u5nJCdXPadOKO7?=
 =?us-ascii?Q?/Mfz5YpdXAedK66XxlcJG1xSyo+C/WCWrv/XdXB3BSe7Qz5ZQgaLa/3if5o+?=
 =?us-ascii?Q?h//AWUu0SsM9hQQ2r5k0PpXKkRV4YAhPCFrkr0nwoi1dQV3Okd03Ec3IZlqo?=
 =?us-ascii?Q?fLY3QtKhCzEzSIYrYWIAqzmxE+3bzIJ6uyaWT+dVNj+km1FNACjECyq8jlk3?=
 =?us-ascii?Q?kNQ5mkb8oLFyxJ6oVJBZBl4P3C4Y4EnCz75fEMH6VHFYSimhWmE5fh3ZvaR+?=
 =?us-ascii?Q?nqyx9VLwtydwt6XceIARupBq9X3WEgMah8ZMC1nc8lYI4smIBs+dEHR01cdu?=
 =?us-ascii?Q?8E2XrdJNb1/lMmK6WG+dAYT529iIEH3zD8Vlih5csXaiJ3Ce5oOSs9HEjqTb?=
 =?us-ascii?Q?flJ5LoBdNPXVS64MhOqsRiNAuCdC6XvRmvS1WOmdUWuGoUuQ/dmXQwnKcZs0?=
 =?us-ascii?Q?echqTn7S/fXIQYTpHF6e+afIhfu50ZKcbBpRvl6uH5fQ4raRrgc1nCLlZ4j5?=
 =?us-ascii?Q?pijgcGWQoHvhuA7SSsb7zBKafHbst+NjuduDjubOtKsjhnZXfHdZKcIJLlZ2?=
 =?us-ascii?Q?IgpBQI9vkfxkXjxOqhUsSnpQ6QWMRz1wtakcTJvprhkgW96sKBzdOG0bbA7H?=
 =?us-ascii?Q?aekjbYOkn4qblFCHs4a58yO4sD/u6bl0LOjaa9sOpZvFLJfzz3tR9j9GLTnS?=
 =?us-ascii?Q?nBbaNGOfviPHmjqSw4lQII1ohHfejpvTZ9KCirC0BRNU6z4ovr1nA/vLlVUx?=
 =?us-ascii?Q?Z7PyQ5joPJ9YJSOKom10H6094IeReCXTMWX8kEj0d5vAWKXGRVIjFdgU4MbB?=
 =?us-ascii?Q?keyLOC+a2BB0BeLCRPgQtZYidPu265xodUnE8T1dfOYomHN9PL9c5AlVHRw0?=
 =?us-ascii?Q?J/Dn+3ofNOyexp7ppA4+MPhTg/iSeUJDw+dgGXa8Nr1gzLaZp+woQFSiGsd6?=
 =?us-ascii?Q?Bz+DPlATTM5iqh2S9hSQmsDnNtDeib64+YDKquIayhLXKsvFNbNxEyS5hu/4?=
 =?us-ascii?Q?79HAMtJnW0C+2wxS04HsrOwpbMUrz4rsojrF3lDCcLRDUAZJ1lPBmnQFmurl?=
 =?us-ascii?Q?++fwlu6VCVImYtD4Sh11XuZh+o3htl7pi5LNtnWfV6U3qIgDYp52AmEjppZ8?=
 =?us-ascii?Q?pFoPqq5h+Jt3mmCzPhO/040xJALjP4NIO/JhfvEeJ48HLyHV6t2yXzCAaEsi?=
 =?us-ascii?Q?pM6TbgAOGUNjF+BlQ7L1uocmC/WpwQISiaVeF0ZvCeAeuvUk7JBJLTyyoonN?=
 =?us-ascii?Q?YyndqaeLV3HYhC6Dr503GSYg1zSkQJnzmELWfjxV/z/MiKggbcjJwvU7gVpM?=
 =?us-ascii?Q?sAZYbVwi+uheU+Gu343HvL1DKqvJ3SSjVNrMk0YYIYC8zdxQSXFAwoDbxCzZ?=
 =?us-ascii?Q?NP4IYTLW80xuLIBWCXth4DgjJ6vPUq23WQ/quGpTCy55dyHE0jzzGA196qqn?=
 =?us-ascii?Q?MARL9vprgEZzs1eA0vTHzlmE/AQ0c5QerR9L0Fy2/NddTH2kW49UzeuuY6MB?=
 =?us-ascii?Q?szyBYKqGB3n8eP7VcuxHLmqw8lNpyiuNO/rD?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?eW4gTLyuRsfx1+xeVklhrA6WJIZFrvM81JcCdeAU7k/Ju5rc1g0rC1KGL5yy?=
 =?us-ascii?Q?egvyAi1b4Za3g/nSRGP9GegcaSPTv3cj5YlT6UtyJDHhoaWHZSxU6dbu8PAZ?=
 =?us-ascii?Q?4u7wClBHy4GYWO4OJKgvvrKKnrbVWrc7aLKArKIDglf9MUSi4HisFsP9bxX9?=
 =?us-ascii?Q?V6Izmk5bzV5ttdVVY3/GSJWILrJ1yWoPNfeZ0Jzl47+Vpcab3dgehBUT7dB+?=
 =?us-ascii?Q?pihHDB4VDyu78XXpWTDUEDDlizCpne6fmCDLuuDIN4b5UYYrxVDJXWrA7xy3?=
 =?us-ascii?Q?FmuhPXlnivwaRQDG8c09TQDMtEmVU/4wA0cWJ38khstzBlBGoZ3I+RBE68CR?=
 =?us-ascii?Q?FyA7MGp8opqXrv5z+eoK4C3RREdlOUzwpnZXaJNXC0GQAcDP9Jn8u2cc3Lql?=
 =?us-ascii?Q?/lXdYYS/h4QnjEp/nX//MnEEv7AmeyD4shwc9yG66tCUniPL70ogZWkqkSk+?=
 =?us-ascii?Q?JVI7oMVlZV7YHY3taq2O1VeJo48AZew4nvcoX0yUC9mBseHEFyGn3nyDQINw?=
 =?us-ascii?Q?2qM595ONgUPozD05HGZ9+GaBJaPUDDXeCyBkOXQ1IxKFfhj6/RhpVsbxbLk4?=
 =?us-ascii?Q?JDs5GAK/5wqL0JL6ASPFtIAXLlHpKUEaWv5TA8ZnEwz+J8QseMkMRfKateNp?=
 =?us-ascii?Q?IzdbZmHYlYu2+HsG9ZRC3gX0T41T7icdoYfihZ6szU/Fhn6sNa+U1xHhVwoS?=
 =?us-ascii?Q?vVRFmv2rYdcuIHBZwYVUJ5ywEPJyyhnUv03GUPMFM4ouXRg24uXgs7uXwZGj?=
 =?us-ascii?Q?xvZQu+DJTpnFD4hAss5nf4NLy+H8JvyPmWXHxZYQ/qHoEKL/LQMnXecKfLiU?=
 =?us-ascii?Q?8L6Q4PviAaT3CSYtU/iQdPaBTOh9erM7pI5XBqBXDRhc4uqILagGCR9QvSyw?=
 =?us-ascii?Q?gpbmITLR/e7KLpduu0N8/WiQ6e54jstkd/7v4SYqLAFd43YlCMe2HDeXWb4+?=
 =?us-ascii?Q?mOa0VC7j+8T2Ow8J73sX90FA8U2C8wLTsVIQlAadx0nKN9jWfqMGIXA/cbxP?=
 =?us-ascii?Q?kmobJ/cwo55ux91sehHEWb2izvJX/lCC7X/7QhS0rHGoKevttrMJqsndLLKy?=
 =?us-ascii?Q?a4i3E1FMDQWmBGB3EidbYVm1X/mXlz9x3nw7EYQH5vXrm35hVIyfZGbM/hFJ?=
 =?us-ascii?Q?dgBFLmtAgS/eOYbOIBS88XxDL2oMm2pOqJxaasQJhMLxxukHK9WUY6r3DFrR?=
 =?us-ascii?Q?wTT21btauz3XwAwapsh2zzjBmDraVDBUjiaf6lfSfGVTlognT1+itcaOPGOx?=
 =?us-ascii?Q?ihNXXcG3QQ/cv1mecJpHqr24UwgK5XVGiRL2QuDiaIQ9Yn74d8lDPd3dx0MF?=
 =?us-ascii?Q?IoEIv3S5qHroGqWfIqWJ+uoZ07WM3hGMK7iH3jMSI0fuK4DnLYQ2B5Jds3NW?=
 =?us-ascii?Q?NjUNdC2HmOnyQgikJ6g3oYhua+2H9Q6KUAwsnrlCejpqu6DBI0jKDIUkREV5?=
 =?us-ascii?Q?uTegb2KlhqAHmeF7ojicW+UrPrPSlSJYci3vvB1Urb79Mitg+0sJscRhIHSz?=
 =?us-ascii?Q?9TmSxKcDqtZ9BLwkhifEFPK+gCYOvciAHxEvkZQglHhaEK2GF1tsKgCHt0T9?=
 =?us-ascii?Q?uYvCxLYJKVaUOEzbZCQ45xeL3e2jkLaGQzfhuiRq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cea6d9c-9d1f-4c69-ebcf-08de1e1d6dfe
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:48:08.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDXRzPJFjsWJ8HNyYXlpbLLZXx4EpV2eCKJkgXqqM+I/VjrOtnzUJ8HewVh2N+DhbJYDjSG/MylfKai485by2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10388

On Fri, Nov 07, 2025 at 03:58:13AM +0200, Laurent Pinchart wrote:
> CSIS output channels can be used to demultiplex CSI-2 virtual channels,
> and likely data types. While this feature is not clearly documented,
> tests seem to indicate that each output channel includes filters to
> select which VC and DT to output, with the filtering mode being
> configured globally. Four modes are supported:
>
> - No filtering: all VCs and DTs are output on channel 0
> - VC filtering: each channel filters out all but the configured VC, the
>   DT is ignored
> - DT filtering: each channel filters out all but the configured DT, the
>   VC is ignored
> - DT and VC filtering: each channel filters out all but the configured
>   VC and DT
>
> Expose this feature to userspace through the streams API. The routing
> table is expanded to support multiple routes, with the source stream ID
> mapping to the output channel number. As the VC and DT values
> corresponding to a stream are not known until they get queried from the
> source, validation of the routes is postponed to stream enable time in
> the mipi_csis_calculate_params() function that extract the configuration
> of each output channel from the routing table. The validation ensures
> that, when filtering is enabled, each output channel is configured to
> output exactly one VC and one DT.
>
> When multiple streams are routed to the same output channel, the output
> heights is the sum of the heights of all the streams. This is
> implemented when propagating formats frim sink to source pads.
>
> Due to how the SoC glues together IP cores, multi-output operation in
> the i.MX8MP is used only for the purpose of capturing multi-exposure or
> multi-gain HDR streams from a camera sensor over different CSI-2 VCs and
> transmitting them to the ISP. The streams are stitched together by the
> ISP and can't be captured individually. This has allowed testing VC
> filtering but not DT filtering. For that reason, multi-channel support
> is currently limited to VC filtering only.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add guoniu.zhou@nxp.com, patch itself look good, but I am not famillar with
internal logic, Guoniu, can you help check it?

Frank

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 264 ++++++++++++++++++---
>  1 file changed, 234 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index d8c11223ed0a..b5c7ab7c541c 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -12,6 +12,7 @@
>   *
>   */
>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -334,7 +335,8 @@ struct mipi_csis_info {
>  };
>
>  struct mipi_csis_channel_params {
> -	unsigned int data_type;
> +	u16 vc_mask;
> +	u16 data_type;
>  	unsigned int width;
>  	unsigned int height;
>  };
> @@ -343,6 +345,7 @@ struct mipi_csis_params {
>  	u32 hs_settle;
>  	u32 clk_settle;
>
> +	bool interleave_vc;
>  	struct mipi_csis_channel_params channels[MIPI_CSIS_MAX_CHANNELS];
>  };
>
> @@ -626,7 +629,7 @@ static void mipi_csis_set_channel_params(struct mipi_csis_device *csis,
>  		val |= MIPI_CSIS_ISPCFG_PIXEL_MODE_DUAL;
>
>  	val |= MIPI_CSIS_ISPCFG_DATAFORMAT(params->data_type);
> -	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(0);
> +	val |= MIPI_CSIS_ISPCFG_VIRTUAL_CHANNEL(ffs(params->vc_mask) - 1);
>
>  	mipi_csis_write(csis, MIPI_CSIS_ISP_CONFIG_CH(channel), val);
>
> @@ -645,20 +648,148 @@ static int mipi_csis_calculate_params(struct mipi_csis_device *csis,
>  				      const struct v4l2_subdev_state *state,
>  				      struct mipi_csis_params *params)
>  {
> -	const struct v4l2_mbus_framefmt *format;
> -	const struct csis_pix_format *csis_fmt;
> +	const struct csis_pix_format *csis_fmt = NULL;
> +	struct v4l2_subdev_route *route;
> +	struct v4l2_mbus_frame_desc fd;
>  	s64 link_freq;
>  	u32 lane_rate;
> +	int ret;
>
> -	format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK);
> -	csis_fmt = find_csis_format(format->code);
> +	memset(params, 0, sizeof(*params));
>
> -	params->channels[0].data_type = csis_fmt->data_type;
> -	params->channels[0].width = format->width;
> -	params->channels[0].height = format->height;
> +	/*
> +	 * Translate routing configuration to output channels parameters.
> +	 *
> +	 * The CSIS VC and DT handling is poorly documented. The device supports
> +	 * a global "interleave mode" parameter in the CMN_CTRL register that
> +	 * can be set to "VC and DT", "VC only", "DT only" or "CH0 only, no data
> +	 * interleave". The ISP_CONFIG registers specify DT and VC values per
> +	 * output channel.
> +	 *
> +	 * This can be interpreted as per-channel VC and DT filters, with the
> +	 * filter type being configured globally and the VC and DT configured
> +	 * per-channel. VC tests seem to corroborate this interpretation, but DT
> +	 * tests are yet to be performed.
> +	 */
> +	ret = v4l2_subdev_call(csis->source.sd, pad, get_frame_desc,
> +			       csis->source.pad->index, &fd);
> +	if (ret && ret != -ENOIOCTLCMD) {
> +		dev_err(csis->dev, "Failed to get source frame descriptors: %d\n", ret);
> +		return ret;
> +	}
>
> -	/* Calculate the line rate from the pixel rate. */
> -	link_freq = v4l2_get_link_freq(csis->source.pad, csis_fmt->width,
> +	if (ret == -ENOIOCTLCMD) {
> +		const struct v4l2_mbus_framefmt *format;
> +
> +		/*
> +		 * The source doesn't report frame descriptors. Assume a single
> +		 * stream on VC0.
> +		 */
> +		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK, 0);
> +		if (!format)
> +			return -EPIPE;
> +
> +		csis_fmt = find_csis_format(format->code);
> +
> +		fd.type = V4L2_MBUS_FRAME_DESC_TYPE_CSI2;
> +		fd.num_entries = 1;
> +		fd.entry[0].pixelcode = format->code;
> +		fd.entry[0].bus.csi2.dt = csis_fmt->data_type;
> +	}
> +
> +	/*
> +	 * Translate sink streams to source streams and fill the channel
> +	 * configuration vc_mask and data_type fields.
> +	 */
> +	for_each_active_route(&state->routing, route) {
> +		struct mipi_csis_channel_params *channel =
> +			&params->channels[route->source_stream];
> +		const struct v4l2_mbus_frame_desc_entry *entry = NULL;
> +
> +		/*
> +		 * Find the corresponding frame descriptor entry, to get the VC
> +		 * and DT for the stream. Multiple entries may match the stream,
> +		 * but they have to all report the same VC and DT, so we can
> +		 * just use the first matching entry.
> +		 */
> +		for (unsigned int i = 0; i < fd.num_entries; ++i) {
> +			if (fd.entry[i].stream == route->sink_stream) {
> +				entry = &fd.entry[i];
> +				break;
> +			}
> +		}
> +
> +		if (!entry) {
> +			dev_dbg(csis->dev, "No frame descriptor for stream %u\n",
> +				route->sink_stream);
> +			return -EPIPE;
> +		}
> +
> +		/*
> +		 * Routing constraint: all streams routed to the same output
> +		 * channel need to have the same DT.
> +		 */
> +		if (channel->data_type &&
> +		    channel->data_type != entry->bus.csi2.dt) {
> +			dev_dbg(csis->dev,
> +				"DT mismatch on channel %u: stream %u DT 0x%02x != 0x%02x\n",
> +				route->source_stream, route->sink_stream,
> +				entry->bus.csi2.dt, channel->data_type);
> +			return -EPIPE;
> +		}
> +
> +		/* Record the VC and DT for the output channel. */
> +		channel->vc_mask |= BIT(entry->bus.csi2.vc);
> +		channel->data_type = entry->bus.csi2.dt;
> +
> +		/*
> +		 * If any output channel beside channel 0 is enabled, enable VC
> +		 * interleave mode.
> +		 */
> +		if (route->source_stream > 0)
> +			params->interleave_vc = true;
> +	}
> +
> +	/*
> +	 * Iterate over the enabled output channels to record the width and
> +	 * height. Verify that the VC filtering matches the hardware
> +	 * constraints.
> +	 */
> +	for (unsigned int i = 0; i < csis->num_channels; ++i) {
> +		struct mipi_csis_channel_params *channel = &params->channels[i];
> +		const struct v4l2_mbus_framefmt *format;
> +
> +		if (!channel->vc_mask)
> +			continue;
> +
> +		/*
> +		 * In VC interleave mode, each output channel is limited to a
> +		 * single VC.
> +		 */
> +		if (params->interleave_vc && hweight8(channel->vc_mask) != 1) {
> +			dev_dbg(csis->dev,
> +				"Channel %u must output a single VCs\n", i);
> +			return -EPIPE;
> +		}
> +
> +		format = v4l2_subdev_state_get_format(state, CSIS_PAD_SOURCE, i);
> +		if (!format) {
> +			dev_dbg(csis->dev, "No format for source stream %u\n", i);
> +			return -EPIPE;
> +		}
> +
> +		channel->width = format->width;
> +		channel->height = format->height;
> +	}
> +
> +	/*
> +	 * Calculate the line rate from the pixel rate. If the source supports
> +	 * the .get_frame_desc() operation it has to implement the LINK_FREQ
> +	 * control, as the link frequency can't be calculated from the pixel
> +	 * rate with multiple streams having possibly different data types.
> +	 */
> +	link_freq = v4l2_get_link_freq(csis->source.pad,
> +				       csis_fmt ? csis_fmt->width : 0,
>  				       csis->bus.num_data_lanes * 2);
>  	if (link_freq < 0) {
>  		dev_err(csis->dev, "Unable to obtain link frequency: %d\n",
> @@ -704,6 +835,8 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
>  				 const struct mipi_csis_params *params)
>  {
>  	int lanes = csis->bus.num_data_lanes;
> +	u32 cmn_ctrl = 0;
> +	u32 clk_ctrl = 0;
>  	u32 val;
>
>  	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
> @@ -714,19 +847,32 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
>
>  	if (csis->info->version == MIPI_CSIS_V3_3)
>  		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT;
> +	if (params->interleave_vc)
> +		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_VC;
>
>  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
>
> -	mipi_csis_set_channel_params(csis, 0, &params->channels[0]);
> +	for (unsigned int i = 0; i < csis->num_channels; ++i) {
> +		const struct mipi_csis_channel_params *channel =
> +			&params->channels[i];
> +
> +		if (!channel->vc_mask)
> +			continue;
> +
> +		mipi_csis_set_channel_params(csis, i, channel);
> +
> +		cmn_ctrl |= MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW(i);
> +		clk_ctrl |= MIPI_CSIS_CLK_CTRL_CLKGATE_TRAIL(i, 15)
> +			 |  MIPI_CSIS_CLK_CTRL_WCLK_SRC(i);
> +	}
>
>  	mipi_csis_write(csis, MIPI_CSIS_DPHY_CMN_CTRL,
>  			MIPI_CSIS_DPHY_CMN_CTRL_HSSETTLE(params->hs_settle) |
>  			MIPI_CSIS_DPHY_CMN_CTRL_CLKSETTLE(params->clk_settle));
>
>  	val = mipi_csis_read(csis, MIPI_CSIS_CLK_CTRL);
> -	val |= MIPI_CSIS_CLK_CTRL_WCLK_SRC(0);
> -	val |= MIPI_CSIS_CLK_CTRL_CLKGATE_TRAIL(0, 15);
>  	val &= ~MIPI_CSIS_CLK_CTRL_CLKGATE_EN_MASK;
> +	val |= clk_ctrl;
>  	mipi_csis_write(csis, MIPI_CSIS_CLK_CTRL, val);
>
>  	mipi_csis_write(csis, MIPI_CSIS_DPHY_BCTRL_L,
> @@ -741,8 +887,7 @@ static void mipi_csis_set_params(struct mipi_csis_device *csis,
>
>  	/* Update the shadow register. */
>  	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
> -	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL,
> -			val | MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW(0) |
> +	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val | cmn_ctrl |
>  			MIPI_CSIS_CMN_CTRL_UPDATE_SHADOW_CTRL);
>  }
>
> @@ -1053,7 +1198,7 @@ static int mipi_csis_enum_mbus_code(struct v4l2_subdev *sd,
>  		if (code->index > 0)
>  			return -EINVAL;
>
> -		fmt = v4l2_subdev_state_get_format(state, code->pad);
> +		fmt = v4l2_subdev_state_get_format(state, code->pad, code->stream);
>  		code->code = fmt->code;
>  		return 0;
>  	}
> @@ -1069,10 +1214,57 @@ static int mipi_csis_enum_mbus_code(struct v4l2_subdev *sd,
>  	return 0;
>  }
>
> +static void mipi_csis_propagate_formats(struct mipi_csis_device *csis,
> +					struct v4l2_subdev_state *state)
> +{
> +	const struct v4l2_mbus_framefmt *channels[MIPI_CSIS_MAX_CHANNELS] = { };
> +	struct v4l2_subdev_route *route;
> +
> +	for_each_active_route(&state->routing, route) {
> +		const struct csis_pix_format *csis_fmt;
> +		struct v4l2_mbus_framefmt *sink_fmt;
> +		struct v4l2_mbus_framefmt *src_fmt;
> +
> +		sink_fmt = v4l2_subdev_state_get_format(state, CSIS_PAD_SINK,
> +							route->sink_stream);
> +		src_fmt = v4l2_subdev_state_get_format(state, CSIS_PAD_SOURCE,
> +						       route->source_stream);
> +
> +		csis_fmt = find_csis_format(sink_fmt->code);
> +
> +		/*
> +		 * If the output channel corresponding to this source stream
> +		 * isn't associated with a sink stream yet, simply propagate the
> +		 * format from sink stream to source stream and associate the
> +		 * sink stream with the channel.
> +		 *
> +		 * Otherwise, the sink stream format must match the primary sink
> +		 * stream associated with the channel except for the height that
> +		 * can be different. We propagate the format from the primary to
> +		 * secondary sink stream, and accumulate the height in the
> +		 * source stream format.
> +		 */
> +		if (!channels[route->source_stream]) {
> +			*src_fmt = *sink_fmt;
> +			src_fmt->code = csis_fmt->output;
> +
> +			channels[route->source_stream] = sink_fmt;
> +		} else {
> +			unsigned int height = sink_fmt->height;
> +
> +			*sink_fmt = *channels[route->source_stream];
> +			sink_fmt->height = height;
> +
> +			src_fmt->height += sink_fmt->height;
> +		}
> +	}
> +}
> +
>  static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *state,
>  			     struct v4l2_subdev_format *sdformat)
>  {
> +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
>  	const struct csis_pix_format *csis_fmt;
>  	struct v4l2_mbus_framefmt *fmt;
>  	unsigned int align;
> @@ -1120,7 +1312,8 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
>  			      &sdformat->format.height, 1,
>  			      CSIS_MAX_PIX_HEIGHT, 0, 0);
>
> -	fmt = v4l2_subdev_state_get_format(state, sdformat->pad);
> +	fmt = v4l2_subdev_state_get_format(state, sdformat->pad,
> +					   sdformat->stream);
>
>  	fmt->code = csis_fmt->code;
>  	fmt->width = sdformat->format.width;
> @@ -1133,12 +1326,8 @@ static int mipi_csis_set_fmt(struct v4l2_subdev *sd,
>
>  	sdformat->format = *fmt;
>
> -	/* Propagate the format from sink to source. */
> -	fmt = v4l2_subdev_state_get_format(state, CSIS_PAD_SOURCE);
> -	*fmt = sdformat->format;
> -
> -	/* The format on the source pad might change due to unpacking. */
> -	fmt->code = csis_fmt->output;
> +	/* Propagate the format. */
> +	mipi_csis_propagate_formats(csis, state);
>
>  	return 0;
>  }
> @@ -1155,7 +1344,7 @@ static int mipi_csis_get_frame_desc(struct v4l2_subdev *sd, unsigned int pad,
>  		return -EINVAL;
>
>  	state = v4l2_subdev_lock_and_get_active_state(sd);
> -	fmt = v4l2_subdev_state_get_format(state, CSIS_PAD_SOURCE);
> +	fmt = v4l2_subdev_state_get_format(state, CSIS_PAD_SOURCE, 0);
>  	csis_fmt = find_csis_format(fmt->code);
>  	v4l2_subdev_unlock_state(state);
>
> @@ -1187,6 +1376,8 @@ static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
>  		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
>  		.xfer_func = V4L2_XFER_FUNC_SRGB,
>  	};
> +	struct mipi_csis_device *csis = sd_to_mipi_csis_device(sd);
> +	struct v4l2_subdev_route *route;
>  	int ret;
>
>  	ret = v4l2_subdev_routing_validate(sd, routing,
> @@ -1194,15 +1385,27 @@ static int __mipi_csis_set_routing(struct v4l2_subdev *sd,
>  	if (ret)
>  		return ret;
>
> -	/* Only a single route is supported for now. */
> -	if (routing->num_routes != 1 ||
> -	    !(routing->routes[0].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
> -		return -EINVAL;
> +	/*
> +	 * The source stream identifies the output channel. Validate that it
> +	 * does not exceed the number of channels available in the device. The
> +	 * other routing constraints can't be validated now as they require
> +	 * querying the frame descriptor on the sink side, which can only be
> +	 * done when enabling streaming.
> +	 */
> +	for_each_active_route(routing, route) {
> +		if (route->source_stream >= csis->num_channels) {
> +			dev_dbg(csis->dev, "Invalid source stream %u",
> +				route->source_stream);
> +			return -EINVAL;
> +		}
> +	}
>
>  	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
>  	if (ret)
>  		return ret;
>
> +	mipi_csis_propagate_formats(csis, state);
> +
>  	return 0;
>  }
>
> @@ -1554,7 +1757,8 @@ static int mipi_csis_subdev_init(struct mipi_csis_device *csis)
>  	snprintf(sd->name, sizeof(sd->name), "csis-%s",
>  		 dev_name(csis->dev));
>
> -	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS
> +		  |  V4L2_SUBDEV_FL_STREAMS;
>  	sd->ctrl_handler = NULL;
>
>  	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> --
> Regards,
>
> Laurent Pinchart
>
