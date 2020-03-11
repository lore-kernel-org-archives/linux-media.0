Return-Path: <SRS0=T/3t=44=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94BDC10F27
	for <linux-media@archiver.kernel.org>; Wed, 11 Mar 2020 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F66D20736
	for <linux-media@archiver.kernel.org>; Wed, 11 Mar 2020 14:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgCKOu6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:50:58 -0400
Received: from www.linuxtv.org ([130.149.80.248]:38766 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbgCKOu6 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 11 Mar 2020 10:50:58 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jC2fH-00AwRa-U0; Wed, 11 Mar 2020 14:48:55 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jC2ij-0005PY-BB; Wed, 11 Mar 2020 14:52:29 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] Various fixes (#62088)
Date:   Wed, 11 Mar 2020 14:52:29 +0000
Message-Id: <20200311145229.20759-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <bc2880a4-42b7-8dab-241f-b263b26e20e7@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/62088/
Build log: https://builder.linuxtv.org/job/patchwork/41844/
Build time: 00:02:17
Link: https://lore.kernel.org/linux-media/bc2880a4-42b7-8dab-241f-b263b26e20e7@xs4all.nl

gpg: Signature made Wed 11 Mar 2020 02:37:18 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
