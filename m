Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EECAC4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C9020855
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqDKgrox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDDPSw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:18:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41133 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDPSw (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 11:18:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id v7so2189934oie.8
        for <linux-media@vger.kernel.org>; Thu, 04 Apr 2019 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlGD8WIf6ohkhP09V9i/QzkDu+7T+QNVsmhFoB8Othg=;
        b=cqDKgroxRnyTcq3fWEeNykoLNeucXuqRDVfdDWdqkgPSYGqeQOKlO5w+9m/qqs5LLP
         VQ6vH1y4+X9Y/RAmUFv5nJjEg5hKc0GX2kOkbkWNglxC8DA9nkBoqK4qEgfR7tvVfVR7
         sPnp0fCTnTeCcneTs7ZJ8C7XD3GBdJxRbge8rAqPDHgMd072XGmqoKwUvRX0SKUUapIZ
         xt72RJTPwb/+jghum5tbld/ozyWjgkqNliGBbfRIGyZ8yEYPoM1ZPGkK7+M2/p9wORHG
         KIRikiJOz0pkE7gsvajcL23kpvhrPR2TV7Ts8EAwHzsgYnptiMEJmjyGn1xaDceifJDQ
         /QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlGD8WIf6ohkhP09V9i/QzkDu+7T+QNVsmhFoB8Othg=;
        b=qDbZNfmbSccp2Iw59uhvkxHRdpI+SdRC575jCTWUetwQeXBg8QhMki1n1tMGGdtVtU
         EpjZSfzm9bj/+1kLKaeDiEVAElNTSZljuiUts8o8ysx6cn6XavKdch7EJKRSxV2KD+o+
         j0rQWbZXuQZX89EfeHC+8kMywHrr2bwARvVUavBUsUuX1rjr4kXijOnHAPuZggXl6FMf
         TJI9V6/jWAf8cTe9JGjIJpfTf3JdABi745AFVCaTstZ0XQ2NXVu0oiO35ZQLPeKxf02U
         NyGJ83KMbutDIhT/9sPfA+5EQCaSwQZLpXorRkbBjHelXpKvwbVN6xDJPLbjQHmpxAjD
         9ktw==
X-Gm-Message-State: APjAAAUjyyhh7GIH6+5DsdQGsvoO+VSnFys1Y4U52DzVwrDvTwQpLSMN
        YgUmPzMiQmooBqTWIlDQqdCOpL63kkRJ/QZUhrg=
X-Google-Smtp-Source: APXvYqzR5gTgYCL4mWu1PCpMqClCNcoxCu2zMNfSaJjYfBm0QjDkC8H05bx/cant7pdPBUhr/bTy/m3hNyd5r4Cm4Rs=
X-Received: by 2002:aca:cc4e:: with SMTP id c75mr3732837oig.7.1554391131711;
 Thu, 04 Apr 2019 08:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <1553954492-24982-1-git-send-email-akinobu.mita@gmail.com> <1553954492-24982-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1553954492-24982-2-git-send-email-akinobu.mita@gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 4 Apr 2019 16:18:25 +0100
Message-ID: <CA+V-a8tRhE=8DU9CpExtCsmJaS_9vjn94tnEqMta-pLCxuCMVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: ov2659: make S_FMT ioctl succeed even if
 requested format doesn't match
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Akinobu,

Thanks for the patch.

On Sat, Mar 30, 2019 at 2:01 PM Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> This driver returns an error if unsupported media bus pixel code is
> requested by VIDIOC_SUBDEV_S_FMT.
>
> But according to Documentation/media/uapi/v4l/vidioc-subdev-g-fmt.rst,
>
> Drivers must not return an error solely because the requested format
> doesn't match the device capabilities. They must instead modify the
> format to match what the hardware can provide.
>
> So select default format code and return success in that case.
>
> This is detected by v4l2-compliance.
>
> Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/media/i2c/ov2659.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

> diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
> index 799acce..a1e9a98 100644
> --- a/drivers/media/i2c/ov2659.c
> +++ b/drivers/media/i2c/ov2659.c
> @@ -1117,8 +1117,10 @@ static int ov2659_set_fmt(struct v4l2_subdev *sd,
>                 if (ov2659_formats[index].code == mf->code)
>                         break;
>
> -       if (index < 0)
> -               return -EINVAL;
> +       if (index < 0) {
> +               index = 0;
> +               mf->code = ov2659_formats[index].code;
> +       }
>
>         mf->colorspace = V4L2_COLORSPACE_SRGB;
>         mf->field = V4L2_FIELD_NONE;
> --
> 2.7.4
>
