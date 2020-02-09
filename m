Return-Path: <SRS0=x5Ow=35=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E5AC2BA83
	for <linux-media@archiver.kernel.org>; Sun,  9 Feb 2020 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A7220726
	for <linux-media@archiver.kernel.org>; Sun,  9 Feb 2020 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="manqrbCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgBIRtl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:49:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44577 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgBIRtl (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 9 Feb 2020 12:49:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so3409121qts.11
        for <linux-media@vger.kernel.org>; Sun, 09 Feb 2020 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FeBkmy6QVNf+NuUYRyPEo6h//2FrzM8wWrM0I5E3M8c=;
        b=manqrbCOY31qcdqsUsXWcp1Igxkp/Wc9jH33auwqhQyQP0zcaQLHsNrqXmGxXBS3V0
         KM3VJtM2X0s/vaH9vwBuwDBfqr7YRbL1CFPoeznsB96tZfVeHjD0Tt/bFeAumnVA6Kvc
         6MTD223t4Y87owLEy3avbdJ1RPBAlbtXiI3gJV+kDiOm9Ax0U9lLEH4rxPTLHkrx4sJS
         YSATQvUS0etkCn43yidqev0oqwfQwpDlhl+849t00umawPNOwa7y0BwgLdTP7vEVzNK0
         YrMqksx700PwtTShE5MUIqQTLHExxHI+UU1yRcaAkaY2ETroCc8i2baa06TmjMfM8XnS
         4Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FeBkmy6QVNf+NuUYRyPEo6h//2FrzM8wWrM0I5E3M8c=;
        b=aossaBAq3rMqd0OLjtcLHzRnw7leD9AA1WMH+uwleJDPODD9qv2ftMGULyP41YTWRR
         y7tsL5x2IzJHscArkaJCxhqz/nCUGtA2uDCI/qeC4wISDR+1bq/1peykZcmJS0CQuwvA
         e7rt23CkqySs3ECdpJ7lu2fjWvZFfKwOMvbKAULdzIP0xqHISX2JOB2C/bYYo30y4RRF
         BpN3WOaNna6bJ7SZ3NQA/DzKRTnqHYw1dF7/VuIbATNqI4gs5brslXvY0sQr0PwktQbg
         EJJgEYFWCZi+u/xHeMqhLh9AS8SrIBwCZ9eH3NB4wyPc36Og57nn54AXOxhKLUwcvt+S
         W19Q==
X-Gm-Message-State: APjAAAXvMcKlcaOiWbVLs1pzWwvaEsPpWzdHuQze4/ftzacWqmR7Il1G
        ssiCZMVwP0DX9NXqc1DTa7emwgD2kFU=
X-Google-Smtp-Source: APXvYqxKofm84Cleq+kD4RFg9QwqsQqIyUnYz9CdBUybnRZzJ3403MDxdGJX0FWOkhn01HZjFBujpA==
X-Received: by 2002:ac8:43c2:: with SMTP id w2mr5186820qtn.376.1581270580553;
        Sun, 09 Feb 2020 09:49:40 -0800 (PST)
Received: from athos.hellosponsor.com (pool-173-68-201-69.nycmny.fios.verizon.net. [173.68.201.69])
        by smtp.gmail.com with ESMTPSA id 206sm4621095qkf.132.2020.02.09.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 09:49:39 -0800 (PST)
From:   Ilia Mirkin <imirkin@alum.mit.edu>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [PATCH 0/2] edid-decode: add emscripten support
Date:   Sun,  9 Feb 2020 12:49:35 -0500
Message-Id: <20200209174937.22844-1-imirkin@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Demo available here:

https://people.freedesktop.org/~imirkin/edid-decode/

This is enough to generate the edid-decode.{js,wasm} files, and the html
was hand-modified from the demo one to remove a bunch of unnecessary
bits and provide the required integration. Happy to move it into the
project too if desired.

I'm a complete emscripten newbie, so I'm not 100% sure I've set this up
correctly, as alluded in patch 2's comments. But it does seem to work.
Given that the patches aren't crazy, I think it's reasonable to carry
them inside of the project.

Ilia Mirkin (2):
  edid-decode: add function to enable usage as a library
  edid-decode: add build rule for emscripten output

 Makefile        |  5 +++++
 edid-decode.cpp | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.24.1

