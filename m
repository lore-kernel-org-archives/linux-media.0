Return-Path: <SRS0=54rz=5Y=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F03C2D0EC
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 01:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D68F20748
	for <linux-media@archiver.kernel.org>; Wed,  8 Apr 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShVvijYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDHBNu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:13:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDHBNt (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Apr 2020 21:13:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id a13so1639835pfa.2
        for <linux-media@vger.kernel.org>; Tue, 07 Apr 2020 18:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p+hUl73+nVkUeJFchzhimvM3N1SChVdynuaclSURC7g=;
        b=ShVvijYiQcUEwVHQz55w8x/jFFS5vEJb3uiyDyJin0J6IR79EUYy8vCpzLM/ZwogQi
         gVWzLD9aSS7hF6N/3BnPBHmjJgOlHdQw1Zfm6AsZgy0srl1IWiwKfd7BG4fgaXoNv8vB
         voAa42LJqzlbeTw6+4bVK/Z+O5FDW7y4Ae7jHEZe0+i6z3KwCbb+NePDUCWa+02lLV5r
         veIZtcPSECBjVmY6L8POYLu86ptUCwU7KMAtHsnw/nnIBRZixjH5OzeuoFmSRc7CziyW
         Jbyo3j1ULAfrr+brdm3tW46jK1qOMMcBPZrVeKMu9tMavoWPdBG4k6lWHGY6cw743SgT
         rvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p+hUl73+nVkUeJFchzhimvM3N1SChVdynuaclSURC7g=;
        b=SDd9kuso82Qko3IsxFDPOkmEPheEu9Ml/Siy3o1lasq2dozGLqcmHcT+ydUazyxn+u
         3+bg/Y3c93UBooM634ImidMLm798nkY/CgDA4w5BYXmsmCDs+0pRDWslsKXQ0jHkjlK5
         tFh48e0fNswlblBLPvkvB6/9ln5/zO2zr9qygGFVBV8vRhKEgmbdOWG+8yIpXpKep99G
         mIZgpJ8NG/LzyFjDfOS4TPxAWgg14abUGqxcsvAlvhe5BGywqE6iQh7+LBuxy0+q1WF6
         CBQLLdTUSbB2TAdfNF3xhwockO3L6vxsz07VRnzh4heas1Pavdd6U0Xu1gY8fJqwUI1U
         qcLg==
X-Gm-Message-State: AGi0PuYsCDRB05GU93Y+fsOgtHVKV4pGgGgaiKHL45DUlEx/pd/ZPIo8
        gPt4yECtQqio8asPyLZxoQh5XKI/
X-Google-Smtp-Source: APiQypKdRkLTltUA/vlukkLV3Aaw9Lq3WB0zcwVK7XDSnGnaz/3FIRJD4U8rrkfQ8pFKbC616QdVdg==
X-Received: by 2002:a63:141:: with SMTP id 62mr4853669pgb.101.1586308426868;
        Tue, 07 Apr 2020 18:13:46 -0700 (PDT)
Received: from localhost.localdomain (astound-69-42-19-227.ca.astound.net. [69.42.19.227])
        by smtp.gmail.com with ESMTPSA id z16sm15122003pfr.138.2020.04.07.18.13.46
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:13:46 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH] keytable: add compatibility for input_event_sec
Date:   Tue,  7 Apr 2020 18:13:44 -0700
Message-Id: <20200408011344.13022-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Linux 4.16 added support for this macro. When it is not available,
define it back to the previous value.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 utils/keytable/keytable.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/utils/keytable/keytable.c b/utils/keytable/keytable.c
index bc890394..4db91267 100644
--- a/utils/keytable/keytable.c
+++ b/utils/keytable/keytable.c
@@ -62,6 +62,10 @@ struct input_keymap_entry_v2 {
 	u_int8_t  scancode[32];
 };
 
+#ifndef input_event_sec
+#define input_event_sec time.tv_sec
+#define input_event_usec time.tv_usec
+#endif
 
 #define IR_PROTOCOLS_USER_DIR IR_KEYTABLE_USER_DIR "/protocols"
 #define IR_PROTOCOLS_SYSTEM_DIR IR_KEYTABLE_SYSTEM_DIR "/protocols"
-- 
2.25.1

