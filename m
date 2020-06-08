Return-Path: <SRS0=Gwua=7V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A304C433DF
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6472074B
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgFHPkW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:40:22 -0400
Received: from ns.iliad.fr ([212.27.33.1]:57590 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgFHPkW (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Jun 2020 11:40:22 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 11:40:22 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 52BC12015F;
        Mon,  8 Jun 2020 17:30:40 +0200 (CEST)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 43C3E1FF42;
        Mon,  8 Jun 2020 17:30:40 +0200 (CEST)
To:     linux-media <linux-media@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Scanning for TV channels over DVB-T and DVB-T2
Message-ID: <11fbc112-c410-8c67-9bcb-9450924d12ef@free.fr>
Date:   Mon, 8 Jun 2020 17:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jun  8 17:30:40 2020 +0200 (CEST)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

Suppose we know that several channels are transmitted on a given frequency
by terrestrial antenna. However, we don't know if the signal is "encoded"
(not sure this is the right term) in DVB-T or DVB-T2 modulation.

Do we have to scan the frequency /twice/
first with DTV_DELIVERY_SYSTEM = SYS_DVBT
 then with DTV_DELIVERY_SYSTEM = SYS_DVBT2 ?

Or is there some optimization where both modulations are handled
in a single step?

Or maybe it depends on the tuner driver?

Regards.
