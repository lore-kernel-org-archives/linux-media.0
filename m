Return-Path: <SRS0=VeA5=3C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FAC33CAD
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 12:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A412084D
	for <linux-media@archiver.kernel.org>; Mon, 13 Jan 2020 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMMVg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:21:36 -0500
Received: from www.linuxtv.org ([130.149.80.248]:33688 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgAMMVg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jan 2020 07:21:36 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iqyhy-007VSo-K0; Mon, 13 Jan 2020 12:20:38 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iqyjx-0005FM-9u; Mon, 13 Jan 2020 12:22:41 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.6] Various fixes
Date:   Mon, 13 Jan 2020 12:22:41 +0000
Message-Id: <20200113122241.20127-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <da873712-6eda-e564-6f3b-efb09d6a64f5@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61151/
Build log: https://builder.linuxtv.org/job/patchwork/33479/
Build time: 00:02:32
Link: https://lore.kernel.org/linux-media/da873712-6eda-e564-6f3b-efb09d6a64f5@xs4all.nl

gpg: Signature made Mon 13 Jan 2020 12:16:50 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
