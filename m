Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BCAC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D51920675
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDLKfY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:35:24 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:54497 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfDLKfY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 06:35:24 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EtWjh0BJqNG8zEtWkhCMfn; Fri, 12 Apr 2019 12:35:22 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] cec fixes, new Meson G12A AO CEC driver
Message-ID: <cb09f54d-e03d-e09b-cdea-ad419e0b5514@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:35:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKuQJqoiZgAthklEBw4jEMvTObj1R39ODwuPibUnU7KgTrTn89rgnloWGyknvGWX/tG9uybWc3Q9EXMc2Q4nbbhoTjSa8+B3EG9yqLxVQDsjVZYzYnKN
 G7JZlyC4UA2GL7jVsJzFh3/1BS5rmviODWr1BXPFLWdPmYjgXC4GAdZyz6fT4+r+3rFOdDb2Hs/WqhKW6muuRTZSU/2f3G2f8+HO7dZYXzHY4kdVbSvoQqZM
 Rpti2dT8XCVTuY4YOocPhurOb1iPpWnmiGDn8a9egkHUJ2xP74I8qD1kcGQddWhFoNL+mSh0OqKnQYP6wSYNZQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fixes to prevent incrementing but never decrementing the hdmi device
refcount, and the series for the new Meson CEC driver is sitting on top
of those.

Regards,

	Hans

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2f

for you to fetch changes up to 8ce1eb87ae608c4b0b51be9fd322b3bfa50659b0:

  MAINTAINERS: Update AO CEC with ao-cec-g12a driver (2019-04-12 11:45:19 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (7):
      cec-notifier: add cec_notifier_parse_hdmi_phandle helper
      meson: ao-cec: use new cec_notifier_parse_hdmi_phandle helper
      s5p_cec: use new cec_notifier_parse_hdmi_phandle helper
      stih_cec: use new cec_notifier_parse_hdmi_phandle helper
      tegra_cec: use new cec_notifier_parse_hdmi_phandle helper
      seco-cec: decrement HDMI device refcount
      cros-ec-cec: decrement HDMI device refcount

Neil Armstrong (3):
      media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
      media: platform: meson: Add Amlogic Meson G12A AO CEC Controller driver
      MAINTAINERS: Update AO CEC with ao-cec-g12a driver

 Documentation/devicetree/bindings/media/meson-ao-cec.txt |  13 +-
 MAINTAINERS                                              |   1 +
 drivers/media/cec/cec-notifier.c                         |  30 ++
 drivers/media/platform/Kconfig                           |  16 +
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c         |   1 +
 drivers/media/platform/meson/Makefile                    |   1 +
 drivers/media/platform/meson/ao-cec-g12a.c               | 779 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/media/platform/meson/ao-cec.c                    |  16 +-
 drivers/media/platform/s5p-cec/s5p_cec.c                 |  16 +-
 drivers/media/platform/seco-cec/seco-cec.c               |   1 +
 drivers/media/platform/sti/cec/stih-cec.c                |  21 +-
 drivers/media/platform/tegra-cec/tegra_cec.c             |  14 +-
 include/media/cec-notifier.h                             |  19 +-
 13 files changed, 878 insertions(+), 50 deletions(-)
 create mode 100644 drivers/media/platform/meson/ao-cec-g12a.c
