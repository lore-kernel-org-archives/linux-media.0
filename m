Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D9C6369E
	for <linux-media@archiver.kernel.org>; Thu, 19 Nov 2020 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4DB24654
	for <linux-media@archiver.kernel.org>; Thu, 19 Nov 2020 15:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKSPRl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:17:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgKSPRj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Nov 2020 10:17:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 00D991F45952
Message-ID: <569f39571ed5307f7f40860e04a6563c0c9cbce7.camel@collabora.com>
Subject: Re: [PATCH v3 12/13] media: uapi: move H264 stateless controls out
 of staging
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Date:   Thu, 19 Nov 2020 12:17:29 -0300
In-Reply-To: <20201118184700.331213-13-ezequiel@collabora.com>
References: <20201118184700.331213-1-ezequiel@collabora.com>
         <20201118184700.331213-13-ezequiel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2020-11-18 at 15:46 -0300, Ezequiel Garcia wrote:
> The H264 stateless controls is ready to be part
> of the stable uAPI.
> 
> Re-number the control IDs, move them to the newly
> created stateless control class, and updates all
> the drivers accordingly.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c          |  36 +-
>  drivers/staging/media/hantro/hantro_drv.c     |  26 +-
>  drivers/staging/media/hantro/hantro_h264.c    |   8 +-
>  drivers/staging/media/rkvdec/rkvdec-h264.c    |   8 +-
>  drivers/staging/media/rkvdec/rkvdec.c         |  26 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  12 +-
>  include/media/v4l2-ctrls.h                    |   1 -
>  include/uapi/linux/v4l2-controls.h            | 379 ++++++++++++++++++
>  9 files changed, 449 insertions(+), 71 deletions(-)
> 

Ah, this patch should also delete the old media/h264-ctrls.h.

Another thing to fix for next iteration.

Thanks,
Ezequiel


