Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA0C433DB
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F36B2064C
	for <linux-media@archiver.kernel.org>; Tue, 12 Jan 2021 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbhALKBP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:01:15 -0500
Received: from www.linuxtv.org ([130.149.80.248]:40582 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhALKBP (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 12 Jan 2021 05:01:15 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kzGTZ-00BTyW-QL; Tue, 12 Jan 2021 10:00:33 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1kzGX0-0004np-1S; Tue, 12 Jan 2021 10:04:06 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT FIXES FOR v5.11] Revert "media: videobuf2: Fix length check for (#70669)
Date:   Tue, 12 Jan 2021 10:04:05 +0000
Message-Id: <20210112100405.18420-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <226e167d-6a3d-ed39-673e-6dcc9db2c9fb@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/226e167d-6a3d-ed39-673e-6dcc9db2c9fb@xs4all.nl/
Build log: https://builder.linuxtv.org/job/patchwork/85451/
Build time: 00:02:34
Link: https://lore.kernel.org/linux-media/226e167d-6a3d-ed39-673e-6dcc9db2c9fb@xs4all.nl

gpg: Signature made Tue 12 Jan 2021 09:20:52 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]
gpg: Note: This key has expired!
Primary key fingerprint: 052C DE7B C215 053B 689F  1BCA BD2D 6148 6614 3B4C
     Subkey fingerprint: AAA7 FFBA 4D2D 77EF 4CAE  A142 1326 E0CD 23AB DCE5

Summary: got 0/1 patches with issues, being 0 at build time, plus one error when buinding PDF document

Error/warnings:


Error #512 when building PDF docs

