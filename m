Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB63C43465
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C6921531
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600688662;
	bh=QmQy/pcy8NDQkzIChqtlIR9cNRvb2k7XKNTUNepknX0=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=JHD/pIS5Q6FHcAEsMQrtT1yQyqX0GSgufB6X/m5EZo8c8SMR4bhueTW28cfQORXJB
	 OuO2XkqtM/fRwsqwg9mLQ9ew+7yQxaOtAd1O08Ilh5qJFWoru70jUzFUnObFIcnSfM
	 cfMprLKPmB8cctuxppmaEkDOFmqqr0M0vRBlkNnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIULnv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 07:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgIULnv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 07:43:51 -0400
Received: from mail.kernel.org (ip5f5ad5b1.dynamic.kabel-deutschland.de [95.90.213.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521E420EDD;
        Mon, 21 Sep 2020 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600688630;
        bh=QmQy/pcy8NDQkzIChqtlIR9cNRvb2k7XKNTUNepknX0=;
        h=From:To:Cc:Subject:Date:From;
        b=XiY5zKB0Jv54quG/qIq/lq2TKN0xvwyPlHutXGap3Vg4g6H7gpDgag/8e1rX6TDAH
         QwDKVgDEix6SmcxqlnJIUpkZgBtmX7eJfV5h/J6kvYetCNNheAxFjdXYUlbbynYmJ+
         SLkWKFdQEDyEYeiFx3k0qnKizRyHJjMnd2B2SRvw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kKKEV-0004V4-Uj; Mon, 21 Sep 2020 13:43:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/9] vidtv: fix several things on it
Date:   Mon, 21 Sep 2020 13:43:37 +0200
Message-Id: <cover.1600688419.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

There are still several issues at vidtv driver. This series address
the ones I found so far.

After this series, the generated TS output can now be decoded
by Kaffeine, and probably by other DVB players.

There is still something weird there, though: after playing some
notes, there's a long silence that happens only when played with
VLC.  I suspect that the package times are not ok yet, but further
investigation is required.

Mauro Carvalho Chehab (9):
  media: vidtv: simplify PCR logic to get jiffies
  media: vidtv: remove more ENDIAN_BITFIELD nonsense
  media: vidtv: fix initialization of the network_id field at SDT
  media: vidtv: cleanup PSI version numbers
  media: vidtv: cleanup SDT string identifiers
  media: vidtv: fix a typo
  media: vidtv: simplify parameters for vidtv_pes_write_stuffing()
  media: vidtv: rewrite the adaption field logic
  media: vidtv: fix decoding with gstreamer and Vlc

 .../media/test-drivers/vidtv/vidtv_channel.c  |   7 +-
 drivers/media/test-drivers/vidtv/vidtv_mux.c  |   8 +-
 drivers/media/test-drivers/vidtv/vidtv_pes.c  | 216 +++++++++++-------
 drivers/media/test-drivers/vidtv/vidtv_pes.h  |   4 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c  |  18 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.h  |   8 -
 drivers/media/test-drivers/vidtv/vidtv_ts.h   |  13 --
 7 files changed, 153 insertions(+), 121 deletions(-)

-- 
2.26.2


