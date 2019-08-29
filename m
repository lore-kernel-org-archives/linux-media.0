Return-Path: <SRS0=r2fB=WZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEFCC3A59F
	for <linux-media@archiver.kernel.org>; Thu, 29 Aug 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29C221726
	for <linux-media@archiver.kernel.org>; Thu, 29 Aug 2019 12:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2M0I (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:26:08 -0400
Received: from www.linuxtv.org ([130.149.80.248]:42617 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfH2M0I (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 29 Aug 2019 08:26:08 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i3JV2-0007ZV-JS; Thu, 29 Aug 2019 12:26:00 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1i3JV9-0001hF-LO; Thu, 29 Aug 2019 12:26:07 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.4] Small fixes
Date:   Thu, 29 Aug 2019 12:26:07 +0000
Message-Id: <20190829122607.6480-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7d8c241c-10a5-948a-4e0f-24962e3d7a59@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58474/
Build log: https://builder.linuxtv.org/job/patchwork/13787/
Build time: 00:05:35
Link: https://lore.kernel.org/linux-media/7d8c241c-10a5-948a-4e0f-24962e3d7a59@xs4all.nl

gpg: Signature made Thu 29 Aug 2019 12:12:37 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
