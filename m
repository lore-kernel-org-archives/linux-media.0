Return-Path: <SRS0=gSK1=CQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8646C433E2
	for <linux-media@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDC721556
	for <linux-media@archiver.kernel.org>; Mon,  7 Sep 2020 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgIGUFV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:05:21 -0400
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:60211 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729049AbgIGUFV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Sep 2020 16:05:21 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 16:05:21 EDT
Received: from sinitiainen (85-156-156-197.elisa-laajakaista.fi [85.156.156.197])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 35f6946b-f143-11ea-ba22-005056bd6ce9;
        Mon, 07 Sep 2020 22:49:15 +0300 (EEST)
Received: from kuusitiainen.riihineva.no-ip.org ([192.168.1.40])
        by sinitiainen with esmtp (Exim 4.71)
        (envelope-from <timo@riihineva.no-ip.org>)
        id 1kFN8d-0002AP-M4
        for linux-media@vger.kernel.org; Mon, 07 Sep 2020 22:49:15 +0300
To:     linux-media@vger.kernel.org
From:   Timo Ketola <timo@riihineva.no-ip.org>
Subject: Asus PN50 CEC
Message-ID: <e56fb2cd-5e40-b83e-f702-0dced9df86fb@riihineva.no-ip.org>
Date:   Mon, 7 Sep 2020 22:49:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

I'm not sure  weather this is the right place to ask but one has to 
start somewhere. Here we go:

I bought an Asus PN50 mini PC (Ryzen 3 4300U). It should have HDMI-CEC 
and there indeed are some related settings in the BIOS. But there seems 
to be no support for it in Linux and I can't find any hints how it might 
have been implemented on the hardware side.

Any ideas what to do now?

--

Timo
