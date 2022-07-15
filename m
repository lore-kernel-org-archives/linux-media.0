Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4BDC43334
	for <linux-media@archiver.kernel.org>; Fri, 15 Jul 2022 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiGOR7t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGOR7s (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Jul 2022 13:59:48 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAE42AD0
        for <linux-media@vger.kernel.org>; Fri, 15 Jul 2022 10:59:48 -0700 (PDT)
Received: from builder.linuxtv.org ([140.211.167.10] helo=slave0)
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1oCPbO-00CHEO-Jn; Fri, 15 Jul 2022 17:59:46 +0000
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by slave0 with esmtp (Exim 4.94.2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1oCPbM-00Aeqj-BK; Fri, 15 Jul 2022 17:59:44 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL FOR v5.20] Miscellaneous uvcvideo improvements and fixes (#84898)
Date:   Fri, 15 Jul 2022 17:59:44 +0000
Message-Id: <20220715175944.2540259-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YtGA3W+wwzQIE74a@pendragon.ideasonboard.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/YtGA3W+wwzQIE74a@pendragon.ideasonboard.com/
Build log: https://builder.linuxtv.org/job/patchwork/225090/
Build time: 00:00:00
Link: https://lore.kernel.org/linux-media/YtGA3W+wwzQIE74a@pendragon.ideasonboard.com

Build aborted due to a fatal error:
FAILED: can't fetch patches from b228cf38f0b72d797fab60386da7ee935e033aac to 13fadd1df43b955d176d9039de8f6fbbf9be529c
