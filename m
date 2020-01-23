Return-Path: <SRS0=DIJ2=3M=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC55C2D0DB
	for <linux-media@archiver.kernel.org>; Thu, 23 Jan 2020 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9D22464
	for <linux-media@archiver.kernel.org>; Thu, 23 Jan 2020 15:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWPLk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:11:40 -0500
Received: from www.linuxtv.org ([130.149.80.248]:45746 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgAWPLk (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Jan 2020 10:11:40 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iue7s-003CZY-Bq; Thu, 23 Jan 2020 15:10:32 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iueA6-0002nR-Ht; Thu, 23 Jan 2020 15:12:50 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL v2 FOR v5.7] Various fixes
Date:   Thu, 23 Jan 2020 15:12:50 +0000
Message-Id: <20200123151250.10708-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ddaec9b5-acad-6131-e8d1-60abfaef5af7@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61266/
Build log: https://builder.linuxtv.org/job/patchwork/34935/
Build time: 00:02:39
Link: https://lore.kernel.org/linux-media/ddaec9b5-acad-6131-e8d1-60abfaef5af7@xs4all.nl

gpg: Signature made Thu 23 Jan 2020 03:05:26 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
