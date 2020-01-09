Return-Path: <SRS0=MIHa=26=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9FC282DD
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 16:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA3E206ED
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 16:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578586450;
	bh=ePLE/0kjcY61EZrnQGGWVzvEAMoiXTEJ2zxMzL3drEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zvph7H5fbcSM0u+Rx1cgYDIo2/aUg3G7P1eR0Phw1SPqSCfycLv3J5PZ7e4+ddfFf
	 t2qk6YVc7g1vRRTKkQP0MAjao3GKes12k8Oh3YC4os8J+294frJS0j+gVzR8HHu8id
	 VVvxj++XXUAHTqSfY2B9brAD0hgj4ZYH4ohKW338=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgAIQOG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:14:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgAIQOG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 9 Jan 2020 11:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=23iMw4u+/DVo7oz9I68gScHBJuS7WAFFLyCdELFXaPM=; b=TXzR4VXX2s5VyCBs5oKtVPrTw
        yHb9OfAxH0ZDUVrcmxYyGIxXK33AvONs/jnHI5eyDzIAtRLeRlUQ3Qky4FzdNoM+5yQvPmDPcG6kL
        vSAKJ/yCH3gDvF1bthd/9HcvS8G0p9adTaMxExDSwPdKNP/g/NrMGK3hDlQb1F1Yk4EeoeTctjm+8
        aWHwvdNpdPML5xf6wdwIF+qVKhLHXgBpg2b6FfKGmZDTcjDDPrjWULZEnnTgUX37GkVtKZPs4mn3+
        TNq/smGYGs1u/LnHlGfwxs+IC/Xr3uTrxJh1WkoKZ4zlJqn7gltar1n/eiPgmb36YbyW+VsfSdgUk
        Z18m9BCVw==;
Received: from 177.206.132.169.dynamic.adsl.gvt.net.br ([177.206.132.169] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipaRd-0007cV-Ng; Thu, 09 Jan 2020 16:14:03 +0000
Date:   Thu, 9 Jan 2020 17:13:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     sean@mess.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/1] media: dvb_dummy_tuner: implement driver skeleton
Message-ID: <20200109171345.2cf30990@kernel.org>
In-Reply-To: <20200109152408.919325-2-dwlsalmeida@gmail.com>
References: <20200109152408.919325-1-dwlsalmeida@gmail.com>
        <20200109152408.919325-2-dwlsalmeida@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu,  9 Jan 2020 12:24:08 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> escreveu:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Implement the skeleton for the tuner driver in a separate file.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  drivers/media/tuners/Kconfig           |   7 ++
>  drivers/media/tuners/Makefile          |   1 +
>  drivers/media/tuners/dvb_dummy_tuner.c | 153 +++++++++++++++++++++++++
>  drivers/media/tuners/dvb_dummy_tuner.h |  20 ++++
>  4 files changed, 181 insertions(+)
>  create mode 100644 drivers/media/tuners/dvb_dummy_tuner.c
>  create mode 100644 drivers/media/tuners/dvb_dummy_tuner.h
> 
> diff --git a/drivers/media/tuners/Kconfig b/drivers/media/tuners/Kconfig
> index e104bb7766e1..efa1591fe0ae 100644
> --- a/drivers/media/tuners/Kconfig
> +++ b/drivers/media/tuners/Kconfig
> @@ -296,4 +296,11 @@ config MEDIA_TUNER_QM1D1B0004
>  	default m if !MEDIA_SUBDRV_AUTOSELECT
>  	help
>  	  Sharp QM1D1B0004 ISDB-S tuner driver.
> +
> +config MEDIA_TUNER_DVB_DUMMY_TUNER
> +	tristate "Dummy tuner"
> +	depends on MEDIA_SUPPORT && I2C

> +	default m if !MEDIA_SUBDRV_AUTOSELECT

Actually, this is a dummy driver. It should not be auto-selected, as no
real hardware depends on it. We don't want production distros to come with
those test drivers.

When we add a bridge driver (let's say we call it DVB_DUMMY_BRIDGE), then
what we could do here would be something like:

	depends on DVB_DUMMY_BRIDGE
	default y

Cheers,
Mauro
