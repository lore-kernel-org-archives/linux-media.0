Return-Path: <SRS0=rbir=2U=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A369C2D0C2
	for <linux-media@archiver.kernel.org>; Mon, 30 Dec 2019 10:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA2C206DB
	for <linux-media@archiver.kernel.org>; Mon, 30 Dec 2019 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfL3K3D (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Dec 2019 05:29:03 -0500
Received: from www.linuxtv.org ([130.149.80.248]:47138 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfL3K3D (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Dec 2019 05:29:03 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ilsHd-0050X2-LV; Mon, 30 Dec 2019 10:28:21 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ilsJG-0008Sg-II; Mon, 30 Dec 2019 10:30:02 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT FIXES for 5.5] Ipu3 alignment warning fix
Date:   Mon, 30 Dec 2019 10:30:02 +0000
Message-Id: <20191230103002.32464-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230101513.GE5050@valkosipuli.retiisi.org.uk>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/60944/
Build log: https://builder.linuxtv.org/job/patchwork/31451/
Build time: 00:09:35
Link: https://lore.kernel.org/linux-media/20191230101513.GE5050@valkosipuli.retiisi.org.uk

gpg: Signature made Mon 30 Dec 2019 09:53:55 AM UTC
gpg:                using DSA key F0D0377A0D4F25A79238EFE56D40361B6E28C193
gpg:                issuer "sakari.ailus@linux.intel.com"
gpg: Good signature from "Sakari Ailus <sakari.ailus@linux.intel.com>" [full]

Summary: no issues
