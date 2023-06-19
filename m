Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF0EB64DA
	for <linux-media@archiver.kernel.org>; Mon, 19 Jun 2023 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFSKU1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 19 Jun 2023 06:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjFSKUW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 19 Jun 2023 06:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119E1B8;
        Mon, 19 Jun 2023 03:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99D2E60B4B;
        Mon, 19 Jun 2023 10:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B39FC433CA;
        Mon, 19 Jun 2023 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687170020;
        bh=5npHlICX1Ui08YJUtQBgkjqlYH9O/bXDO+sewSzOHso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YqrmBdBh/vZu60o7Pbso8WgHJN/DJkJddoBQmw19FIfhxpZTzTDH5IswHVJdssQZp
         hXi1MDLwQUg06OzgvCasN0IryLxdkkH0UrVzWnGhoqH6tDkoxzLxDpqY3jwGHDB2hx
         LWsFtW6Jx2+DCjGio3bM9gfHreVYU+weZZKBzZmmM69m/jkIHXeZHy+UYV+j64bJia
         oupGSS0UqG8cF8fc8VEgpXqDGC0qRCphTJ+eduSWwWqcJyJjcYDHbVXDfwXvM3JLsN
         q7ZQTJDCdY2vGudNrCT3h3IN/TXYh1riRQ+YTha11fpybjEYNZTz9ma7RVkRQ90vQu
         0rwNI50sYeiZA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b47742de92so12077381fa.0;
        Mon, 19 Jun 2023 03:20:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDwnY+1lmG61GE1Ud+ea1rHtHAuI2otTtE8tWEonNs/pPzqLyeh+
        Gkg3tDQ28EnDmRnyJjh4/hAxZb4+uK38z+IiKeQ=
X-Google-Smtp-Source: ACHHUZ5LVZk3OMm09AuAMk+KuIwlCvrpDvoFz2Z5S+ZqZMi+9mMRLffEi6MsXuJWpLfSQKBGOiVUGuOsvIz0A9XR+5I=
X-Received: by 2002:a2e:9916:0:b0:2b3:48de:e282 with SMTP id
 v22-20020a2e9916000000b002b348dee282mr5125044lji.51.1687170018106; Mon, 19
 Jun 2023 03:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230615143613.1236245-1-15330273260@189.cn> <20230615143613.1236245-2-15330273260@189.cn>
 <CAAhV-H704swbRxsZoJN5ef3X41n9Vw-js_73tptK3cAjCWP6tQ@mail.gmail.com> <3e41da42-7bfc-c934-d8a1-ec18047849dc@loongson.cn>
In-Reply-To: <3e41da42-7bfc-c934-d8a1-ec18047849dc@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 19 Jun 2023 18:20:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5XR+tbxuDoGHZo3vshes6xwhBOGC=OrZy11Mq5fizaCA@mail.gmail.com>
Message-ID: <CAAhV-H5XR+tbxuDoGHZo3vshes6xwhBOGC=OrZy11Mq5fizaCA@mail.gmail.com>
Subject: Re: [PATCH v15 1/2] drm: Add kms driver for loongson display controller
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        loongson-kernel@lists.loongnix.cn, inux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jun 19, 2023 at 6:12=E2=80=AFPM Sui Jingfeng <suijingfeng@loongson.=
cn> wrote:
>
> Hi.
>
> On 2023/6/19 17:18, Huacai Chen wrote:
> >> +
> >> +enum loongson_chip_id {
> >> +       CHIP_LS7A1000 =3D 0,
> >> +       CHIP_LS7A2000 =3D 1,
> >> +       CHIP_LS_LAST,
> > CHIP_LAST or CHIP_LOONGSON_LAST?
> >
> This is intended,  CHIP_LAST is already defined by other drivers.
>
> It will not cause redefinition,  but it deny my VIM text editor jump to
>
> the right place on one shot.
Then use CHIP_LOONGSON_LAST please.

Huacai
>
> --
> Jingfeng
>
