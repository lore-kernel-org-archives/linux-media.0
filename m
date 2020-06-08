Return-Path: <SRS0=Gwua=7V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B67C433E0
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E882074B
	for <linux-media@archiver.kernel.org>; Mon,  8 Jun 2020 19:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgFHTpm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:45:42 -0400
Received: from www.linuxtv.org ([130.149.80.248]:45234 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFHTpm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Jun 2020 15:45:42 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jiNeQ-0058kM-Ma; Mon, 08 Jun 2020 19:41:42 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1jiNkM-0004Zb-H1; Mon, 08 Jun 2020 19:47:50 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.9] Various fixes (#64368)
Date:   Mon,  8 Jun 2020 19:47:50 +0000
Message-Id: <20200608194750.17538-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <04f2cd86-ddf1-dbcc-0f03-fc4b2f586ccd@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/64368/
Build log: https://builder.linuxtv.org/job/patchwork/54548/
Build time: 00:06:58
Link: https://lore.kernel.org/linux-media/04f2cd86-ddf1-dbcc-0f03-fc4b2f586ccd@xs4all.nl

gpg: Signature made Mon 08 Jun 2020 07:32:11 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 1 patches and/or PDF generation with issues, being 0 at build time
