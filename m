Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A62AC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1A20883
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqJyBw+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDHMpA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:45:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46502 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHMpA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:45:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id z17so15079621qts.13
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/xUuJQBOFDaId6HAEMcjV7QPgCxjQvp6jl6GY/i+VY=;
        b=wqJyBw+H/H6bB+Q9nyDf2LKXwDWKa6cvVN5uB71oYAj7XWVB+RRpukOeEidXKR4QRz
         R5iDZcK1lkwE/BlGPfTOH1XAupf0bAvvp4Kl3H9SbkENgTvif4MgRcWNro8WbTLjduRy
         y6gsDU2KRDTAZLWn8yFPLoW7uLPcK02AR6dqlw/ADpSYk2VWXw/atKRcHNzFNH4DTbGL
         KM4bOUtC0Nqo+Yhhayk+d0KTzctJeR++JMXdrMtE5ne6vuP7VjfVCHK731xesznqQWQH
         om9l5wwSB0jl+gj/1HSJeieZhAZOT3lqpO7QHKxln2EPbE/PJ5MG/B4Kr0Rie3CVD09P
         ukmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/xUuJQBOFDaId6HAEMcjV7QPgCxjQvp6jl6GY/i+VY=;
        b=L5aBIAzfQFIzZk6mPllqlwZ1keNBALKxLOHU7UDSIvNN5SaAVdtgfBRdwZ8uGhk3DT
         TFt349NfI9jJrSWHhy7M9Ghi+NBd6IegPLmHFFAWyYub200BuGLCUSU+T85QJ76dOAxt
         u1PA17mtKJQN7DmEugv+H5V+9VGqOSPGzxZLQef2Tj+0E6Hu3+Vw9LLnuJxk7j90Eav9
         rMP4MiH1kvH9TDMcl/qXUkOiCHuRXeG5zNfoWKheEPZZeRxMMsXEzZ7esn/+NHXZsbue
         w73tLK3dh3H1lRhS4/mCZG9oc63xjwiUM8zFo2V/RtZ5cmOMYGPVBMOrkem8TY6cAK4U
         AoZA==
X-Gm-Message-State: APjAAAV7DIsr2M0zYJCfkxL7SOBhPzyGHEAdIami9zCwbtDPbglLYJNy
        ofhVPwgZ/Q532rOqbYILZtI0swwMOvZ2p6Hs/Wzmbw==
X-Google-Smtp-Source: APXvYqz+eVBwHHlDLkJSAZ+tOfbDT2ApFMyTV3QcsXUnIA8lTtg5WHjMubitcPbl4K2ANgIJV0oX3C3V9aEvpbqagdY=
X-Received: by 2002:aed:3fb8:: with SMTP id s53mr23487651qth.61.1554727499413;
 Mon, 08 Apr 2019 05:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl> <20190408110401.3345-5-hverkuil-cisco@xs4all.nl>
In-Reply-To: <20190408110401.3345-5-hverkuil-cisco@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 8 Apr 2019 14:44:48 +0200
Message-ID: <CA+M3ks6PwHVCfPcp1dEMv5QXpjmegAo-Dy5307NXV3-NZLazjQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] stih_cec: use new cec_notifier_find_hdmi_dev helper
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Le lun. 8 avr. 2019 =C3=A0 13:04, Hans Verkuil <hverkuil-cisco@xs4all.nl> a=
 =C3=A9crit :
>
> The STI CEC driver increased the HDMI device refcount when
> it shouldn't. Use the new helper function to ensure that that
> doesn't happen and to simplify the driver code.
>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
>  drivers/media/platform/sti/cec/stih-cec.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/media/platform/sti/cec/stih-cec.c b/drivers/media/pl=
atform/sti/cec/stih-cec.c
> index d34099f75990..678d7cb38637 100644
> --- a/drivers/media/platform/sti/cec/stih-cec.c
> +++ b/drivers/media/platform/sti/cec/stih-cec.c
> @@ -301,26 +301,19 @@ static int stih_cec_probe(struct platform_device *p=
dev)
>         struct device *dev =3D &pdev->dev;
>         struct resource *res;
>         struct stih_cec *cec;
> -       struct device_node *np;
> -       struct platform_device *hdmi_dev;
> +       struct device *hdmi_dev;
>         int ret;
>
> +       hdmi_dev =3D cec_notifier_find_hdmi_dev(dev);
> +
> +       if (IS_ERR(hdmi_dev))
> +               return PTR_ERR(hdmi_dev);
> +
>         cec =3D devm_kzalloc(dev, sizeof(*cec), GFP_KERNEL);
>         if (!cec)
>                 return -ENOMEM;
>
> -       np =3D of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
> -
> -       if (!np) {
> -               dev_err(&pdev->dev, "Failed to find hdmi node in device t=
ree\n");
> -               return -ENODEV;
> -       }
> -
> -       hdmi_dev =3D of_find_device_by_node(np);
> -       if (!hdmi_dev)
> -               return -EPROBE_DEFER;
> -
> -       cec->notifier =3D cec_notifier_get(&hdmi_dev->dev);
> +       cec->notifier =3D cec_notifier_get(hdmi_dev);
>         if (!cec->notifier)
>                 return -ENOMEM;
>
> --
> 2.20.1
>
