Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BABC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500222075B
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfDJJNj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:13:39 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:56720 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728851AbfDJJNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9IUhpDJCUjKfE9IWhgrA7; Wed, 10 Apr 2019 11:13:36 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 6/7] seco-cec: decrement HDMI device refcount
Date:   Wed, 10 Apr 2019 11:13:33 +0200
Message-Id: <20190410091334.8654-7-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
References: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOI7DS1Nto+WVDbT9kY2Sy2fxK3GKg2CTzMo+Xa6eAvzgQvnVNFTuUSZy6zWbkyyV2EbCMnr7VN3GWx2LMMPBJTpeT6xhl1UmxQlTqPua3NjMaU2JNlL
 gBwU0RYJPyLzCaTcaEBZcXVtbGLkjODXbljv6/1sSgcH5OnyzW8NuGjirC/PWvWkgOcqKKkCxIs/QrRfU6vMKTwSQZ3/92XhopbPR+L/+GPYjOV6KK645+z8
 VK6HRQ/Dnq3/ZR6wvUOf1J0q47ug7gBbd9eOZ5fVGBbPs7xV5tttvaEekIEJfTxpU88i1ErkXGc44U0hJMX9OLQ9G6DbV1WnktuoaOE6zbro/yfhtglt04kM
 dFKqS70V3gQcbUC53xIeApeDp6jV0pw26VEI/jtVrPbOjRCyDtZM/+G80OXrvJvkruj1DerpUP+2xGTUCxKd+TFONQ5C5oX023k6ft/t1f4Qte6MI2WdjpLZ
 L6cOusAMz6F7NcW2xNcv5znePfzvDU6LgdZSwg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The SECO CEC driver never decremented the HDMI device refcount.
CEC drivers only need the HDMI device pointer as a key in the
notifier list, it never accesses the device, so there is no
need to keep a reference.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/platform/seco-cec/seco-cec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
index a425a10540c1..e5080d6f5b2d 100644
--- a/drivers/media/platform/seco-cec/seco-cec.c
+++ b/drivers/media/platform/seco-cec/seco-cec.c
@@ -536,6 +536,7 @@ static int secocec_cec_get_notifier(struct cec_notifier **notify)
 				return -EPROBE_DEFER;
 
 			*notify = cec_notifier_get_conn(d, m->conn);
+			put_device(d);
 
 			return 0;
 		}
-- 
2.20.1

