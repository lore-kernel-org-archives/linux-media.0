Return-Path: <SRS0=oIBZ=4N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61BC35DF9
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 08:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5432176D
	for <linux-media@archiver.kernel.org>; Tue, 25 Feb 2020 08:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="aKkHPQ6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgBYI4f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:56:35 -0500
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57721 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729268AbgBYI4f (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Feb 2020 03:56:35 -0500
Received: from [192.168.2.10] ([46.9.234.233])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 6W10jxLxojmHT6W13jVfFb; Tue, 25 Feb 2020 09:56:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582620994; bh=IwGppUDbo+fUB3HbL94E0ntBlQ1+gJJmZcWmynoGmmk=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=aKkHPQ6QuYMmAsJNO+1VA0WI2rE51noC8ZteWmom1rbjetn1aSnt/KbJ2BvkAN+xB
         HpW6C9cad0GBVb7hzMVEvukxyBSRt7xm/XFLTPZIAH67VDS6r/56LJQfcqkpqBQnbg
         mnMDGFqnRSmYA8CDzkekd38Va04gVFez7Jvy3GeQ1MKETfeuKYolFlqDKsaLEVmWV0
         9I3+LduuZVQEIJV3ZEjL6/TBem1jKPUIAoR9cGCndwIXDkCa0CsjO39ix5Hptd+n6W
         SGKRW0xx0yYhcn0sZFmx/Pu5RN4qchS3M0gptM7NJY22fQBALd3C2IrMcmMcqLkcHt
         2Y0ZGfd3/YulA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL v2 FOR v5.7] rockchip: Add the rkvdec driver
Message-ID: <d4cc12b2-3d24-95db-102b-e5091c067e76@xs4all.nl>
Date:   Tue, 25 Feb 2020 09:56:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOhOaXJlODrOMmfmKQodC/PmBPzpya6c7Vdu6GpL5AIhhUqT3dwii90uZH33daTmU09KoGIPNcRf9b3Z3WNxETthRdoTs9s4N4cSqYVCZWuL6ZlBvkdo
 igzdw7VbXs1GCq93MdPescl9L+lYaxt+qDmoL4STLXJC5Wlai40Tsqq61uPwmSsutwAL4p3blTYa3jT9aasIlkeYWsmQrUhWbjo=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Changes since v1: rebased with the latest master and replaced VFL_TYPE_GRABBER by _VIDEO.

Regards,

	Hans

The following changes since commit ef0ed05dcef8a74178a8b480cce23a377b1de2b8:

  media: staging/imx: Missing assignment in imx_media_capture_device_register() (2020-02-24 17:53:22 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-rkvdec

for you to fetch changes up to bab8c3cade08b173ce72cb16e0c651017b4f5c27:

  media: rkvdec: Add the rkvdec driver (2020-02-25 09:53:43 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Boris Brezillon (4):
      media: v4l2-core: Add helpers to build the H264 P/B0/B1 reflists
      media: hantro: h264: Use the generic H264 reflist builder
      media: dt-bindings: rockchip: Document RK3399 Video Decoder bindings
      media: rkvdec: Add the rkvdec driver

Jonas Karlman (1):
      media: uapi: h264: Add DPB entry field reference flags

 Documentation/devicetree/bindings/media/rockchip,vdec.yaml |   71 +++
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst           |   16 +
 MAINTAINERS                                                |    7 +
 drivers/media/v4l2-core/Kconfig                            |    4 +
 drivers/media/v4l2-core/Makefile                           |    1 +
 drivers/media/v4l2-core/v4l2-h264.c                        |  258 ++++++++++
 drivers/staging/media/Kconfig                              |    2 +
 drivers/staging/media/Makefile                             |    1 +
 drivers/staging/media/hantro/Kconfig                       |    1 +
 drivers/staging/media/hantro/hantro_h264.c                 |  237 +--------
 drivers/staging/media/rkvdec/Kconfig                       |   15 +
 drivers/staging/media/rkvdec/Makefile                      |    3 +
 drivers/staging/media/rkvdec/TODO                          |   11 +
 drivers/staging/media/rkvdec/rkvdec-h264.c                 | 1153 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec-regs.h                 |  223 +++++++++
 drivers/staging/media/rkvdec/rkvdec.c                      | 1134 +++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec.h                      |  123 +++++
 include/media/h264-ctrls.h                                 |    2 +
 include/media/v4l2-h264.h                                  |   85 ++++
 19 files changed, 3118 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,vdec.yaml
 create mode 100644 drivers/media/v4l2-core/v4l2-h264.c
 create mode 100644 drivers/staging/media/rkvdec/Kconfig
 create mode 100644 drivers/staging/media/rkvdec/Makefile
 create mode 100644 drivers/staging/media/rkvdec/TODO
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-h264.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-regs.h
 create mode 100644 drivers/staging/media/rkvdec/rkvdec.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec.h
 create mode 100644 include/media/v4l2-h264.h
