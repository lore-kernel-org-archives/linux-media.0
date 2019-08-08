Return-Path: <SRS0=C8kz=WE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD838C0650F
	for <linux-media@archiver.kernel.org>; Thu,  8 Aug 2019 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A32173E
	for <linux-media@archiver.kernel.org>; Thu,  8 Aug 2019 15:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbfHHPqA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:46:00 -0400
Received: from www.linuxtv.org ([130.149.80.248]:38524 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbfHHPqA (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 8 Aug 2019 11:46:00 -0400
Received: from 140-211-167-10-openstack.osuosl.org ([140.211.167.10] helo=builder.linuxtv.org)
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hvkbv-00077D-Ea; Thu, 08 Aug 2019 15:45:51 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxdvb.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hvkbx-0003ZL-Ue; Thu, 08 Aug 2019 15:45:54 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v5.3-rc4] media fixes
Date:   Thu,  8 Aug 2019 15:45:53 +0000
Message-Id: <20190808154553.13677-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808123943.1551193d@coco.lan>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58037/
Build log: https://builder.linuxtv.org/job/patchwork/4527/
Build time: 00:04:25

Summary: 1 issues, being 0 build regressions

Error/warnings:

patches/0001-media-vivid-fix-missing-cec-adapter-name.patch:6: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
patches/0001-media-vivid-fix-missing-cec-adapter-name.patch:61: WARNING: Missing Signed-off-by: line by nominal patch author 'Hans Verkuil <hverkuil@xs4all.nl>'

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0001-media-vivid-fix-missing-cec-adapter-name.patch

