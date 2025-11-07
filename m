Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1018C2C
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547878; cv=fail; b=VmjFc8RDqg+wvpbVm+o4T9ez6+YXgC01LcEHCTQ4ZH2oQ2kruYm/3ed9qJiIKJqSeMuI/5CrPPlAZCdv9Tkfl7+GUl5642QdgasJV7YaueA4dn+6A51p3e7I+VHEMJCKVAZrh2lFzPMnU1sXd8lHRAjl/h1USs1Y3EdA1uPKoQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547878; c=relaxed/simple;
	bh=8jfn0TL/qy+EAwxNLx7rIbnrYBN9vYl8zZbbR6UwyBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhyEy3/ZtAVxJqRzbatb7Ccl5S6ra/M432MQcZIx2T1EuX4ehINAVO2ZBIiLv7uY+SdGFrEpAE5AQVowW4ZSnUGW+ujwQhToN8wDE+0TILaRdgbrkFaL9o56GBfO0CP71M+MykuRJZZFplYvQE4eDyqo9uxHjJWC2tAswAMG7kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VvyO/YBs; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VvyO/YBs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gos3lPLA0XXjp9EednicfuOeSG3zuvgRET15pZY0myeRyw/CRUhxiVVHS3IEzr9UQzVaEeYMtAcgIPaWeINF8pCC5wRMM89lT9kvjIY9/N47c5avIaL6ZBgchK0goMTeV/jNYO2gA7Ve5v1tSYBxj5f1t35hKp2PJwGv7Oyp3r3nNlRAMW6u+LJjWJF5KQGo5a6hlO3hrUdxUWy8a+0gkZSe9LGTC2pA4eLVIAy37V9NWYQk9B7vRSGBaPa8gd09RHyMT8W9ibRLat4QF+3rVsK9gDKmIiAxlGWVpOD+pj5XX7jGhZSFeBwcn0Yl/euSZLzQSH50YnBlNzQfGin4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+NufR7hLn0zx9tac0f/IM8aP9BWg/dGvCIqqC8JIb8=;
 b=SAI1yoUWcjjF1uu7Ts4tIXgtFOtTloR4llzxKthcKsar6MIC5EopyOhMZvTISuRlrggeluApAhSgqylaqZArLrLGDcKF6D0umAOg13xtKlgvibHfWcX/7qD8eIDxYU0454JImIxNVajbHdV19qNpa1awjUwhzFORlgWiIElVTF4MyBDWLRv2ueNJaQH6225REbyxPlNTFqYXnzm5WgNBTwz12eAMvOEN8Tl+FL92dQpFISvqqdeSWVXL3/c8Kh1viVyYf93InGMjRT3+LZDIFjQgwQN7MF67k3+v3tcaW/ZHTfW6bAEpi43AWrD59dlsXUdRWpySTwiqdypM6ojyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+NufR7hLn0zx9tac0f/IM8aP9BWg/dGvCIqqC8JIb8=;
 b=VvyO/YBsUxMd0qjl8moW2JjO+rg2Z+Bk2Qq8TK3SKtUsChslva815t2xQ9w+rQeE8TMJR0qSnvt1+448LBFEbpyw/mc12BaZmADH39lmBgyGV3R0AATRT5HMergBwTYlDDXI7biGgvqvgn9Xl7paes5okpfnInNq389jD8d/1TjQA2KSEYT+Vz158+Kt0ZodmFcjrHW/vRKKrYY6KEjzUwudif7VdvghZbHT5FV6cFmnZN8P+LunVHba6dmlyNBmq6Sqqcg/3wl8nksk+6dLziYYMqBKUIRLB+T+2Z0HPrKmWWiBEPVOK8Tc8WhHzd3+/mc6Xk3szSvHSvvRY2CtTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:37:52 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:37:52 +0000
