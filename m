Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81966C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5862C20857
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 11:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfDHLEF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:04:05 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:36532 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfDHLEF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 07:04:05 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DS4HhTHSRNG8zDS4IhlZN7; Mon, 08 Apr 2019 13:04:03 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/7] cec: introduce cec_notifier_find_hdmi_dev helper
Date:   Mon,  8 Apr 2019 13:03:54 +0200
Message-Id: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfH7OL5DyzLDdVztcZ2ma7nbJ3Ot8rLyWGBmOvfeD5qfFvnAu6OOoeEbfRkcN7vksAw92Z8RLCAmYWndZqItjHaO1Wndrg33DynsBefJykKrmVIm3XBzk
 DoRjdktsQh9Xn0So0BGzw8cLNZLtB0m7Ctr0wl5Pghv9OaeTRJyOxu3177FT+igpTNyuuvbyA+OxXuzRfRE6NuNUgFGiq59Jm4fSAbbL1mi+F+h6JdTaFLOt
 1Y4DpCVvJDHS1+pNiPNLjx14Y1AJO4BR9aAWa4NA0MFQ5WTyR6FQS2rzZOAKNeJsUj1Qtp39qn+I168RCjqlPm3Y5Dmj6zs7j0bhuR9h6/CD2XKvAZPaFj9D
 T7pFBKn/cdyQxzlD+GIzc7pYm2fCfGz11qQeZkFWgKDkO1HCej3y9SrH/lQ0fn+Kbq7P/TUmwV3diRgP4/GwlFBXUlzGj8z0VppswTpdTgtgFG9TqcY=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Wen Yang reported that some CEC drivers incremented the refcount
of the HDMI device, but never decremented it, potentially leading
to memory leaks.

Rather than fixing each driver I decided to create a helper function
that finds the HDMI device and handles the refcounting correctly.

Two drivers (seco-cec and cros-ec-cec) still required a manual patch.

Regards,

	Hans

Hans Verkuil (7):
  cec-notifier: add cec_notifier_find_hdmi_dev helper
  meson: ao-cec: use new cec_notifier_find_hdmi_dev helper
  s5p_cec: use new cec_notifier_find_hdmi_dev helper
  stih_cec: use new cec_notifier_find_hdmi_dev helper
  tegra_cec: use new cec_notifier_find_hdmi_dev helper
  seco-cec: decrement HDMI device refcount
  cros-ec-cec: decrement HDMI device refcount

 drivers/media/cec/cec-notifier.c              | 24 +++++++++++++++++++
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  1 +
 drivers/media/platform/meson/ao-cec.c         | 16 ++++---------
 drivers/media/platform/s5p-cec/s5p_cec.c      | 16 ++++---------
 drivers/media/platform/seco-cec/seco-cec.c    |  1 +
 drivers/media/platform/sti/cec/stih-cec.c     | 21 ++++++----------
 drivers/media/platform/tegra-cec/tegra_cec.c  | 14 ++++-------
 include/media/cec-notifier.h                  | 19 ++++++++++++++-
 8 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.20.1

