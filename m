Return-Path: <SRS0=8lr5=ED=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB83C388F7
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2604120759
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 22:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbgJ1W5z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:57:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59733 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbgJ1W5Y (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Oct 2020 18:57:24 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3997E6000A;
        Wed, 28 Oct 2020 22:57:20 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     hugues.fruchet@st.com, tomi.valkeinen@ti.com,
        sam@elite-embedded.com
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, slongerbeam@gmail.com,
        linux-media@vger.kernel.org
Subject: [RFC 0/3] media: ov5640: Adjust htot, rework clock tree, add LINK_FREQ
Date:   Wed, 28 Oct 2020 23:57:03 +0100
Message-Id: <20201028225706.110078-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hugues Tomi and Sam

   this small series collects Tomi's patch on adjusting htot which has been
floating around for some time with a rework of the clock tree based on
Hugues' and Sam's work on setting pclk_period. It also address the need to
suppport LINK_FREQUENCY control as pointed out by Hugues.

I'm sort of happy with the result as I've removed quite some chrun and the clock
tree calculation is more linear. All modes work except full-resolution which a
bit annoys me, as I can't select it through s_fmt (to be honest I have not
investigated that in detail, that's why an RFC).

Framerate is better than before, but still off for some combinations:
640x480@30 gives me ~40 FPS, 1920x1080@15 gives me ~7.
The other combinations I've tested looks good.

Can I have your opinion on these changes and if they help you with your
platforms?

I've only been able to test YUYV, support for formats with != bpp will need
some work most probably, but that was like this before (although iirc Hugues
has captured JPEG, right ?)

There's a bit more cleanup on top to be done (I've left TODOs around) and
probably the HBLANK calculation should be checked to see if it works with the
new htot values.

Thanks
  j

Jacopo Mondi (2):
  media: i2c: ov5640: Rework CSI-2 clock tree
  media: i2c: ov5640: Add V4L2_CID_LINK_FREQ support

Tomi Valkeinen (1):
  media: i2c: ov5640: Adjust htot

 drivers/media/i2c/ov5640.c | 176 +++++++++++++++++++++++++------------
 1 file changed, 118 insertions(+), 58 deletions(-)

--
2.28.0

