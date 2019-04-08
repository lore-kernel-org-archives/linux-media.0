Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E0C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F9420879
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfDHOla (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:41:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37647 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfDHOla (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 10:41:30 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hDVSg-00064k-JW; Mon, 08 Apr 2019 16:41:26 +0200
Message-ID: <1554734486.6439.6.camel@pengutronix.de>
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-media@vger.kernel.org
Date:   Mon, 08 Apr 2019 16:41:26 +0200
In-Reply-To: <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
         <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
         <20190408072854.13077345@coco.lan>
         <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
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

On Mon, 2019-04-08 at 12:44 +0200, Hans Verkuil wrote (paraphrased):
> On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote (paraphrased):
[...]
> > > [I hate colors]
> > [I love colors]
> I could live with [compromise]

Sorry for opening that can of worms :-)

How about doing something similar to 'ls':

- an environment variable V4L_COLORS which, if not set, defaults to
  V4L_COLORS="ok=32:warn=1:fail=1;31"
- an option --color=always|never|auto, which if not set, defaults to
  auto (check isatty())
- to disable colors by default, set V4L_COLORS to "ok=0:warn=0:fail=0"

This would allow to pipe colors into non-terminal stdout like less -R if
desired, or quickly disable colors with --color=never.
The pattern could be extended to include dvbv5 log levels or fe tool
quality levels.

Or alternatively, V4L_COLOR=always|never|auto for easier configuration,
but with a fixed color scheme?

regards
Philipp
