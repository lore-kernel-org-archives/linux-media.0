Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A109C433F5
	for <linux-media@archiver.kernel.org>; Sat,  9 Apr 2022 19:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiDITiC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 9 Apr 2022 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiDITiA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 9 Apr 2022 15:38:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD2D9E82
        for <linux-media@vger.kernel.org>; Sat,  9 Apr 2022 12:35:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1B30482;
        Sat,  9 Apr 2022 21:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649532950;
        bh=I8iV07Olh/TuU93Himm0iGAVkx/a72iBbVNgImMThNI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DDIEgZXCoiNCPQmhkv8rFBBxDopOD/HB1SDMDiXUh313Nuc05bbS1togfCJqlwjuG
         vrI/F6BmQRICTvKzzTPMqCP2dbiV8PAZBanWOFnh/8u3I1WkJKGNmp4s5EEpyVZ+4Z
         l9cZI+iaO2OvY1Uc6kTfNH66ew91Fi/WejRRsfsw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321145134.29820-1-laurent.pinchart@ideasonboard.com>
References: <20220321145134.29820-1-laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] media: v4l2-async: Use endpoints in __v4l2_async_nf_add_fwnode_remote()
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Date:   Sat, 09 Apr 2022 20:35:48 +0100
Message-ID: <164953294830.22830.18350472818944012018@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Quoting Laurent Pinchart (2022-03-21 14:51:34)
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>=20
> Matching on device fwnode handles is deprecated in favour of endpoint
> fwnode handles. Switch the __v4l2_async_nf_add_fwnode_remote() function
> to use the latter. The match code handles backward compatibility by
> falling by to the device fwnode handle, so this shouldn't introduce any

s/by/back/ ?

It sounds like this helps move other devices towards endpoint matching
more generically too, but I expect there will still be more specifics to
handle in receiver drivers?

And indeed the whole point of the fallback case was to make them
compatible... so:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


But I suspect this needs some testing on platforms that haven't yet
moved to endpoint matching.. ?

> regression.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  drivers/media/v4l2-core/v4l2-async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-co=
re/v4l2-async.c
> index 0404267f1ae4..67d7f445d429 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -662,7 +662,7 @@ __v4l2_async_nf_add_fwnode_remote(struct v4l2_async_n=
otifier *notif,
>         struct v4l2_async_subdev *asd;
>         struct fwnode_handle *remote;
> =20
> -       remote =3D fwnode_graph_get_remote_port_parent(endpoint);
> +       remote =3D fwnode_graph_get_remote_endpoint(endpoint);
>         if (!remote)
>                 return ERR_PTR(-ENOTCONN);
> =20
> --=20
> Regards,
>=20
> Laurent Pinchart
>