Date: Fri, 7 Nov 2025 15:37:43 -0500
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
Message-ID: <aQ5YlzMWf/3czSIO@lizhi-Precision-Tower-5810>
References: <20251107015813.5834-1-laurent.pinchart@ideasonboard.com>
 <20251107015813.5834-2-laurent.pinchart@ideasonboard.com>
 <aQ4cKf3y1zqwBmar@lizhi-Precision-Tower-5810>
 <20251107184429.GF5558@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107184429.GF5558@pendragon.ideasonboard.com>
X-ClientProxiedBy: SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7dc9c-b9d0-4dea-b88d-08de1e3d8511
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?5eOQUes4OhAOc3JCJPJL4tN5RYExPzKRTUnYyn4kCHi82Pu3DmwdsrykJe+7?=
 =?us-ascii?Q?XCrcUoLrqnWIbVlPmINimFATm6gmgAPj8aunrF7g9xE6lWlROHD058nuOl0N?=
 =?us-ascii?Q?00lzpu4sdHCtVIjyzt8PGPJ1gi5Q+KinBQXU7VFNUVWZdWEqJgjTJV9ogxdA?=
 =?us-ascii?Q?DKT3WFFd3HOzmBttL1Jhp8YrI7BHniULIN/jEw1Rei5lHvfBhqOrrkS1er6H?=
 =?us-ascii?Q?r0wquAeLoF+sTa65wztFnYnMkzLTiQQEoC2ebkaqBcUVS3Kxy2k3WWgZiOVo?=
 =?us-ascii?Q?Sj4AxT7BYibu/4tRCP50Yo5ydWXO9r+uFnvXjsnOr3ZI95Vux7FsJf94PugB?=
 =?us-ascii?Q?O1CmalRwVbFrEcWuVnW3ig2rMcmFFmczA+nWkcpETjwHu1gI5/CJPd38EXeY?=
 =?us-ascii?Q?fAeItZijApCGjsN24smYwrDCy8O5fT0SxvWx7KW86M8thIJJAk19tBxUIMu6?=
 =?us-ascii?Q?ByT51+hwL6u7BRS83hmKJty+e/D1033JyRSwxzRLCcL77PKRmP/xHZkK+8uz?=
 =?us-ascii?Q?qqQ6Qibj/KyV8F13sDF500d6mR3vSYgRJ6rv42R2TDUVzd2YDO0PrtVRccLH?=
 =?us-ascii?Q?qybeISaNv/o0eBAt8LzKFMWF1JFeSFQB3DoqMunUYHtd6N3nFwwTgT7Xcotu?=
 =?us-ascii?Q?x/Olw0wyYRCJ32VAGWULauDTtaZLnuqBdK7VzuSEB6hMdMNgZvAn6XDPcxkU?=
 =?us-ascii?Q?AvmhcVRjWLbzC152BvsIuKkueuuotS29zEjx0Welc/oYztsChiAi+CV0c8Np?=
 =?us-ascii?Q?SJ7BUFvzFm/wnZRR/5lDAldzNcJkgRqYVJiT79/KJ5W925bp7BvgFzClqXek?=
 =?us-ascii?Q?x0t9o39BptITcM0F0opai5cV/Ts7lbOU80kzyos4ZO7jWdg/iePViNWttjq8?=
 =?us-ascii?Q?9q+k5JbEVNZoTwJRShWbpbVp1jHguWX4lajcWmz5BxS0vRXGZMc8gKrI5iAF?=
 =?us-ascii?Q?YXKUhozkO/aIsEAFMHJ1rp1Ec0NaddPBuvuIDl1nvAEKumy1UZAMv+ESa90u?=
 =?us-ascii?Q?kY2niWMerBbDA2iBZe9TqLyOWEYoxgZennZzpmfvgZL03zApXtpLWYUimtRH?=
 =?us-ascii?Q?0TIv3F3gTZgxp83GPaBb7qzIDTabJam9eULT0ST/WK8bap3pZtqjRdcA+RLE?=
 =?us-ascii?Q?vwqLy9SUSXiAMNHbFx9XpPSNMXBuUgF4e4ml2uyx065iV+axkfafmQk+2Eu4?=
 =?us-ascii?Q?tv1ebVZ742xEat/EbZB2OaNhrptMXjyKv/o76eGRSefWYTI3OTZCD2CMPMJS?=
 =?us-ascii?Q?AEDxbgjlRkeKEMt6KkXb8lzUHUfcVW/nOU56Y40YPTzKIjoUHcgY9pQkretg?=
 =?us-ascii?Q?0lHpqFdkq/ZplENArT5h+SuQK3iD/F2FErhuD5aCCeugEl+gayvA0cA/VmWm?=
 =?us-ascii?Q?xF+AMGE6rWg9hymcuUUaz9SoNWVNxaSjduFo0ZbF+jLsB/i37SiWUR7JYvC1?=
 =?us-ascii?Q?gXF56RlUmLR2MhlMMvJqHUYsIY4c4pydE3uOZ6i6qGxwb4uv6qUbNOy5c0Q/?=
 =?us-ascii?Q?U7+iewXO7JtU8eu0589P0w6oNjstmlEAIV4r?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NabEWjknSyWGy+ssNNBlvgjNR0GAJtI6uWZNU8AeY2H11mC7ZZbHjhevDztl?=
 =?us-ascii?Q?zAo+sfvoad5Wdvmzy+WQAwT5Ql+nlzgsHerPBRiHWV/CeI+rd2JuZQupz6N4?=
 =?us-ascii?Q?0N/pmxtBYoK5VdEA3sHFACy1YEnFgmJjTkwfo3SGGggCk3NOj1m2fqArLZqU?=
 =?us-ascii?Q?pyQDPZG6qokDS3oExLerRIgmNSb59D7XKGIYwRh4gfzhuotXG05q1z1dCcRO?=
 =?us-ascii?Q?51fnb4TD8ric93jIc+hnlK49TzT40jYH/R19VMmARZNe4a0c3kkpw48UTIP5?=
 =?us-ascii?Q?VmggNMfOxQPEkaO0SwLPB91uQC2rXNOTq1ODZ9fOuoEAQQEAQorzeabvZ3aV?=
 =?us-ascii?Q?Lb1ThtS/2t81EQFZMjpaif0+KxgMVlFaWyBAzN6Mif6FXZQUZz6kkpNCWSJN?=
 =?us-ascii?Q?RvmR4Q5dVSlxCLVIXRQKADpwesgedESyiWtWg6OP86iCtIn0vkBcNXckPeN/?=
 =?us-ascii?Q?5HtrKReHVaOaKKEzaF9nAmZskeuCLqi23dmj4+CseTpnaWESUc2U8i58QKWM?=
 =?us-ascii?Q?pE07zCs9/XF4QVAGl3Zs+XWp7Vn6mZAfNnUP/Wzx0HEeXo/96ZV68LSzBjHA?=
 =?us-ascii?Q?hulru/2g6KvZErE2GfaN2F3HNQzhssp4CHhqCW8pYUZF6jM+pbqWmxrShPod?=
 =?us-ascii?Q?smm6h7xyMML9mGE5RjaqZkJeH/+uYg9du0Vf1bsmW8kUhInESspLAPDUITUx?=
 =?us-ascii?Q?IVBSmopgI8vFit/AU59bR4yqK7JL+I0csGw+/EZa5zAm67lsRVyy78VXUJte?=
 =?us-ascii?Q?1Lus/Gk+yoLNjsnoBHY7bIOK01C04s211Qkj7ql+VbhWp8qfKDxSQrZ5Q9+V?=
 =?us-ascii?Q?XEj/n11WWgOfur6tEyMug79pWOAbVUby8hyRDOJV9mIOCgE0tY5r+64ufLUD?=
 =?us-ascii?Q?2Vi6V8P32eD9SQIuIHsW6Rdfz+yMJPkveLGG/oD3KC7U06ftRiK1ZsFxCk0O?=
 =?us-ascii?Q?kqXnNY/qudXmBWeOK/kDEzda0U7hU5GY/wLZAE6gThvicWyfklfDSZNLxgfp?=
 =?us-ascii?Q?sLwO65mzvpLHPbpM6ynRsxKnbj6J9trx3sTjbdwKKlFBQdo/LcrYt9tdybUK?=
 =?us-ascii?Q?dn/v4BCjCUR5ZadNakKKJqq3QQbEaBrsht6LdmvB2yH+p2o5DolDKRbsHoeF?=
 =?us-ascii?Q?uemWOcnXJ1/w6n8TqdRHh6bzXX/BtntziFebz5HWa+juTVs+oFOeEUUMHSES?=
 =?us-ascii?Q?VjrSMGqyjdKH5IDO2R8fWt7htAtocQgkQQC9ImGSBjizeeBdQxZtnNxbJ6co?=
 =?us-ascii?Q?juhmG4/vT3+lBzJbaNohnItjglc8NPqNHOxITOmMWcvQRTWIPTsBrOI2FATa?=
 =?us-ascii?Q?VBtUVjioVZ3CBY02OowpxDpBEujsZeueRITWD/O4hSiN+dxrmLFbmRXDW14R?=
 =?us-ascii?Q?XqBW2y9KDKsma7Sl+ObjDuGtLzzFpH1sy/Re5ZiGyn1f8cJ/86WQDPcXKsJw?=
 =?us-ascii?Q?Wdv2GnN2liElf/wjJaFbYphUxJZrGNvm0io6mO+tdA0FOg0InD+wjTQOz1jv?=
 =?us-ascii?Q?MdJTngThxFxl4f58EAkTwgt9gt47WlczvWNlkYFCdlwqJ1FcCbYBZ8Wcb+Zp?=
 =?us-ascii?Q?UNZRMGx+iTzFs38BGhGECdlxLbL2ydWYgrOaiXfE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7dc9c-b9d0-4dea-b88d-08de1e3d8511
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:37:51.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32VzTZTGp1H7oxuqzwYaiqbIcP5a/T514u3Vz7H4o3h9/rRBTkmFAaOxnOlN62agrK8EVcy2xrwyOeDlSOEMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

