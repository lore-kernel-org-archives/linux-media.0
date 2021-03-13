Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBECC43603
	for <linux-media@archiver.kernel.org>; Sat, 13 Mar 2021 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C2064F27
	for <linux-media@archiver.kernel.org>; Sat, 13 Mar 2021 14:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCMOnx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Mar 2021 09:43:53 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:36105 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234045AbhCMOnc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Mar 2021 09:43:32 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id L5UBljyoWC40pL5UJlV5fc; Sat, 13 Mar 2021 15:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1615646611; bh=cjCEu9Q7NxzS05k7yOFa4La2O8Ohl8VPtngk6zduQUk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=twA4LPU5YXKaGlx3e6g07XcOuPSRJ5Me+GVJGanWURkMmtkbJ4i2McLlL6Qzs1qOC
         8oyGBeLxcjqD3eHmTWZneAkKag276Cba+6G57kUVQMRN6T4lfbd9Ffaei+F//ivDDG
         vICFu599YZRJ7F/n3bd1i20v5rohSKShKR7+elgQ7b5weg8xKuT1nxaWjCo0D1fr0+
         6DmlQFG6p0O3KTwhxNOHmqltu4Ko7LO14izFAP5BA/Tk/PRW2ClUcknT8w+9vPYmwl
         /CUjC0yMLU8sc9Enagge8JzQbbTZiicMHeHSVGWEV9OY4ZgdNX2sbVmdMYj0BA9YqR
         O8Oyf2qBn3HCA==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 13/15] videodev2.h: rename MPEG to CODEC
Date:   Sat, 13 Mar 2021 15:43:21 +0100
Message-Id: <20210313144323.143600-14-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210313144323.143600-1-hverkuil-cisco@xs4all.nl>
References: <20210313144323.143600-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGjXQlB6dPm00Q5+tRzwB3aFZ8OPWH98sQ8KnCSmkllNXyOGRQ451yEBhBRoSYMx/70Ei/1lTHb4u1Yw6H0ALeY4fngk6nnf7VxwMjVJZ/QCpkLpMsRG
 0cbnbgZrMioPgn2hCI1grQsUPJS4MPV7NF0UM8f3Qt46iZkw1yyvlU5ZteXZXVD7CVPHuWYjWWnA7sAzN4+F8MCOgsnyOHL8eOqVNGSWDDRgqL0ulujm5oSG
 weKk9dhW0UbALkS0GbKq4Ua7DNlgTvhiDCO8eUKkv+J+RlHCMgI1ZUYQVYYllrLhoOtQ7bGTxoQ5ns0gcRVG3SUfLe21/fiJSZ6KWQ+tbog6fM3CObuQ2YzZ
 CclsM0VNtE3ny/g1X0fBANEUoLwNfQ==
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Historically all codec-related data structures and defines used the
MPEG prefix. This is confusing. Rename MPEG to CODEC to make it clear
that the MPEG prefix isn't MPEG specific.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 include/uapi/linux/videodev2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 79dbde3bcf8d..db838c3a548f 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2177,10 +2177,10 @@ struct v4l2_sliced_vbi_data {
  */
 
 /*
- * V4L2_MPEG_STREAM_VBI_FMT_IVTV:
+ * V4L2_CODEC_STREAM_VBI_FMT_IVTV:
  *
  * Structure of payload contained in an MPEG 2 Private Stream 1 PES Packet in an
- * MPEG-2 Program Pack that contains V4L2_MPEG_STREAM_VBI_FMT_IVTV Sliced VBI
+ * MPEG-2 Program Pack that contains V4L2_CODEC_STREAM_VBI_FMT_IVTV Sliced VBI
  * data
  *
  * Note, the MPEG-2 Program Pack and Private Stream 1 PES packet header
-- 
2.30.1

