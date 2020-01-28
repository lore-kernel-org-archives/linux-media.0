Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F542C35246
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 06:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E8520678
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 06:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580193667;
	bh=qRfrpNKmqQXfhes6bXZ5dPrAD/bdvvGUK7AFtq/eYBA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dLd2DJKTpW0srkY1OIybFNhVytuiiV8MUso52bCScfpQ/RDfdLffVl7wC9hD8jFIM
	 SuZojD89QpU+96YcuYZzkF780EH3nn222CFvQhNMW+guO0gUA4pAv09MmGLKFTPrEf
	 GbKbKb5hmDkb7aTImq7Eg4+HTGwuwd2tiHwUclbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgA1GlG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:41:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgA1GlG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 01:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hj3x6hGuIsjrHf6MaVRlpxCrQuBrNOlZdi/Yvl7xCTw=; b=I9I6B4Vyf92AdCWGghUchQa66
        cfrK8tVpsL5VfzWuyMOq3547Goq0cjr8u4knuj0rb8pW5Q5LBuJUHzrfCFrpRPAWYiDdO8EpMylKV
        mVlJ5XSymhORk/1S2nVylpsmZmKbqG25wNCTpCQFa7kGr+jcV+g44e/rybR3IbYvZFb2QexR3Avv7
        jRBvHzJKPYkgddJsFhHRZeOP7sKTksy5rt11mb7ozVKib2ajz3tJZi6yojXKRNmuQBpxofrwYWP6i
        CaKp8n8wW4oagIaBCxaIhlpIDGH/zDPjtUgbtgpDQXVk83NuRBFHVxmVL373iRKLrJWbwvPjFLaA6
        18tDpe/vQ==;
Received: from [80.156.29.194] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwKYb-00077m-Vt; Tue, 28 Jan 2020 06:41:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iwKYa-001Ae7-1G; Tue, 28 Jan 2020 07:41:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/2] docs: usb: remove some broken references
Date:   Tue, 28 Jan 2020 07:41:00 +0100
Message-Id: <00008303fde6b4e06d027d3b76ae7032614a7030.1580193653.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

It seems that some files were removed from USB documentation.

Update the links accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/usb/index.rst      | 2 --
 Documentation/usb/text_files.rst | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
index e55386a4abfb..36b6ebd9a9d9 100644
--- a/Documentation/usb/index.rst
+++ b/Documentation/usb/index.rst
@@ -22,11 +22,9 @@ USB support
     misc_usbsevseg
     mtouchusb
     ohci
-    rio
     usbip_protocol
     usbmon
     usb-serial
-    wusb-design-overview
 
     usb-help
     text_files
diff --git a/Documentation/usb/text_files.rst b/Documentation/usb/text_files.rst
index 6a8d3fcf64b6..1c18c05c3920 100644
--- a/Documentation/usb/text_files.rst
+++ b/Documentation/usb/text_files.rst
@@ -16,12 +16,6 @@ USB devfs drop permissions source
 .. literalinclude:: usbdevfs-drop-permissions.c
     :language: c
 
-WUSB command line script to manipulate auth credentials
--------------------------------------------------------
-
-.. literalinclude:: wusb-cbaf
-   :language: shell
-
 Credits
 -------
 
-- 
2.24.1

