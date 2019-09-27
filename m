Return-Path: <SRS0=mTxV=XW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABACC4360C
	for <linux-media@archiver.kernel.org>; Fri, 27 Sep 2019 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA85217D9
	for <linux-media@archiver.kernel.org>; Fri, 27 Sep 2019 14:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfI0O5P (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:57:15 -0400
Received: from www.linuxtv.org ([130.149.80.248]:47392 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfI0O5P (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Sep 2019 10:57:15 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iDrgF-0006Im-TH; Fri, 27 Sep 2019 14:57:12 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1iDrgZ-0008RJ-53; Fri, 27 Sep 2019 14:57:31 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.5] Various fixes/enhancements
Date:   Fri, 27 Sep 2019 14:57:31 +0000
Message-Id: <20190927145731.32400-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <e99ce728-5571-b043-c6c7-3d6d96c35870@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58972/
Build log: https://builder.linuxtv.org/job/patchwork/17976/
Build time: 00:13:18
Link: https://lore.kernel.org/linux-media/e99ce728-5571-b043-c6c7-3d6d96c35870@xs4all.nl

gpg: Signature made Fri 27 Sep 2019 02:27:33 PM UTC
gpg:                using RSA key AAA7FFBA4D2D77EF4CAEA1421326E0CD23ABDCE5
gpg: Good signature from "Hans Verkuil <hverkuil-cisco@xs4all.nl>" [unknown]
gpg:                 aka "Hans Verkuil <hverkuil@xs4all.nl>" [full]

Summary: 3 patches and/or PDF generation with issues, being 0 at build time

Error/warnings:

patches/0012-media-mtk-vcodec-vdec-clean-up-vidioc_vdec_s_fmt-a-b.patch:44: CHECK: Comparison to NULL could be written "!fmt"

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0012-media-mtk-vcodec-vdec-clean-up-vidioc_vdec_s_fmt-a-b.patch
patches/0013-media-vim2m-Fix-BUG_ON-in-vim2m_device_release.patch:7: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0013-media-vim2m-Fix-BUG_ON-in-vim2m_device_release.patch
patches/0027-media-hantro-h264-Fix-the-frame_num-wraparound-case.patch:67: WARNING: line over 80 characters

Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0027-media-hantro-h264-Fix-the-frame_num-wraparound-case.patch

