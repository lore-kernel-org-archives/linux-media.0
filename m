Return-Path: <SRS0=XDiR=ZW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78596C432C3
	for <linux-media@archiver.kernel.org>; Sat, 30 Nov 2019 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF62073C
	for <linux-media@archiver.kernel.org>; Sat, 30 Nov 2019 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfK3M0i (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Nov 2019 07:26:38 -0500
Received: from zeus.seaquake.net ([195.62.218.101]:52174 "EHLO
        zeus.seaquake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfK3M0i (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Nov 2019 07:26:38 -0500
Received: from [192.168.8.111] (unknown [81.96.60.135])
        by zeus.seaquake.net (Postfix) with ESMTP id 9AA9D21C116
        for <linux-media@vger.kernel.org>; Sat, 30 Nov 2019 12:26:37 +0000 (GMT)
To:     linux-media@vger.kernel.org
From:   Steven Maddox <s.maddox@lantizia.me.uk>
Subject: em28xx: new board id [0b1a:2820]
Message-ID: <623be288-0fe5-8313-bd40-7223e045c796@lantizia.me.uk>
Date:   Sat, 30 Nov 2019 12:26:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

I've made tests with my StarTech.com board:

Model: USB 2.0 to Composite and S-Video Capture Cable SVID2USB2NS
Vendor/Product id: [0b1a:2820].

Tests made:

    - Analog [Worked]
    - DVB    [this board doesn't support dvb mode]

Note: Only tested composite by using input 1 via v4l2 by using card=14
(which is EM2820_BOARD_PROLINK_PLAYTV_USB2 as that has a very similar
USB product ID)

Images of the actual device here:
https://photos.app.goo.gl/vh19iFzZuokjhNZq6


~lantizia
