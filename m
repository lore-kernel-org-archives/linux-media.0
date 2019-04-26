Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0747C43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 18:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF355208CA
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 18:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfDZSTx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:19:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZSTx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 14:19:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B4D49273331
Message-ID: <52effdcfcbacac8a6df56d0d43591326d314a894.camel@collabora.com>
Subject: Re: [PATCH 4/5] media: coda: Remove pic_run_work worker
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 26 Apr 2019 15:19:46 -0300
In-Reply-To: <1556266306.3664.5.camel@pengutronix.de>
References: <20190425183546.16244-1-ezequiel@collabora.com>
         <20190425183546.16244-5-ezequiel@collabora.com>
         <1556266306.3664.5.camel@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 2019-04-26 at 10:11 +0200, Philipp Zabel wrote:
> On Thu, 2019-04-25 at 15:35 -0300, Ezequiel Garcia wrote:
> > There isn't any reason to run the mem2mem job on a separate worker,
> > because the mem2mem framework guarantees that device_run will never
> > run in interrupt context.
> 
> The purpose of the workqueue is to serialize BIT processor commands,
> currently the PIC_RUN commands issued by the mem2mem framework (as well
> as SEQ_INIT, SET_FRAME_BUF, and ENCODE_HEADER) against the SEQ_END
> command issued directly from the STREAMOFF ioctl.

Right, but that's serialized by the coda_mutex, not by the worker, right?

> Further, to fully support the stateful decoder API we'll have to move
> SEQ_INIT out of the mem2mem device_run as well, since that should be
> called on queued OUTPUT buffers before the CAPTURE side is even
> streaming.
> 

Isn't that already done? I see SEQ_INIT being issued in start_streaming.
In what sense is this driver currently violating the decoder spec?

So, returning to the serialization. I believe commands are still
serialized after this change.

The pic_run_work worker is only queued from .device_run.
Only one job can run on a context at any given time,
but multiple contexts can run in parallel.

Inside the worker, the coda_mutex serializes the commands.
The worker waits until the command has finished execution.

So, with this commit, there is no longer a worker, but commands
are still serialized by the mutex and the fact that the command
is completed in .device_run.

That being said, the worker does makes the serialization
more clear, so I think dropping this patch is better.

Perhaps adding a small comment so the purpose of pic_run_work
is clear.

Thanks,
Eze

