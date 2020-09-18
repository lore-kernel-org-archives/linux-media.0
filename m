Return-Path: <SRS0=ldJM=C3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576E3C43463
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 02:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155862083B
	for <linux-media@archiver.kernel.org>; Fri, 18 Sep 2020 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600397895;
	bh=jGhZISFgVL+/FUIGMcXqvuU+A9Nr5jP1pkKvf9EPlPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xCN+HmWaGBgCVyWOwuJX+qnDo50aK1NbqK8bcm2iWNPS/TgOl/rV+4vCl8Dc2KP1A
	 vnHg240E4wzzsNLtAcv2MWW/zfkYMNQC253ANkVzM+8qs+wnb2prSy8Anwt/dgOWDj
	 aaNSNVU8vhSSil9GZ4Dfo0/E8lj5dYyQc62sLr3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgIRC6B (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbgIRCGV (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 22:06:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1F8238D6;
        Fri, 18 Sep 2020 02:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394781;
        bh=jGhZISFgVL+/FUIGMcXqvuU+A9Nr5jP1pkKvf9EPlPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8wBvW5rzrK2nll1jwR17lkQ+J1P//CnOpQwo182EFNLcAQKMTYzhH4Pne/RjVnmB
         LSy8aNBHBFad9VnUnxMIBzDAM2v18Eie1g+8m377YvBSO+2zo+SuxGgtq8DfFrUfYf
         hON4Hm+41mKezodA5b1gzr1eWx0mti0IpdrB3bks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 254/330] media: venus: vdec: Init registered list unconditionally
Date:   Thu, 17 Sep 2020 21:59:54 -0400
Message-Id: <20200918020110.2063155-254-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

[ Upstream commit bc3d870e414b42d72cd386aa20a4fc3612e4feb7 ]

Presently the list initialization is done only in
dynamic-resolution-change state, which leads to list corruptions
and use-after-free. Init list_head unconditionally in
vdec_stop_capture called by vb2 stop_streaming without takeing
into account current codec state.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 59ae7a1e63bc2..05b80a66e80ed 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -987,13 +987,14 @@ static int vdec_stop_capture(struct venus_inst *inst)
 		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT);
 		vdec_cancel_dst_buffers(inst);
 		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
-		INIT_LIST_HEAD(&inst->registeredbufs);
 		venus_helper_free_dpb_bufs(inst);
 		break;
 	default:
-		return 0;
+		break;
 	}
 
+	INIT_LIST_HEAD(&inst->registeredbufs);
+
 	return ret;
 }
 
-- 
2.25.1

