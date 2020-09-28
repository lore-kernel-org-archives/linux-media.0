Return-Path: <SRS0=+xP7=DF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF8C2D0A8
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A449B221EC
	for <linux-media@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="D4etXrp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI1N2h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:28:37 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:60013 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbgI1N2h (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 28 Sep 2020 09:28:37 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id MtChk6Ptpv4gEMtClkR605; Mon, 28 Sep 2020 15:28:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1601299715; bh=boBJi6Z7XRek+b6NVOnh+7AIpxcoQXMExIbzm3Xwk0M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=D4etXrp22z9S/0FTmHWuE4W5l+9xmFXzCLECL4EbLzuwNWOISehjM8r5dFfSVyjGz
         wG8rzneDvBpuAaFCMLIZ3A/NUCEKGcGORgmkkxtFjLl05lBOyIJKpv7kKeRXvIf6Kh
         IvcUg8M9ufVQssxqLe8vZuTxi1RSpP9mGJihzMy7HOFupZbQkuQZRt2iYEaaThg5jk
         lRekzEKPsCAVe6gR9EhTXZNxhmUCdcRRHkNyX+sWiNnIyW+ynh5v42T9ehoJJJFQRf
         pndR03tyM9sA9aFZRoGk73YUxyzDGuf0JBuEGGyPOgiCka7HTFne++ZUmGKg4f1GEe
         yQ3ydxCmHrsUQ==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/2] zoran: sparse/smatch fixes
Date:   Mon, 28 Sep 2020 15:28:29 +0200
Message-Id: <20200928132831.1587872-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEdO0u9ACvEjzb1/b6UnPDH8j+pJTjxRusGevMRo+qBXukRNgpiIix+dTEigqLz9HC6uAB9EYWb/Grn73Y9kSlCx6UfB+av/34m8y+bEInrudK9CRqnT
 jkUiq+x6cvpQnQGyJp7f1WDgR4+J/eTL+Rhf3wJ0H2igPpeeBlSa0YtZ52mJoRMKg/M1NFuYvbd0V1/EVWlHuSN//IgYjKJhL9wBOwRl2APz3/inr5ZaE+Qe
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Two patches on top of Corentine's patch series:

'[PATCH RFT/RFC v2 00/47] staging: media: bring back zoran driver'

This fixes smatch and sparse warnings and will be added to the
upcoming PR.

Regards,

	Hans

Hans Verkuil (2):
  zoran: fix smatch warning
  zoran: fix sparse warnings

 drivers/staging/media/zoran/zoran_device.c |  8 ++++----
 drivers/staging/media/zoran/zoran_driver.c | 15 +++++++--------
 2 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.28.0

