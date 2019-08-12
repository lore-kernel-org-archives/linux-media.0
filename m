Return-Path: <SRS0=7F4W=WI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340EDC31E40
	for <linux-media@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0840C206C2
	for <linux-media@archiver.kernel.org>; Mon, 12 Aug 2019 13:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHLN5q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:57:46 -0400
Received: from www.linuxtv.org ([130.149.80.248]:41642 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfHLN5q (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Aug 2019 09:57:46 -0400
Received: from builder.linuxtv.org ([140.211.167.10])
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hxApM-00060q-PA; Mon, 12 Aug 2019 13:57:36 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxtv.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1hxApM-00042n-Hv; Mon, 12 Aug 2019 13:57:36 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab+samsung@kernel.org,
        linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.4] Fix dma_mask for omap_vout
Date:   Mon, 12 Aug 2019 13:57:34 +0000
Message-Id: <20190812135734.15503-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d8972207-52e0-76af-4226-d276c649b434@xs4all.nl>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/58083/
Build log: https://builder.linuxtv.org/job/patchwork/7203/
Build time: 00:02:16
Link: https://lore.kernel.org/linux-media/d8972207-52e0-76af-4226-d276c649b434@xs4all.nl
Summary: 0 issues, being 0 build regressions
