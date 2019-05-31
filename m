Return-Path: <SRS0=lOn+=T7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796DEC04AB6
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5373B26D37
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b="PFB6aAcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEaRdH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 31 May 2019 13:33:07 -0400
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:63368
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfEaRdG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 31 May 2019 13:33:06 -0400
X-Sender-Id: dreamhost|x-authsender|brad@nextdimension.ws
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 73E201A1837;
        Fri, 31 May 2019 17:33:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (100-96-4-95.trex.outbound.svc.cluster.local [100.96.4.95])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1739D1A12A4;
        Fri, 31 May 2019 17:32:50 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|brad@nextdimension.ws
Received: from pdx1-sub0-mail-a61.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Fri, 31 May 2019 17:33:05 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|brad@nextdimension.ws
X-MailChannels-Auth-Id: dreamhost
X-Average-Keen: 294de195396f678f_1559323985257_1456804042
X-MC-Loop-Signature: 1559323985257:3924281861
X-MC-Ingress-Time: 1559323985256
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTP id A6E2D80191;
        Fri, 31 May 2019 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=nextdimension.cc; h=from
        :to:cc:subject:date:message-id:in-reply-to:references; s=
        nextdimension.cc; bh=v1BEtP8HQmJ8YoYUUAYVhJe4VIc=; b=PFB6aAcK8YC
        IshR0GG5NXKvoFvfYDxXguOGX8/PCZRCfqgvuVAwtE5kdO7SiwTYDR+SL3isJQPQ
        F5QYvspWJPlB8007e9JAWenJd5+M4/xpTqRoQZZYPrO+Cg3+vxuI4nqNk8vjGNjh
        7PQbWu7LKOZhuvwBVjTXsBA2XfSiawFA=
Received: from localhost.localdomain (67-198-57-188.static.grandenetworks.net [67.198.57.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: brad@nextdimension.ws)
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTPSA id E94388018A;
        Fri, 31 May 2019 10:32:45 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a61
From:   Brad Love <brad@nextdimension.cc>
To:     linux-media@vger.kernel.org, mchehab@kernel.org, sean@mess.org
Cc:     Brad Love <brad@nextdimension.cc>
Subject: [PATCH v5 3/4] pvrusb2: Add i2c client demod/tuner support
Date:   Fri, 31 May 2019 12:32:23 -0500
Message-Id: <1559323944-15639-4-git-send-email-brad@nextdimension.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559323944-15639-1-git-send-email-brad@nextdimension.cc>
References: <1559323944-15639-1-git-send-email-brad@nextdimension.cc>
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 30
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvufffkffojghfsedttdertdertddtnecuhfhrohhmpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqnecukfhppeeijedrudelkedrheejrddukeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepieejrdduleekrdehjedrudekkedprhgvthhurhhnqdhprghthhepuehrrgguucfnohhvvgcuoegsrhgrugesnhgvgihtughimhgvnhhsihhonhdrtggtqedpmhgrihhlfhhrohhmpegsrhgrugesnhgvgihtughimhgvnhhsihhonhdrtggtpdhnrhgtphhtthhopegsrhgrugesnhgvgihtughimhgvnhhsihhonhdrtggtnecuvehluhhsthgvrhfuihiivgepud
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

i2c client device is the "new" method to attach to dvb modules, include
support for this functionality. Cleanup code has been added to init in
case of failure, as well as to frontend exit.

Required by Hauppauge HVR-19x5 with si2168/lgdt3306a/si2177

Signed-off-by: Brad Love <brad@nextdimension.cc>
---
Since v4:
- commit message expansion

 drivers/media/usb/pvrusb2/pvrusb2-dvb.c | 11 +++++++++++
 drivers/media/usb/pvrusb2/pvrusb2-dvb.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
index f302f1e..7f5df5c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
@@ -404,6 +404,9 @@ static int pvr2_dvb_frontend_init(struct pvr2_dvb_adapter *adap)
 fail_frontend0:
 	dvb_frontend_detach(adap->fe[0]);
 	adap->fe[0] = NULL;
+	dvb_module_release(adap->i2c_client_tuner);
+	dvb_module_release(adap->i2c_client_demod[1]);
+	dvb_module_release(adap->i2c_client_demod[0]);
 
 	return ret;
 }
@@ -420,6 +423,14 @@ static int pvr2_dvb_frontend_exit(struct pvr2_dvb_adapter *adap)
 		dvb_frontend_detach(adap->fe[0]);
 		adap->fe[0] = NULL;
 	}
+
+	dvb_module_release(adap->i2c_client_tuner);
+	adap->i2c_client_tuner = NULL;
+	dvb_module_release(adap->i2c_client_demod[1]);
+	adap->i2c_client_demod[1] = NULL;
+	dvb_module_release(adap->i2c_client_demod[0]);
+	adap->i2c_client_demod[0] = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.h b/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
index 91bff57..c0b27f5 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
+++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
@@ -20,6 +20,9 @@ struct pvr2_dvb_adapter {
 	struct dvb_net		dvb_net;
 	struct dvb_frontend	*fe[2];
 
+	struct i2c_client	*i2c_client_demod[2];
+	struct i2c_client	*i2c_client_tuner;
+
 	int			feedcount;
 	int			max_feed_count;
 
-- 
2.7.4

