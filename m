Return-Path: <SRS0=qtPK=IG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C3C433E0
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2941865126
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 10:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCHKbi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Mar 2021 05:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhCHKbe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Mar 2021 05:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615199494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oXUV3uUBlNRwfYbVozczdNSXnAoQCd7tXcHJWhKqtFE=;
        b=CbZ0ZDZR8aow/k5iZHdihhjYEF7RzTv2Ho38OuqeJFen/fSSyW9n4CnbbHRsoAHHMjBLvi
        Jbonr9Y8xlV8jrXK+LGxwtgeg1qHu4s6LgNdT+kvjM/JgZjXCzxMQMV6D0KJLiT2r/8HNe
        BUGN7JiNwcf7FPiBSl8epDHU9aSSQzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-i_jz4GF0PDCeqeJndF0zJA-1; Mon, 08 Mar 2021 05:31:32 -0500
X-MC-Unique: i_jz4GF0PDCeqeJndF0zJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD82A1084D6C;
        Mon,  8 Mar 2021 10:31:30 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-220.ams2.redhat.com [10.36.114.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1DBD62AFA;
        Mon,  8 Mar 2021 10:31:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-media@vger.kernel.org
Subject: [PATCH 0/1] media: uvcvideo: Support devices that report an OT as an entity source
Date:   Mon,  8 Mar 2021 11:31:27 +0100
Message-Id: <20210308103128.33173-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro, et al.,

Fedora has been receiving quite a lot of bug reports (about 1 per day)
for a while now about the WARN_ON recently added by the:
"media: mc-entity.c: use WARN_ON, validate link pads" commit
triggering with uvcvideo (causing backtraces in dmesg).

I've been acting as a go-between for the Fedora bug reporters and
Laurent.

Laurent has written the fix which I'm posting here; I've provided
a Fedora kernel to the users with the fix added and they have confirmed
that this fixes the WARN_ON triggering.

Since Laurent is a bit short on time ATM I'm submitting his patch
upstream now that it has been tested.

Regards,

Hans


Laurent Pinchart (1):
  media: uvcvideo: Support devices that report an OT as an entity source

 drivers/media/usb/uvc/uvc_driver.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.30.1

