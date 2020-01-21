Return-Path: <SRS0=XjDO=3K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3840CC2D0CE
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1C92073A
	for <linux-media@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="H+Gsb1HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAUT1b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:27:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58130 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUT1b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Jan 2020 14:27:31 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37C2252A
        for <linux-media@vger.kernel.org>; Tue, 21 Jan 2020 20:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579634849;
        bh=RKgySBBga3PXLf3zhHBIi8F0rdNghd+m7RmelVJ0UL8=;
        h=Date:From:To:Subject:From;
        b=H+Gsb1HVNvX+xnIpJUxvmsF37rQsCzfTg3NhAIWPQt4/6HZF8OtWHUezN83Ts97sj
         7CrH4G73GLMQsFQd17qqN0rN7pmJrNcONNGAAO3pkJxduhsmEo2TZpncFa2bxhyVob
         4G/qUHdJR9wyTcSwevVln44b2OmoyujQDBfmoUqw=
Date:   Tue, 21 Jan 2020 21:27:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.6] uvcvideo changes
Message-ID: <20200121192713.GH5003@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

The following changes since commit 2a0a0bc7020ef7e66c9569d8229d79fa72e3d659:

  media: MAINTAINERS: add entry for Rockchip ISP1 driver (2020-01-09 16:45:01 +0100)

are available in the Git repository at:

  git://linuxtv.org/pinchartl/media.git tags/uvc-next-20200121

for you to fetch changes up to 6d45f20a0d28071944329f43f6f66e513b8ac956:

  media: uvcvideo: Add a quirk to force GEO GC6500 Camera bits-per-pixel value (2020-01-21 21:16:55 +0200)

----------------------------------------------------------------
uvcvideo changes:

- Fix a bug with malformed USB descriptors
- Support for GEO GC6500 Camera raw mode

----------------------------------------------------------------
Sergey Zakharchenko (1):
      media: uvcvideo: Add a quirk to force GEO GC6500 Camera bits-per-pixel value

Will Deacon (1):
      media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

 drivers/media/usb/uvc/uvc_driver.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 38 insertions(+)

-- 
Regards,

Laurent Pinchart
