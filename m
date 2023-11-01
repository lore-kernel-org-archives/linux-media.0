Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8908BC4332F
	for <linux-media@archiver.kernel.org>; Wed,  1 Nov 2023 13:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjKANOH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 1 Nov 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbjKANOG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 1 Nov 2023 09:14:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37451F4;
        Wed,  1 Nov 2023 06:14:01 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A68F8D;
        Wed,  1 Nov 2023 14:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698844422;
        bh=WeazysA2wZwO1k2cdJi8Xprj7J2sH0wuGVkt5qnZ4No=;
        h=From:To:Cc:Subject:Date:From;
        b=gnMUe8Ny1GFV6OP1eWkV4mqJ9gtaNaeM1B/Gq9UjoPzQIjwtOGlUBOKnt5yKpexYZ
         1BUAODX10PvD1Cy5by48g293yeHQ5bw6EA9/CyBP1bOAaTiIaRky0dnVWqyevgWjmM
         0YhnQh49OU2biciR9gj6L4PHdMTx1uNitlm6tCI8=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v2 0/6] media: Sony IMX335 improvements
Date:   Wed,  1 Nov 2023 13:13:48 +0000
Message-Id: <20231101131354.2333498-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Sony IMX335 is not yet compatible with libcamera, as it is missing
the get selection API call.

It also misses a way to describe how to power on the sensor.

Now that I've got this camera functioning on Debix-SOM and Pi5, I expect
to be able to do quite a bit more cleanup to the code here. But these
patches should already be valid for consideration.

The series provides the bindings required to reference the power
supplies, and then performs some initial clean up to the driver for
error reporting before adding the regulator enablement, implementing the
get_selection api (as well as set selection, which returns the static
configuration) and restricts the hblanking to match the configuration.

v2:
 - Supplies are no longer 'required'
 - media: i2c: imx335: Fix logging line endings - New patch
 - line endings are fixed
 - error paths are handled for the regulator in imx335_power_on
 - set_selection is defined alongside get_selection


Kieran Bingham (6):
  media: dt-bindings: media: imx335: Add supply bindings
  media: i2c: imx335: Fix logging line endings
  media: i2c: imx335: Improve configuration error reporting
  media: i2c: imx335: Enable regulator supplies
  media: i2c: imx335: Implement get selection API
  media: i2c: imx335: Fix hblank min/max values

 .../bindings/media/i2c/sony,imx335.yaml       |  13 ++
 drivers/media/i2c/imx335.c                    | 135 ++++++++++++++----
 2 files changed, 122 insertions(+), 26 deletions(-)

-- 
2.34.1

