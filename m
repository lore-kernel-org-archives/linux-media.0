Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE5C77B71
	for <linux-media@archiver.kernel.org>; Tue, 25 Apr 2023 07:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjDYHuM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Apr 2023 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjDYHuG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Apr 2023 03:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2A2D7B
        for <linux-media@vger.kernel.org>; Tue, 25 Apr 2023 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682408962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvKm/GKzTvSKmJLIRwrHdMpjShR/Gw/Pyls5+2QU2l0=;
        b=aV7A4+bkbIIoUchsxZF6tO2q/bJV/wrECwhkIdr6tHG+Ydqts4JQfflO/dciHsPGuAYk4O
        lctHvsjIMTn9O1wSvyJfhNJlP9UDPLxCj6J/9wvKXlL58Kc/5ynF6Q1Kg1XBOO5pRx0ITr
        yw4YSWghf7NrtPGkoB2zW1s3K8/sIoA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-DM2o_HeQP82WF2HcWK439Q-1; Tue, 25 Apr 2023 03:49:18 -0400
X-MC-Unique: DM2o_HeQP82WF2HcWK439Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AF6829ABA13;
        Tue, 25 Apr 2023 07:49:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.67.24.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B71414171B8;
        Tue, 25 Apr 2023 07:49:14 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 2/5] staging: media: atomisp: runtime: frame: remove #ifdef ISP2401
Date:   Tue, 25 Apr 2023 15:48:38 +0800
Message-Id: <20230425074841.29063-3-hpa@redhat.com>
In-Reply-To: <20230425074841.29063-1-hpa@redhat.com>
References: <20230425074841.29063-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The actions of ISP2401 and 2400 are determined at the runtime.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 .../media/atomisp/pci/runtime/frame/src/frame.c   | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c b/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
index 83bb42e05421..425e75f7dda7 100644
--- a/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
+++ b/drivers/staging/media/atomisp/pci/runtime/frame/src/frame.c
@@ -601,9 +601,9 @@ static void frame_init_qplane6_planes(struct ia_css_frame *frame)
 
 static int frame_allocate_buffer_data(struct ia_css_frame *frame)
 {
-#ifdef ISP2401
-	IA_CSS_ENTER_LEAVE_PRIVATE("frame->data_bytes=%d\n", frame->data_bytes);
-#endif
+	if (IS_ISP2401)
+		IA_CSS_ENTER_LEAVE_PRIVATE("frame->data_bytes=%d\n", frame->data_bytes);
+
 	frame->data = hmm_alloc(frame->data_bytes);
 	if (frame->data == mmgr_NULL)
 		return -ENOMEM;
@@ -635,11 +635,10 @@ static int frame_allocate_with_data(struct ia_css_frame **frame,
 
 	if (err) {
 		kvfree(me);
-#ifndef ISP2401
-		return err;
-#else
-		me = NULL;
-#endif
+		if (IS_ISP2401)
+			me = NULL;
+		else
+			return err;
 	}
 
 	*frame = me;
-- 
2.39.2

