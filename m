Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7456BC4363D
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3820760
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFM7L (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 08:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFM7L (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Oct 2020 08:59:11 -0400
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1CC061755;
        Tue,  6 Oct 2020 05:59:10 -0700 (PDT)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id BAF62634C87;
        Tue,  6 Oct 2020 15:58:30 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1kPmY2-0001ec-Cf; Tue, 06 Oct 2020 15:58:30 +0300
Date:   Tue, 6 Oct 2020 15:58:30 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     David Lu <david.lu@bitland.com.cn>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov8856: decrease hs_trail time
Message-ID: <20201006125830.GD5682@valkosipuli.retiisi.org.uk>
References: <20200727030748.3791-1-david.lu@bitland.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727030748.3791-1-david.lu@bitland.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi David,

On Mon, Jul 27, 2020 at 11:07:48AM +0800, David Lu wrote:
> To meet mipi hi speed transmission, decrease hs_trail time to pass mipi
> test.
> 
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
> ---
>  drivers/media/i2c/ov8856.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 4ca27675cc5a..1f1835b14a24 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -284,7 +284,7 @@ static const struct ov8856_reg mode_3280x2464_regs[] = {
>  	{0x4601, 0x80},
>  	{0x4800, 0x44},
>  	{0x4816, 0x53},
> -	{0x481b, 0x58},
> +	{0x481b, 0x42},

Could you elaborate a little more in the commit message what does the
register do and exactly what is changed? Is it the raw ths_trail value or
something else?

The nature of the change is such that it is very likely board specific
somehow. If you change this value for your system, does the change have
adverse effects elsewhere?

>  	{0x481f, 0x27},
>  	{0x4837, 0x16},
>  	{0x483c, 0x0f},
> @@ -474,7 +474,7 @@ static const struct ov8856_reg mode_1640x1232_regs[] = {
>  	{0x4601, 0x80},
>  	{0x4800, 0x44},
>  	{0x4816, 0x53},
> -	{0x481b, 0x58},
> +	{0x481b, 0x42},
>  	{0x481f, 0x27},
>  	{0x4837, 0x16},
>  	{0x483c, 0x0f},

-- 
Kind regards,

Sakari Ailus
