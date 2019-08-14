Return-Path: <SRS0=fuZj=WK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F20C32753
	for <linux-media@archiver.kernel.org>; Wed, 14 Aug 2019 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9212084F
	for <linux-media@archiver.kernel.org>; Wed, 14 Aug 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b9AXMmM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfHNPa0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:30:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50778 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfHNPaZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 14 Aug 2019 11:30:25 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A9942B2
        for <linux-media@vger.kernel.org>; Wed, 14 Aug 2019 17:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1565796624;
        bh=XDIKeybaVAGYajW0vNM0PWuB9EJu8umSWY93e9r4pN0=;
        h=Date:From:To:Subject:From;
        b=b9AXMmM7YD2sCKnLNVkasbCYnAmb53767kQUtuFBpfKBocQo0rsbZETXx/vQB1Ti4
         KnpLtB9OdelbCEBjr/SHoAobpTkcymZUAGQ0Nlibhd4mj9zKkGBu5aNVes1Icu5Ibv
         2VCv0TSZg7RXdccdQk9lDNoQ3UHQ3SCKHbm7pa5M=
Date:   Wed, 14 Aug 2019 18:30:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-media@vger.kernel.org
Subject: [GIT PULL FOR v5.4] R-Car VSP1 change
Message-ID: <20190814153020.GA30953@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

The following changes since commit b20a6e298bcb8cb8ae18de26baaf462a6418515b:

  media: rc: imon: Allow iMON RC protocol for ffdc 7e device (2019-08-14 05:08:27 -0300)

are available in the Git repository at:

  git://linuxtv.org/pinchartl/media.git tags/vsp1-next-20190814

for you to fetch changes up to f95c54e35811b711ce73e5a54c6a01e096bc324f:

  media: vsp1: fix memory leak of dl on error return path (2019-08-14 17:55:22 +0300)

----------------------------------------------------------------
Miscellaneous R-Car VSP1 fix

----------------------------------------------------------------
Colin Ian King (1):
      media: vsp1: fix memory leak of dl on error return path

 drivers/media/platform/vsp1/vsp1_dl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
Regards,

Laurent Pinchart
