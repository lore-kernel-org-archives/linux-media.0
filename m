Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB95C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B8021841
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfDJJNh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:48066 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729068AbfDJJNh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:13:37 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9IUhpDJCUjKfE9IVhgr8p; Wed, 10 Apr 2019 11:13:35 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCHv2 0/7] cec: introduce cec_notifier_parse_hdmi_phandle helper
Date:   Wed, 10 Apr 2019 11:13:27 +0200
Message-Id: <20190410091334.8654-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIefm1wvOkBIt1bXOX7G3Qkbt7geMjELYYlM/3tAmvR+Vej4U7mmDzhU3CAOiDJxDERX+fKtJxhmq5rm9HXyPmIdt66EnCPHgJzIm/LRsLf0OKu49flx
 I4YPhZNoM1JHwcngK5DtkdjsFEvDAVjzoPRYqTWk9YnasaINJR9XMELMhb/2txL0xQaH0qQ4UnPsgjJXMRZXoTfHHWIZOxWcW2EcUTNwsWcpJWHiefZLckjc
 OWpppriec7OkxmJp4c+WB+Dhwuapxn2WA/Juf2wrYMuYH274Gvw20kRBfEJ7/eH6yrkgHCbyETw1XHlQdTbGgYWgKk6qfL6pdQZ9+END4u+mJjmd1c5AdAn7
 el0U08B3hS2+9Yn9knf4Mik+CHpLpO4dSIFG2XC3MZV5Wv3e4waS1GItQQuOJ62u83bNqMX6+Q6fc4E3aik7I8TKDE4zpWBlaMMjwfKr1CBDFoS+v0o=
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

Changes since v1:

- Renamed the helper function to cec_notifier_parse_hdmi_phandle
- Uppercased 'hdmi' in the error message ("...find HDMI node...")
- Added a comment in the helper clarifying that the returned
  device pointer is used as a key and so shouldn't take a reference.

Hans Verkuil (7):
  cec-notifier: add cec_notifier_parse_hdmi_phandle helper
  meson: ao-cec: use new cec_notifier_parse_hdmi_phandle helper
  s5p_cec: use new cec_notifier_parse_hdmi_phandle helper
  stih_cec: use new cec_notifier_parse_hdmi_phandle helper
  tegra_cec: use new cec_notifier_parse_hdmi_phandle helper
  seco-cec: decrement HDMI device refcount
  cros-ec-cec: decrement HDMI device refcount

 drivers/media/cec/cec-notifier.c              | 30 +++++++++++++++++++
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  1 +
 drivers/media/platform/meson/ao-cec.c         | 16 ++++------
 drivers/media/platform/s5p-cec/s5p_cec.c      | 16 ++++------
 drivers/media/platform/seco-cec/seco-cec.c    |  1 +
 drivers/media/platform/sti/cec/stih-cec.c     | 21 +++++--------
 drivers/media/platform/tegra-cec/tegra_cec.c  | 14 +++------
 include/media/cec-notifier.h                  | 19 +++++++++++-
 8 files changed, 71 insertions(+), 47 deletions(-)

-- 
2.20.1

