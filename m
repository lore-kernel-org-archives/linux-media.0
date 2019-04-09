Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D7CC10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F92B2084C
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=thinciit.onmicrosoft.com header.i=@thinciit.onmicrosoft.com header.b="fLj65eF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDIPtr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:49:47 -0400
Received: from rfout2.hes.trendmicro.com ([54.67.111.2]:55446 "EHLO
        rfout2.hes.trendmicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIPtr (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 11:49:47 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 11:49:46 EDT
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.4.223])
        by rfout2.hes.trendmicro.com (Postfix) with ESMTPS id 9BD621116B8C
        for <linux-media@vger.kernel.org>; Tue,  9 Apr 2019 15:39:30 +0000 (UTC)
Received: from 0.0.0.0_hes.trendmicro.com (unknown [10.64.0.132])
        by rout6.hes.trendmicro.com (Postfix) with SMTP id C8F8BC66093
        for <linux-media@vger.kernel.org>; Tue,  9 Apr 2019 15:39:29 +0000 (UTC)
Received: from IND01-MA1-obe.outbound.protection.outlook.com (unknown [104.47.100.58])
        by relay1.hes.trendmicro.com (TrendMicro Hosted Email Security) with ESMTPS id E5D6B142C17C;
        Tue,  9 Apr 2019 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thinciit.onmicrosoft.com; s=selector1-thinci-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIgbBGVdAoQIIV24K3rRmLHH1lBCLYo9zpIYyq+kK0U=;
 b=fLj65eF27dXeZ/57GK/9lDFoLDHoQJuBgVSmc8C/7ax/3gUnuN/m9R+vvUQ92/lnCzeQvc9Yy5KnDFi/QJW+XVBOvFEDFuTav/rrkKttAj69bJRzxCFooNl3VSmKuPvbJiENlP+JUJZc76QW7X/exeMhzdlwcU3uTTKrIAp+KPs=
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM (52.134.158.84) by
 MAXPR01MB2382.INDPRD01.PROD.OUTLOOK.COM (52.134.152.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Tue, 9 Apr 2019 15:39:25 +0000
Received: from MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a]) by MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8c8f:543a:ccd6:fe7a%2]) with mapi id 15.20.1792.009; Tue, 9 Apr 2019
 15:39:25 +0000
From:   Matt Redfearn <matt.redfearn@thinci.com>
To:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "gstreamer-devel@lists.freedesktop.org" 
        <gstreamer-devel@lists.freedesktop.org>
