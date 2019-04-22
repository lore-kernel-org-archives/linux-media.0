Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB14C10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B6120693
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfDVP2s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:28:48 -0400
Received: from mail-oln040092065021.outbound.protection.outlook.com ([40.92.65.21]:50574
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbfDVP2s (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 11:28:48 -0400
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (10.152.0.55) by HE1EUR01HT018.eop-EUR01.prod.protection.outlook.com
 (10.152.1.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16; Mon, 22 Apr
 2019 15:28:45 +0000
Received: from DB8PR03MB5898.eurprd03.prod.outlook.com (10.152.0.60) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1771.16 via Frontend Transport; Mon, 22 Apr 2019 15:28:44 +0000
Received: from DB8PR03MB5898.eurprd03.prod.outlook.com
 ([fe80::e9bc:d2b0:dec9:5065]) by DB8PR03MB5898.eurprd03.prod.outlook.com
 ([fe80::e9bc:d2b0:dec9:5065%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 15:28:44 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 14/15] rockchip/vpu: Add support for MPEG-2 decoding
Thread-Topic: [PATCH v3 14/15] rockchip/vpu: Add support for MPEG-2 decoding
Thread-Index: AQHU+OKTJ74H/CBmyE2nwl2DtyGZP6ZIRiKAgAADq4CAAASRgA==
Date:   Mon, 22 Apr 2019 15:28:44 +0000
Message-ID: <DB8PR03MB58987F631F913769E150BD3DAC220@DB8PR03MB5898.eurprd03.prod.outlook.com>
References: <20190422080818.29130-1-boris.brezillon@collabora.com>
 <20190422080818.29130-15-boris.brezillon@collabora.com>
 <DB8PR03MB5898C649C628B6FDEF4E2C80AC220@DB8PR03MB5898.eurprd03.prod.outlook.com>
 <20190422171223.48cd51fc@collabora.com>
In-Reply-To: <20190422171223.48cd51fc@collabora.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::17) To DB8PR03MB5898.eurprd03.prod.outlook.com
 (2603:10a6:10:e7::18)
x-incomingtopheadermarker: OriginalChecksum:9DCE524F9AEEB6DA0E0AF4746B295CDB8B737513B2F50121A4F779D2171BAC02;UpperCasedChecksum:5173C9842C161508430FAB65C6C4077C94FBAD26A21C35523F3C0667A50C0BAC;SizeAsReceived:8140;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ikOh31Ws4fm6DUSXEv9l+Js5JzEWzYAp]
x-microsoft-original-message-id: <c66e253f-0ec5-6847-a7f4-642c0daed115@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HE1EUR01HT018;
x-ms-traffictypediagnostic: HE1EUR01HT018:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-message-info: hGmhAOYnW6T+WDAp3OJTj4NNJw7fQ4S/vRov8EpDBiIrNiKF0mjn4o1uX/UjHvCH3dZiujUzQoyl3CO8JMU++Zy+dCZGzSQQA71XSetob/WE5BjkTTYOcLJk+ozy80bwW1+cpifCD9jUQ75zr+PiH5KHHcy2BiRjZ7fwXm9XLYhX+l1sshIVJIsReUJUQgn7
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <52E62053DE4FAB45883385E2D2CCDEC4@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 050197f3-e5ae-49f8-c1dc-08d6c73734f6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 15:28:44.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT018
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2019-04-22 17:12, Boris Brezillon wrote:
> On Mon, 22 Apr 2019 14:59:17 +0000
> Jonas Karlman <jonas@kwiboo.se> wrote:
>
>> On 2019-04-22 10:08, Boris Brezillon wrote:
>>> From: Ezequiel Garcia <ezequiel@collabora.com>  
>> Please restore my commit authorship, it seems to have changed in v3.
> Oops, sorry about that, it was not intentional.

Thanks :-)

>
>> I would appreciate if you can pick the fixups from [1] and [2] to sync rk3288/rk3399 code.
> Sure, I'll have a look.
>
>> Please also squash both MPEG-2 commits, that is closer to the original commit at [4].
> Hm, okay. I thought it'd be preferable to split that in 2 or even 3
> commits (one adding the core infra and one per platform), but if
> everyone is okay with having things squashed in a single commit I'll do
> that.

If you think it is better to split please do. I am biased and see both platforms as one that only differ in hwreg order.

Regards,
Jonas

>
>> This module seems to crash after repeated rmmod / insmod, calls to video_device_release
>> seems to be the culprit for crash. There is also an issue with uneven pm runtime autosuspend calls
>> leaving clocks enabled when module is unloaded.
>>
>> Feel free to pick/squash any of the changes at [3], they fixes the crash and uneven autosuspend for me.
> Will do.
>
>> MPEG-2 decoding is working on my RK3288 and RK3399 devices.
>>
>> Fixup commits:
>> [1] https://github.com/Kwiboo/linux-rockchip/commit/8d8b5aca522176d17b6a0f13da57fd9b8e7d1e9a
>> [2] https://github.com/Kwiboo/linux-rockchip/commit/75de5f322ffe889154832f6ebfb08e48257af526
>> [3] https://github.com/Kwiboo/linux-rockchip/commit/0729b53c825a630c9040d28541d2635a42177361
>>
>> Original MPEG-2 commit:
>> [4] https://github.com/Kwiboo/linux-rockchip/commit/25d9502927540c6f17c65d52a350b28c664cbf5a
>>
>> Thanks,
> Thanks for reviewing/testing/debugging.
>
> Boris

