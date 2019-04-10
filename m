Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820CC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90520850
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732705AbfDJOXE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:23:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52547 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfDJOXE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 10:23:04 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEE7z-0006g7-0x; Wed, 10 Apr 2019 16:23:03 +0200
Message-ID: <1554906182.3765.10.camel@pengutronix.de>
Subject: Re: [PATCH 08/10] media: coda: allow encoder to set colorimetry on
 the output queue
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Wed, 10 Apr 2019 16:23:02 +0200
In-Reply-To: <1c5e978c-eecb-8847-8746-51e83e48ae85@xs4all.nl>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-8-p.zabel@pengutronix.de>
         <1c5e978c-eecb-8847-8746-51e83e48ae85@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2019-04-10 at 15:48 +0200, Hans Verkuil wrote:
[...]
> Isn't the colorimetry information encoded in the stream's metadata?

That depends on the codec. Colorimetry information can be stored in
optional headers (for example Sequence Display Extension for MPEG-2,
Video Usability Information for H.264) but I don't know that the CODA
firmware can parse or generate any of them.

> So should it be set i an encoder register so it ends up in the right
> place in the bitstream?

I could produce the necessary headers manually and inject them into the
bitstream in the driver.

But for example for JPEG it is not clear to me if there even is a
correct way to do that. Can V4L2 colorimetry settings be translated into
ICC profiles?

> And for decoders it should then be read back from a register.

Same as above, I'd have to parse the headers in the driver.

> Just curious how this would work for this codec and if it is even possible.
> 
> For now this patch is OK, but I think more work is needed.

Agreed.

regards
Philipp
