Return-Path: <SRS0=g9gv=EJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C373C63699
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C82223BD
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 09:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tx/lZiWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgKCJbQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:31:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58354 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCJbQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 3 Nov 2020 04:31:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A39V9pG028334;
        Tue, 3 Nov 2020 03:31:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604395869;
        bh=8YUhMeCFGdJ9L2TYcFXAkJxTIuBTr+6CLuSIL8/BIBQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tx/lZiWdLAXjyNzLCg7BxVLTvZ/VtgZ7R89ldQSaeaUvM0tS0kkuDfey2jcPqoAd9
         RUmk9zqKluPb8WmhHfG48yFpS3sOUf4RSNJaGmdRv6HG+fuzUrGnDlsSEgpyHp873R
         aKKsXe1MfBEy8+ErFz+yuvOuvnkjxCsuV9bKHqcQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A39V87t033527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 03:31:08 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 03:31:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 03:31:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A39V6eh025024;
        Tue, 3 Nov 2020 03:31:07 -0600
Subject: Re: [RFC 0/3] media: ov5640: Adjust htot, rework clock tree, add
 LINK_FREQ
To:     Jacopo Mondi <jacopo@jmondi.org>
CC:     Jacopo Mondi <jacopo+renesas@jmondi.org>, <hugues.fruchet@st.com>,
        <sam@elite-embedded.com>, <slongerbeam@gmail.com>,
        <linux-media@vger.kernel.org>
References: <20201028225706.110078-1-jacopo+renesas@jmondi.org>
 <1bc29f6f-20b1-245e-c346-9c57058b9a24@ti.com>
 <20201103081945.pihysjlqha2noz2m@uno.localdomain>
 <1123502e-f82f-182d-cf44-899fe54392f8@ti.com>
 <20201103084544.ocgt33at7tkaumxv@uno.localdomain>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <82ccf16d-b9d1-ad95-07cd-442d7696a0bb@ti.com>
Date:   Tue, 3 Nov 2020 11:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103084544.ocgt33at7tkaumxv@uno.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 03/11/2020 10:45, Jacopo Mondi wrote:

>> I tested 640x480, 720x480, 720x576.
>>
>> I have only this sensor to test the CSI RX on AM6 EVM, so I would not be surprised if there are
>> issues in the CSI RX driver (too). But this is super frustrating to debug, as the sensor is a badly
>> documented black box, and I don't have means to probe the CSI lines...
> 
> I see.. I'm sure you noticed, but as you mentioned the 'second patch'
> I'll point it out anyway: the series has to be applied in full, as the
> last patch adds support for reporting the link frequency, that has
> been re-calculated by patch 2/3. On imx6 and on Hugues' platforms
> adjusting the receiver's link frequency based on what's reported makes a
> difference.

Yes, I first tried with all three, then tested one by one, and the second one started failing.

drivers/media/platform/ti-vpe/cal-camerarx.c doesn't use V4L2_CID_LINK_FREQ (it uses
V4L2_CID_PIXEL_RATE), though, so why would the third patch matter? Or do you mean that
V4L2_CID_LINK_FREQ must be used to get ov5640 work? Aren't pixel rate and link freq directly linked?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
