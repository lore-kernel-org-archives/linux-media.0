Return-Path: <SRS0=CsWU=ZA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBADC5DF60
	for <linux-media@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637852084D
	for <linux-media@archiver.kernel.org>; Fri,  8 Nov 2019 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214243;
	bh=X33pF3J0S4PQTHIOi6rgmmFFe9etwYPH/2MIH3bxg/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhK9/fQfIt6Yj3BVdzL+B3aH5nweN3xYEgjXv8ad3/O3LpoY4EHTAnaPDsMLM62CV
	 oa682lftFc4kuhrNI+DChs62ccB8BphgtkX1/MTv439gcwF2fi3twOBj8Ojk0U0URx
	 UZV7NdhWhTT9lWz0SsVDqHzlKXQS/wg/j8B9W0XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbfKHL5W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391018AbfKHLpH (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA01222CB;
        Fri,  8 Nov 2019 11:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213506;
        bh=X33pF3J0S4PQTHIOi6rgmmFFe9etwYPH/2MIH3bxg/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l22JztHMfSOF44ANn7MrMnQRmKfpd+cWvG4+cW8BRiBgMqoJykzrA3V9VeLI5rb5E
         foUliqirbXKBFvD/DiIMOgm5iJEE1iNm0W6PiV9oV5ndevjReElcM/OHA678+8uBnW
         2XGqQlGhV3tIJeGX9S6ZpfvuEi1vQzGx5n6Md1pw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lao Wei <zrlw@qq.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 080/103] media: fix: media: pci: meye: validate offset to avoid arbitrary access
Date:   Fri,  8 Nov 2019 06:42:45 -0500
Message-Id: <20191108114310.14363-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Lao Wei <zrlw@qq.com>

[ Upstream commit eac7230fdb4672c2cb56f6a01a1744f562c01f80 ]

Motion eye video4linux driver for Sony Vaio PictureBook desn't validate user-controlled parameter
'vma->vm_pgoff', a malicious process might access all of kernel memory from user space by trying
pass different arbitrary address.
Discussion: http://www.openwall.com/lists/oss-security/2018/07/06/1

Signed-off-by: Lao Wei <zrlw@qq.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/meye/meye.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/meye/meye.c b/drivers/media/pci/meye/meye.c
index 49e047e4a81ee..926707c997acb 100644
--- a/drivers/media/pci/meye/meye.c
+++ b/drivers/media/pci/meye/meye.c
@@ -1460,7 +1460,7 @@ static int meye_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned long page, pos;
 
 	mutex_lock(&meye.lock);
-	if (size > gbuffers * gbufsize) {
+	if (size > gbuffers * gbufsize || offset > gbuffers * gbufsize - size) {
 		mutex_unlock(&meye.lock);
 		return -EINVAL;
 	}
-- 
2.20.1

