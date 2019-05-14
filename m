Return-Path: <SRS0=tLen=TO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E95C04AB4
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEE220879
	for <linux-media@archiver.kernel.org>; Tue, 14 May 2019 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865264;
	bh=MuCEyaZgegTV8kZ1hXGREdsFwr7xjuKYIWSpue1ClFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O+1dhbIZNWG+HsLdfARQm2vzYIHMR/DcFNyBUJibcCoMtHs63E9pu2oWkJVO9Ipks
	 wkkn+OzDgOh6R8tQvFACwLiiznuKuCMV/oH7u5agByadr7aeO8L72MP2oZQFP8kSNV
	 TO52oWTL62BW1gjx32GxYujbyjp9aj3wVg7l71I8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfENUVD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 May 2019 16:21:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:33418 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUVD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 May 2019 16:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dHqiFxkPKeEQINMZVKqRHDY+nesR3Am9tiwcWOQ5toE=; b=DNwnxVBK73Xouka+xUwDxEFBpG
        T93GOhYZmqN/Z/3FG9GPeA5sEXHYfI6ZfX56YjkH5wC0BFyXACf8SXsuZRKs3mIupLpVc3JRRNjk8
        apaPmSg9w16cljkzwd9HKmG5oP4AZBgeHT88dbnCidjUeRDM3WxDTsGd/v2QsFkm1jKNkLrrj/Dpc
        fZB7ypik0I5IL8bUBpywYTOMz0aVTNXH817dT22QRN3k9WtIEaj77U+tO+5nkFHogr8G88w8YSRcf
        ACc3UtoSIvp+CBH3uNKjADkiWs6bYWvtRVHiT76272CrpUsJSAkBqVS7ihEPHrV6fgsmSMDPlBT3M
        D1IbMqJA==;
Received: from [179.179.44.200] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQduz-0000K3-W3; Tue, 14 May 2019 20:20:58 +0000
Date:   Tue, 14 May 2019 17:20:52 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        jacopo+renesas@jmondi.org, robh+dt@kernel.org,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH v6 08/13] media: tvp5150: initialize subdev before
 parsing device tree
Message-ID: <20190514172052.7123204f@coco.lan>
In-Reply-To: <20190415124413.18456-9-m.felsch@pengutronix.de>
References: <20190415124413.18456-1-m.felsch@pengutronix.de>
        <20190415124413.18456-9-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 15 Apr 2019 14:44:08 +0200
Marco Felsch <m.felsch@pengutronix.de> escreveu:

> From: Michael Tretter <m.tretter@pengutronix.de>
> 
> There are several debug prints in the tvp5150_parse_dt() function, which
> do not print the prefix, because the v4l2_subdev is not initialized, yet.
> 
> Initialize the v4l2_subdev before parsing the device tree to fix the
> debug messages.
> 
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Looks ok to me.

> ---
>  drivers/media/i2c/tvp5150.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
> index 9331609425bf..305a5e256b31 100644
> --- a/drivers/media/i2c/tvp5150.c
> +++ b/drivers/media/i2c/tvp5150.c
> @@ -1973,6 +1973,9 @@ static int tvp5150_probe(struct i2c_client *c,
>  
>  	core->regmap = map;
>  	sd = &core->sd;
> +	v4l2_i2c_subdev_init(sd, c, &tvp5150_ops);
> +	sd->internal_ops = &tvp5150_internal_ops;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  
>  	if (IS_ENABLED(CONFIG_OF) && np) {
>  		res = tvp5150_parse_dt(core, np);
> @@ -1985,10 +1988,6 @@ static int tvp5150_probe(struct i2c_client *c,
>  		core->mbus_type = V4L2_MBUS_BT656;
>  	}
>  
> -	v4l2_i2c_subdev_init(sd, c, &tvp5150_ops);
> -	sd->internal_ops = &tvp5150_internal_ops;
> -	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> -
>  	res = tvp5150_mc_init(core);
>  	if (res)
>  		goto err_cleanup_dt;



Thanks,
Mauro
