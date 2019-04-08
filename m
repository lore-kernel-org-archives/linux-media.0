Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711CC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F8921473
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o/rvHZTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDHMSJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:18:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51728 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHMSI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:18:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so14095270wmf.1
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UpAj9YfdUW4CMDRxIiHz7xX8khEqdof0qRT0yl1Om0=;
        b=o/rvHZTFAe0VdbSzgTiiC99n/h4CzCWZe0CTp2ayr1+YHssIea0MmB9jYzr5+9LWd9
         0MO9ytqi0WMvFDguDixKX9s6xDFoDaZcSccQOeJvU+OX5PoNGreS4m1AwGJXXvtpICCZ
         Z4iGah8tY3Bp3XvTIj5qlSYcAnnAVn92FXwsvM4sZM7WE2nIcN2M2LPxQXeNL43SD34I
         sRoyIXDRK3k8hz/MKTYVr23UtPnn/4mxD+IsjvvqWLcYyYjOhf6CRlhfm+ZA3seLfOz8
         8J5VkxEFMQl4GxN5P2GRwLjQPIgBIVWNW+X14qMWOE6o3StUViVfsU7Hf9vh4NEyn3vd
         ulKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UpAj9YfdUW4CMDRxIiHz7xX8khEqdof0qRT0yl1Om0=;
        b=ZDkhuoQNUZfOO8hJWs1BxOC7gY1TIfRUiKqEQoORv3A1L3TxLGcDEPWorfiyZ3sIW3
         sg79BOktzUGTp/x/6u+c5yGFdr38niRRVbZgUI4VSagxG2mzEHBc/5qkwKReh3V2ymS6
         MY1q7iBa0wBUeE3PN5XvGmWESYxMXBewAne1QtP78blCbrXI+Kbcbm1Ujh8tPaL8NAAs
         Qu6FGdzCKZnP9oC7qgbuwbZitPFMYMq27PlMvOwoKDyVJuSKy86hvWYIXYlcQWVXgBqF
         RxAUwUfERXDTeheuZIv9TdPLrJxpQX19cFOrb4bLVdFdbxmaDmloUC1WkPDbMw3B2sCm
         cojw==
X-Gm-Message-State: APjAAAUmwrZnby5QaIYBXFLZaC8kgAFkG73BF/Wr2tHKYUnROC/B5pMk
        0e/83YyTBonTWLiHPViO9pXK4A==
X-Google-Smtp-Source: APXvYqzLuoC3RfA2e2x0g4Fs95byB5EytlhVbbhVCctSoT7tKo/dTwrmxUbR2pSfQyOoo8Fat4opfg==
X-Received: by 2002:a1c:9e96:: with SMTP id h144mr17941211wme.33.1554725887208;
        Mon, 08 Apr 2019 05:18:07 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e1sm52865103wrw.66.2019.04.08.05.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 05:18:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] media: platform: Add support for the Amlogic Meson G12A AO CEC Controller
Date:   Mon,  8 Apr 2019 14:18:02 +0200
Message-Id: <20190408121805.2870-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The Amlogic G12A SoC embeds a second CEC controller with a totally
different design.

The two controller can work in the same time since the CEC line can
be set to two different pins on the two controllers.

This second CEC controller is documented as "AO-CEC-B", thus the
registers will be named "CECB_" to differentiate with the other
AO-CEC driver.

Unlike the other AO-CEC controller, this one takes the Oscillator
clock as input and embeds a dual-divider to provide a precise
32768Hz clock for communication. This is handled by registering
a clock in the driver.

Unlike the other AO-CEC controller, this controller supports setting
up to 15 logical addresses and supports the signal_free_time settings
in the transmit function.

Unfortunately, this controller does not support "monitor" mode.

This patchset :
- Update the bindings for this controller
- Add the controller driver
- Update the MAINTAINERS entry

Changes since v3:
- Use the cec_notifier_find_hdmi_dev() introduced in [1]

Changes since v2:
- Really fixed compatible used in driver
- Collected bindings review tag

Changes since v1:
- Fixed typos in bindings
- Fixed compatible used in driver, using the bindings defined one
- Fix regmap return value handling
- Fix irq error handling
- Fixed wrong clk unprepare on oscin

[1] https://patchwork.linuxtv.org/patch/55513/

Neil Armstrong (3):
  media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
  media: platform: meson: Add Amlogic Meson G12A AO CEC Controller
    driver
  MAINTAINERS: Update AO CEC with ao-cec-g12a driver

 .../bindings/media/meson-ao-cec.txt           |  13 +-
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |  13 +
 drivers/media/platform/meson/Makefile         |   1 +
 drivers/media/platform/meson/ao-cec-g12a.c    | 779 ++++++++++++++++++
 5 files changed, 804 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/meson/ao-cec-g12a.c

-- 
2.21.0

