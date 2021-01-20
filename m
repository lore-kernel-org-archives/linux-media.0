Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E714C07EBC
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 10:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3223332
	for <linux-media@archiver.kernel.org>; Wed, 20 Jan 2021 10:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbhATKma (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 Jan 2021 05:42:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732965AbhATKVn (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 Jan 2021 05:21:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97B8BAAAE;
        Wed, 20 Jan 2021 10:21:00 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: [PATCH 0/2] media: dvb-usb: Fix UAF and memory leaks
Date:   Wed, 20 Jan 2021 11:20:55 +0100
Message-Id: <20210120102057.21143-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

here is a patch set to address the use-after-free at disconnecting
a USB DVB device that was recently reported on openSUSE Bugzilla.
The bug itself seems to be a long-standing one, and I spotted
another memory leak there, which is covered in the first patch.


Takashi

===

Takashi Iwai (2):
  media: dvb-usb: Fix memory leak at error in dvb_usb_device_init()
  media: dvb-usb: Fix use-after-free access

 drivers/media/usb/dvb-usb/dvb-usb-init.c | 41 +++++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

-- 
2.26.2

