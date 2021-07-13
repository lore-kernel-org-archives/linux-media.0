Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22002C07E95
	for <linux-media@archiver.kernel.org>; Tue, 13 Jul 2021 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C0D61288
	for <linux-media@archiver.kernel.org>; Tue, 13 Jul 2021 14:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhGMO4x (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 13 Jul 2021 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236763AbhGMO4w (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 13 Jul 2021 10:56:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4162C0613DD;
        Tue, 13 Jul 2021 07:54:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s15so33498422edt.13;
        Tue, 13 Jul 2021 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4EB4Sx0jgByYWBwXJvCykjKMntXAwLAnZkvJwOEWdQ=;
        b=PbpZ3Zv91l1nzaxTFRSV5RCJ0UZMnXDJxa7hn7u6BRCxqTWqxI1G5Wbm4zKEbjuE7z
         iawq7JjeMNb1OFc6OruibX/GHRxgi/g2AYwfm4zJOHYzqwu2eSJueMn8m5Uzm93nnU17
         zbZDQPLsczXsJgDb5p2GMM+nUH2P2Yevrj3e+VpaJFuv3Z3kmqACJWiwpO82DrBzOpCV
         TVqGNW7vrvNHkVFzz3CE+NnjRIEpAsM0tFH6+8SKTDQYIDbwADWNUxopOvA9bF0QDCsQ
         9rAz4uecRNQhkp4obuczNolb95cQ2dDsXpkohzV8YlJ6J5MDeIlTNzvAJsmkMk+djIUx
         Z8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4EB4Sx0jgByYWBwXJvCykjKMntXAwLAnZkvJwOEWdQ=;
        b=V9p3SYX6QKefIDY/LGFLChHj0xZWDTiEJULMrYSgNHabj1n2U/PrGQyMCjjZZoR0jz
         r88HjHfnqLLdk0AOUjOrYNoZ+WP2UpL2QKrSJCGZrIxOjl34d4MjV6D0AcEQfZ/p0aEn
         t8cpA7FZXO3ONPvrFvfd/XhYjc05rPxRHHzgC4qMe6JuWBULg/YB9lcEzQ8fImGBUD5t
         ucQOwKS/bRYSggy4ZKxF4I5OkqIGre81JLpgOEvseF2MsNkUMfzX6uZz0WaL8qKE+nG+
         FlxtTEmbIsmTMYPLUBiV51VboOcQBUEah1j2OM8KMXu59N+3uFMVEmfSd4LKui5yNn7a
         YPRw==
X-Gm-Message-State: AOAM53386OuKH4SpPAMiYAOk/KxErZaiNgSWWGLewFFt9DU/hq6sgSqr
        rlQqMaVFgKi2pJiOPPXMiny+DDTrOLIoTaedMhw=
X-Google-Smtp-Source: ABdhPJzUeWoIkovQmYJqOXz7yl/cm5RYe1xqlUrLVUZ7bM0bvpjRJVHK5xYFlMvPgUzLU8YuBHGHvNsLzh3G+R69Sgk=
X-Received: by 2002:aa7:c74e:: with SMTP id c14mr6327253eds.40.1626188040412;
 Tue, 13 Jul 2021 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210712201732.31808-1-viktor.prutyanov@phystech.edu> <20210712201732.31808-2-viktor.prutyanov@phystech.edu>
In-Reply-To: <20210712201732.31808-2-viktor.prutyanov@phystech.edu>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 13 Jul 2021 16:53:49 +0200
Message-ID: <CAFBinCBF6BH4LCJB0EQXdwMsmFOryH+1Y+JpcRY6BzG6hX0VWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: rc: meson-ir-tx: document device tree bindings
To:     Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Viktor,

On Mon, Jul 12, 2021 at 10:17 PM Viktor Prutyanov
<viktor.prutyanov@phystech.edu> wrote:
[...]
> +  max-fifo-level:
> +    maxItems: 1
> +    description:
> +      Maximum IR TX FIFO fill level
From Documentation/devicetree/bindings/writing-bindings.rst:
"DO use a vendor prefix on device specific property names. Consider if
properties could be common among devices of the same class. Check
other existing bindings for similar devices."
I am not sure if there's a "common" fifo size property for IR
transmitters though.

Also in general I think it's good to write the schema for properties
in a way so the binding validation can detect issues.
For "common" properties (like clocks, interrupts, etc.) this is
inherited by default
However, for custom properties this needs to be defined manually.
For this property I would add:
  $ref: /schemas/types.yaml#/definitions/uint32
(I think this can replace maxItems)
And I would define the allowed value, from what I have seen in the
vendor driver (which I am not sure about though!) that would be:
  const: 1024


Best regards,
Martin
