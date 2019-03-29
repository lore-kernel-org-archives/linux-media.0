Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2092C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE4A2184C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553869845;
	bh=wJIwSMqzSquID8sr7bo0vGRdtLWU1AjkF8cdqcwKn1I=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=L3K06hUkmXxcWiSkH5WQLwAtDcgrewiK/mYduBfuxAoA798/4xzkViv5ekqOkV3PU
	 2O9RrQ5DARBq+0K10qYgTtsaon+EV+yJzXZj6wP6qSO0dT3m5EzLJIoJIEZH5kPRHz
	 hjei8my41uM3JHRWwSCL26sLM+QnTLm9zj/THdmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfC2Oap (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:30:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2Oap (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 10:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n8vGal7GfBpEZ1sm6TmnG7UkuO59AXCFLsb66qDiD5s=; b=EJrOrh1sTuXroKGRjx5W3KwLD
        WxJmTZjm6yxxe4hOF6p71OFBmOjaTvwzjCI4VwULS88wqwxNAGH6JhnbTjnuptjMVF7PhA72CqdHK
        fw3xAFcibrvPnlmfQsKMiT4AW/lTcz+hvTKvCrDDX1xY+qErhqk1tcz7FI/PaCy3cVRYn0FgVgZkC
        iOSJ2/JX3cG0AnuooTp22eWVQf3mYFEAJWI88OFVnBc/eu0JdMr0msbjeBsxHyB1dlBANS4BJCbd/
        SgTFsb0q5fJfuPb7N6FQzmdxXrZDmXPvMKS3vjZ5O/b/6GQSx7KCP7FEFAz0pEzlpgANY/CcHc/oJ
        aux1oSKPw==;
Received: from [179.183.99.176] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9sWq-0005K9-Qd; Fri, 29 Mar 2019 14:30:44 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9sWo-0001hZ-Nn; Fri, 29 Mar 2019 10:30:42 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] media: bt8xx: avoid a needless u8 to char conversion
Date:   Fri, 29 Mar 2019 10:30:41 -0400
Message-Id: <05fa38fd63e557d2681b063f053c5b94d9c442e3.1553869835.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Instead of doing the cast, just change the type to char.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/pci/bt8xx/dst.c        | 4 ++--
 drivers/media/pci/bt8xx/dst_common.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index 3315a6d67edf..e929797206f6 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1100,8 +1100,8 @@ static int dst_get_device_id(struct dst_state *state)
 			/*	Card capabilities	*/
 			state->dst_hw_cap = p_dst_type->dst_feature;
 			pr_err("Recognise [%s]\n", p_dst_type->device_id);
-			strscpy((char *)state->fw_name, p_dst_type->device_id,
-				sizeof(state->fw_name));
+			strscpy(state->fw_name, p_dst_type->device_id,
+			        sizeof(state->fw_name));
 			/*	Multiple tuners		*/
 			if (p_dst_type->tuner_type & TUNER_TYPE_MULTI) {
 				switch (use_dst_type) {
diff --git a/drivers/media/pci/bt8xx/dst_common.h b/drivers/media/pci/bt8xx/dst_common.h
index 6a2cfdd44e3e..79dec1b1722c 100644
--- a/drivers/media/pci/bt8xx/dst_common.h
+++ b/drivers/media/pci/bt8xx/dst_common.h
@@ -138,7 +138,7 @@ struct dst_state {
 	u32 tuner_type;
 	char *tuner_name;
 	struct mutex dst_mutex;
-	u8 fw_name[8];
+	char fw_name[8];
 	struct dvb_device *dst_ca;
 };
 
-- 
2.20.1

