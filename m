Return-Path: <SRS0=dfwv=UR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDB2C31E5B
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490E12084B
	for <linux-media@archiver.kernel.org>; Tue, 18 Jun 2019 16:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfFRQrW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:47:22 -0400
Received: from ns.iliad.fr ([212.27.33.1]:54020 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbfFRQrW (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Jun 2019 12:47:22 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1E94920338;
        Tue, 18 Jun 2019 18:47:21 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0C7341FF3E;
        Tue, 18 Jun 2019 18:47:21 +0200 (CEST)
To:     Olli Salonen <olli.salonen@iki.fi>, Antti Palosaari <crope@iki.fi>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: si2168 gapped clock
Message-ID: <cdffeaf7-86cf-32d5-88c1-a6d7b07127b3@free.fr>
Date:   Tue, 18 Jun 2019 18:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jun 18 18:47:21 2019 +0200 (CEST)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

In the qcom SoC, the TS interface has two modes of operation.

- with 3 signals (clk, valid, data)
- with 4 signals (clk, valid, data, sync)

In the si2168 short datasheet, I can see a diagram with these
4 signals.

My question is: how do we configure the si2168 demod to be
in the first mode or the second mode?

Is it the ts_clock_gapped parameter?

ts_clock_gapped=0 means no sync
ts_clock_gapped=1 means with sync ???

Regards.
