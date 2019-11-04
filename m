Return-Path: <SRS0=7+ZA=Y4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BECA9EA0
	for <linux-media@archiver.kernel.org>; Mon,  4 Nov 2019 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5A20B7C
	for <linux-media@archiver.kernel.org>; Mon,  4 Nov 2019 10:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfKDKa5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:30:57 -0500
Received: from www.linuxtv.org ([130.149.80.248]:38546 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfKDKa5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 4 Nov 2019 05:30:57 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iRZdK-0003Pl-Ga; Mon, 04 Nov 2019 10:30:50 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iRZdu-0005Gu-U6; Mon, 04 Nov 2019 10:31:26 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for 5.5] Hi556 sensor driver
Date:   Mon,  4 Nov 2019 10:31:26 +0000
Message-Id: <20191104103126.20223-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104102458.GQ6253@valkosipuli.retiisi.org.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/59785/
Build log: https://builder.linuxtv.org/job/patchwork/23397/
Build time: 00:01:17
Link: https://lore.kernel.org/linux-media/20191104102458.GQ6253@valkosipuli.retiisi.org.uk

gpg: Signature made Mon 04 Nov 2019 10:21:18 AM UTC
gpg:                using DSA key F0D0377A0D4F25A79238EFE56D40361B6E28C193
gpg:                issuer "sakari.ailus@linux.intel.com"
gpg: Good signature from "Sakari Ailus <sakari.ailus@linux.intel.com>" [full]

Summary: no issues
