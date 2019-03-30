Return-Path: <SRS0=IMFm=SB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1261FC43381
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71572146F
	for <linux-media@archiver.kernel.org>; Sat, 30 Mar 2019 20:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyexrZZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfC3Upp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:45:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34734 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Upo (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 30 Mar 2019 16:45:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so12282484wmc.1
        for <linux-media@vger.kernel.org>; Sat, 30 Mar 2019 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7ulS7YQWCa4dNwzy2Y7Z9HEnbe9QnvEALJ/junLalCU=;
        b=NyexrZZC62a/KVb4Oku8hXvPEGn/p+S5Wv4qc66Ks6vyf8hbirJLskThgdHpfkq0RK
         TlMT2EfkViyPhtfRw6mg2jATY7koWxMYhq3eEdKKs8JkIak4L0M+L35ktmxutNMtXFHO
         ra8CAUfAkcAcc9Gatjqle4+vy0FHzPXrCBSXavXSvDcJbM5jwY2qDBMq6v7I+I5MYL+F
         bz0WcgvC2k2GTTQAgaG4Fm18KGbUtoEw7X+nih4Mz06k3HXQ6jrlSUbrV0kLg/U5jLzx
         /Cb6o8uBPoAE1zsKa8oXkeunIwLcg5HKnmaIqgpWbZOTRzG9a2r+hsk9Dy9EhZxcmzQM
         /3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ulS7YQWCa4dNwzy2Y7Z9HEnbe9QnvEALJ/junLalCU=;
        b=CazwJAdSyxDvh3fnKBYI75DvccR1JTVbOFxW2c3qtFXlUPPRgyOf6v79OgfWdJjz7M
         LmysAgupBRA1xMz2GSMCw1Ps7FiX+qMpmdZE9A+KT2dRF6zHc+IpsyO5yEgpPJsHfL44
         pnhZyoSsO3OIejlzD6ndnLrLKkkwwM8NFrmAA2NR4IcdPysuH+j/4B5gEDmx9cTjrV2O
         xALNFtpSBCAWXhxIwG4d7uRZ8auJzG4eTWE560kd/XGuFvOIGbsCRbF9S6XRI1+Ndn8g
         5nGCsuucZgb6d2vBrDY3DyYmbQWf7aNiv0lJG/5dhOjtrv4lXBn1DlR8v7NBRrZuFSju
         Gq6w==
X-Gm-Message-State: APjAAAVb2FVl0xyFuocRoI1Q6V6nu5QBoi6zVyIGMpoR74DN+c5ac3bO
        i4DSW3LG8j/J+RDhkQBWb6hZxLq51kI=
X-Google-Smtp-Source: APXvYqwtdbw0gbLCjIdQnukkVLY1OMqzPZKIQMM6cMtR+6qGVMrvLzdvHnqvTWxcOsNWqPzkFCzKGg==
X-Received: by 2002:a7b:cc19:: with SMTP id f25mr7691560wmh.8.1553978742801;
        Sat, 30 Mar 2019 13:45:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id a9sm5903671wmb.30.2019.03.30.13.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 13:45:42 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>
Subject: [PATCH 00/14] add support for stateless encoder
Date:   Sat, 30 Mar 2019 13:42:58 -0700
Message-Id: <20190330204311.107417-1-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

patches 9-13 are new,

Dafna Hirschfeld (6):
  media: vicodec: don't test if info is NULL
  media: vicodec: add field 'dev_inst' to vicodec_ctx
  media: vicodec: Register another node for stateless encoder
  media: vicodec: set pixelformat V4L2_PIX_FMT_FWHT_STATELESS for
    stateless encoder
  media: vicodec: Add support for stateless encoder
  prints

Hans Verkuil (8):
  kernel/sysctl.c: bug fix
  vicodec: always return a valid format.
  vicodec: pass on enc output format to capture side
  vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
  videobuf2-v4l2: set last_buffer_dequeued in dqbuf
  vicodec: improve handling of ENC_CMD_STOP/START
  vicodec: restrict decoder format list when src fmt is known
  vicodec: fix vicodec_buf_queue()

 .../media/common/videobuf2/videobuf2-v4l2.c   |  10 +-
 drivers/media/media-request.c                 |   3 +
 drivers/media/platform/vicodec/codec-fwht.c   |  25 +
 drivers/media/platform/vicodec/codec-fwht.h   |   2 +
 .../media/platform/vicodec/codec-v4l2-fwht.c  |  63 ++-
 drivers/media/platform/vicodec/vicodec-core.c | 497 +++++++++++++-----
 drivers/media/v4l2-core/v4l2-ctrls.c          |  57 +-
 kernel/sysctl.c                               |   2 +-
 8 files changed, 507 insertions(+), 152 deletions(-)

-- 
2.17.1

