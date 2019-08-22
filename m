Return-Path: <SRS0=WnEk=WS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD6C3A5A1
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CFA233FD
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566502780;
	bh=rSqT+IXvdJCWN9K3QAa57WzQi9npFCrFiEqpPRQOCSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvSozLFbBpwcdkq92RjiI02tTWZon0dL8o4Orj7oZBZtcRbfverrYjIYa5cPR6VZI
	 Oa4hkaJ+o20y6vsmjUukw2hsZCfLIyY9NI9lebXe58B3yGGYBt/mo9P83OWyHlLSY3
	 3DfBTJ9wCmx54y2zeZH3iORI9PrweTB2gbjJWcUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfHVTjk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:39:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59180 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfHVTjk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Aug 2019 15:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pgErmpFXxq4tr/V2Zyyibb7WVocvEmJ2tAtqbs4GtSU=; b=G7KPORPNxRfa01/z5Clbh1Jhi9
        sYV6/cUV+ECUQAn+1m8j1sD5LH8HEac6DvXTcfGvCNZ19tp1bGTefiwWwOPH+xqVr9Tr/AL6ynTQ+
        GDIVY6E1k6YoYB5P6YuASdl+PGpMZR3TRA5uH0JSNPJ9sIjznzG2lVQ2SzXqoZw5VAxhS1+1H9nQh
        9BCzQ7lt4ulasgKBq5iBW5fPG9lPBaiXgpJ1mnlyZhbWaPicDartKNv4X1k0LcMC2JBylxuRjqSA8
        lsf+6vmuFoc1YCAtQkUgcb4x4Z3mg/u2csLH9/yixIRpB9bWD3Ycx6SdTqO/B238ofuXOk8YVR/v8
        gzbKS0MQ==;
Received: from [177.133.63.56] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0svr-0002lX-LB; Thu, 22 Aug 2019 19:39:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i0svo-0007IJ-Dx; Thu, 22 Aug 2019 16:39:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 2/7] media: vicodec: make life easier for static analyzers
Date:   Thu, 22 Aug 2019 16:39:29 -0300
Message-Id: <2d4cde2e91237af9cae10d4a1e2df4d1f4e1bce0.1566502743.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
References: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

cppcheck incorrectly produces an error here:
	[drivers/media/platform/vicodec/vicodec-core.c:1677]: (error) Pointer addition with NULL pointer.

While this is actually a false positive, it doesn't hurt to
reorder the checks to make the code simpler, handling first
the error patch, where no color or alpha components are there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/vicodec/vicodec-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 5152f44bcc0a..0ee143ae0f6b 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -1664,19 +1664,22 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 	kvfree(state->compressed_frame);
 	state->compressed_frame = new_comp_frame;
 
-	if (info->components_num >= 3) {
-		state->ref_frame.cb = state->ref_frame.luma + size;
-		state->ref_frame.cr = state->ref_frame.cb + size / chroma_div;
-	} else {
+	if (info->components_num < 3) {
 		state->ref_frame.cb = NULL;
 		state->ref_frame.cr = NULL;
+		state->ref_frame.alpha = NULL;
+		return 0;
 	}
 
+	state->ref_frame.cb = state->ref_frame.luma + size;
+	state->ref_frame.cr = state->ref_frame.cb + size / chroma_div;
+
 	if (info->components_num == 4)
 		state->ref_frame.alpha =
 			state->ref_frame.cr + size / chroma_div;
 	else
 		state->ref_frame.alpha = NULL;
+
 	return 0;
 }
 
-- 
2.21.0

