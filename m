Return-Path: <SRS0=tdip=DZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D3DC433E7
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0202137B
	for <linux-media@archiver.kernel.org>; Sun, 18 Oct 2020 19:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050039;
	bh=LJo36oZvjES6iiePu+aWwhNnfptmuFWCkAh8BvbK3bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TRPNA+NID5C+J8/2ej48Xt/ANcpB0FEz/9klCbB1I0OtgDNahFa3JK08B7emdl0qT
	 pO5gRWytepNK9LkXMdpNiY5E0aXUa5rygAWW1KmnLA33kguDgNGY3vXWrFaFj4eo7x
	 sDluQHG2HGdgqz7Vgla2AHvizJ4H/HM+Rnofc57M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgJRTki (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbgJRTYW (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 18 Oct 2020 15:24:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D2C222E7;
        Sun, 18 Oct 2020 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049062;
        bh=LJo36oZvjES6iiePu+aWwhNnfptmuFWCkAh8BvbK3bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0f3E1YLICghb8/ry/zDo7UvXp2AZ3gcLpufPuwg66a3ZnSM5nsuwC7XEXjImbNh+
         DwGA3omJpWz6FVCg2sgMEQp37KsF8bVD4zVGZKuLxaPbAu3+LwhBxbazwolXCab4Jp
         n+I5vs8PD7hJ0ZvF3L5PufPgO2wetu2Ty9MsJfDg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Pavel Machek <pavel@denx.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 03/56] media: firewire: fix memory leak
Date:   Sun, 18 Oct 2020 15:23:24 -0400
Message-Id: <20201018192417.4055228-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192417.4055228-1-sashal@kernel.org>
References: <20201018192417.4055228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

[ Upstream commit b28e32798c78a346788d412f1958f36bb760ec03 ]

Fix memory leak in node_probe.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/firewire/firedtv-fw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/firewire/firedtv-fw.c b/drivers/media/firewire/firedtv-fw.c
index eaf94b817dbc0..2ac9d24d3f0cd 100644
--- a/drivers/media/firewire/firedtv-fw.c
+++ b/drivers/media/firewire/firedtv-fw.c
@@ -271,8 +271,10 @@ static int node_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	name_len = fw_csr_string(unit->directory, CSR_MODEL,
 				 name, sizeof(name));
-	if (name_len < 0)
-		return name_len;
+	if (name_len < 0) {
+		err = name_len;
+		goto fail_free;
+	}
 	for (i = ARRAY_SIZE(model_names); --i; )
 		if (strlen(model_names[i]) <= name_len &&
 		    strncmp(name, model_names[i], name_len) == 0)
-- 
2.25.1

