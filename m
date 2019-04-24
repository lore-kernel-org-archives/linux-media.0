Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D27C282E3
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 03:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F9920878
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 03:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jNmVM521"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDXDkz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:40:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38680 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfDXDkz (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 23:40:55 -0400
Received: from pendragon.ideasonboard.com (unknown [212.213.198.112])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A0ED5F
        for <linux-media@vger.kernel.org>; Wed, 24 Apr 2019 05:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556077253;
        bh=CzXym8bJI2uxqSHqCxj4rAEdH8vAV21nFGKqmYbwOF0=;
        h=Date:From:To:Subject:From;
        b=jNmVM521hQUCIgg+h1kTi65edIAkFyizTaoxE6Tbkv9TN4a027d6cfJ8OTVPRcB4n
         9hgnmhTVxb0zY3QxyIv3HLpeolW6aU8NYWMY0jSt83Lv8AInBuhW9b1meL7jlC1962
         P5qqLZm8q9U+cys0gFLSDOfv86eyGRJg2RM9KuBE=
Date:   Wed, 24 Apr 2019 06:40:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.2] VSP1 support for additional 4CCs
Message-ID: <20190424034043.GC4788@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

The following changes since commit a4dfc8a24796ff312d1d307e11f26f8ca466e938:

  media: MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-22 13:16:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/pinchartl/media.git tags/vsp1-next-20190424

for you to fetch changes up to f104dbce248e8f722057cf0c80a841862cee634b:

  media: vsp1: Add support for missing 16-bit RGB555 formats (2019-04-24 06:09:07 +0300)

----------------------------------------------------------------
- Support for additional 4CCs

----------------------------------------------------------------
Laurent Pinchart (6):
      v4l: Add definitions for missing 32-bit RGB formats
      v4l: Add definitions for missing 16-bit RGB4444 formats
      v4l: Add definitions for missing 16-bit RGB555 formats
      media: vsp1: Add support for missing 32-bit RGB formats
      media: vsp1: Add support for missing 16-bit RGB444 formats
      media: vsp1: Add support for missing 16-bit RGB555 formats

 Documentation/media/uapi/v4l/pixfmt-packed-rgb.rst | 436 +++++++++++++++++++++
 drivers/media/platform/vsp1/vsp1_pipe.c            |  62 +++
 include/uapi/linux/videodev2.h                     |  16 +
 3 files changed, 514 insertions(+)

-- 
Regards,

Laurent Pinchart
