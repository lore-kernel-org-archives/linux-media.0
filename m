Return-Path: <SRS0=vajg=EM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F5C4741F
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337E12065D
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKFNoM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Nov 2020 08:44:12 -0500
Received: from www.linuxtv.org ([130.149.80.248]:34770 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgKFNoM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 6 Nov 2020 08:44:12 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kb22E-0003PB-SN; Fri, 06 Nov 2020 13:44:10 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kb25F-0008OZ-2K; Fri, 06 Nov 2020 13:47:17 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.11] Venus updates (#68684)
Date:   Fri,  6 Nov 2020 13:47:17 +0000
Message-Id: <20201106134717.32230-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106133536.1050-1-stanimir.varbanov@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20201106133536.1050-1-stanimir.varbanov@linaro.org/
Build log: https://builder.linuxtv.org/job/patchwork/75844/
Build time: 00:05:54
Link: https://lore.kernel.org/linux-media/20201106133536.1050-1-stanimir.varbanov@linaro.org

gpg: Signature made Fri 06 Nov 2020 01:21:34 PM UTC
gpg:                using RSA key E1558C2497CE3CCC2B5AA30F25B55FC81B7035F2
gpg: Good signature from "Stanimir Varbanov <stanimir.varbanov@linaro.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 34CF E039 8A16 AD93 18FD  D5E8 A6D0 26D8 E358 14D4
     Subkey fingerprint: E155 8C24 97CE 3CCC 2B5A  A30F 25B5 5FC8 1B70 35F2

Summary: got 0/10 patches with issues, being 0 at build time, plus one error when buinding PDF document

Error/warnings:


Error #512 when building PDF docs