On Fri, Nov 07, 2025 at 08:44:29PM +0200, Laurent Pinchart wrote:
> On Fri, Nov 07, 2025 at 11:19:53AM -0500, Frank Li wrote:
> > On Fri, Nov 07, 2025 at 03:58:08AM +0200, Laurent Pinchart wrote:
> > > The CMN_CTRL and ISPCFG registers have fiels related to virtual channel
> > > handling. In CMN_CTRL, the INTERLEAVE_MODE field is 2 bits wide, and
> > > controls filtering by DT, VC or both. The VC number is then set in the
> > > ISPCFG.VIRTUAL_CHANNEL field.
> > >
> > > Expand the definition of the register macros to support those features,
> > > and set the VC ID to 0 explicitly instead of relying on the default
> > > register value. This prepares for VC filtering but does not modify the
> > > driver's behaviour.
> > >
> > > While at it, use GENMASK in the last few register mask macros that don't
> > > use it.
> > >
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > >  drivers/media/platform/nxp/imx-mipi-csis.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > ...
> > >
> > >  	val = mipi_csis_read(csis, MIPI_CSIS_CMN_CTRL);
> > > -	val &= ~MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK;
> > > +	val &= ~(MIPI_CSIS_CMN_CTRL_LANE_NUMBER_MASK |
> > > +		 MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_MASK);
> > > +
> > >  	val |= MIPI_CSIS_CMN_CTRL_LANE_NUMBER(lanes - 1);
> > > +
> > >  	if (csis->info->version == MIPI_CSIS_V3_3)
> > >  		val |= MIPI_CSIS_CMN_CTRL_INTERLEAVE_MODE_DT;
> > > +
> >
> > above two empty line is not related this patch
>
> It's just a matter of giving the code more room to breathe. I can move
> them to patch 6/6 if you prefer.

That will be great.

Frank
>
> > >  	mipi_csis_write(csis, MIPI_CSIS_CMN_CTRL, val);
> > >
> > >  	__mipi_csis_set_format(csis, format, csis_fmt);
>
> --
> Regards,
>
> Laurent Pinchart
