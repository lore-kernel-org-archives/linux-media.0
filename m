Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA62C77B7D
	for <linux-media@archiver.kernel.org>; Fri, 19 May 2023 00:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjESADF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 May 2023 20:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjESADE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 May 2023 20:03:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B233DE77
        for <linux-media@vger.kernel.org>; Thu, 18 May 2023 17:03:03 -0700 (PDT)
Received: from db550.. (node-1w7jr9st5p2esmclet71ntnwp.ipv6.telus.net [IPv6:2001:569:beb1:1500:6f9d:3a5c:4d25:e949])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dbrouwer)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF90E660572A;
        Fri, 19 May 2023 01:03:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684454582;
        bh=0P8l8jhwA7b/zYArG6Pbxvy35RkHYmCbfLeAq+59UDs=;
        h=From:To:Cc:Subject:Date:From;
        b=FDluQ8EAE3vnIbjim0NNxLVWsL1RM+k6udT8CFIB/26kCLjISEWJlaoMRCvKWDJZc
         IGngYyxAb6Oxc7f3KENxhrpdgu1ruHFAQLHbfqmoYo/g1gu4N9I3QYoJ1SL92cqdxf
         7eISA2in0uVu5sNDq4oEcdSD8g6Mt69WInpNOF/6f2thTlEICvs+znllM0dB9U3OCx
         x9Tl7g24SwOrBs3Fy+NHY051S/+0+4QoUywWntf9i+bj2ldtTEkWubfrjWZFGkjiSn
         WA5ZbHi78SVlYW+yFoM0dF1tyD9/KcYHxnVwN8XeMPd0VWGo2L38mJCCgR9nkF7+rG
         FX4QWdCvT+QfQ==
From:   Deborah Brouwer <deborah.brouwer@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH 0/2] v4l2-tracer: add tuner ioctls
Date:   Thu, 18 May 2023 17:02:46 -0700
Message-Id: <cover.1684453027.git.deborah.brouwer@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is just some tracing for tuners that I was
recently using to debug bttv, and then revised after
looking at this helpful patch:

https://lore.kernel.org/linux-media/20230518133649.6913-1-marex@denx.de/T/#u

Incidentally these changes are independent of the
v4l2-tracer debug series so could be added before
or after.

https://lore.kernel.org/linux-media/cover.1681245372.git.deborah.brouwer@collabora.com/

Deborah Brouwer (2):
  v4l2-tracer: stop stringifying v4l2_input "tuner"
  v4l2-tracer: add G/S TUNER ioctls

 utils/v4l2-tracer/libv4l2tracer.cpp  |  2 ++
 utils/v4l2-tracer/retrace.cpp        | 28 ++++++++++++++++++++++++++
 utils/v4l2-tracer/trace.cpp          |  4 ++++
 utils/v4l2-tracer/v4l2-tracer-gen.pl | 30 ++++++++++++++++++++++++----
 4 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.40.1

