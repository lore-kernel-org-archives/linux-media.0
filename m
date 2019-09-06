Return-Path: <SRS0=gXbs=XB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C2C43331
	for <linux-media@archiver.kernel.org>; Fri,  6 Sep 2019 06:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA8B2084F
	for <linux-media@archiver.kernel.org>; Fri,  6 Sep 2019 06:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392469AbfIFGyH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Sep 2019 02:54:07 -0400
Received: from www.linuxtv.org ([130.149.80.248]:43673 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390346AbfIFGyH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 6 Sep 2019 02:54:07 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i6885-0006Ua-Lf; Fri, 06 Sep 2019 06:53:57 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i688F-0003g1-S7; Fri, 06 Sep 2019 06:54:07 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for 5.4] MC fix and sensor driver cleanup
Date:   Fri,  6 Sep 2019 06:54:07 +0000
Message-Id: <20190906065407.14092-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906064546.GD1586@valkosipuli.retiisi.org.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58618/
Build log: https://builder.linuxtv.org/job/patchwork/14906/
Build time: 00:03:54
Link: https://lore.kernel.org/linux-media/20190906064546.GD1586@valkosipuli.retiisi.org.uk

gpg: Signature made Fri 06 Sep 2019 06:40:58 AM UTC
gpg:                using DSA key F0D0377A0D4F25A79238EFE56D40361B6E28C193
gpg:                issuer "sakari.ailus@linux.intel.com"
gpg: Good signature from "Sakari Ailus <sakari.ailus@linux.intel.com>" [full]

Summary: no issues
