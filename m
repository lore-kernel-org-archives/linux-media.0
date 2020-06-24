Return-Path: <SRS0=XVSF=AF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFBC433E0
	for <linux-media@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC19206F7
	for <linux-media@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgFXPy2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:54:28 -0400
Received: from www.linuxtv.org ([130.149.80.248]:54996 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403931AbgFXPy1 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Jun 2020 11:54:27 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jo7f8-007iJn-Sj; Wed, 24 Jun 2020 15:50:10 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jo7lT-0001zA-6t; Wed, 24 Jun 2020 15:56:43 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.9] Add Chrontel ch7322 CEC adapter driver (#64883)
Date:   Wed, 24 Jun 2020 15:56:43 +0000
Message-Id: <20200624155643.7581-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <eecb9151-2e7d-7d90-010d-dab6fc42307f@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/64883/
Build log: https://builder.linuxtv.org/job/patchwork/56820/
Build time: 00:08:54
Link: https://lore.kernel.org/linux-media/eecb9151-2e7d-7d90-010d-dab6fc42307f@xs4all.nl

gpg: Signature made Wed 24 Jun 2020 03:23:02 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
