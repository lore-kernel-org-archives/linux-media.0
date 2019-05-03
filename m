Return-Path: <SRS0=4iHd=TD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59433C43219
	for <linux-media@archiver.kernel.org>; Fri,  3 May 2019 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3496020675
	for <linux-media@archiver.kernel.org>; Fri,  3 May 2019 08:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfECIAs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 May 2019 04:00:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49377 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECIAs (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 May 2019 04:00:48 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hMT7f-0006Uw-9F; Fri, 03 May 2019 10:00:47 +0200
Message-ID: <1556870446.3046.1.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] media: coda: Print a nicer device registered
 message
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com
Date:   Fri, 03 May 2019 10:00:46 +0200
In-Reply-To: <20190502220045.14962-2-ezequiel@collabora.com>
References: <20190502220045.14962-1-ezequiel@collabora.com>
         <20190502220045.14962-2-ezequiel@collabora.com>
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

Hi Ezequiel,

On Thu, 2019-05-02 at 19:00 -0300, Ezequiel Garcia wrote:
> This is just a cosmetic change to print a more descriptive
> message, to distinguish decoder from encoder:
> 
> So, instead of printing
> 
>   coda 2040000.vpu: codec registered as /dev/video[4-5]
> 
> With this change, the driver now prints
> 
>   coda 2040000.vpu: encoder registered as /dev/video4
>   coda 2040000.vpu: decoder registered as /dev/video5
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
