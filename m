Return-Path: <SRS0=dpHg=ZS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8505C432C0
	for <linux-media@archiver.kernel.org>; Tue, 26 Nov 2019 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDBD2075C
	for <linux-media@archiver.kernel.org>; Tue, 26 Nov 2019 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfKZRAp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:00:45 -0500
Received: from mleia.com ([178.79.152.223]:45872 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfKZRAp (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 26 Nov 2019 12:00:45 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 12:00:44 EST
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 00EBE3B37BD;
        Tue, 26 Nov 2019 16:52:46 +0000 (UTC)
Subject: Re: TI Deserializer DT node configuration
To:     Stuvart S <lovelinuxdeeply@gmail.com>
References: <CAAMGra5wp8o3DAFQdYk3Ky2oaWaNcX-o4gejW7jro5Rm1pkVug@mail.gmail.com>
Cc:     linux-media@vger.kernel.org
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <8137b15e-084d-417a-6ee8-b425b74140df@mleia.com>
Date:   Tue, 26 Nov 2019 18:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAAMGra5wp8o3DAFQdYk3Ky2oaWaNcX-o4gejW7jro5Rm1pkVug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20191126_165246_022854_C9791A8F 
X-CRM114-Status: GOOD (  10.18  )
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Stuvart,

On 11/26/19 5:55 PM, Stuvart S wrote:
> Hello team,
> 
> I am integrating DS90UB964 deserializer into my custom board based on
> Rcar H3 Salvator XS. Deserializer is connected in i2c6.Also I have my
> four serializers as DS90UB913 and cameras OV10635.
> 
> Can any one please help with the following?
> 
> How Deserializer connects to Serializer in DT node?I came accross
> about the terms remote i2c, i2c-mux,i2c-atr.but I dont understand.I am
> not using any i2c switches.
> Any DT example is helpful for me
> 

once in the past I've shared the essential part of my device drivers
and the device tree configuration of connecting a serializer/deserializer
to a display panel [1][2]. Unfortunately for dealing with camera sensors
there should be one more device driver present, and MIPI CSI-2 controllers
are very specific to particular deserializer/serializer ICs.

Both TI DS90UB964 and DS90UB913 are supported in my driver suite,
however your hardware configuration may require some adjustments, also
note that my selected approach is different from Luca's one, and to my
knowledge anyone's published work is still under development.

I feel I have to find more time and complete the driver series,
the precondition is quite difficult though...

[1] https://lore.kernel.org/lkml/f0a52a64-a7e7-b266-a402-1279036fad36@mleia.com/
[2] https://lore.kernel.org/lkml/20181012060314.GU4939@dell/T/#mead5ea226550b6f0

Slides for introduction into the patch series:

* https://schd.ws/hosted_files/ossalsjp18/8a/vzapolskiy_als2018.pdf
* https://events19.linuxfoundation.org/wp-content/uploads/2018/07/Vladimir_Zapolskiy_Bridging.pdf

Hope it helps.

--
Best wishes,
Vladimir
