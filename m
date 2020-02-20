Return-Path: <SRS0=i8LN=4I=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FFC7619D
	for <linux-media@archiver.kernel.org>; Thu, 20 Feb 2020 02:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE824656
	for <linux-media@archiver.kernel.org>; Thu, 20 Feb 2020 02:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBTCBt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:01:49 -0500
Received: from www.linuxtv.org ([130.149.80.248]:46956 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbgBTCBs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Feb 2020 21:01:48 -0500
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1j4b8L-003T17-6M; Thu, 20 Feb 2020 02:00:09 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1j4bBG-00010J-MT; Thu, 20 Feb 2020 02:03:10 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.7] VSP1 minor fix
Date:   Thu, 20 Feb 2020 02:03:10 +0000
Message-Id: <20200220020310.3808-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220014904.GG5070@pendragon.ideasonboard.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/61761/
Build log: https://builder.linuxtv.org/job/patchwork/38887/
Build time: 00:03:00
Link: https://lore.kernel.org/linux-media/20200220014904.GG5070@pendragon.ideasonboard.com

gpg: Signature made Thu 20 Feb 2020 01:46:59 AM UTC
gpg:                using RSA key BD94648A8E47ECEDBF199B1862255D299E280B24
gpg:                issuer "laurent.pinchart@ideasonboard.com"
gpg: Good signature from "Laurent Pinchart <laurent.pinchart@ideasonboard.com>" [full]

Summary: no issues
