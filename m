Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3BBC43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24E218AE
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553876072;
	bh=3DODlHoajHpIwFif9Vn/jxNRV2H4QcBJD0o/Be4ncZs=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=xPBO0hQKgEAHPXxmTIYwjLmQ71XBJEhMrPxvWkh7CZc+bMtTTEyLm0JAPgdyn9JKn
	 dnyKh1alkIyGwxjhvANDlQFPqURpiSFnH+uODQ53KqhQWmRygR3nsVJTqT/oUkUj9f
	 ssUleT0CSmqnKw7NnX3JyKg180mg3oVsozSeDUCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfC2QOb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:14:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfC2QOb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 12:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oaaPtdbAR3IrwWeHMLo64Pe9d/cDFtxo8BEQRYVHBq8=; b=Lmso7a0T9OZtjQiwi4905y/7x
        GEarJSGKpRv98duwEJ7ccp6FSDjAlbljOQ2HAFju0ZPHZp46oD/zEtm1piOJtMnkn/UNG4gKSuGmU
        bJFx88ckd1MuHB/7TFj1VWzQo3Nat0FP9kknnUoqthX1BlK8LFa4nvxzx3ZBPfB1tU+gJsR/IL/HR
        plZCT9c7Gb9j4HJVy0YSdKRZ5cVLH8HaGirX89g82+F99TBk8KCuDA55WiV3//kPp3Z/vD3nmQoFg
        o3I4tcCSGQD5pJkqVb9tURLW9RknTHWJxBXdsTBg7eNrHt6AMhSnOFyz4WPDTR8hjBQKZS4YUZ8EN
        WC6pSo//w==;
Received: from [179.95.36.211] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9u9G-00071R-Ux; Fri, 29 Mar 2019 16:14:30 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1h9u9E-0004W5-Si; Fri, 29 Mar 2019 12:14:28 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] media: pixfmt-packed-yuv.rst: better adjust cell sizes
Date:   Fri, 29 Mar 2019 12:14:27 -0400
Message-Id: <26ff80fffe21e81a189377373e0f738332420029.1553876065.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Avoid cell overlapping by changing some sizes.

Tested with Sphinx 1.7.8.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
index 9d2b281f06a2..41b60fae703a 100644
--- a/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
@@ -28,7 +28,7 @@ component of each pixel in one 16 or 32 bit word.
 
 .. _packed-yuv-formats:
 
-.. tabularcolumns:: |p{2.0cm}|p{0.67cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|p{0.29cm}|
+.. tabularcolumns:: |p{2.5cm}|p{0.69cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|p{0.31cm}|
 
 .. flat-table:: Packed YUV Image Formats
     :header-rows:  2
-- 
2.20.1

