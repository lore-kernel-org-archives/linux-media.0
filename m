Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E73C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5872077B
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfDZILs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:11:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35115 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZILr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 04:11:47 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hJvxS-0002oG-HB; Fri, 26 Apr 2019 10:11:46 +0200
Message-ID: <1556266306.3664.5.camel@pengutronix.de>
Subject: Re: [PATCH 4/5] media: coda: Remove pic_run_work worker
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 10:11:46 +0200
In-Reply-To: <20190425183546.16244-5-ezequiel@collabora.com>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-5-ezequiel@collabora.com>
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
> There isn't any reason to run the mem2mem job on a separate worker,
> because the mem2mem framework guarantees that device_run will never
> run in interrupt context.

The purpose of the workqueue is to serialize BIT processor commands,
currently the PIC_RUN commands issued by the mem2mem framework (as well
as SEQ_INIT, SET_FRAME_BUF, and ENCODE_HEADER) against the SEQ_END
command issued directly from the STREAMOFF ioctl.
Further, to fully support the stateful decoder API we'll have to move
SEQ_INIT out of the mem2mem device_run as well, since that should be
called on queued OUTPUT buffers before the CAPTURE side is even
streaming.

regards
Philipp
