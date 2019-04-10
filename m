Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE508C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E8B20850
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 14:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfDJOW6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:22:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfDJOW6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 10:22:58 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hEE7s-0006dP-Lq; Wed, 10 Apr 2019 16:22:56 +0200
Message-ID: <1554906176.3765.9.camel@pengutronix.de>
Subject: Re: [PATCH 07/10] media: coda: limit frame interval enumeration to
 supported frame sizes
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Wed, 10 Apr 2019 16:22:56 +0200
In-Reply-To: <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
References: <20190408123256.22868-1-p.zabel@pengutronix.de>
         <20190408123256.22868-7-p.zabel@pengutronix.de>
         <ebbc3d03-e59e-32d5-c943-f9e426414848@xs4all.nl>
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

On Wed, 2019-04-10 at 15:43 +0200, Hans Verkuil wrote:
[...]
> > @@ -1126,12 +1127,32 @@ static int coda_enum_frameintervals(struct file *file, void *fh,
[...]
> 
> Why support VIDIOC_ENUM_FRAMEINTERVALS at all? It makes no sense for a codec.
> I'd remove it altogether.

It returns the range supported by the frame rate registers that can be
set for constant bitrate encoding. I think the idea was to let the
GStreamer v4l2 elements know about possible frame rate range.
I think I should be able to remove it without any negative effects.

regards
Philipp
