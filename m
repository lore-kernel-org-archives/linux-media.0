Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FBC001E0
	for <linux-media@archiver.kernel.org>; Wed,  2 Aug 2023 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjHBRfF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Aug 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjHBRen (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 2 Aug 2023 13:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063801FC3
        for <linux-media@vger.kernel.org>; Wed,  2 Aug 2023 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690997479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqN0c+AcsVBq1Tmy3j1X99cRe+Uws4Ex+XR2ZdEUD28=;
        b=fXr7QH0Sxe/ZQD57EfbE3STJFujS2hiuHglJ8ejHk94ySs4B0sbaOhvoR3XMbWG2ptfQ/4
        yhi2MMaFyBHoSkUSOIh1wdbV7u+r9MOi3Ie3z65YVUfY/DZ9Yv05Vnz1LsN3F4G6X6F+kq
        nwyOQRK8Ni99f2XMfc7IxQXo5E42HHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Rm2pDrSsP06iKFV0lJ-vBA-1; Wed, 02 Aug 2023 13:31:18 -0400
X-MC-Unique: Rm2pDrSsP06iKFV0lJ-vBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5106B81D9EC;
        Wed,  2 Aug 2023 17:31:15 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7122140E949;
        Wed,  2 Aug 2023 17:31:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v4 17/32] media: ov2680: Add support for ACPI enumeration
Date:   Wed,  2 Aug 2023 19:30:31 +0200
Message-ID: <20230802173046.368434-18-hdegoede@redhat.com>
In-Reply-To: <20230802173046.368434-1-hdegoede@redhat.com>
References: <20230802173046.368434-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add an acpi_match_table now that all the other bits necessary for
ACPI support are in place.

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/i2c/ov2680.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index d4664581b49b..0adfacc70735 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -932,11 +932,18 @@ static const struct of_device_id ov2680_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, ov2680_dt_ids);
 
+static const struct acpi_device_id ov2680_acpi_ids[] = {
+	{ "OVTI2680" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, ov2680_acpi_ids);
+
 static struct i2c_driver ov2680_i2c_driver = {
 	.driver = {
 		.name  = "ov2680",
 		.pm = pm_sleep_ptr(&ov2680_pm_ops),
 		.of_match_table	= ov2680_dt_ids,
+		.acpi_match_table = ov2680_acpi_ids,
 	},
 	.probe		= ov2680_probe,
 	.remove		= ov2680_remove,
-- 
2.41.0

