Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6995AEB64DA
	for <linux-media@archiver.kernel.org>; Mon, 10 Jul 2023 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjGJPxX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 10 Jul 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjGJPxR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 10 Jul 2023 11:53:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91735172C
        for <linux-media@vger.kernel.org>; Mon, 10 Jul 2023 08:52:55 -0700 (PDT)
Received: from uno.LocalDomain (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B1A6BEB;
        Mon, 10 Jul 2023 17:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689004287;
        bh=uES8qlX4nXchcqaLuHhqALkmv28PutRWH6VcEL0oLTo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ay6v5ola5M59G8JMlkhOY1CTJQ8On0kUWenC2S7q52GdTNeybeNqgipMhUYFh3TML
         aHoIIt6cOtiBLuaZmbcUrlUKinJOB0m6jx89riSPu+OuZmRSJwQ2dN79gfbUeOdmHk
         fGeYta7JKxLA5nfNOLFjyWIoiE+ikgq+UAKRiUoU=
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: [PATCH v2 0/7] media: i2c: imx219: Use subdev active state
Date:   Mon, 10 Jul 2023 17:51:56 +0200
Message-Id: <20230710155203.92366-1-jacopo.mondi@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,
   this series ports the imx219 to use the subdev active state with great
simplification of format handling, locking and device initialization.

It resumes the work started by Jean-Michel but had to be ported to the new API
and applied on the most recent version of the sensor driver.

Tested with libcamera, by streaming in 1080p, VGA applying V/H flips to make
sure the mbus code permutation handling is still correct.

Thanks
   j

v1->v2:
- Two additional patches to fix colorspace handling a suggested by Laurent

Jacopo Mondi (5):
  media: i2c: imx219: Complete default format initialization
  media: i2c: imx219: Fix colorspace info
  media: i2c: imx219: Use subdev active state
  media: i2c: imx219: Simplify format assignment
  media: i2c: imx219: Simplify code handling in s_fmt

Jean-Michel Hautbois (2):
  media: i2c: imx219: Rename mbus codes array
  media: i2c: imx219: Switch from open to init_cfg

 drivers/media/i2c/imx219.c | 292 ++++++++++++-------------------------
 1 file changed, 93 insertions(+), 199 deletions(-)

--
2.40.1

