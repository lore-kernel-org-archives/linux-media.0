Return-Path: <SRS0=yRRj=YQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02133CA9EB6
	for <linux-media@archiver.kernel.org>; Wed, 23 Oct 2019 08:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37602084C
	for <linux-media@archiver.kernel.org>; Wed, 23 Oct 2019 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfJWIbm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:31:42 -0400
Received: from www.linuxtv.org ([130.149.80.248]:35605 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390082AbfJWIbm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Oct 2019 04:31:42 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iNC3M-0006ph-Pp; Wed, 23 Oct 2019 08:31:36 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iNC3r-0004Ua-U2; Wed, 23 Oct 2019 08:32:08 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.5] vimc fixes and enhancements
Date:   Wed, 23 Oct 2019 08:32:07 +0000
Message-Id: <20191023083207.17227-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <a4f86608-3ad9-a57b-e399-ed3f1078a0ab@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/59601/
Build log: https://builder.linuxtv.org/job/patchwork/21656/
Build time: 00:11:57
Link: https://lore.kernel.org/linux-media/a4f86608-3ad9-a57b-e399-ed3f1078a0ab@xs4all.nl

gpg: Signature made Wed 23 Oct 2019 07:37:59 AM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: no issues
