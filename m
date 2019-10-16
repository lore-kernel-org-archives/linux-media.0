Return-Path: <SRS0=3WN/=YJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD25FA372A
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340A92168B
	for <linux-media@archiver.kernel.org>; Wed, 16 Oct 2019 13:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391984AbfJPNjY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:39:24 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:45505 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730396AbfJPNjY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Oct 2019 09:39:24 -0400
Received: from tschai.fritz.box ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id KjWGiHz9CPduvKjWKirEmL; Wed, 16 Oct 2019 15:39:22 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCHv8 0/2] drm: tda998x: use cec_notifier_conn_(un)register
Date:   Wed, 16 Oct 2019 15:39:14 +0200
Message-Id: <20191016133916.21475-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE2wvjBYiAvhFfBUXuFE0uMfRS1MwR8IivP7xwmNNc/ArZH/TjkyUtk5waN0KoBCfZzKcT5iPgx+6XudQezFQaB/S9MyqEhsb++uoaDd2B1kVEYo2sVs
 F/xRpiagZmJcyfwQwp4ka3NOP9cdsmjRLOPnlxtTFRIPE3bj0JPZsErnRUKOCg2OngAnulh2mvs5DD9iCu1/ThVD52Idx8c5gbjgMQGg3YT5yFdoRPeVfJmD
 uJuNkJoSh3IbnO67SKMI5b6u3BGSQwOP8PtN0/QTw0CezN5F4OWM4PjeE8LVvoePR71TZkmfRPYuLkf0BL2ka3NA4hMk6q7DJ4nb6pQHtmNqxsMb/KqsTeaf
 p6+Ut512G8F19k3azUMSVq3xQ7QXHg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This splits the previous v7.2 patch (1) into two parts: one that replaces
cec_notifier_get/put by cec_notifier_conn_(un)register, and one that
sets the connector info.

That second patch moves the CEC notifier code to tda998x_bridge_detach,
but Laurent is making changes in that area and prefers that this isn't
implemented yet.

But the replacement of the cec_notifier_get/put functions is something
that needs to be finished for v5.5.

By splitting this patch up I can merge the first half, but delay the
second half. This tda driver just won't be able to report the connector
information in the meantime.

Regards,

	Hans

(1) https://patchwork.linuxtv.org/patch/58464/

Dariusz Marcinkiewicz (2):
  drm: tda998x: use cec_notifier_conn_(un)register
  drm: tda998x: set the connector info

 drivers/gpu/drm/i2c/tda998x_drv.c | 38 ++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
2.23.0

