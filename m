Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52171C4321E
	for <linux-media@archiver.kernel.org>; Mon,  5 Dec 2022 05:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiLEFCQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Dec 2022 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiLEFCO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Dec 2022 00:02:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DFFAF3
        for <linux-media@vger.kernel.org>; Sun,  4 Dec 2022 21:02:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so9750754plb.13
        for <linux-media@vger.kernel.org>; Sun, 04 Dec 2022 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RaPN84Uxf892uugyR0/feAI2xM9TuK0z8cP4MEIBR8c=;
        b=XPzQWo9Aig7b540V7TojrYhvSH53zgLOaQkg0q3giQu2YDrfVnTZIMTRRi3iCqD9+c
         sAUbjJ50eTtwtIrPQqlDVcLb50kh1nyvmElQpnBMqBM7Ds0lNjxEcEmbYuiosrUZnNRU
         b+24kKscS6YJnUHalv8THRhltm0XxrIk5t4LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaPN84Uxf892uugyR0/feAI2xM9TuK0z8cP4MEIBR8c=;
        b=38r6Hq5BcM54vZl0aXndMwWs9Z+cAphAlJWvFGok8rIp0OPNOKCj1XrCos/O482w6V
         AuaKeo3BoakqDm7a1ZVBzOIKOhgdC3SgdfiAjpWIgxlXv/mUWEvI8KKOD4OMMHcwRx8f
         /m9VJDAFhj0Iq+WCuw7DqUPg0HkMbop01K6sC68m02nsZPcCVBHGmhw6d3/DiGaN8aUV
         a0Zy9YK5vzS7EL25ETsxHkcpMHi+4ZdPJOkDZemN5ju3NCWJp5SzY9RQ3Kh06HKbc3TA
         RKJwOfYqprWWA5zdhsE5McArlnK3SbdV68hMR62OjtfKkvamU2qCh9vpXULknhDvmU88
         pSCg==
X-Gm-Message-State: ANoB5pmkYpbTXBNQ8uWdicTsowkHqzaK4E2JEVhIZVSeF5rQTH7XpA72
        wyJiGUZSJMr3CWsuknWg5rQ9QHmaGvk/shaq2me3hw==
X-Google-Smtp-Source: AA0mqf6psoRKWmJz/JSqESjSHaDjM+aeAcK9X2GX1CQDKXqq0KqtubyUdxlKbqLSiT3wHzGn2ZcdBessKGx3W3DrpKI=
X-Received: by 2002:a17:90a:f189:b0:219:996c:6bfc with SMTP id
 bv9-20020a17090af18900b00219996c6bfcmr12489960pjb.134.1670216533438; Sun, 04
 Dec 2022 21:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org> <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
From:   Yunke Cao <yunkec@chromium.org>
Date:   Mon, 5 Dec 2022 14:02:02 +0900
Message-ID: <CAEDqmY4F5fmcBydBtvyUQdUOBCs9N1HjrWBJAc-p0Smgj8VE2g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of
 metadata devices
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sat, Dec 3, 2022 at 2:08 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Devices with Metadata output (like uvc), create two video devices, one
> for the data itself and another one for the metadata.
>
> Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
> to avoid having multiple devices with the same name.
>
> Fixes v4l2-compliance:
> Media Controller ioctls:
>      fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>    test MEDIA_IOC_G_TOPOLOGY: FAIL
>      fail: v4l2-test-media.cpp(394): num_data_links != num_links
>    test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
>
> Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/v4l2-core/v4l2-dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index 397d553177fa..5c2c9ebb6b96 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
>         if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
>                 return -EINVAL;
>
> +       /* Add Meta: to metadata device names */
> +       if (vdev->device_caps &
> +           (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
> +               char aux[sizeof(vdev->name)];
> +
> +               snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
> +               strscpy(vdev->name, aux, sizeof(aux));
> +       }
> +
>         /* v4l2_fh support */
>         spin_lock_init(&vdev->fh_lock);
>         INIT_LIST_HEAD(&vdev->fh_list);
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

Reviewed-by: Yunke Cao <yunkec@chromium.org>
