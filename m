Return-Path: <SRS0=A+9d=WF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C2C31E40
	for <linux-media@archiver.kernel.org>; Fri,  9 Aug 2019 11:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47FF2084D
	for <linux-media@archiver.kernel.org>; Fri,  9 Aug 2019 11:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406507AbfHILkg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:40:36 -0400
Received: from www.linuxtv.org ([130.149.80.248]:42219 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406388AbfHILkg (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 9 Aug 2019 07:40:36 -0400
Received: from 140-211-167-10-openstack.osuosl.org ([140.211.167.10] helo=builder.linuxtv.org)
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hw3G4-00045u-9X; Fri, 09 Aug 2019 11:40:32 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hw3Fy-000727-1E; Fri, 09 Aug 2019 11:40:27 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v5.3-rc4] media fixes
Date:   Fri,  9 Aug 2019 11:40:25 +0000
Message-Id: <20190809114025.26710-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809083410.3997c6b5@coco.lan>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58047/
Build log: https://builder.linuxtv.org/job/patchwork/5018/
Build time: 00:03:10
Link: https://lore.kernel.org/linux-media/r/20190809083410.3997c6b5@coco.lan
Summary: 1 issues, being 0 build regressions

Error/warnings:

patches/0001-media-vivid-fix-missing-cec-adapter-name.patch:6: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
patches/0001-media-vivid-fix-missing-cec-adapter-name.patch:61: WARNING: Missing Signed-off-by: line by nominal patch author 'Hans Verkuil <hverkuil@xs4all.nl>'

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0001-media-vivid-fix-missing-cec-adapter-name.patch

