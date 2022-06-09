Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC9CCA473
	for <linux-media@archiver.kernel.org>; Thu,  9 Jun 2022 14:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343593AbiFIO0f (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbiFIO0a (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 9 Jun 2022 10:26:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968A472224;
        Thu,  9 Jun 2022 07:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B2F9B82E00;
        Thu,  9 Jun 2022 14:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B602C341C0;
        Thu,  9 Jun 2022 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784787;
        bh=BDkDwzqe/xNBOHFU1U6C1lsC1hcKmfItFKnBeNnP+vI=;
        h=From:To:Cc:Subject:Date:From;
        b=XfrS1xqToL6zmX8vhCK37yyiLPLH5/9EELt1AUy7r2ZTeeUpyYvJ56q65qfhmTyzq
         iEt7Rhu0ergtsNxsDVgIPAdZdnuCXbS6VCzecfPmxNLUkv6VTWudupHhNB6dxNHdEk
         xr2yatDfRyw1fXpLhGHRlttwyCId70IkgU3FgqjUR5Jz7562NNqzA1CP3dfPDOXUre
         RO7WwZOTmoyAewCf1tv2eoO+kfJ2rRsaBTfZFmHWZDm8OglUtJ2riThwhs6qhht0he
         FUE0QjyV6Uni5V12S4pHY6NjGCMDaX3WqSd+ge958JS9GJYyvfYz6yH6EbRKyOSuMi
         UizZuPlfm0ZGw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzJ79-00069J-5j; Thu, 09 Jun 2022 16:26:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] media: flexcop-usb: probe cleanups
Date:   Thu,  9 Jun 2022 16:26:02 +0200
Message-Id: <20220609142605.23620-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series cleans up the probe helper functions a bit to make the code
more readable.

Note that these apply on top of the fix posted here:

	https://lore.kernel.org/all/20220609135341.19941-1-johan@kernel.org/

Johan


Johan Hovold (3):
  media: flexcop-usb: clean up endpoint sanity checks
  media: flexcop-usb: clean up URB initialisation
  media: flexcop-usb: use usb_endpoint_maxp()

 drivers/media/usb/b2c2/flexcop-usb.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.35.1

