Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A7C63777
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA45E208D5
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DaR1wZtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgK0MWV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:22:21 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:33067 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbgK0MWU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Nov 2020 07:22:20 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id iclSkPsuGDuFjiclWkqkCU; Fri, 27 Nov 2020 13:22:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1606479738; bh=w4uPfS0k0L/1RE9b/G3D1XLztUH/A1T/mQc5oY0bNTc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=DaR1wZtFsXRHsgRXFRYM432qoy4SBUBtguj1OwDNRWmKV2/YyW/2Am4RiunLZM6c3
         gpeg8Ezfkz0XaBczFiJQ1Yt13izAHY3xSr6Ptisl0LAgOIDNr4g3ne6W4cxB6ATJpS
         R2T1hpID0aoy/NlHDInBi+FL503juoqLU4T83AVcqr15baSwp1ZHvSG2dKPabsJJRD
         /0SUyvuPqukwU72wOhOUDI+PzKnnZhoYF4j/GYj73wt9go/yNolY2HMhevq+XO0M6h
         5oLl73CrSstl00t44EQxMGnZbgyj/jXRFmDLUPRNmITSCf4Op5wZzNfPPghlVjMUHM
         FMXWEStdE8smg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH for v5.10 0/2] pulse8-cec: fix crash and support v12
Date:   Fri, 27 Nov 2020 13:22:12 +0100
Message-Id: <20201127122214.126701-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCI2x+FT1W3infBpAwg8JpW+78HkGwN3u+nBE7/pVkwQcrqPHbLo+ltLF4qpNzfBJNEMjxtT0JfALfBMNstKdV+jdyE9BH2izAVJzm9tlTHGq7QZuOMl
 +zY+C2JHAn/byUfhYSE+O1dpuzBrnXv0xj9gt0MgXGzqqsQZWY6CfORAR+5+sLGhxAzJTl2EgA8rPfkaok7gWllVNQ7Y2ubA3QeeU2+B/mdewHpeWvEpThrT
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The first patch fixes a nasty bug where disconnecting a Pulse-Eight
would cause a duplicate free and crash.

In addition, it turns out that Pulse-Eight has a newer firmware version
(12, but the same issue is present for any firmware >= 10) where one
message was removed. This caused the probe() to fail, and then hit
exactly the same issue with a duplicate free. Both issues are fixed in
the first patch.

The second patch adds support for FW versions >= 10 by skipping the
removed message.

Thanks to Maxime Ripard for reporting this.

Regards,

	Hans

Hans Verkuil (2):
  pulse8-cec: fix duplicate free at disconnect or probe error
  pulse8-cec: add support for FW v10 and up

 drivers/media/cec/usb/pulse8/pulse8-cec.c | 52 +++++++++++++++--------
 1 file changed, 34 insertions(+), 18 deletions(-)

-- 
2.29.2

