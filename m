Return-Path: <SRS0=Yp04=2C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6637EC43603
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 08:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F84214AF
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 08:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfLLItm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:49:42 -0500
Received: from www.linuxtv.org ([130.149.80.248]:45274 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfLLItm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Dec 2019 03:49:42 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ifK9x-009rXC-Hj; Thu, 12 Dec 2019 08:49:21 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1ifKB7-0006rY-T9; Thu, 12 Dec 2019 08:50:34 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT FIXES FOR v5.5] cec: four fixes
Date:   Thu, 12 Dec 2019 08:50:33 +0000
Message-Id: <20191212085033.26339-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d12cd8de-0ee0-7f8a-c970-bda9949b3d84@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/60680/
Build log: https://builder.linuxtv.org/job/patchwork/28856/
Build time: 00:00:00
Link: https://lore.kernel.org/linux-media/d12cd8de-0ee0-7f8a-c970-bda9949b3d84@xs4all.nl

Build aborted due to a fatal error:
FAILED: can't fetch patches from 2099ef02c6c024751e4d16ace67dd6b910c875e4 to fea8ea467c7d488dd5c2448dc2d0f1fe57b6064e
