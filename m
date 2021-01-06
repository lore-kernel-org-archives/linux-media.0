Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F7C433DB
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 10:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85C23110
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 10:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAFKcF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:32:05 -0500
Received: from www.linuxtv.org ([130.149.80.248]:50106 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFKcE (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 Jan 2021 05:32:04 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kx666-002yFq-5J; Wed, 06 Jan 2021 10:31:22 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kx69T-0006Uq-Km; Wed, 06 Jan 2021 10:34:51 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT FIXES FOR v5.11] rc nsec to usec fix (#70509)
Date:   Wed,  6 Jan 2021 10:34:51 +0000
Message-Id: <20210106103451.24931-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106101957.GA29145@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20210106101957.GA29145@gofer.mess.org/
Build log: https://builder.linuxtv.org/job/patchwork/84590/
Build time: 00:03:09
Link: https://lore.kernel.org/linux-media/20210106101957.GA29145@gofer.mess.org

error: FETCH_HEAD: cannot verify a non-tag object of type commit.

Summary: got 0/1 patches with issues, being 0 at build time, plus one error when buinding PDF document

Error/warnings:


Error #512 when building PDF docs