Subject: Gstreamer / V4L support for MIPI CSI transmitter device
Thread-Topic: Gstreamer / V4L support for MIPI CSI transmitter device
Thread-Index: AQHU7uppTDMHvzBhwU6N8uBNVpU9SQ==
Date:   Tue, 9 Apr 2019 15:39:25 +0000
Message-ID: <8e7c5ac9-61ef-4d17-869b-07ab1d579c13@thinci.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::19) To MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:64::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=matthew.redfearn@thinci.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [87.242.198.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 815a4a87-f70a-4857-d21e-08d6bd018b85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MAXPR01MB2382;
x-ms-traffictypediagnostic: MAXPR01MB2382:
x-microsoft-antispam-prvs: <MAXPR01MB238235B5ECA6F75BAD587A96F12D0@MAXPR01MB2382.INDPRD01.PROD.OUTLOOK.COM>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(189003)(199004)(8936002)(26005)(2906002)(7736002)(3846002)(31696002)(386003)(6506007)(68736007)(66066001)(25786009)(256004)(186003)(102836004)(99286004)(5660300002)(52116002)(6116002)(97736004)(6512007)(486006)(31686004)(14444005)(8676002)(105586002)(476003)(110136005)(106356001)(2501003)(2616005)(305945005)(6486002)(6436002)(36756003)(71190400001)(71200400001)(478600001)(14454004)(316002)(53936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MAXPR01MB2382;H:MAXPR01MB3773.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: thinci.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hOQoVmvnzY3lLtjHW01mcpH/fWFlCll/xZ9HHUcpDl3sJLBUjgq0UDbHgK5dXppNtUNdzdhhb0cKipG5kr1eALJYZbHI6k0P0zxxaSK087YGjAm/p1DkaaSF7C2IF76qTANidZYv/3vPxc8Vr3Haa8ypgHI2gHT9kZcCMBGtV2f/LaW+1a3Cjz1N2R4Mxgt6FBIc7YnUNrcVUiKZdbSfPFuwogV7Yt7kdJ46djyQ13oEVVQljmoIOn2OZB17VnSuknopBDG7FbypocHq4QHuLt22mCbHrM5MWY1JG4kBf1cNH7HAdOO/ZQnpVQ490SpD+mTL//yD8xPje81n6P3UdaxM7E8FcMNtw6lcPo0Sw6Tw5Ldv4cPq37wv2wIcFIroHesW1LJnJqiCfhY/tUkwGV4s8fKIX9vo24ltd+ORp/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6ADA05687D10041838ECE9B70521B2C@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: thinci.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a4a87-f70a-4857-d21e-08d6bd018b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 15:39:25.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB2382
X-TMASE-Version: StarCloud-1.3-8.2.1013-24542.000
X-TMASE-Result: 10--5.308400-4.000000
X-TMASE-MatchedRID: /Tnn5EXWEDwTqqg1ekHcnG3NvezwBrVmviRliDV2nyxWq2HU6M4qhQhh
        sVZPSyMHLhcDc613Ii0q/32YPqClKq6EIEWX9vrejNvYZHpO13dimi8LvNfmry5hVkDKEqeBmyc
        Y/8v++6TecYuHLZXjOwTHdzd5oRymS3Zni/NoaLcTRDzcDa8P62GNLTRnb5YtcfqEBkUZwxBm+j
        6YVbX2YGCkCBAxrfYx4QeSIpZv9OnQOCWBwgRKBYesoyUFcYI/wWulRtvvYxTWRN8STJpl3PoLR
        4+zsDTtCx9qoxmS2x15sW1qjkPLzYBjPqyyd4oZA+ULbZ1me5D9oqrqupVE9Q==
X-TM-Deliver-Signature: DA9D261B5728234A12A0373186FD708E
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

SGksDQoNCkknbSB3cml0aW5nIGEgTGludXggZHJpdmVyIGZvciBhIE1JUEkgQ1NJIHRyYW5zbWl0
dGVyIGRldmljZS4gVGhpcyANCmhhcmR3YXJlIGFsbG93cyB0aGUgTGludXggc3lzdGVtIHRvIHRy
YW5zbWl0IGEgTUlQSSBDU0kgc3RyZWFtIHRvIGEgDQpzdWl0YWJsZSBNSVBJIENTSSByZWNlaXZl
ciBpLmUuIExpbnV4IGJlaGF2ZXMgbGlrZSBhIGNhbWVyYS4NClNvIGZhciBJIGhhdmUgYWRkZWQg
YSBWNEwgb3V0cHV0IGRyaXZlciBmb3IgdGhlIGhhcmR3YXJlIGFuZCBJIGFtIGFibGUgDQp0byB0
cmFuc21pdCBhIHZpZGVvIHN0cmVhbS4gVG8gZG8gdGhpcyBJIGFtIHVzaW5nIGdzdHJlYW1lciB3
aXRoIHY0bDJzaW5rOg0KDQpnc3QtbGF1bmNoLTEuMCB2aWRlb3Rlc3RzcmMgICEgDQp2aWRlby94
LWJheWVyLHdpZHRoPTY0MCxoZWlnaHQ9NDgwLGZvcm1hdD1iZ2dyICEgdjRsMnNpbmsgZGV2aWNl
PS9kZXYvdmlkZW8wDQoNClRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBNSVBJIENTSSB0cmFuc21pdHRl
ciBuZWVkcyB0byBrbm93IHRoZSB2aWRlbyANCnRpbWluZ3MgKHBpeGVsY2xvY2sgJiBibGFua2lu
ZyBwZXJpb2RzKSB0aGF0IGl0IHNob3VsZCBkcml2ZSB0byB0aGUgTUlQSSANCkNTSSBidXMuIEZv
ciBub3csIEkganVzdCBoYXJkY29kZWQgNjQweDQ4MEA2MGZwcyBudW1iZXJzIGludG8gdGhlIGRy
aXZlci4NCklkZWFsbHksIEkgdGhpbmsgSSBuZWVkIHRvIGFkZCBzdXBwb3J0IGZvciBEVl9USU1J
TkdTIGlvY3RscyBzdWNoIHRoYXQgDQp1c2Vyc3BhY2UgY2FuIGVudW1lcmF0ZSB0aGUgcG9zc2li
bGUgdmlkZW8gdGltaW5ncyAocHJvYmFibHkganVzdCBhIA0Kc3Vic2V0IG9mIHY0bDJfZHZfdGlt
aW5nc19wcmVzZXRzKQ0KDQpJIHdvdWxkIHRoZW4gbmVlZCB0byBhZGQgc3VwcG9ydCB0byBHc3Ry
ZWFtZXIncyB2NGwyc2luayB0byBnZXQgdGhlIA0KZHZfdGltaW5ncywgaWYgc3VwcG9ydGVkLCBw
aWNrIG9uZSBjb21wYXRpYmxlIHdpdGggdGhlIHZpZGVvIGNhcHMsIGFuZCANCnNldCBpdCwgYWxv
bmcgd2l0aCB0aGUgcGl4ZWwgZm9ybWF0Lg0KDQpJcyB0aGlzIHRoZSBiZXN0IGFwcHJvYWNoPyBB
cmUgdGhlcmUgYW55IGdvdGNoYXMgaW4gdGhpcyBvciBvdGhlciB0aGluZ3MgDQpJIHNob3VsZCBj
b25zaWRlciBkb2luZyBpbnN0ZWFkPyBPbmUgcG9zc2liaWxpdHkgaXMgdGhhdCBJIHNob3VsZCAN
Cmluc3RlYWQgbWFrZSB0aGUgZHJpdmVyIGluIHRoZSBEUk0gc3Vic3lzdGVtLiBJIGRpZG4ndCBp
bml0aWFsbHkgZG8gdGhhdCANCmRvIHRvIG1pc3Npbmcgc3VwcG9ydCBmb3IgdGhlIG1vcmUgZXhv
dGljIHBpeGVsIGZvcm1hdHMgdGhhdCBNSVBJIENTSSANCmhhcyBlLmcuIHJhdyBiYXllci4gQnV0
IG9mIGNvdXJzZSwgRFJNIHdvdWxkIGdpdmUgbWUgbXVjaCBlYXNpZXIgYWNjZXNzIA0KdG8gdmlk
ZW8gdGltaW5ncy4uLg0KDQpUaGFua3MgZm9yIGFueSBhZHZpY2UuDQpNYXR0DQo=
