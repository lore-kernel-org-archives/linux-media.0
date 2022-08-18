Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132F0C00140
	for <linux-media@archiver.kernel.org>; Thu, 18 Aug 2022 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiHRUdn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiHRUdl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 18 Aug 2022 16:33:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E9E034
        for <linux-media@vger.kernel.org>; Thu, 18 Aug 2022 13:33:35 -0700 (PDT)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0BCE06601B46;
        Thu, 18 Aug 2022 21:33:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660854813;
        bh=tJ3R/WFg5/1Nu1xM45QmBOyXSzMAGRIV8mbBpXXZ27U=;
        h=From:To:Cc:Subject:Date:From;
        b=XSfKfeTZ0RXCfhxs0R+J591A3ylyx8VAJUERCqv2m+/PZcIWtmPOOmmcdV4Y6Fyqe
         0+ZMlTox0c1o349fsWjnC5n/DLUW+Gk4kELaWH5v3UjcowH9PUFzJjX3Pi4k2kJbD4
         4oDHyJG7lRAcpMlIYrOWrl0XnxZjybeD9Pu00srp4R0jhEAP5YuOaf43bG9FpmLFFk
         7ssAgXGvmlbkkLerXIF/ZFpKSqjTK4Dq3QJtUpbGZZ+Szai8IF5+TIzgNX/SxylhHW
         liiiGRo67CbSr6ZaJV0upSb9BLhKiu6kd9kRQYfVbUHcbf9mhreqij/QUzM2o6FoHV
         ZL0YILspzR9TA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v1 0/3] cedrus: Various bug fixes
Date:   Thu, 18 Aug 2022 16:33:05 -0400
Message-Id: <20220818203308.439043-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patchset addresses different bugs in cedrus driver. The first
patch address a possible NULL dereference in the probe function, the
second a possible infinite loop when passed invalid offsets and the
last one fixes a race condition in the watchdog implementation.

As of writing this cover later, fluster score remains unaffected
and score is 132/147 with GStreamer.

Dmitry Osipenko (2):
  media: cedrus: Set the platform driver data earlier
  media: cedrus: Fix endless loop in cedrus_h265_skip_bits()

Nicolas Dufresne (1):
  media: cedrus: Fix watchdog race condition

 drivers/staging/media/sunxi/cedrus/cedrus.c      | 4 ++--
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c  | 4 ++--
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 6 ++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.37.2

