Return-Path: <SRS0=SSLR=6M=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6202C83000
	for <linux-media@archiver.kernel.org>; Tue, 28 Apr 2020 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8F206D7
	for <linux-media@archiver.kernel.org>; Tue, 28 Apr 2020 12:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Vdb9DGQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgD1Mnc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgD1Mnb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Apr 2020 08:43:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7448C03C1A9
        for <linux-media@vger.kernel.org>; Tue, 28 Apr 2020 05:43:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so2703418wmg.1
        for <linux-media@vger.kernel.org>; Tue, 28 Apr 2020 05:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BusMdviIkzFWFKPmh8XGZy6n1ZSHQk7HTVNyoFwd5MU=;
        b=Vdb9DGQkACBTF5W4J3p5Mkj1NPUdDA+BqZU7pGrWdPlIlJEVnIogFPn0B4iPFyj5FZ
         Jv+8J6VFfQzcR1i1UOrI7jdxU9DXybiKgeeqzKp5haqfCJSbzYqDRAsfX+jW7p0tB0mr
         4OVL0nAHp0g5ynsxX3mul0H2YDTPPOORA1RXEG9PGZGUE5COM0ABRBcDGIedtfIBEg1U
         8BuFtMG53hsDnP79rrkDrqThhiEvm7lcn/gTjE5IfZI3cW6yb4kTrivRj4D+O+USM8PJ
         VWlsWHSYn4718pf83yMTicgyLHfIm47b8TuKeTkihkMxeWK+YtbrCsNHLcunW/WPvg1y
         8D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BusMdviIkzFWFKPmh8XGZy6n1ZSHQk7HTVNyoFwd5MU=;
        b=DkUmewOxPdgBYEDYRFBxDZEbbVNv6csWeGLElJWw8ypxxA2ttyLU2rM9y+x7N1rZCi
         BKK0UcXwBo/Tla25GW4Je6qksa1sa6JM4dw8YCP0S2AR3D+X+GGLn6zB8tvMVK56HtKj
         Dp2wV8uJHa5x3/dMFMjwg+jN/zYM0Sb+UlgO4QX8awl0fyUgFupxgyT8vUKCDmgh/Etu
         o9EecvkhO1Kfw1JxqRlNYHuxW8HTo/Za3c+7vOJJZIcFHt9D0XKrvK7xnHrUZRzIVN+q
         bdzdAR1iFFsEbYEODUvLwJz8tvTjd/UGj/AQJziDfYI3rOe2e3/+qfpRJGTlAffJVjij
         EnrQ==
X-Gm-Message-State: AGi0Pua1OflMg8jrSzpK6d9NHjPR9n+mrqRgP2ntAdwSUWbMKYg0eFTA
        zEVAeQs51N9vy1mZTr6HXFOMKeuN3VKDYOmn/kmvmQ==
X-Google-Smtp-Source: APiQypKhH+NrD0gFuAtpM8Rq0l3WRKR3GdaQhlpyYjI7L+1n85l6eCXgM0xFmgiu55phG+Jz0ml7sHDgsuhbrRVGkBw=
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr4711605wme.82.1588077810297;
 Tue, 28 Apr 2020 05:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200424013419.12954-1-laurent.pinchart@ideasonboard.com> <20200424013419.12954-2-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20200424013419.12954-2-laurent.pinchart@ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 28 Apr 2020 13:43:16 +0100
Message-ID: <CAPY8ntDUuLAw4eRN7Yk7dkd_OVzxWoDgXdZCjbiZGqQ92vUxag@mail.gmail.com>
Subject: Re: [PATCH 1/5] media: i2c: imx219: Set V4L2_SUBDEV_FL_HAS_EVENTS flag
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Naushir Patuck <naush@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent

Thanks for the patch

On Fri, 24 Apr 2020 at 02:34, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> The imx219 subdev can generate control events, set the
> V4L2_SUBDEV_FL_HAS_EVENTS flag.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/imx219.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index cb03bdec1f9c..6e585c39a46a 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -1396,7 +1396,8 @@ static int imx219_probe(struct i2c_client *client)
>
>         /* Initialize subdev */
>         imx219->sd.internal_ops = &imx219_internal_ops;
> -       imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +       imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE
> +                        |  V4L2_SUBDEV_FL_HAS_EVENTS;
>         imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>
>         /* Initialize source pad */
> --
> Regards,
>
> Laurent Pinchart
>
