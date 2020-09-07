Return-Path: <SRS0=gSK1=CQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B95C43461
	for <linux-media@archiver.kernel.org>; Mon,  7 Sep 2020 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1041821481
	for <linux-media@archiver.kernel.org>; Mon,  7 Sep 2020 10:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="wUfgPRrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgIGK1l (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:27:41 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51993 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728746AbgIGK11 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Sep 2020 06:27:27 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id FEMlktsuGgJnQFEMnkcCvh; Mon, 07 Sep 2020 12:27:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599474437; bh=MJ49WhVdescCBy3FFKwVPtdeaQ7aEPh189wMZiYJVQI=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=wUfgPRrRzjNR9e5NPqioJF7QeYrowaB//BnnVkOGtAvaS8S2P58DnpjK18wSqxVFq
         pRiyMqXmM7aPhIjVIRu2D9pjr4wRh9ff3FrVtIg9WZeM6grnCyQ/gqBzDELRf28aFk
         Bm9lAVBFqezuU3ePds4ZPo/njVS/dIU9fXNMm12cWPdVOPwac8P/rVCWXPnDc/KsWl
         jgANvzNX/DM3bSfa8qAyuJWNtYvkdd7ISfHQx8JH+aJWexpdQDbDCsx1OUBM11DCek
         H+aM6wclBjCIIeomYaF0nhon/ee5S6b7P2KncOuoI8UpyZsdnUj6mogrycjGVQx46w
         H+9IMjmNYwUqA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.10] Remove deprecated usbvision driver
Message-ID: <5c991e83-e97a-4f42-54be-41a400eba666@xs4all.nl>
Date:   Mon, 7 Sep 2020 12:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMCnhY2RE73MYFOvs9+ZVi4Z2zf+yC/LEdkqEpsGypAjxn8ShCYLRAhkfMekuwOUw/MKhNC6NDOiI5pP3Mfnvx41hlBW9Y3UF3saWnH2iQX/M6Rc/Tj0
 i+HI1Dcf95q4CYwATVzWp+c7NE4fCuMPVx83xq2wtSQDNOoBTlqtv4OHPTkod158kJ9oiUc/mM0qs9K0lgohFxynNKG2t2+qUst32kmFyX5EDS6hJaRmrqoW
 IhYkE5/QgMo7N1d3ApDqZNT91yLChd1J1ry7UnAuIeI=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

To quote the TODO of this driver:

--------------------------------------------------------------
The driver is deprecated and scheduled for removal by the end
of 2020.

In order to prevent removal the following actions would have to
be taken:

- clean up the code
- convert to the vb2 framework
- fix the disconnect and free-on-last-user handling (i.e., add
  a release callback for struct v4l2_device and rework the code
  to use that correctly).
--------------------------------------------------------------

Nobody picked this up, so it's time to retire this driver.

Regards,

	Hans

The following changes since commit 75992a4418b6c51d4da9c99aac7d92ab29148196:

  media: rc: rename ir_lirc_* functions to lirc_* (2020-09-03 16:19:27 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-usbvision

for you to fetch changes up to ec21cd0d227daaa06749f4de9f6221792edb1bec:

  usbvision: remove deprecated driver (2020-09-07 12:25:31 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      usbvision: remove deprecated driver

 Documentation/admin-guide/media/usb-cardlist.rst       |    1 -
 Documentation/admin-guide/media/usbvision-cardlist.rst |  283 ------
 MAINTAINERS                                            |    8 -
 drivers/staging/media/Kconfig                          |    4 -
 drivers/staging/media/Makefile                         |    1 -
 drivers/staging/media/usbvision/Kconfig                |   18 -
 drivers/staging/media/usbvision/Makefile               |    4 -
 drivers/staging/media/usbvision/TODO                   |   11 -
 drivers/staging/media/usbvision/usbvision-cards.c      | 1120 ----------------------
 drivers/staging/media/usbvision/usbvision-cards.h      |   70 --
 drivers/staging/media/usbvision/usbvision-core.c       | 2428 ------------------------------------------------
 drivers/staging/media/usbvision/usbvision-i2c.c        |  438 ---------
 drivers/staging/media/usbvision/usbvision-video.c      | 1643 --------------------------------
 drivers/staging/media/usbvision/usbvision.h            |  500 ----------
 14 files changed, 6529 deletions(-)
 delete mode 100644 Documentation/admin-guide/media/usbvision-cardlist.rst
 delete mode 100644 drivers/staging/media/usbvision/Kconfig
 delete mode 100644 drivers/staging/media/usbvision/Makefile
 delete mode 100644 drivers/staging/media/usbvision/TODO
 delete mode 100644 drivers/staging/media/usbvision/usbvision-cards.c
 delete mode 100644 drivers/staging/media/usbvision/usbvision-cards.h
 delete mode 100644 drivers/staging/media/usbvision/usbvision-core.c
 delete mode 100644 drivers/staging/media/usbvision/usbvision-i2c.c
 delete mode 100644 drivers/staging/media/usbvision/usbvision-video.c
 delete mode 100644 drivers/staging/media/usbvision/usbvision.h
