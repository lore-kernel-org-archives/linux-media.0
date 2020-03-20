Return-Path: <SRS0=12Uk=5F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99391C4332D
	for <linux-media@archiver.kernel.org>; Fri, 20 Mar 2020 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7232820781
	for <linux-media@archiver.kernel.org>; Fri, 20 Mar 2020 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTPR2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:17:28 -0400
Received: from www.linuxtv.org ([130.149.80.248]:44516 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgCTPR2 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 20 Mar 2020 11:17:28 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jFJMi-003rUv-8U; Fri, 20 Mar 2020 15:15:16 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jFJQN-0003Xj-E6; Fri, 20 Mar 2020 15:19:03 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] snprintf fixes (#62410)
Date:   Fri, 20 Mar 2020 15:19:03 +0000
Message-Id: <20200320151903.13578-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320150221.GA22904@gofer.mess.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/62410/
Build log: https://builder.linuxtv.org/job/patchwork/43140/
Build time: 00:08:54
Link: https://lore.kernel.org/linux-media/20200320150221.GA22904@gofer.mess.org

error: FETCH_HEAD: cannot verify a non-tag object of type commit.

Summary: no issues
