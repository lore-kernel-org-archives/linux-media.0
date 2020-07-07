Return-Path: <SRS0=sYeE=AS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D96C433E0
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1504D20738
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGRIz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:08:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35042 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGRIz (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Jul 2020 13:08:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 39A22260FA7
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     dafna.hirschfeld@collabora.com, helen.koike@collabora.com,
        ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
Subject: [PATCH 0/2] change fields of uapi struct rkisp1_cif_isp_ctk_config
Date:   Tue,  7 Jul 2020 19:08:43 +0200
Message-Id: <20200707170845.28845-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The struct rkisp1_cif_isp_ctk_config represents a 3x3 matrix
and an offset vector for the color correction. It is nicer
to represent those with a 3x3 array and a 3-array fields.

- First patch repalces 9 fields 'coeff*' with one field coeff[3][3]
- Second patch replaces 3 fields 'ct_offset_{rgb}' with one field 'ct_offset[3]'

Dafna Hirschfeld (2):
  media: staging: rkisp1:: replace 9 coeff* fields with a 3x3 array
  media: staging: rkisp1: replace 3 fields 'ct_offset_*' with one array

 drivers/staging/media/rkisp1/rkisp1-params.c  | 24 +++++++------------
 .../staging/media/rkisp1/uapi/rkisp1-config.h | 20 +++++-----------
 2 files changed, 15 insertions(+), 29 deletions(-)

-- 
2.17.1

