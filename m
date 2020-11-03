Return-Path: <SRS0=g9gv=EJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F6C388F9
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5423720780
	for <linux-media@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="eMtzjso3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKCPRW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:17:22 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:47089 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728458AbgKCPQK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 3 Nov 2020 10:16:10 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Zy2VkqwR41KUMZy2YkA6pi; Tue, 03 Nov 2020 16:16:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1604416568; bh=KPjJ9DHK2lUP+oWBFPO2S3C6j9o7K1NmxIkmJFR3xDM=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=eMtzjso3WegxKoQYwHU8cgZO95VuYXnY5Brsu3X8s/uM4KgNL7KgAQC672jy9167J
         TTlUnZaqNJzbfSvnW86uTq28MfWFt+HJI4Gm840h0YD1GTeIcB5FchgeAAssovM3hV
         CfJar5YtzVD7GYUZqTEljwOpyJX3f/cd8iBbzanbStTycyGuPSk0EQh9gVuq28P3rO
         OMYEFDE2P0sswZ5JtdQZ6Fq6WnIxIfXmMjXQQfDQsL2DaL8jykNipygZeLfUG82VOz
         60Z/P6PuCGkO5IT0C94iL5xQL+ZpocS//Ove43PwDHYWESnr5/w7NRa/7G6KM5XW65
         1oCK0waCd6F7Q==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Randy Dunlap <rdunlap@infradead.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.10] Various fixes for v5.10
Message-ID: <fbf7c3ed-5dea-ada3-f09d-bab2e24a3183@xs4all.nl>
Date:   Tue, 3 Nov 2020 16:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOHVfmeinKlS6F8W05vcxlzm0VDFW2IfeP4RBVwq21l5muuwH1xLdtDHdUDDaqULMqpyuK0nH9Wp4ACS6k90eD284Xx0Gn4jipfu+g7Pvm+cZD9jV5zy
 w7mrepDanriPLx71Ez96zxudqmWZqJcRdXxL4M1Or/Kh1WXrKqOnUhWC3tjqfwNyzXRtsPkBCADwrlzt9jS3uumwXpVrdaCKpCMRa9fY7hTB3HIAPSmdSR5U
 vqDtfOqalv0rmqpndkF7cmWCa3H7KmwY4NA08wDWve3EQUwZO7HV1PIt2vfDUqsL
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Two fixes for build issues and one cedrus bug fix.

Regards,

	Hans


The following changes since commit dfe3d19bd092cefb184c6e65b881602c793edd33:

  Merge tag 'v5.10-rc1' into patchwork (2020-10-29 09:03:21 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.10a

for you to fetch changes up to 4bb9a231d16ca1b35164c438a9bc7b5da788479f:

  media: cedrus: h264: Fix check for presence of scaling matrix (2020-11-03 16:10:07 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Alexandre Courbot (2):
      media: mtk-vcodec: move firmware implementations into their own files
      media: mtk-vcodec: fix build breakage when one of VPU or SCP is enabled

Jernej Skrabec (1):
      media: cedrus: h264: Fix check for presence of scaling matrix

Randy Dunlap (1):
      media/platform/marvell-ccic: fix warnings when CONFIG_PM is not enabled

 drivers/media/platform/Kconfig                         |  28 ++++++--
 drivers/media/platform/marvell-ccic/mmp-driver.c       |   2 +
 drivers/media/platform/mtk-vcodec/Makefile             |  10 ++-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c |   2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c |   2 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c      | 174 ++-------------------------------------------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h      |   7 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h |  52 ++++++++++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c  |  73 +++++++++++++++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c  | 110 ++++++++++++++++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c       |   2 +-
 11 files changed, 281 insertions(+), 181 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_priv.h
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_vpu.c
