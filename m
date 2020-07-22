Return-Path: <SRS0=rgoD=BB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BD1C433E1
	for <linux-media@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54762065F
	for <linux-media@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgGVNQg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGVNQg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jul 2020 09:16:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF281C0619DC
        for <linux-media@vger.kernel.org>; Wed, 22 Jul 2020 06:16:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEbn-0001NZ-KP; Wed, 22 Jul 2020 15:16:31 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1jyEbn-0004xj-7c; Wed, 22 Jul 2020 15:16:31 +0200
Date:   Wed, 22 Jul 2020 15:16:31 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] media: allegro: fix potential null dereference
 on header
Message-ID: <20200722131631.GA18419@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Colin King <colin.king@canonical.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200722130903.818041-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722130903.818041-1-colin.king@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:12:53 up 153 days, 20:43, 131 users,  load average: 0.09, 0.22,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-media@vger.kernel.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 22 Jul 2020 14:09:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer header is an alias to msg and msg is being null checked.
> However, if msg is null then header is also null and this can lead to
> a null pointer dereference on the assignment type = header->type. Fix
> this just using header->type after the null check and removing the need
> for type as it is only used once.
> 
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 3de16839669f ("media: allegro: add explicit mail encoding and decoding")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
> 
> V2: remove need for variable type, as suggested by Michael Tretter
> 
> ---
>  drivers/staging/media/allegro-dvt/allegro-mail.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/allegro-dvt/allegro-mail.c b/drivers/staging/media/allegro-dvt/allegro-mail.c
> index 4ac65de12463..9286d2162377 100644
> --- a/drivers/staging/media/allegro-dvt/allegro-mail.c
> +++ b/drivers/staging/media/allegro-dvt/allegro-mail.c
> @@ -462,13 +462,12 @@ allegro_dec_encode_frame(struct mcu_msg_encode_frame_response *msg, u32 *src)
>  ssize_t allegro_encode_mail(u32 *dst, void *msg)
>  {
>  	const struct mcu_msg_header *header = msg;
> -	enum mcu_msg_type type = header->type;
>  	ssize_t size;
>  
>  	if (!msg || !dst)
>  		return -EINVAL;
>  
> -	switch (type) {
> +	switch (header->type) {
>  	case MCU_MSG_TYPE_INIT:
>  		size = allegro_enc_init(&dst[1], msg);
>  		break;
> -- 
> 2.27.0
> 
> 
