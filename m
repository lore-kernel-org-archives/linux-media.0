Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD728C10F06
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B81C20882
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw+kVGJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCWSK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:18:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDCWSJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 3 Apr 2019 18:18:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so695079wmd.0
        for <linux-media@vger.kernel.org>; Wed, 03 Apr 2019 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ezLR53W2vosalsFwXrYxmSNyScLNXPjMdN6ybp7IoLo=;
        b=Gw+kVGJPXcJmrTwj1Qlj+9sSR9xlyZu9thOwNlKHg13fFs8+czNdOrM8RIo4Q39ThQ
         ouz6M3S5tqIOO8I7Vys0VBKm2DB+ZetWP63rg283XF2CIPF7/5VVRJttAdRZoTmXSMJU
         4j5UWbxmu7Ump8QYkZRIJXgDZWgUJT33kOU5fTjyNZaIHi2m1DQvCbyl/YjtZjqmFGQr
         xqgCVg2/6aEc0UdbGXIlhhpExnfHJngwUbzLRVH0PZuS58okOHxdYgFJ/ppp/4uj8o7s
         NjC5XO6mgKS/wiMCxW0NmEc58lqqaZG+1e+WhLhTkBbjYelduK2V1frj3+2B1nfuTHwG
         mHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ezLR53W2vosalsFwXrYxmSNyScLNXPjMdN6ybp7IoLo=;
        b=nSYBtaWDBTYOiTyxumRB2V4XRbT0m3+cNFILE8wt29O0t/JqT3ViW0ep9eX/rj9iwY
         3zSHBFTFVqRJFvaLwK0ZTf0KagTqoMc/ws3bKeJ/6F9YjaTjYj1qOhc13MCr2MlAe/jk
         b2Ym8PELbN2GpO2my249Bh/v8eaRUnTRjTbYRO+bQgFRGNa5ILRKpTuMvkZkzRXb/PsX
         klcIjlOeATUAbK/mr6cW1vpFfDTUsg8fS+yJkd6D6iGzKwyPfkUGp/mEiWbtVdHCZuuh
         D72kdEBQ9qgGYk4ZQfRMn7L+e6IOe/3fAaeDOavuN/uZWziPBzSk+T5pJvJbzFQ/gye9
         yfKA==
X-Gm-Message-State: APjAAAW9uS1EkzDdlmtLHdMPkkgGFPO9pLyIIbJ5GlUPFqCJDRWQnCvj
        i8BIG0xaxq38O8is/crslVu6ja6nOsU=
X-Google-Smtp-Source: APXvYqw+rq6IT2s/pWQpxIsTffmT9t2Y5Lxxp7r2UFeA7PP+fgR3nq6YvLUnhlg0FLRM2ujJWhbd7g==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr1638526wmf.125.1554329887593;
        Wed, 03 Apr 2019 15:18:07 -0700 (PDT)
Received: from localhost.localdomain (ip5f5ab07d.dynamic.kabel-deutschland.de. [95.90.176.125])
        by smtp.gmail.com with ESMTPSA id d6sm26019552wrx.62.2019.04.03.15.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:18:06 -0700 (PDT)
From:   Dafna Hirschfeld <dafna3@gmail.com>
To:     dafna3@gmail.com, linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, helen.koike@collabora.com
Subject: [PATCH v2 00/16] media: vicodec: adding support for stateless encoder
Date:   Wed,  3 Apr 2019 15:14:45 -0700
Message-Id: <20190403221501.32814-1-dafna3@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

patches 10-16 are new, patch 16 is experimental.
It is not yet clear how vicodec will update the
request controls so that the userspace can read it.

Dafna Hirschfeld (7):
  media: vicodec: don't test if info is NULL
  media: vicodec: change fwht_encode_frame to get the header separately
  media: vicodec: bugfix: release stateless dec m2m_dev in
    vicodec_remove
  media: vicodec: add field 'dev_inst' to vicodec_ctx
  media: vicodec: Register another node for stateless encoder
  media: vicodec: set pixelformat V4L2_PIX_FMT_FWHT_STATELESS for
    stateless encoder
  media: vicodec: Add support for stateless encoder

Hans Verkuil (9):
  videobuf2-v4l2: set last_buffer_dequeued in dqbuf
  vicodec: move v4l2_ctrl_request_complete after spin_unlock
  vicodec: always return a valid format.
  vicodec: pass on enc output format to capture side
  vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
  vicodec: improve handling of ENC_CMD_STOP/START
  vicodec: restrict decoder format list when src fmt is known
  vicodec: set KEY/PFRAME flag when decoding
  v4l2-ctrls: add v4l2_ctrl_s_ctrl_ptr()

 .../media/common/videobuf2/videobuf2-v4l2.c   |  10 +-
 .../media/platform/vicodec/codec-v4l2-fwht.c  |   9 +-
 .../media/platform/vicodec/codec-v4l2-fwht.h  |   3 +-
 drivers/media/platform/vicodec/vicodec-core.c | 463 +++++++++++++-----
 drivers/media/v4l2-core/v4l2-ctrls.c          |  11 +
 include/media/v4l2-ctrls.h                    |  42 ++
 6 files changed, 392 insertions(+), 146 deletions(-)

-- 
2.17.1

