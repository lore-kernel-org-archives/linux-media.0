Return-Path: <SRS0=BPg3=W7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80356C3A5A7
	for <linux-media@archiver.kernel.org>; Wed,  4 Sep 2019 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563E6233A1
	for <linux-media@archiver.kernel.org>; Wed,  4 Sep 2019 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567586733;
	bh=ReJN7nfBuAkxDGWCkNioWGAoCEhadI8k72Wr8vLuB04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F+eytvFy004IEQe0LCRrF1jW9uS580gFs0YT9HlSpKBmNQSlb2gDOd0d+LuyEHb1Z
	 TvPGgwMG8tKcjln4K0wiHijzocydWyG8Wh/xrlGtGmuI7mwrnH9DUKIn3+riKjuvA3
	 3Cal5FHVijUWi0YI8X2rf5TIU7Q9Uz1GL7myxLWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfIDIp3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfIDIp3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 4 Sep 2019 04:45:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A8A22CEA;
        Wed,  4 Sep 2019 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567586728;
        bh=ReJN7nfBuAkxDGWCkNioWGAoCEhadI8k72Wr8vLuB04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3Xt1vFW/wLgQGkDEIy6pqv/t0kVUwS6A3oiUXXAYWBOsZHrhociWsvB2liN1QZHu
         +SSN7vWvBsPVq82ASvqxK10UF/FXwJaiuidUdpOlfaeNy50XOGVJC+DRhY7DTioILy
         jS6HbwoS0Jhjv1c7g1DMdZWsb7tvNRYs2pda0vpw=
Date:   Wed, 4 Sep 2019 10:45:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     mchehab@kernel.org, khilman@baylibre.com, mjourdan@baylibre.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: meson: Add NULL check after the call to kmalloc()
Message-ID: <20190904084525.GB4925@kroah.com>
References: <20190904082232.GA171180@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904082232.GA171180@LGEARND20B15>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 04, 2019 at 05:22:32PM +0900, Austin Kim wrote:
> If the kmalloc() return NULL, the NULL pointer dereference will occur.
> 	new_ts->ts = ts;
> 
> Add exception check after the call to kmalloc() is made.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  drivers/staging/media/meson/vdec/vdec_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
> index f16948b..e7e56d5 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -206,6 +206,10 @@ void amvdec_add_ts_reorder(struct amvdec_session *sess, u64 ts, u32 offset)
>  	unsigned long flags;
>  
>  	new_ts = kmalloc(sizeof(*new_ts), GFP_KERNEL);
> +	if (!new_ts) {
> +		dev_err(sess->core->dev, "Failed to kmalloc()\n");

Did you run this through checkpatch?  I think it will say that this line
is not ok.

> +		return;

Shouldn't you return an -ENOMEM error somehow?

thanks,

greg k-h
