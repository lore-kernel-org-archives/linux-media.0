Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664CC10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A221773
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IEVxGNjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1HIA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:08:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43678 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HIA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:08:00 -0400
Received: from pendragon.nordic-sky.finnair.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 379D354D;
        Thu, 28 Mar 2019 08:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553756878;
        bh=KfcLbxgTduGerzot0bITkuh+bn1giZd9rCNS1iQtjoA=;
        h=From:To:Cc:Subject:Date:From;
        b=IEVxGNjMzwq3ehNgRoDyemskwZUuLWJh7AKZvUQ2VWRaKwFi7uEXSiprFJMREG30d
         9ZxQfYrisDpk25CuwC4b1OmWvn5RQieC86QcYhaAIo8xnxQZAnlD2lguCwapQPUUYj
         dFuy1LUzY6sqMTRxqsYoZmiDuIfv9oIbqyUFqzIs=
From:   Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/9] R-Car DU: Add missing RGB pixel formats
Date:   Thu, 28 Mar 2019 09:07:14 +0200
Message-Id: <20190328070723.26553-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

This patch series adds support for 16 missing RGB formats to the DU
driver. To do is, the formats are first added to the VSP1 driver.
Patches 1/9 to 3/9 define those formats in the V4L2 API, patches 4/9 to
6/9 add them to the VSP driver, and patches 7/9 to 9/9 finally add them
to the DU driver.

There's nothing very special here, but those patches are likely very
error-prone due to the many instances of very similar constructs. I
would thus appreciate careful review.

The new V4L2 4CCs match (or at least should match if I haven't made any
mistake) the DRM 4CCs, but the names of the format macros differ in
order to stick to the V4L2 naming scheme.

Laurent Pinchart (9):
  v4l: Add definitions for missing 32-bit RGB formats
  v4l: Add definitions for missing 16-bit RGB4444 formats
  v4l: Add definitions for missing 16-bit RGB555 formats
  media: vsp1: Add support for missing 32-bit RGB formats
  media: vsp1: Add support for missing 16-bit RGB444 formats
  media: vsp1: Add support for missing 16-bit RGB555 formats
  drm: rcar-du: Add support for missing 32-bit RGB formats
  drm: rcar-du: Add support for missing 16-bit RGB4444 formats
  drm: rcar-du: Add support for missing 16-bit RGB1555 formats

 .../media/uapi/v4l/pixfmt-packed-rgb.rst      | 436 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |  80 ++++
 drivers/media/platform/vsp1/vsp1_pipe.c       |  70 +++
 include/uapi/linux/videodev2.h                |  16 +
 4 files changed, 602 insertions(+)

-- 
Regards,

Laurent Pinchart

