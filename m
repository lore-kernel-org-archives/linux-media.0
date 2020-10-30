Return-Path: <SRS0=wnq3=EF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E6C00A89
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA920756
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 12:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgJ3Mnk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:43:40 -0400
Received: from www.linuxtv.org ([130.149.80.248]:36244 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgJ3Mnk (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Oct 2020 08:43:40 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kYTkp-007Eyj-1k; Fri, 30 Oct 2020 12:43:39 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kYTnl-00056k-W8; Fri, 30 Oct 2020 12:46:42 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.11] More fixes (#68447)
Date:   Fri, 30 Oct 2020 12:46:41 +0000
Message-Id: <20201030124641.19593-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7f665b32-c800-abed-b874-8083c55f1c5e@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/7f665b32-c800-abed-b874-8083c55f1c5e@xs4all.nl/
Build log: https://builder.linuxtv.org/job/patchwork/74832/
Build time: 00:05:16
Link: https://lore.kernel.org/linux-media/7f665b32-c800-abed-b874-8083c55f1c5e@xs4all.nl

gpg: Signature made Fri 30 Oct 2020 12:25:57 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]
gpg: Note: This key has expired!
Primary key fingerprint: 052C DE7B C215 053B 689F  1BCA BD2D 6148 6614 3B4C
     Subkey fingerprint: AAA7 FFBA 4D2D 77EF 4CAE  A142 1326 E0CD 23AB DCE5

Summary: got 0/7 patches with issues, being 0 at build time, plus one error when buinding PDF document

Error/warnings:


Error #512 when building PDF docs

