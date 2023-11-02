Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F9C4332F
	for <linux-media@archiver.kernel.org>; Thu,  2 Nov 2023 09:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbjKBJu7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 2 Nov 2023 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbjKBJu6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 2 Nov 2023 05:50:58 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06648138
        for <linux-media@vger.kernel.org>; Thu,  2 Nov 2023 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1698918652; x=1730454652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t7O46auKYIMDaq9tlhzakdoXUZN4Nh58myNpkqsBS7A=;
  b=LDvKRDRombLuHhGkbXlEJdcWDw+zoH9yYyQacEgIMMqeFrCtPkZDJScv
   uS3Fa587+IaB9JrmmEp8veF7MYY1KZ7vDEjwwRfpKfvxlmlokWzjYtmOW
   THVXPXQbT/Lw2HYYH1bIIL6xFq5tmkx9kvKtslInx3DiPR2r4c4PzsYho
   MsfQcjPNAO0h8XJlV5dkKlR+cEC1ko3aU4Nk5ulO4rIlaf6Ye+6NRoDDw
   7mhjzqoCJdYdTYxT2Qdnf2/Rc+6qKLSkOydQ7zPDy0THaxFx+C0OOJQV2
   i7QLL9atRTbCwtm7z4lomubo2hFWesMNXpyC3v9miDfnWnTQ1/Ahj0+m/
   g==;
X-IronPort-AV: E=Sophos;i="6.03,271,1694728800"; 
   d="scan'208";a="33774786"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Nov 2023 10:50:50 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 12D1C28007F;
        Thu,  2 Nov 2023 10:50:50 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH v3 0/2] v4l2-cci: little-endian registers
Date:   Thu,  2 Nov 2023 10:50:46 +0100
Message-Id: <20231102095048.3222110-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

after the discussions at [1] and [2], this series adds proper support for
little-endian encoded registers.
Patch 1 adds the infrastructure and patch 2 fixes imx290 driver.
As v6.6 was released with imx290 broken, both should be added to stable.

I just focues on fixing the endianess issue. Any future cleanup as already
discussed is discarded for now.

Changes in v3:
* Explicitly name IMX290 as an example sensor using little-endian registers
* Move CCI_REG_LE to first location on register definition
* Use unsigned numbers for registers width definition
* Added Laurent's and Hans' R-b

Changes in v2:
* Add proper Fixes/CC tags to both patches
* Add little-endian support for cci_read()

Best regards,
Alexander

[1] https://lore.kernel.org/linux-media/20231030173637.GA2977515@gnbcxd0016.gnb.st.com/
[2] https://lore.kernel.org/linux-media/ZUIuNDTJAN_fz3q6@kekkonen.localdomain/

Alexander Stein (2):
  media: v4l2-cci: Add support for little-endian encoded registers
  media: i2c: imx290: Properly encode registers as little-endian

 drivers/media/i2c/imx290.c         | 42 ++++++++++++++--------------
 drivers/media/v4l2-core/v4l2-cci.c | 44 ++++++++++++++++++++++++------
 include/media/v4l2-cci.h           |  5 ++++
 3 files changed, 62 insertions(+), 29 deletions(-)

-- 
2.34.1

