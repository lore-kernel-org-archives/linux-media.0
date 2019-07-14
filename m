Return-Path: <SRS0=LoL3=VL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C58C73C66
	for <linux-media@archiver.kernel.org>; Sun, 14 Jul 2019 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B322C2064A
	for <linux-media@archiver.kernel.org>; Sun, 14 Jul 2019 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563087534;
	bh=zKf8zOTbNEkJeWxR2L5x+aUe18MAd+GlbNHFKT3IklE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cx8IFUyFVDSK4lBbFaKSlvkF8M2fcEuy+jnGuSOMjEWV5F2JmV+upiLwRj1ynoqHE
	 HLC9qgcYpONOye+J55tOpbnmlKOc7Q6YMwXEAlo+IGgvf+0qmUqdfhWK4OD9z3i+yu
	 9zihEmjMDxXgOfs27pvJ1mP3jDcogx3bvjJ0W5Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfGNG6y (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfGNG6x (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jul 2019 02:58:53 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72572064A
        for <linux-media@vger.kernel.org>; Sun, 14 Jul 2019 06:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563087533;
        bh=zKf8zOTbNEkJeWxR2L5x+aUe18MAd+GlbNHFKT3IklE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F0CL7/fOf4I0dfT9nkKTVl0hequOYYgagU3kIN6PI72d03PXP/k9dZjMhhfQIXe5/
         6rFm9aZyIz2l/rWtR7TFs95IFtq4qCqRPZeaw2RCOs71l8nU3fTPVEHybvyaceaTVe
         hlKNDxLGX9njz857e5WWdEsDbXW6/KF0ECyts8Bk=
Received: by mail-wm1-f47.google.com with SMTP id l2so12215507wmg.0
        for <linux-media@vger.kernel.org>; Sat, 13 Jul 2019 23:58:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVYpTVzjl5h4QoR6CXZBrgdnxYT/iVywhfbndOyY90+jPg6XFXZ
        6EH/26JUiNPBYC9NKazYq+0fLkfYSS8Ztq4q0s0=
X-Google-Smtp-Source: APXvYqza6QMmdfCOUlCkE/k1A3puE3espph5WDClbPv/gPN9SBkDRuznnEDTsIdSTaUndJF9LPH/eVlUPrKxDPQxYus=
X-Received: by 2002:a05:600c:20c3:: with SMTP id y3mr18302011wmm.3.1563087531365;
 Sat, 13 Jul 2019 23:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190712224700.11285-1-sean@mess.org>
In-Reply-To: <20190712224700.11285-1-sean@mess.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Sat, 13 Jul 2019 23:58:40 -0700
X-Gmail-Original-Message-ID: <CAGp9LzpVUExzvNZM2U2EcbTKg016xx3q0CGYXxqgaD+Y+UoRFA@mail.gmail.com>
Message-ID: <CAGp9LzpVUExzvNZM2U2EcbTKg016xx3q0CGYXxqgaD+Y+UoRFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: mtk-cir: only allow protocols that have
 software decoders
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Jul 12, 2019 at 3:47 PM Sean Young <sean@mess.org> wrote:
>
> RC_PROTO_BIT_ALL includes protocols like unknown and other that do not
> have IR decoders by definition. If these protocols are set in the
> allowed_protocols, they will show in the protocols sysfs file but cannot
> be enabled.
>
> Signed-off-by: Sean Young <sean@mess.org>

Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/media/rc/mtk-cir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
> index 46101efe017b..9dc467ebae24 100644
> --- a/drivers/media/rc/mtk-cir.c
> +++ b/drivers/media/rc/mtk-cir.c
> @@ -342,7 +342,7 @@ static int mtk_ir_probe(struct platform_device *pdev)
>         ir->rc->map_name = map_name ?: RC_MAP_EMPTY;
>         ir->rc->dev.parent = dev;
>         ir->rc->driver_name = MTK_IR_DEV;
> -       ir->rc->allowed_protocols = RC_PROTO_BIT_ALL;
> +       ir->rc->allowed_protocols = RC_PROTO_BIT_ALL_IR_DECODER;
>         ir->rc->rx_resolution = MTK_IR_SAMPLE;
>         ir->rc->timeout = MTK_MAX_SAMPLES * (MTK_IR_SAMPLE + 1);
>
> --
> 2.21.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
