Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B7C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 08:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685D8206DD
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 08:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfDZIMW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:12:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51861 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZIMV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 04:12:21 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hJvxz-0002vp-TL; Fri, 26 Apr 2019 10:12:19 +0200
Message-ID: <1556266339.3664.6.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] media: coda: Clear the interrupt reason
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 10:12:19 +0200
In-Reply-To: <20190425183546.16244-6-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-6-ezequiel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-04-25 at 15:35 -0300, Ezequiel Garcia wrote:
> This commit clears the interrupt reason (INT_REASON) register
> on the interrupt handler. Without this clearing, the CODA hardware
> has been observed to get completely stalled on CODA980 variants,
> requiring a pretty deep hardware reset.
> 
> The datasheet specifies that the INT_REASON register is set
> by the CODA hardware, and should be cleared by the host.
> 
> While the CODA versions that are currently supported by this driver
> don't seem to need this change, it's a really small change,
> so it seems a wise thing to do to avoid hitting some
> rare race-condition in the hardware.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
