Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270EC433B4
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B81D61354
	for <linux-media@archiver.kernel.org>; Mon, 19 Apr 2021 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhDSTXf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:23:35 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40385 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhDSTXe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Apr 2021 15:23:34 -0400
X-Originating-IP: 24.194.32.49
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B202B60008;
        Mon, 19 Apr 2021 19:23:01 +0000 (UTC)
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Martiros Shakhzadyan <vrzh@vrzh.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 0/8] staging: media: atomisp: A series of cleanup
Date:   Mon, 19 Apr 2021 15:25:54 -0400
Message-Id: <20210419192602.498815-1-vrzh@vrzh.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following set of patches for sh_css.c resolves all coding style
errors and a number of warnings/checks.

Martiros Shakhzadyan (8):
  staging: media: atomisp: Fix the rest of sh_css.c brace issues
  staging: media: atomisp: Remove all redundant assertions in sh_css.c
  staging: media: atomisp: Remove a superfluous else clause in sh_css.c
  staging: media: atomisp: Replace goto with immediate return in
    sh_css_pipe_get_grid_info()
  staging: media: atomisp: Refactor ia_css_stream_load()
  staging: media: atomisp: Replace if else clause with a ternary
  staging: media: atomisp: Fix line split style issues
  staging: media: atomisp: Fix alignment and line length issues

 drivers/staging/media/atomisp/pci/sh_css.c | 1850 +++++++++-----------
 1 file changed, 866 insertions(+), 984 deletions(-)

-- 
2.31.1

