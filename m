Return-Path: <SRS0=3WN/=YJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D56EFA372A
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6935720650
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbfJPKDx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:03:53 -0400
Received: from www.linuxtv.org ([130.149.80.248]:44404 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbfJPKDw (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Oct 2019 06:03:52 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iKg9h-00029Y-NB; Wed, 16 Oct 2019 10:03:45 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iKgA8-0005NR-MF; Wed, 16 Oct 2019 10:04:13 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.5] uvcvideo and omap4iss fixes
Date:   Wed, 16 Oct 2019 10:04:12 +0000
Message-Id: <20191016100412.20628-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016095738.GB5175@pendragon.ideasonboard.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/59497/
Build log: https://builder.linuxtv.org/job/patchwork/20659/
Build time: 00:03:57
Link: https://lore.kernel.org/linux-media/20191016095738.GB5175@pendragon.ideasonboard.com

gpg: Signature made Wed 16 Oct 2019 09:56:09 AM UTC
gpg:                using RSA key BD94648A8E47ECEDBF199B1862255D299E280B24
gpg:                issuer "laurent.pinchart@ideasonboard.com"
gpg: Good signature from "Laurent Pinchart <laurent.pinchart@ideasonboard.com>" [full]

Summary: no issues
