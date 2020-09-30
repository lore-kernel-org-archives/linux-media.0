Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD49EC4727F
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8320759
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgI3PaS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:18 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44650 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbgI3P3F (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:05 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 4832C634CA9
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:48 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 022/100] dt-bindings: nokia,smia: Make vana-supply optional
Date:   Wed, 30 Sep 2020 18:27:40 +0300
Message-Id: <20200930152858.8471-23-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

vana-supply is optional in the spec, therefore make it optional in
bindings, too.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

