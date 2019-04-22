Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD1C10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71022087E
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 14:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfDVO7V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:59:21 -0400
Received: from mail-oln040092069071.outbound.protection.outlook.com ([40.92.69.71]:30016
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfDVO7V (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 10:59:21 -0400
Received: from VE1EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (10.152.12.54) by VE1EUR02HT084.eop-EUR02.prod.protection.outlook.com
 (10.152.13.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 22 Apr
 2019 14:59:17 +0000
Received: from DB8PR03MB5898.eurprd03.prod.outlook.com (10.152.12.57) by
 VE1EUR02FT046.mail.protection.outlook.com (10.152.12.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 22 Apr 2019 14:59:17 +0000
Received: from DB8PR03MB5898.eurprd03.prod.outlook.com
 ([fe80::e9bc:d2b0:dec9:5065]) by DB8PR03MB5898.eurprd03.prod.outlook.com
 ([fe80::e9bc:d2b0:dec9:5065%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 14:59:17 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 14/15] rockchip/vpu: Add support for MPEG-2 decoding
Thread-Topic: [PATCH v3 14/15] rockchip/vpu: Add support for MPEG-2 decoding
Thread-Index: AQHU+OKTJ74H/CBmyE2nwl2DtyGZP6ZIRiKA
Date:   Mon, 22 Apr 2019 14:59:17 +0000
Message-ID: <DB8PR03MB5898C649C628B6FDEF4E2C80AC220@DB8PR03MB5898.eurprd03.prod.outlook.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
 <20190422080818.29130-15-boris.brezillon@collabora.com>
In-Reply-To: <20190422080818.29130-15-boris.brezillon@collabora.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:203:91::15) To DB8PR03MB5898.eurprd03.prod.outlook.com
 (2603:10a6:10:e7::18)
x-incomingtopheadermarker: OriginalChecksum:94DDD9848DFE81392266906743217EC5126C10031CB8AD71526C23417BD6BFA8;UpperCasedChecksum:CAA0DB22DE0872DB80FDA3F685FBE7FDC7FD80EB06883E9B3D17307ED136E3CA;SizeAsReceived:8037;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GO529d1B4Sn0R6JJAQrTgvHTrndsqDqH]
x-microsoft-original-message-id: <879cfdb6-116f-0828-7c20-5030e84a71bd@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:VE1EUR02HT084;
x-ms-traffictypediagnostic: VE1EUR02HT084:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-message-info: QJmmoWOedPgZHwYSmaCVs4KdDV57584PBmS6Ni6DWPaWUzVqiscJUFXp/eD9kxBgFOW56IQu7OZR3eChyIH4A1M1fXv1KWzn710AoR+2hRu7Yl4qb2SZVuQdN0m2w/+rhaw5t4f4JjF1tKqAJ4M0KqSRJFygL1v7EFotuhlphLV3/2dCFaAjFTs05hcMB8lS
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EB973E92AA36734E9CD149EBCAE20546@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf7c76a-678e-4762-24b9-08d6c733179c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 14:59:17.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT084
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2019-04-22 10:08, Boris Brezillon wrote:
> From: Ezequiel Garcia <ezequiel@collabora.com>

Please restore my commit authorship, it seems to have changed in v3.

I would appreciate if you can pick the fixups from [1] and [2] to sync rk3288/rk3399 code.
Please also squash both MPEG-2 commits, that is closer to the original commit at [4].

This module seems to crash after repeated rmmod / insmod, calls to video_device_release
seems to be the culprit for crash. There is also an issue with uneven pm runtime autosuspend calls
leaving clocks enabled when module is unloaded.

Feel free to pick/squash any of the changes at [3], they fixes the crash and uneven autosuspend for me.

MPEG-2 decoding is working on my RK3288 and RK3399 devices.

Fixup commits:
[1] https://github.com/Kwiboo/linux-rockchip/commit/8d8b5aca522176d17b6a0f13da57fd9b8e7d1e9a
[2] https://github.com/Kwiboo/linux-rockchip/commit/75de5f322ffe889154832f6ebfb08e48257af526
[3] https://github.com/Kwiboo/linux-rockchip/commit/0729b53c825a630c9040d28541d2635a42177361

Original MPEG-2 commit:
[4] https://github.com/Kwiboo/linux-rockchip/commit/25d9502927540c6f17c65d52a350b28c664cbf5a

Thanks,
Jonas

>
> Add MPEG-2 decoding, only on RK3399. Other SoCs
> and support for other codecs will be added in the future.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> --
> Changes from v2:
> * Remove uneeded check from rockchip_vpu_get_ctrl.
> * Use user negotiated resolution when programming the hardware.
> ---
>  drivers/staging/media/rockchip/vpu/Makefile   |   4 +-
>  .../media/rockchip/vpu/rk3399_vpu_hw.c        |  40 ++-
>  .../rockchip/vpu/rk3399_vpu_hw_mpeg2_dec.c    | 273 ++++++++++++++++++
>  .../staging/media/rockchip/vpu/rockchip_vpu.h |   9 +
>  .../media/rockchip/vpu/rockchip_vpu_common.h  |   3 +
>  .../media/rockchip/vpu/rockchip_vpu_drv.c     |  30 ++
>  .../media/rockchip/vpu/rockchip_vpu_hw.h      |  15 +
>  .../media/rockchip/vpu/rockchip_vpu_mpeg2.c   |  61 ++++
>  8 files changed, 433 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/staging/media/rockchip/vpu/rk3399_vpu_hw_mpeg2_dec.c
>  create mode 100644 drivers/staging/media/rockchip/vpu/rockchip_vpu_mpeg2.c
>
> ...

