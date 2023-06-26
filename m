Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1501DEB64D7
	for <linux-media@archiver.kernel.org>; Mon, 26 Jun 2023 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFZLZS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Jun 2023 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFZLZR (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Jun 2023 07:25:17 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00B101;
        Mon, 26 Jun 2023 04:25:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-400a9d4b474so5580341cf.0;
        Mon, 26 Jun 2023 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687778715; x=1690370715;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MurxMTQFEWdZvNUGfU83XotW57ML2bBX0pSdLPLZ+f0=;
        b=p4nGsAEcV2VUdiYQDXgMMnG+Wi6MKcS0zbocgr4eP/gx+JyK8POwk4fIlMIuRWpf9J
         1ffIEBQp/RcPSc8WqUJwKi0X06v1mzgp/wzne8tEwT41c2Gqk6YoFm76itEJSvbbuYVm
         ze9GzNyWagTlvTHeSEOEoFfX0gjHrSwV9O/Dqq7L9eolq2Ej5DLJls2aqzyOmo155nVU
         lVscXPT+7vYiCTLP9Oc/NE+3CLJr9aj2GMSEMxFTDiQHquKymWabuO9hohGmZzdevgHB
         f+y6AVxQ9IqNBNS/3CYwfE/Q1LMKQahA+/zq9gNFNlqbBPDRSN2HZSWkqmGabfUiEThF
         HL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778715; x=1690370715;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MurxMTQFEWdZvNUGfU83XotW57ML2bBX0pSdLPLZ+f0=;
        b=awzrmk/YoREkFGW5XobCbcdjhYcuONmpAnSKg7Wb1NC/lzXrx8oDbkjBQosXpf4iNl
         8fcAiwEyxSxrgWKWXNh37OgmNiMVjLrGzyrQfIZEi1oxlJI5Vv5s1oLHzuayWmmjhY0E
         788hWe3QevbEjkjE2ZXAsimP93Bxtak3kEw8qTvVr+2/AS3c3/neopgREo+ILx49th+1
         TLcx72qBtd3AI3KuctHEMCT1MIke/AQDp0Ta11UOMrE7HLcSHd0IUAV9mlY9gbfn+EPK
         jsUq9Gp3i9rYw9RvKRq2ez4DR5kBh6NkwbVFXrYzDyKGSBe3mapHLAlsmmILIWsGOo6Y
         g6gQ==
X-Gm-Message-State: AC+VfDwlGr1cDVMUdX7ilqgR98jBpDg0f2ALJxZ7+l0He/97LwaTVaG+
        em0AQU214gLFjxno97fyN8H8zQSDh6JHvC/NadI=
X-Google-Smtp-Source: ACHHUZ6r5+Vtu4RaA9efJ4JNSDQbAsOj3um01LgO75PP4O5L1d5t0BkmmtlzGB24LMaYjqWzLT+5p4x9yfhHwY7pj5U=
X-Received: by 2002:ac8:5acc:0:b0:3fd:e17e:9468 with SMTP id
 d12-20020ac85acc000000b003fde17e9468mr33095220qtd.37.1687778715428; Mon, 26
 Jun 2023 04:25:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5f47:0:b0:3e6:3312:616d with HTTP; Mon, 26 Jun 2023
 04:25:15 -0700 (PDT)
From:   "zbynek.miklik@email.cz" <hallotherebuddy10413m@gmail.com>
Date:   Mon, 26 Jun 2023 11:25:15 +0000
Message-ID: <CABsaQPJscjHGv+C2VJj73_V4e0KiS5ZOTbSiraCx22ZjtgpCkg@mail.gmail.com>
Subject: Newsy Paper
To:     Klaus Schmidinger <Klaus.Schmidinger@tvdr.de>,
        linux dvb <linux-dvb@yahoo.com>,
        linux media <linux-media@vger.kernel.org>,
        Igor M Liplianin <liplianin@me.by>,
        Majordomo <Majordomo@vger.kernel.org>,
        Meysam Hariri <meysam.hariri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

https://bit.ly/43YOfP4
