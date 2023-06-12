Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A2C88CB4
	for <linux-media@archiver.kernel.org>; Mon, 12 Jun 2023 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbjFLOWj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 12 Jun 2023 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbjFLOW1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 12 Jun 2023 10:22:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E03C10F3;
        Mon, 12 Jun 2023 07:20:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62de0e82a07so12560706d6.1;
        Mon, 12 Jun 2023 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579568; x=1689171568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGt2khsldW/yK01+mAcstIFHVN65sV05z5Q79/bd880=;
        b=ljEZHTKkONftdKKVSCi+wKIDdm0gnLJ6SMBdTdimtUJIhZHOpe76DvW3UUDLYM/2kU
         B5QCbInfk2RTZ/c53c+7GbxXOVj7MDaF7xLWlukwCl18GXuSd+vg6LcpZkMbWImY57Ya
         C7Kik1WKlSuEUJDiGYpkXlh7cQsJt6pamP874FmHLJ0BElhvp7NgnXmfMfbkXC4bKPBc
         mL5J5inTe5v5PEBFDTZOtqmlYbYR1vtwPHZ733loEQ/EqwxCfxfegSbG5KHOfGwNAukW
         6p3lf5jb+wQS/2sfH1xjBDRKbQHv35Ul8lEApqSErk3abp2/dK6tMEKqxS7eTIx3aHb9
         k9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579568; x=1689171568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGt2khsldW/yK01+mAcstIFHVN65sV05z5Q79/bd880=;
        b=Xy3fXQ0WorQG4PvZ+HhUQAGdvyw2jULExN9gZhK0RVcfQiXWbxJr6kk//5vW2mqkMX
         dLnXzzKGW+mI8pBV/CIcJXf4ix3xjKoDbgmfqFw3W4yu4HC5UvBZE3bxaZC6LrK+ihx6
         azMjiz2gkN55QKduP5nhLBf7KxOy4v+Q7UxSgoC2AelK/G83KTiaJ1310EIvTlJ5F/4m
         VgYV5s4qU8VHUxbozPUeBUFsAReXk2Kz8KnIq/ETbniQhEsWGXwxjcRntZ0MzANmYZSR
         ZPb8uGAkW8vocKdOyUc4r1Bp+rQHXpkeoAfIXtJ/dz9ms79+XLWThhmu4exB2jxWeCic
         rVdg==
X-Gm-Message-State: AC+VfDxTGgHboHa4yHKj3WpMAJhKivLBkVLVmSA/yC/NTkZmLWuFpWo7
        DRTy7KL+6FuuSFNjTcdWQB/reURSA2jlhPWG00CTu185TTzUew==
X-Google-Smtp-Source: ACHHUZ7EiL/u/Oo0zMxIczzjDxMtBBH12JwT1SrPTJPkS8ghP6RD7B8U5Okx2cKU3Hp5YLtAnSFPjLBGKMuVgEDkCn8=
X-Received: by 2002:a05:6214:2a83:b0:62b:3dd9:2dc with SMTP id
 jr3-20020a0562142a8300b0062b3dd902dcmr9945032qvb.64.1686579568244; Mon, 12
 Jun 2023 07:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230612141632.5232-1-hdegoede@redhat.com>
In-Reply-To: <20230612141632.5232-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:18:52 +0300
Message-ID: <CAHp75Ve3+XvsyrPauSzto0jU8Q1czM4Bj-qMquAc_WYK+ZHhxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: int3472: discrete: Fix getting active_value
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Jun 12, 2023 at 5:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> acpi_object.integer.value is 64 bit, so to get bits 31-24
> the value not only needs to be shifted but also masked.

Why? The type of active_value is u8. How does this make any difference?

--=20
With Best Regards,
Andy Shevchenko
