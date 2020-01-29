Return-Path: <SRS0=dZFy=3S=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9D2C2D0DB
	for <linux-media@archiver.kernel.org>; Wed, 29 Jan 2020 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314620716
	for <linux-media@archiver.kernel.org>; Wed, 29 Jan 2020 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bzadverts.com header.i=@bzadverts.com header.b="ao5yBc6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2NUZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:20:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43428 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2NUZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 Jan 2020 08:20:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so13883095oif.10
        for <linux-media@vger.kernel.org>; Wed, 29 Jan 2020 05:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzadverts.com; s=google;
        h=message-id:date:from:mime-version:content-transfer-encoding:subject
         :to:content-disposition;
        bh=9tUYY5gmt+xiddI2+CbxleouQlrCrrUaadISs5MBZIA=;
        b=ao5yBc6K37wnDAEBSG+nXQ7nhAxSmIxAf13vKHAFREl6R6EdqyGvKDEorcYbJyYTpH
         Ycf9+pj9F8R09mDwjjGZxwdGJ+OEir8CPXAokmEjPkX2lY5Yy9/ZUv3uqRKvma/KXVQg
         +Iaw13+zbcGO5RMSvMUTDepHGvSbsezaBs6S0cHc5bJaDnkj+8p5cyvlVoaYwD4aa+lg
         KiUc09YnUkX70f0HyKX5OxZ/DUSv/+scAgrGNSBuxbYa4Tn3Mrq22jDnlNLcJQtBtBc4
         3A/FyCtaHi3ru8owtu6yERk4dH57y2ElM3nnFfQAS2NLTfZL6YD5dmcG4xl6tNtGlPje
         4Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:mime-version
         :content-transfer-encoding:subject:to:content-disposition;
        bh=9tUYY5gmt+xiddI2+CbxleouQlrCrrUaadISs5MBZIA=;
        b=WpNx5CP7x5VhyudNQUeh/Ou52ZOHIZthO2lw3Vnkiq6Zt/kd9ARnCV5NEl2nKJrpst
         qhTP/lHtQKlhudrX7wLFvdA+/v75Gv2227eW0B9Ct52JrRfa9f7UWrRRSuiY57SXk7H8
         p+Wb3SfJrdGJi3gbVD2IysKbFjt6m57OpEllZRKwFNfWCauKgH4StoRwOvVnYCoMHwlV
         po173CcHNC5875C/z7I37jOa74xnyzkqc1GpaNtuXIBuhFWkGfe4o0Y4oyy08qhQdANr
         nPy7ulBro/7r4neFHUHrLf6tysG6FfqGpS/GsYQRtW6QjI2ljWhCklsX5F8cCA3H4PCB
         ARvg==
X-Gm-Message-State: APjAAAUVMJYiqf0XQpHBO5hSxBSOw0kbHfMvPlgCZ6iSWDR+SUQULAEx
        +wDxZWdtcyr4WD5PoFuSTekv1h/eSMQphQ==
X-Google-Smtp-Source: APXvYqzTua8clhueJv9eBNhyOGVfsPPUGXbrNOWcvLs2pPAFE1VcmVbUp0zFwHkTQVw54nBNEFS7Vw==
X-Received: by 2002:aca:8d5:: with SMTP id 204mr6172926oii.141.1580304024189;
        Wed, 29 Jan 2020 05:20:24 -0800 (PST)
Received: from [127.0.0.1] ([2600:3c00::f03c:91ff:fe50:9fcb])
        by smtp.gmail.com with ESMTPSA id i12sm682357otk.11.2020.01.29.05.20.23
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 05:20:23 -0800 (PST)
Message-ID: <5e318697.1c69fb81.b4f5c.448f@mx.google.com>
Date:   Wed, 29 Jan 2020 05:20:23 -0800 (PST)
From:   joseph.moore@bzadverts.com
X-Google-Original-From: root@debian
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Collaboration inquiry to bootlin.com
To:     linux-media@vger.kernel.org
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello!
I=E2=80=99m=20an=20SEO=20manager=20at=20Bzadverts.com.=20Having=20visited=
=20your=20website,=20I=20would=20like=20to=20say=20that=20it=20is=20very=20=
informative=20and=20well-organized.=20
Actually,=20I=E2=80=99m=20writing=20to=20ask=20about=20some=20advert=20oppo=
rtunities=20you=20offer.
I=E2=80=99m=20greatly=20interested=20in=20
=E2=80=A2=09guest=20posts
=E2=80=A2=09link=20insertion=20(in=20the=20existing=20article)
=E2=80=A2=09homepage=20link=20placement
=E2=80=A2=09banners
Do=20you=20have=20a=20price-list=20for=20these=20kinds=20of=20advertising?=
=20I=E2=80=99m=20interested=20in=20both=20permanent=20placement=20and=20mon=
thly.
If=20you=20have=20any=20other=20online=20platforms=20for=20advertising,=20I=
=20will=20gladly=20consider=20them=20too.
Hope=20to=20hear=20from=20you=20soon!
