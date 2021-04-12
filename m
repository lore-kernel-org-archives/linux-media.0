Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B140FC43460
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914D461358
	for <linux-media@archiver.kernel.org>; Mon, 12 Apr 2021 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbhDLPim (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:38:42 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52483 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbhDLPib (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Apr 2021 11:38:31 -0400
Received: from coplandos.local (cpe-24-194-32-49.nycap.res.rr.com [24.194.32.49])
        (Authenticated sender: vrzh@vrzh.net)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 72FC4100006;
        Mon, 12 Apr 2021 15:38:11 +0000 (UTC)
Date:   Mon, 12 Apr 2021 11:41:11 -0400
From:   Martiros Shakhzadyan <vrzh@vrzh.net>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     vrzh@vrzh.net
Subject: Re: Re: [PATCH] staging: media: atomisp: Minor code style changes
Message-ID: <YHRqF6BtoBjqAreL@coplandos.local>
References: <20210412023558.360103-1-vrzh@vrzh.net>
 <20210412023558.360103-4-vrzh@vrzh.net>
 <20210412094048.gxnndzkbqv7tvykc@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412094048.gxnndzkbqv7tvykc@uno.localdomain>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 12, 2021 at 11:40:48AM +0200, Jacopo Mondi wrote:
> Hi Martiros,
> 
> On Sun, Apr 11, 2021 at 10:35:58PM -0400, Martiros Shakhzadyan wrote:
> > Fixed line continuation and parenthesis alignment issues.
> >
> > Signed-off-by: Martiros Shakhzadyan <vrzh@vrzh.net>
> >
> > squashme
> 
> This line should probably be dropped :)
> 
Oops! :)
> > ---
> >  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> > index 912eadaffc44..90a985ee25fa 100644
> > --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> > +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> > @@ -49,8 +49,8 @@ static int ov2722_read_reg(struct i2c_client *client,
> >  		return -ENODEV;
> >  	}
> >
> > -	if (data_length != OV2722_8BIT && data_length != OV2722_16BIT
> > -	    && data_length != OV2722_32BIT) {
> > +	if (data_length != OV2722_8BIT && data_length != OV2722_16BIT &&
> > +	    data_length != OV2722_32BIT) {
> 
> Does checkpatch report this one ?
> 
It did. Once I moved `&&` on the previous line it stopped complaining.

> >  		dev_err(&client->dev, "%s error, invalid data length\n",
> >  			__func__);
> >  		return -EINVAL;
> > @@ -212,8 +212,8 @@ static int __ov2722_buf_reg_array(struct i2c_client *client,
> >  }
> >
> >  static int __ov2722_write_reg_is_consecutive(struct i2c_client *client,
> > -	struct ov2722_write_ctrl *ctrl,
> > -	const struct ov2722_reg *next)
> > +					     struct ov2722_write_ctrl *ctrl,
> > +					     const struct ov2722_reg *next)
> 
> These are probably 2 separate changes, but give this is just a style
> fix I think it's ok...
> 
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> 
> 
Thanks for the review - will resubmit with a fixed commit message.

> >  {
> >  	if (ctrl->index == 0)
> >  		return 1;
> > --
> > 2.31.1
> >
