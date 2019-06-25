Return-Path: <SRS0=f2lN=UY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6026EC48BD7
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A23208CB
	for <linux-media@archiver.kernel.org>; Tue, 25 Jun 2019 14:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfFYOpY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:45:24 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:45467 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731016AbfFYOpS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Jun 2019 10:45:18 -0400
Received: from cobaltpc1.rd.cisco.com ([IPv6:2001:420:44c1:2579:b032:593c:25fc:ff9b])
        by smtp-cloud9.xs4all.net with ESMTPA
        id fmh4hQwJSSfvXfmhAhHp03; Tue, 25 Jun 2019 16:45:16 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        dri-devel@lists.freedesktop.org,
        Cheng-yi Chiang <cychiang@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv9 08/13] dw-hdmi-cec: use cec_notifier_cec_adap_(un)register
Date:   Tue, 25 Jun 2019 16:45:05 +0200
Message-Id: <20190625144510.122214-9-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625144510.122214-1-hverkuil-cisco@xs4all.nl>
References: <20190625144510.122214-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAkTWwsUHmfEelg/SEvUpZY9/CZ8hb8g62P3xU16qZ5ShLynhD2V0cuz9N+D/rWAcb7hKH3JmQAxiMe+WxbBdFXRGKypDOCgy+QgEzh1PEuwL4CP/yzY
 4bO33Rc1H3jlSLvijgDmV6ndF8I5T23pcjqrtNcJ08UtDOuFid/R7cG9sAYGa2Z2gef1bKviVtyoXVpZ/lZjhTh9rSagKKTpNraewI3jI4xr8Kw6NZ5WAKkc
 G6uzBcsao34AgkNYf9KFDXubk1FCdIx9VwcQo5zDsIBrK+2r5YZSk2+JuCZsBVxb7cUyFoBA7FuNnU3W9aZugv+NEoHRDSmMlRcQSKOhxzVYob3RSjmqnzVA
 lIHj2nzVCXFzTWRuygWaI3B7E5yafN8PPnBQsg2oXg+AxRxvP06311gT2XeCqrLjntonCOXk
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dariusz Marcinkiewicz <darekm@google.com>

Use the new cec_notifier_cec_adap_(un)register() functions to
(un)register the notifier for the CEC adapter.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index 6c323510f128..6f7ecacb7d1f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -281,13 +281,14 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	cec->notify = cec_notifier_get(pdev->dev.parent);
+	cec->notify = cec_notifier_cec_adap_register(pdev->dev.parent,
+						     NULL, cec->adap);
 	if (!cec->notify)
 		return -ENOMEM;
 
 	ret = cec_register_adapter(cec->adap, pdev->dev.parent);
 	if (ret < 0) {
-		cec_notifier_put(cec->notify);
+		cec_notifier_cec_adap_unregister(cec->notify);
 		return ret;
 	}
 
@@ -297,8 +298,6 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
 	 */
 	devm_remove_action(&pdev->dev, dw_hdmi_cec_del, cec);
 
-	cec_register_cec_notifier(cec->adap, cec->notify);
-
 	return 0;
 }
 
@@ -306,8 +305,8 @@ static int dw_hdmi_cec_remove(struct platform_device *pdev)
 {
 	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
 
+	cec_notifier_cec_adap_unregister(cec->notify);
 	cec_unregister_adapter(cec->adap);
-	cec_notifier_put(cec->notify);
 
 	return 0;
 }
-- 
2.20.1

