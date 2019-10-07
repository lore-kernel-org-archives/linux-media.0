Return-Path: <SRS0=+Pgr=YA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A082DECE58C
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 13:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A720867
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 13:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJGNtT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:49:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58364 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfJGNtT (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 7 Oct 2019 09:49:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 634D928D580
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, andre.almeida@collabora.com,
        skhan@linuxfoundation.org, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com
Subject: [PATCH v3 0/5] media: vimc: bug fixes related to memory management
Date:   Mon,  7 Oct 2019 15:49:07 +0200
Message-Id: <20191007134912.28181-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cleanup and buf fixing patches for vimc

Changes from v2:
The head of the thirds patch is chaned to start with "media vimc: sen:"

Dafna Hirschfeld (5):
  media: vimc: initialize vim entity pointers to NULL
  media: vimc: cleanup code that assigns entity in entities array
  media: vimc: sen: register subdevice only after initialization
  media: vimc: move media_entity_cleanup to release callbacks
  media: vimc: remove the helper function vimc_ent_sd_unregister

 drivers/media/platform/vimc/vimc-capture.c |  2 +-
 drivers/media/platform/vimc/vimc-common.c  |  6 ------
 drivers/media/platform/vimc/vimc-common.h  | 12 -----------
 drivers/media/platform/vimc/vimc-core.c    | 11 ++++-------
 drivers/media/platform/vimc/vimc-debayer.c |  3 ++-
 drivers/media/platform/vimc/vimc-scaler.c  |  3 ++-
 drivers/media/platform/vimc/vimc-sensor.c  | 23 +++++++++++-----------
 7 files changed, 21 insertions(+), 39 deletions(-)

-- 
2.20.1

