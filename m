Return-Path: <SRS0=7WK4=XA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F292CC3A5A5
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB222BEF
	for <linux-media@archiver.kernel.org>; Thu,  5 Sep 2019 08:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfIEInZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:43:25 -0400
Received: from www.linuxtv.org ([130.149.80.248]:41589 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfIEInZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 5 Sep 2019 04:43:25 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i5nMO-00049D-UQ; Thu, 05 Sep 2019 08:43:21 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i5nMY-0005cz-RD; Thu, 05 Sep 2019 08:43:30 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT FIXES FOR v5.3] Fix nasty videobuf poll regression
Date:   Thu,  5 Sep 2019 08:43:30 +0000
Message-Id: <20190905084330.21592-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <55501135-128f-f715-4608-07de0b8c46a1@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58578/
Build log: https://builder.linuxtv.org/job/patchwork/14773/
Build time: 00:03:04
Link: https://lore.kernel.org/linux-media/55501135-128f-f715-4608-07de0b8c46a1@xs4all.nl

gpg: Signature made Thu 05 Sep 2019 08:26:31 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
