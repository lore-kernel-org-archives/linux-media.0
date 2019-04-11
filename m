Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D19C282DE
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2281217F4
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GSq2RutP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDKQNC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:13:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35622 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKQNC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 12:13:02 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C41631972;
        Thu, 11 Apr 2019 18:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554999180;
        bh=vKJNoAp3ytf9dXy/uv0AEcGUJ1uzTf1G4nx00woMROc=;
        h=From:To:Cc:Subject:Date:From;
        b=GSq2RutPKDpwE4x5i4hCnnmwpMeUEHzdltlGBLC0hrtf6vzuxeFf0TrM0bVi+/Ei/
         J+F6Q23HslHjor8XtnntXACEw8zwqfRZJtkyK352kVxInuwyVTjNtMv5WKsEcBSw7D
         f3093xVB7Y57kGdo4okfivb2vUYu9Wy76BNylDZM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3 0/5] media: vsp1: Phased partition overlap support
Date:   Thu, 11 Apr 2019 17:12:51 +0100
Message-Id: <20190411161256.19607-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The UDS and SRU (and SHP) require expanded partition windows to support
overlapping partition windows as a means of discarding discontinous pixel data,
due to repeated pixels in their input filters.

The first four patches are clean ups and helpers to facilitate the
implementation of an updated procedure for calculating the partition windows.

The entities are iterated first backwards through the pipeline allowing them to
request an expanded input window if needed to satisfy their required output.

Then, as only the WPF can support clipping on the left edge, (though the UDS
can clip on it's right edge) the partition window is then propagated forwards
through the entity list allowing them to update any offset which will mark left
pixels to be discarded by the WPF.

Any expanded pixels to the right edge will automatically be clipped by the WPF
as it's partition window will remain fixed.

Kieran Bingham (5):
  media: vsp1: Define partition algorithm helper
  media: vsp1: Initialise partition windows
  media: vsp1: Document partition algorithm in code header
  media: vsp1: Split out pre-filter multiplier
  media: vsp1: Provide partition overlap algorithm

 drivers/media/platform/vsp1/vsp1_entity.h |   2 +-
 drivers/media/platform/vsp1/vsp1_pipe.c   |  48 +++++++-
 drivers/media/platform/vsp1/vsp1_pipe.h   |   7 ++
 drivers/media/platform/vsp1/vsp1_rpf.c    |  10 +-
 drivers/media/platform/vsp1/vsp1_sru.c    |  38 +++++-
 drivers/media/platform/vsp1/vsp1_uds.c    | 137 +++++++++++++++++++---
 drivers/media/platform/vsp1/vsp1_video.c  |  13 +-
 drivers/media/platform/vsp1/vsp1_wpf.c    |  16 ++-
 8 files changed, 241 insertions(+), 30 deletions(-)

-- 
2.19.1

