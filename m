Return-Path: <SRS0=4kUN=CX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E9C43461
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D355C221E8
	for <linux-media@archiver.kernel.org>; Mon, 14 Sep 2020 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600074305;
	bh=WVaCngKH6hOQXbmycVF5potHAglRSisP0Tz3s7uY0lQ=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=fpbJYfVf4Oz6BD5Kuitw7eBa2BAxk22Eu7R8v5PY+yYaDpBrEFIxF0me+sGJ59+e4
	 hqMUkjzxgqXutIAbfHGklHFxy4fHMgXZZrSEY3IzBLamlUDiSdpH6Zx/iBt+EQzWpy
	 rh5m4qW1D0p3VK3N0/zTc+9IcdNOBzbd95csrbZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgINJEq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 14 Sep 2020 05:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgINJDc (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 14 Sep 2020 05:03:32 -0400
Received: from mail.kernel.org (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D550822206;
        Mon, 14 Sep 2020 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600074212;
        bh=WVaCngKH6hOQXbmycVF5potHAglRSisP0Tz3s7uY0lQ=;
        h=From:To:Cc:Subject:Date:From;
        b=vRLAokk67AjZmERId2n86bYwpvhUiyJgETPHULXK5eOevHHy1uaoeThSrr55sLWU6
         TT79bdqzAP2lkNsqTKmKkGrt9KQgttiKqoZpZMr1e+3DMbEoTM8pwF3+qAV23+g2XB
         3lheIgL0AtK+iGRca/a1ycZPfkAIEpwnM6aA/xk0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kHkOV-002dzP-R2; Mon, 14 Sep 2020 11:03:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH RFC 00/11] Solve some issues and do some improvements at vidtv
Date:   Mon, 14 Sep 2020 11:03:15 +0200
Message-Id: <cover.1600073975.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch series is not ready yet. However, as there are some problems reported
when this driver got merged at linux-next, let me send it, in order to avoid
someone to address the same problems I already fixed.

There are still some things to be fixed there. For example, the bitfield 
endiannes logic for MPEG-TS tables are wrong. My plan is to address those
along this week.

Also, Kaffeine is not properly detecting the audio streams. It will likely need
some additional patches for it to properly detect and work with SMPTE 302m
audio streams.

Mauro Carvalho Chehab (11):
  media: vidtv: add modaliases for the bridge driver
  media: vidtv: prefer using dev_foo() instead of pr_foo()
  media: vidtv: fix 32-bit warnings
  media: vidtv: fix frequency tuning logic
  media: vidtv: add an initial channel frequency
  media: vidtv: get rid of some endiannes nonsense
  media: vidtv: remove a wrong endiannes check from s302m generator
  media: vidtv: properly initialize the internal state struct
  media: vidtv: add basic support for DVBv5 stats
  media: vidtv: get rid of the work queue
  media: vidtv: increment byte and block counters

 .../media/test-drivers/vidtv/vidtv_bridge.c   |  35 ++-
 .../media/test-drivers/vidtv/vidtv_bridge.h   |   3 +
 .../media/test-drivers/vidtv/vidtv_channel.c  |  23 +-
 .../media/test-drivers/vidtv/vidtv_common.c   |   4 +-
 .../media/test-drivers/vidtv/vidtv_demod.c    | 242 +++++++++---------
 .../media/test-drivers/vidtv/vidtv_demod.h    |   4 -
 drivers/media/test-drivers/vidtv/vidtv_mux.c  |  32 ++-
 drivers/media/test-drivers/vidtv/vidtv_mux.h  |   9 +-
 drivers/media/test-drivers/vidtv/vidtv_pes.c  |  12 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c  |  32 ---
 .../media/test-drivers/vidtv/vidtv_s302m.c    |  10 +-
 .../media/test-drivers/vidtv/vidtv_tuner.c    |  41 ++-
 12 files changed, 221 insertions(+), 226 deletions(-)

-- 
2.26.2


