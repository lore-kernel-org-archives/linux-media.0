Return-Path: <SRS0=lba3=7W=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A33C433E1
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 00:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C4C20760
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 00:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664047;
	bh=IupQNesex1G6SUuR2nZDGISdq1rJoGT1/PvCdy8NC9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbuL/wtjLhs4pCWuUb5EDpsRwlJSPZ3+WxiD+j+GWmcUmHR5dtJKFNRkAzHw5Sdv6
	 v/TYL3QIWtJMTaq0unoCWUORryN+j4tc2EXrEhLAflVIC4ACmmbGjZNQo0GqQIINbq
	 SWBodtrj/DCyJYUKXMYehieij/l5VZZoPkNM32pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgFHXJi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgFHXJh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Jun 2020 19:09:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EF920897;
        Mon,  8 Jun 2020 23:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657776;
        bh=IupQNesex1G6SUuR2nZDGISdq1rJoGT1/PvCdy8NC9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkKoznP8O3+U43v+J9ngmTcky4ycAxrH0fqmvD2u6WPatyEywui/CLk0ry5w3098f
         MMw4pG7H2zFUAY12arvKGltsUyyi2SH9cClsK+axFO36A+ikuSCEsW6mpOZj4QeEJv
         i1N3NcCz8++eRxIOg8YYlc2YQtB5Ff3C2G7iIi9c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 159/274] media: cec: silence shift wrapping warning in __cec_s_log_addrs()
Date:   Mon,  8 Jun 2020 19:04:12 -0400
Message-Id: <20200608230607.3361041-159-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 3b5af3171e2d5a73ae6f04965ed653d039904eb6 ]

The log_addrs->log_addr_type[i] value is a u8 which is controlled by
the user and comes from the ioctl.  If it's over 31 then that results in
undefined behavior (shift wrapping) and that leads to a Smatch static
checker warning.  We already cap the value later so we can silence the
warning just by re-ordering the existing checks.

I think the UBSan checker will also catch this bug at runtime and
generate a warning.  But otherwise the bug is harmless.

Fixes: 9881fe0ca187 ("[media] cec: add HDMI CEC framework (adapter)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/cec-adap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index 6c95dc471d4c..6a04d19a96b2 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1734,6 +1734,10 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		unsigned j;
 
 		log_addrs->log_addr[i] = CEC_LOG_ADDR_INVALID;
+		if (log_addrs->log_addr_type[i] > CEC_LOG_ADDR_TYPE_UNREGISTERED) {
+			dprintk(1, "unknown logical address type\n");
+			return -EINVAL;
+		}
 		if (type_mask & (1 << log_addrs->log_addr_type[i])) {
 			dprintk(1, "duplicate logical address type\n");
 			return -EINVAL;
@@ -1754,10 +1758,6 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 			dprintk(1, "invalid primary device type\n");
 			return -EINVAL;
 		}
-		if (log_addrs->log_addr_type[i] > CEC_LOG_ADDR_TYPE_UNREGISTERED) {
-			dprintk(1, "unknown logical address type\n");
-			return -EINVAL;
-		}
 		for (j = 0; j < feature_sz; j++) {
 			if ((features[j] & 0x80) == 0) {
 				if (op_is_dev_features)
-- 
2.25.1

