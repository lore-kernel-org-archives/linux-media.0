Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59764CD68E0
	for <linux-media@archiver.kernel.org>; Tue, 10 Oct 2023 00:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379277AbjJJAvm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 9 Oct 2023 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379283AbjJJAvj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 9 Oct 2023 20:51:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B429A9;
        Mon,  9 Oct 2023 17:51:35 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E0F533D9;
        Tue, 10 Oct 2023 02:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696899092;
        bh=Zy8VCT+SRDvV4AB+75gEwkARzmfGl66VR2su70NKDD4=;
        h=From:To:Cc:Subject:Date:From;
        b=FnyVJiJNzV0zZ51rMjrRQoTaGbSHXsD57rmTV/2eq+ukvJrQpg0hEp5jtMDlwgoEJ
         Tx6M4z+4zTTQUqnOZllHCfSN/1FLWHyigdHiyrRy56EALvgKLh2WCsH2NxfiraPFkg
         QkzSweDTM3Z+xzac7KqdIaXwM33vWdazVqQrnpms=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH 0/5] media: Sony IMX335 improvements
Date:   Tue, 10 Oct 2023 01:51:21 +0100
Message-Id: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
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


Kieran Bingham (5):
  media: dt-bindings: media: imx335: Add supply bindings
  media: i2c: imx335: Enable regulator supplies
  media: i2c: imx335: Implement get selection API
  media: i2c: imx335: Fix hblank min/max values
  media: i2c: imx335: Improve configuration error reporting

 .../bindings/media/i2c/sony,imx335.yaml       | 16 ++++
 drivers/media/i2c/imx335.c                    | 95 ++++++++++++++++++-
 2 files changed, 106 insertions(+), 5 deletions(-)

-- 
2.34.1

