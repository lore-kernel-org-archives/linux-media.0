Return-Path: <SRS0=lLmD=X4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58700C10F14
	for <linux-media@archiver.kernel.org>; Thu,  3 Oct 2019 11:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369552086A
	for <linux-media@archiver.kernel.org>; Thu,  3 Oct 2019 11:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfJCLmj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:42:39 -0400
Received: from www.linuxtv.org ([130.149.80.248]:56030 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730185AbfJCLmj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 3 Oct 2019 07:42:39 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iFzVD-0004hk-Le; Thu, 03 Oct 2019 11:42:35 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iFzVa-0004xY-C8; Thu, 03 Oct 2019 11:42:58 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.5] [v2] Two cec fixes
Date:   Thu,  3 Oct 2019 11:42:58 +0000
Message-Id: <20191003114258.19023-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e19af1d9-8a06-cedf-4982-29a72d1d13fc@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/59163/
Build log: https://builder.linuxtv.org/job/patchwork/18800/
Build time: 00:02:49
Link: https://lore.kernel.org/linux-media/e19af1d9-8a06-cedf-4982-29a72d1d13fc@xs4all.nl

gpg: Signature made Thu 03 Oct 2019 11:37:30 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
