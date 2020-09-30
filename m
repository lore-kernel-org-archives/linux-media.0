Return-Path: <SRS0=fdi2=DH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24460C47428
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7647221EC
	for <linux-media@archiver.kernel.org>; Wed, 30 Sep 2020 15:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgI3PaR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:30:17 -0400
Received: from retiisi.org.uk ([95.216.213.190]:44664 "EHLO
        hillosipuli.retiisi.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbgI3P3F (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 30 Sep 2020 11:29:05 -0400
Received: from lanttu.localdomain (lanttu-e.localdomain [192.168.1.64])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 379F8634C8C
        for <linux-media@vger.kernel.org>; Wed, 30 Sep 2020 18:28:48 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 021/100] dt-bindings: nokia,smia: Fix link-frequencies documentation
Date:   Wed, 30 Sep 2020 18:27:39 +0300
Message-Id: <20200930152858.8471-22-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
References: <20200930152858.8471-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The link-frequencies property belongs to the endpoint, not to the node
representing the device.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 .../devicetree/bindings/media/i2c/nokia,smia.txt          | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
index 10ece8108081..6c45c79ef91f 100644
--- a/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
+++ b/Documentation/devicetree/bindings/media/i2c/nokia,smia.txt
@@ -20,8 +20,6 @@ Mandatory properties
   dependent).
 - clocks: External clock to the sensor
 - clock-frequency: Frequency of the external clock to the sensor
-- link-frequencies: List of allowed data link frequencies. An array of
-  64-bit elements.
 
 
 Optional properties
@@ -39,6 +37,8 @@ Endpoint node mandatory properties
 ----------------------------------
 
 - data-lanes: <1..n>
+- link-frequencies: List of allowed data link frequencies. An array of
+  64-bit elements.
 
 
 Example
@@ -55,11 +55,13 @@ Example
 		clocks = <&omap3_isp 0>;
 		clock-frequency = <9600000>;
 		nokia,nvm-size = <512>; /* 8 * 64 */
-		link-frequencies = /bits/ 64 <199200000 210000000 499200000>;
 		port {
 			smiapp_ep: endpoint {
 				data-lanes = <1 2>;
 				remote-endpoint = <&csi2a_ep>;
+				link-frequencies =
+					/bits/ 64 <199200000 210000000
+						   499200000>;
 			};
 		};
 	};
-- 
2.27.0

