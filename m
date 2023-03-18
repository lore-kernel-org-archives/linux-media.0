Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB765C61DA4
	for <linux-media@archiver.kernel.org>; Sat, 18 Mar 2023 08:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCRIvr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 18 Mar 2023 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCRIvn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 18 Mar 2023 04:51:43 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBF392BE
        for <linux-media@vger.kernel.org>; Sat, 18 Mar 2023 01:51:29 -0700 (PDT)
Received: from builder.linuxtv.org ([140.211.167.10] helo=slave0)
        by www.linuxtv.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1pdSHe-002KVA-Sq; Sat, 18 Mar 2023 08:51:26 +0000
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by slave0 with esmtp (Exim 4.94.2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1pdSHb-00HSgu-Br; Sat, 18 Mar 2023 08:51:23 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v6.3-rc1] media updates (#90063)
Date:   Sat, 18 Mar 2023 08:51:23 +0000
Message-Id: <20230318085123.4161818-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230226114551.68480d44@coco.lan>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/project/linux-media/patch/20230226114551.68480d44@coco.lan/
Build log: https://builder.linuxtv.org/job/patchwork/290766/
Build time: 00:00:00
Link: https://lore.kernel.org/linux-media/20230226114551.68480d44@coco.lan

gpg: Signature made Sun 26 Feb 2023 10:26:24 AM UTC
gpg:                using RSA key F909AE68FC11DF09C1755C00085F3EBD8EE4E115
gpg: Good signature from "Mauro Carvalho Chehab <mchehab+huawei@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@kernel.org>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <m.chehab@samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@osg.samsung.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab@s-opensource.com>" [ultimate]
gpg:                 aka "Mauro Carvalho Chehab <mchehab+samsung@kernel.org>" [ultimate]
gpg:                 aka "[jpeg image of size 3594]" [ultimate]


Build aborted due to a fatal error:
FAILED: patch patch patches/0001-media-sun6i-csi-bridge-Error-out-on-invalid-port-to-.patch doesn't apply:
Applying patch patches/0001-media-sun6i-csi-bridge-Error-out-on-invalid-port-to-.patch
patching file drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
Hunk #1 FAILED at 663.
1 out of 1 hunk FAILED -- rejects in file drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
Patch patches/0001-media-sun6i-csi-bridge-Error-out-on-invalid-port-to-.patch can be reverse-applied

