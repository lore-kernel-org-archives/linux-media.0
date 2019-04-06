Return-Path: <SRS0=AJrZ=SI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B2C282DA
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E438D213A2
	for <linux-media@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psFkHR8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfDFXJM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:09:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36190 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFXJM (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 6 Apr 2019 19:09:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so5075154pgc.3
        for <linux-media@vger.kernel.org>; Sat, 06 Apr 2019 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t0VZd5HEnUa9tWQFBI9tjeiMJDvgSoHeymrL4HTk/78=;
        b=psFkHR8JSRqJI/PkErMnMHgWzi0a0KiOgxVZTfvRKYlo62zR5SfvXK7z+qi4WsJ33d
         TLRDdRmzew8kT+6Dx0x8ogaDBM9ZaHZyWYNs14mrimtcwcOrvK+887RHDMP5FOP0qbpY
         sg73ij5nEeEHtq1/U3AyKatvjIfW9zwz+xOK8dvTXMfYAtIXXPBw1CSwNEcvV+Dr4jPt
         HnEXEYpcvCpU0cgniZwHiQB6ycirZicu1p+fxuRqD1ObshxFij+Q3xSnznjTIj4qX3gV
         bcoDHUMI8kWWB9NM2EJzp7LZ/jkCJ7Bmrbe5F+6BDkyL8YOrSGiNr7P6Zc6/NlcQvAN7
         lDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t0VZd5HEnUa9tWQFBI9tjeiMJDvgSoHeymrL4HTk/78=;
        b=rXkZJ+p37+ysjGKn2GvcMh0hCwlLzsnFz1Ssc3HgsrWXhPVJZyVWN+ylvfZXpTVToL
         U1eslvaQVpWM3XQTHYwbJKvppb5dd8IVw3u4j7pjMPHilgpgl5E+PIgWQLuXghUlbe7Z
         7DbIW8x6erB87+xZOKOaESHyaBUZTYcWX928M6881Q79243B+Ekxog0ryKMnKsE/JFzw
         DwnpFCnFp4CiiWf5en2uiyOwnHxnzFNdcN/6UycMUXsWvfoKOTfK2RvvV2bzOyG26FSx
         XrAixIrtPRnOthtKEqU7Bg+92TnTICK+4u3Z6Wd5RncvgtKwcYIG/Pf7zriwuRZrVhCh
         Ocbw==
X-Gm-Message-State: APjAAAXf3g95PiD/PvfrxpHBGi0ncBAwPHDb2v4oyxBjs+eDaUWxFCDI
        7dVvaKR2ExI1N9n6PtNnqn8RuneW
X-Google-Smtp-Source: APXvYqzAN/pLYvZy9cXda6Btfr6z21BRefkE4IuC4T6hTF2oifp+rTNXAiFKV6hv0chJglD7kAZSwQ==
X-Received: by 2002:a63:525f:: with SMTP id s31mr20019713pgl.172.1554592150454;
        Sat, 06 Apr 2019 16:09:10 -0700 (PDT)
Received: from mappy.sklembedded.com (c-24-4-228-186.hsd1.ca.comcast.net. [24.4.228.186])
        by smtp.gmail.com with ESMTPSA id i31sm44550127pgi.36.2019.04.06.16.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 16:09:09 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>
Subject: [PATCH v7 0/5] media: imx: Add Rec.709 and limited range encoding support
Date:   Sat,  6 Apr 2019 16:08:58 -0700
Message-Id: <20190406230903.16488-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patchset adds support for Rec.709 encoding and inverse encoding,
and encoding between both full-range and limited-range quantization
for both YUV and RGB, to ipu-ic. The imx-media driver can now support
both BT.601 and Rec.709 encoding, and limited and full-range quantization.

History:
v7:
- removed the run-time transformation of coefficients from full-range
  to limited-range, and instead hard-code all the coefficient tables.
- moved the coefficient tables into a new module ipu-ic-csc.c.
- introduced ipu_ic_calc_csc() which pre-determines coefficients,
  which are then passed to ipu_ic_task_init(_rsc)() as a filled
  'struct ipu_ic_csc'.
- added support for limited-range RGB.

v6:
- tweak some of the coefficients slightly, they were not getting
  rounded correctly.
- move the introduction of calc_csc_coeffs() to an earlier patch for
  easier patch readability.

v5:
- the hard-coded encode coefficients now convert only between
  full-range quantization. A new function is added to transform the
  coefficients to limited-range at input or output.
- add a bug fix patch for saturation bit in TPMEM register.
- add a patch to fully describe input and output colorspace to
  the IC task init functions.
- add imx_media_try_colorimetry(), called at all sink/source pad try_fmt.

v4:
- fix a compile error in init_csc(), reported by Tim Harvey.

v3:
- fix some inconsistent From: and Signed-off-by:'s.
  No functional changes.

v2:
- rename ic_csc_rgb2rgb matrix to ic_csc_identity.
- only return "Unsupported YCbCr encoding" error if inf != outf,
  since if inf == outf, the identity matrix can be used. Reported
  by Tim Harvey.
- move ic_route check above default colorimetry checks, and fill default
  colorspace for ic_route, otherwise it's not possible to set BT.709
  encoding for ic routes.


Steve Longerbeam (5):
  gpu: ipu-v3: ipu-ic: Fix saturation bit offset in TPMEM
  gpu: ipu-v3: ipu-ic: Fully describe colorspace conversions
  gpu: ipu-v3: ipu-ic-csc: Add support for limited range encoding
  gpu: ipu-v3: ipu-ic-csc: Add support for Rec.709 encoding
  media: imx: Try colorimetry at both sink and source pads

 drivers/gpu/ipu-v3/Makefile                 |   4 +-
 drivers/gpu/ipu-v3/ipu-ic-csc.c             | 410 ++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-ic.c                 | 138 +++----
 drivers/gpu/ipu-v3/ipu-image-convert.c      |  28 +-
 drivers/staging/media/imx/imx-ic-prp.c      |   6 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c |  42 +-
 drivers/staging/media/imx/imx-media-csi.c   |  19 +-
 drivers/staging/media/imx/imx-media-utils.c |  73 ++--
 drivers/staging/media/imx/imx-media-vdic.c  |   5 +-
 drivers/staging/media/imx/imx-media.h       |   5 +-
 drivers/staging/media/imx/imx7-media-csi.c  |   8 +-
 include/video/imx-ipu-v3.h                  |  56 ++-
 12 files changed, 614 insertions(+), 180 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-ic-csc.c

-- 
2.17.1

