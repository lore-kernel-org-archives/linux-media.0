Return-Path: <SRS0=WnEk=WS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A8C3A5A1
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76037233FD
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566503023;
	bh=vNkcLN/tna31gMbSh4hzvI8lDrpPi5no3OdMw2dVCho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OOPQdB9+CTb0gHO3Jgk6+rmZmKVi6oncrFdZGthTgLV8x98+bKQ3VDKdx3WlXsWOW
	 kWJvMCG4XFGkC1LY8JMV8OUrPws/3KPUAGZdqsCpp9X5BlWmiZFjXHbq5bt/QaCljj
	 3PTLvPvLs9f7pfLyB2qUCWGIYTx+mW/RhS3xyeIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfHVTnm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:43:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbfHVTnm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Aug 2019 15:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T2kwb+o/U2rjl69P+5ZwXGF8TMmaqofITp/VNEYGdpQ=; b=SVG5SaQtxlMkZbQyfYenLSzqg
        SetzCVxpRVu8bmIqcI7I7Bcz2M8nV2Ov/Byt8wcW1zfrLf9I+jdo9q3YWRjrbZgYw5DYjPe156iOJ
        j6wKVjyvL+cR7EXNdi8R4/j4PIrG3sWBgDzPdaXkwaQZR56aW7XfCvEIa/3GTPIYFaBzPJU6J+9yw
        yuw+cNutJYswbPbDnQAN5WCjt8cYJhYm8oo8EJlxzwNsITwkwy+epf4zt710vsDiJWtwzDuNUaBWz
        MD6BVzX+VkQ9f46uPHYz4NoRZhp7v6gVIegB1BNlefUkJajmoLRkyL8KlEN6w18wGvwG2Ixbv99+I
        WoEp5udzQ==;
Received: from [177.133.63.56] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0szl-0006GP-Rk; Thu, 22 Aug 2019 19:43:42 +0000
Date:   Thu, 22 Aug 2019 16:43:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] media: ngene: don't try to memcpy from NULL
Message-ID: <20190822164337.3b683850@coco.lan>
In-Reply-To: <11ef5297a62a8c3cc812495b69398b316e80ad73.1566502743.git.mchehab+samsung@kernel.org>
References: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
        <11ef5297a62a8c3cc812495b69398b316e80ad73.1566502743.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 22 Aug 2019 16:39:34 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> [drivers/media/pci/ngene/ngene-i2c.c:122] -> [drivers/media/pci/ngene/ngene-i2c.c:39]: (error) Null pointer dereference: out
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/pci/ngene/ngene-i2c.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/ngene/ngene-i2c.c b/drivers/media/pci/ngene/ngene-i2c.c
> index 2e9e9774dc6f..bfdb7286f6f0 100644
> --- a/drivers/media/pci/ngene/ngene-i2c.c
> +++ b/drivers/media/pci/ngene/ngene-i2c.c
> @@ -36,7 +36,10 @@ static int ngene_command_i2c_read(struct ngene *dev, u8 adr,
>  	com.cmd.hdr.Opcode = CMD_I2C_READ;
>  	com.cmd.hdr.Length = outlen + 3;
>  	com.cmd.I2CRead.Device = adr << 1;
> -	memcpy(com.cmd.I2CRead.Data, out, outlen);
> +
> +	if (out)
> +		memcpy(com.cmd.I2CRead.Data, out, outlen);
> +

Hmm... I actually forgot to drop this one from this series, as I guess it
is safe to do:

	memcpy(out, NULL, 0);

>  	com.cmd.I2CRead.Data[outlen] = inlen;
>  	com.cmd.I2CRead.Data[outlen + 1] = 0;
>  	com.in_len = outlen + 3;



Thanks,
Mauro
