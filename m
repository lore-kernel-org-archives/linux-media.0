Return-Path: <SRS0=c3lX=A6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B615BC433E0
	for <linux-media@archiver.kernel.org>; Sun, 19 Jul 2020 21:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFD221744
	for <linux-media@archiver.kernel.org>; Sun, 19 Jul 2020 21:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="RNWe3132"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGSVQ0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:16:26 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:14721 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVQZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 19 Jul 2020 17:16:25 -0400
Date:   Sun, 19 Jul 2020 21:16:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595193383;
        bh=iHJCwGyfLi/ic3OraUqBRzHGFPaJD/yS0fa/qwNWLbc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=RNWe3132lffeIRtZi2wtEMzi3qU1nkWOVJHZwSp8hh8UguZwz/rDPqj9LF/3bTD++
         bOIcqIZZcx5RJM1kxmBPaypRV+EufiFPCB5cjNPrJMVH4/WlXcp4uTZmC7J56gPDjT
         d+U/zY76CwboSXSDmTZtUeiKxUM6jUwIQjvjWz8M=
To:     mchehab@kernel.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     linux-media@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH 1/2] v4l2: Correct kernel-doc inconsistency
Message-ID: <20200719211609.152611-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Silence documentation build warnings by correcting kernel-doc comment
v4l2_create_fwnode_links_to_pad and v4l2_create_fwnode_links functions.

./include/media/v4l2-mc.h:110: warning: Function parameter or member 'src_s=
d' not described in 'v4l2_create_fwnode_links_to_pad'
./include/media/v4l2-mc.h:110: warning: Function parameter or member 'sink'=
 not described in 'v4l2_create_fwnode_links_to_pad'
./include/media/v4l2-mc.h:134: warning: Function parameter or member 'src_s=
d' not described in 'v4l2_create_fwnode_links'
./include/media/v4l2-mc.h:134: warning: Function parameter or member 'sink_=
sd' not described in 'v4l2_create_fwnode_links'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/media/v4l2-mc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/media/v4l2-mc.h b/include/media/v4l2-mc.h
index 246eed398648..bdaa5f2f8ca2 100644
--- a/include/media/v4l2-mc.h
+++ b/include/media/v4l2-mc.h
@@ -89,8 +89,8 @@ int v4l_vb2q_enable_media_source(struct vb2_queue *q);
  * v4l2_create_fwnode_links_to_pad - Create fwnode-based links from a
  *                                   source subdev to a sink subdev pad.
  *
- * @src_sd - pointer to a source subdev
- * @sink - pointer to a subdev sink pad
+ * @src_sd: pointer to a source subdev
+ * @sink:  pointer to a subdev sink pad
  *
  * This function searches for fwnode endpoint connections from a source
  * subdevice to a single sink pad, and if suitable connections are found,
@@ -113,8 +113,8 @@ int v4l2_create_fwnode_links_to_pad(struct v4l2_subdev =
*src_sd,
  * v4l2_create_fwnode_links - Create fwnode-based links from a source
  *                            subdev to a sink subdev.
  *
- * @src_sd - pointer to a source subdevice
- * @sink_sd - pointer to a sink subdevice
+ * @src_sd: pointer to a source subdevice
+ * @sink_sd: pointer to a sink subdevice
  *
  * This function searches for any and all fwnode endpoint connections
  * between source and sink subdevices, and translates them into media
--=20
2.26.2


