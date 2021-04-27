Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DBAC433B4
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 11:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E8B7613E7
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 11:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhD0LpV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 07:45:21 -0400
Received: from www.linuxtv.org ([130.149.80.248]:55480 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhD0LpU (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 07:45:20 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1lbM8q-009wz7-O1; Tue, 27 Apr 2021 11:44:36 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1lbMCx-0006KV-7v; Tue, 27 Apr 2021 11:48:51 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v5.13-rc1] media updates (#73802)
Date:   Tue, 27 Apr 2021 11:48:50 +0000
Message-Id: <20210427114850.24236-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210427133934.476f22ff@coco.lan>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20210427133934.476f22ff@coco.lan/
Build log: https://builder.linuxtv.org/job/patchwork/101573/
Build time: 00:00:00
Link: https://lore.kernel.org/linux-media/20210427133934.476f22ff@coco.lan

gpg: Signature made Tue 27 Apr 2021 11:05:20 AM UTC
gpg:                using RSA key F909AE68FC11DF09C1755C00085F3EBD8EE4E115
gpg: Good signature from "Mauro Carvalho Chehab <mchehab+huawei@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <m.chehab@samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@osg.samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@s-opensource.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab+samsung@kernel.org>" [ultimate]
gpg:                 aka "[jpeg image of size 3594]" [ultimate]


Build aborted due to a fatal error:
FAILED: patch patch patches/0001-media-colorspaces-details.rst-drop-tabularcolumns.patch doesn't apply:
Applying patch patches/0001-media-colorspaces-details.rst-drop-tabularcolumns.patch
patching file Documentation/userspace-api/media/v4l/colorspaces-details.rst
Hunk #1 FAILED at 17.
Hunk #2 FAILED at 98.
Hunk #3 FAILED at 225.
Hunk #4 FAILED at 308.
Hunk #5 FAILED at 373.
Hunk #6 FAILED at 478.
Hunk #7 FAILED at 532.
Hunk #8 FAILED at 603.
Hunk #9 FAILED at 683.
9 out of 9 hunks FAILED -- rejects in file Documentation/userspace-api/media/v4l/colorspaces-details.rst
Patch patches/0001-media-colorspaces-details.rst-drop-tabularcolumns.patch can be reverse-applied

