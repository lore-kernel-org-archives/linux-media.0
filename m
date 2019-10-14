Return-Path: <SRS0=P/UY=YH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD668C4CECE
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 04:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7A520854
	for <linux-media@archiver.kernel.org>; Mon, 14 Oct 2019 04:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDnSM0Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfJNERY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Oct 2019 00:17:24 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34789 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfJNERX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Oct 2019 00:17:23 -0400
Received: by mail-oi1-f178.google.com with SMTP id 83so12671782oii.1
        for <linux-media@vger.kernel.org>; Sun, 13 Oct 2019 21:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnH/L8Rc3pfliViwaDiTJb1My3pZwZZEfA6V0vKLGx4=;
        b=JDnSM0Y7iXEKNuWhjFQceeY0wbbvM3pcb3M12eomFvUrLiOPTvZpClBPBAtFLnG3Dk
         sAEcXKQLyVEU2xzfvkqPONuL3b+d42v9bovMJWgoXJf1jjTzQQn3pN39ni+6aqIISBI7
         aKjm0stvfqYFIqEHyhPwPHX2dPzql7ytubfRq49wth26Lz80tyr1YWgHY9zDSypDEMao
         IjS9sUwiGRirmb9e+RY3T0GluNrfnilcGtrf0LG3AkpddyoeZ4DfSXla/SbhDnnUnBZA
         I0m6eJ2I8134jWBfMJoR93A/HC3KB1/Ps+iSiddAJB6KWikOboXhZjEhtz+/bCbJovcK
         GoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnH/L8Rc3pfliViwaDiTJb1My3pZwZZEfA6V0vKLGx4=;
        b=AqAwr/lqurPUJ3GKl1fbHNDF0A83Y+w4CRdz3+3md4awIyvOSzd+zBxBREmIQPt+jy
         QbCSSkJOZDYS9NCikJf+8EdYu+D8vGTci5U9LtBJXFBxsfIxy/uggMO6QIuBi5iczXDq
         uFHbXuda/6iTZLsHkLYvnSYgyGUijXVt+I8eO1cYi874uH2EL0BapM++y2mW0kyA/HaV
         WBqG5kG1YRjSuqFdySlrOPgwzL5YPSR/3tEoO4x49TzNp5P1ECWHieix85nR9ZGDsxhf
         +CP+UtwH0WgL+cy1z7jQtZwetWKKbBaMOkza1/VBlJIsSmF3u9Hk/UWwIsx8Wn+qq2UY
         7bdA==
X-Gm-Message-State: APjAAAVIneEw6vvPSLdHqL1mU3vAHQTXtMFkcNR2AoE89pMv+COfr0sa
        QOoPGIaRExyAA9oajL+/ZkfcsWDS
X-Google-Smtp-Source: APXvYqx/qNdGpnJAWvAQ60CSiAdoG2FYWqZsiBFYM/lC2R4EJ03YTYn1EYlr2/CKv0Lg77j+9bcqHw==
X-Received: by 2002:aca:4c91:: with SMTP id z139mr22127774oia.171.1571026642736;
        Sun, 13 Oct 2019 21:17:22 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::40])
        by smtp.googlemail.com with ESMTPSA id l19sm4887918oie.22.2019.10.13.21.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 21:17:22 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     hverkuil@xs4all.nl
Subject: [PATCH 0/8] cec-compliance: add digital tuner support
Date:   Sun, 13 Oct 2019 23:17:13 -0500
Message-Id: <20191014041721.52025-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch series will add digital tuner support to cec-compliance.
cec-follower support for the following digital broadcast systems:

  - ARIB-BS
  - ARIB-T
  - ATSC-SAT
  - ATSC-T
  - DVB-S2
  - DVB-T

has been added for 18 digital plus 81 analog for a total of 98 channels.
Tuner step features have been implemented to cycle through all available
channels with digital proceeding analog.  Channels will wrap on both ends.
Tuner testing will cycle through all channels and check status with tuner
select service following after.

---

Jiunn Chang (8):
  cec-follower: fix analog tuner device info update
  cec-follower: rename freq_idx to service_idx
  cec-follower: create digital ARIB channels
  cec-follower: create digital ATSC channels
  cec-follower: create digital DVB channels
  cec-follower: add tuner digital service emulation
  cec-follower: fix tuner step increment/decrement
  cec-compliance: add digital tuner control testing

 utils/cec-compliance/cec-test.cpp   |  50 +++-
 utils/cec-follower/cec-follower.cpp |   2 +-
 utils/cec-follower/cec-follower.h   |   4 +-
 utils/cec-follower/cec-tuner.cpp    | 375 ++++++++++++++++++++++++++--
 4 files changed, 400 insertions(+), 31 deletions(-)

-- 
2.23.0

