Return-Path: <SRS0=ut6f=SS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74826C10F13
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D756206BA
	for <linux-media@archiver.kernel.org>; Tue, 16 Apr 2019 07:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfDPH7Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:59:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfDPH7Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 Apr 2019 03:59:16 -0400
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1hGIzo-0001RV-DC; Tue, 16 Apr 2019 09:59:12 +0200
Date:   Tue, 16 Apr 2019 09:59:11 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Varunkumar Allagadapa <varunkum@xilinx.com>
Cc:     linux-firmware@kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: Re: Xilinx/Allegro DVT VCU firmware
Message-ID: <20190416095911.233742e0@litschi.hi.pengutronix.de>
In-Reply-To: <20190328113245.32467cdc@litschi.hi.pengutronix.de>
References: <20190328113245.32467cdc@litschi.hi.pengutronix.de>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Varunkumar,

On Thu, 28 Mar 2019 11:32:45 +0100, Michael Tretter wrote:
> Hi Varunkumar,
> 
> I am working on a mainline driver [0] for the VCU/video-codec that is
> found on the Xilinx ZynqMP. The driver depends on a firmware for the
> video codec [1], which is the same firmware that is used by the
> downstream VCU driver.
> 
> As the license allows to distribute the binary, it should be fine to
> include the firmware in the linux-firmware repository and properly
> distribute it with Linux. 
> 
> As you tagged the latest release of the firmware, maybe you could add
> the VCU firmware to the linux-firmware repository and add your
> Signed-off-by: to the commit.
> 
> I could add the firmware myself, but having this done by someone from
> Xilinx would be much better.

Any suggestion how we can continue with that?

Michael

> 
> Michael
> 
> [0] https://www.mail-archive.com/linux-media@vger.kernel.org/msg145294.html
> [1] https://github.com/Xilinx/vcu-firmware
