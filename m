Return-Path: <SRS0=nexb=Z4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A36C43603
	for <linux-media@archiver.kernel.org>; Fri,  6 Dec 2019 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4EF206DB
	for <linux-media@archiver.kernel.org>; Fri,  6 Dec 2019 11:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ntmqAC3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLFL0Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:26:16 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:59555 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfLFL0Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 6 Dec 2019 06:26:16 -0500
Received: from [192.168.2.10] ([82.164.86.234])
        by smtp-cloud7.xs4all.net with ESMTPA
        id dBkOidZotU9wBdBkRi16PZ; Fri, 06 Dec 2019 12:26:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1575631574; bh=NyTQK/xCUzmCnYiy31ummh54q3iWHq/KGxvmuWlpkk4=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ntmqAC3/Uhi5qI/IqOZQS4+jfAXYxNVDJeMGCwP9MjHk746585cK/WlBb+nHoazWk
         2no352hzdHR52idnEBloNGNNG9ZeRZII49idEMY3ekfS6QaZhTCnJuX71rvVz21Zqe
         VNW/yPBQ5kRNd+zwx+eKXEF+LEDdEcvg8ft6gGOo6FYw3qE8YPnvESNgiGlOJyjKqs
         D4ULbMoGqnO2n9Gk93xAw3RsEensOO0hRbQ7oKQY09HkXbS/h4toTNG4F/Q2zycygv
         S/yzzyM1ddQbBmOaa4//tS/54KGMAdtr7us7d0s3LBgwWmUT09C9O2bbxvxlzXMX/O
         cYeHTB6UxvqGg==
To:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] drm/Kconfig: add missing 'depends on DRM' for DRM_DP_CEC
Message-ID: <489bdaae-9b05-2d70-12e1-4fda7899dfc1@xs4all.nl>
Date:   Fri, 6 Dec 2019 12:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFh5ml02Rn9H1tnBYK3P+mBmqyl1VoFSv4YIDM+MdUPd698LB4JOYzMZWuEqBjufU75R1xzHUj43K9TK+FMsIQle3wLJTaKFGBsWyRFRtRPo7OpVvOhZ
 ZqGS4WtBMGCi3lo//cAqQVYANl4pbjY6xyEfa0d3N26wr9VjQ64Efwgm6t/zkDpQ07RAzsfSsBndxBaHwANBtmNTKwBEcGiXYludmibTc7AiBOETzmnPlOHv
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add a missing 'depends on DRM' for the DRM_DP_CEC config
option. Without that enabling DRM_DP_CEC will force CEC_CORE
to =y instead of =m if DRM=m as well.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1168351267fd..e8e478d6da9c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -163,6 +163,7 @@ config DRM_LOAD_EDID_FIRMWARE

 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
+	depends on DRM
 	select CEC_CORE
 	help
 	  Choose this option if you want to enable HDMI CEC support for
