Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0161C64E69
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 11:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878ED2462E
	for <linux-media@archiver.kernel.org>; Wed, 18 Nov 2020 11:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgKRLie (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:38:34 -0500
Received: from retiisi.eu ([95.216.213.190]:53498 "EHLO hillosipuli.retiisi.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgKRLid (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 18 Nov 2020 06:38:33 -0500
Received: from lanttu.localdomain (lanttu.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::c1:2])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id D73BB634CD1;
        Wed, 18 Nov 2020 13:38:18 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org
Subject: [PATCH 23/29] dt-bindings: nokia,smia: Make vana-supply optional
Date:   Wed, 18 Nov 2020 13:31:05 +0200
Message-Id: <20201118113111.2548-24-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201118113111.2548-1-sakari.ailus@linux.intel.com>
References: <20201118113111.2548-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

vana-supply is optional in the spec, therefore make it optional in
bindings, too.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/i2c/nokia,smia.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
index 6c45c79ef91f..5ea4f799877b 100644
--- a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
+++ b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
@@ -16,8 +16,6 @@ Mandatory properties
 
 - compatible: "nokia,smia"
 - reg: I2C address (0x10, or an alternative address)
-- vana-supply: Analogue voltage supply (VANA), typically 2,8 volts (sensor
-  dependent).
 - clocks: External clock to the sensor
 - clock-frequency: Frequency of the external clock to the sensor
 
@@ -31,6 +29,8 @@ Optional properties
 - rotation: Integer property; valid values are 0 (sensor mounted upright)
 	    and 180 (sensor mounted upside down). See
 	    ../video-interfaces.txt .
+- vana-supply: Analogue voltage supply (VANA), typically 2,8 volts (sensor
+  dependent).
 
 
 Endpoint node mandatory properties
-- 
2.27.0

