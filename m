Return-Path: <SRS0=qt09=DT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E2C433E7
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DB72076D
	for <linux-media@archiver.kernel.org>; Mon, 12 Oct 2020 18:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404175AbgJLSEq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:04:46 -0400
Received: from retiisi.eu ([95.216.213.190]:45572 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404156AbgJLSEq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:46 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1002])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id C9367634C87;
        Mon, 12 Oct 2020 21:03:38 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     Tsuchiya Yuto <kitakar@gmail.com>, bingbu.cao@intel.com,
        Yong Zhi <yong.zhi@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 8/8] ipu3-cio2: Remove traces of returned buffers
Date:   Mon, 12 Oct 2020 21:04:14 +0300
Message-Id: <20201012180414.11579-9-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201012180414.11579-1-sakari.ailus@linux.intel.com>
References: <20201012180414.11579-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

If starting a video buffer queue fails, the buffers are returned to
videobuf2. Remove the reference to the buffer from driver's queue as well.

Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org # v4.16 and up
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index d9baa8bfe54f..51c4dd6a8f9a 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -791,6 +791,7 @@ static void cio2_vb2_return_all_buffers(struct cio2_queue *q,
 			atomic_dec(&q->bufs_queued);
 			vb2_buffer_done(&q->bufs[i]->vbb.vb2_buf,
 					state);
+			q->bufs[i] = NULL;
 		}
 	}
 }
-- 
2.27.0

