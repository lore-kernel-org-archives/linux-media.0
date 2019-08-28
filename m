Return-Path: <SRS0=BUBi=WY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00603C3A5A1
	for <linux-media@archiver.kernel.org>; Wed, 28 Aug 2019 07:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5924217F5
	for <linux-media@archiver.kernel.org>; Wed, 28 Aug 2019 07:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QURAhAVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfH1HS4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:18:56 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:36527 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1HS4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Aug 2019 03:18:56 -0400
Received: by mail-io1-f52.google.com with SMTP id o9so3948022iom.3
        for <linux-media@vger.kernel.org>; Wed, 28 Aug 2019 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LBTmr+u/ll+ec1sXUYsm3kWarWnOtf47U/5VvRHfk0=;
        b=QURAhAVVbDqA9BitIpPd7bqLRan4epUlRU5WKqfWOn/AtJSvjkCeRukPuQMaiP1aGZ
         3JcrFtcOmz2LTEycDRL0+gH26Po7febdO3ME8tTmZ3A1nL5p3j6YaEOFlUS3OZE1RMoY
         mT3vnuOco1iAkQoU5XebIE4ly6MU/QIihJrMacQEBDjzXUOR4UMe7avA9pk0ZQ7RJUt4
         COx7H47+Ta9dfMLKrro/tlBTOt5stwrmyTraOlKdbsdO7nX0yblpzKemPZ4bvKG1iHCB
         Y3JuprullAkMBzq+QCIP2jGD4m0UkAP7xM/Kd05kdG/JBm4ut0kGYpa3rsxBfnMC//sr
         PoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LBTmr+u/ll+ec1sXUYsm3kWarWnOtf47U/5VvRHfk0=;
        b=fPEialWHuXwbPsDasQfLnaFz/Hh85bxZaeFYjOSW3ZNAW99niMwQ9sTrThMqFyB2rA
         J/JXlxSuh6qHD4TNnkeExdp1ZgFoyMLQmORvCQqmu+kfNNm4m75/ZWh4gpRl4Vo19OxB
         fhWPQDPN2ZrP6SzhaLhuWv/Y2BvxzYDtHsIFAViUC2C3s61gslSMrAaQSCNGwhDDFOyP
         FTdLakviEp62qKdqWS24qutB0IKDePS7d8GEaAbDxl1d9wiJ1jGLN1sfT7GJCsSAsK6a
         Hyvv2ZPtKzvpdDbGxlpJtPvcISA0yx7qwkLy4hLf1E8v9L6LDKjy5ohG5YcEmsArMEeS
         KTjQ==
X-Gm-Message-State: APjAAAXjx/C52e3VUeS1ehoFaoxI4j8naV5y8VhNcw+JTd5M42DHO7hk
        yIVXwO9L9S0f+L97F41H5zcHUatw/pwRLgUhncFmVw==
X-Google-Smtp-Source: APXvYqxA2ZHjkm6bFll8L6S4oXwEng6zqnJkJSqB0zfTBDBET3xsdisBSj5iJaI2tBO9qwReNTBAjoGICoeMx1bPpqk=
X-Received: by 2002:a5d:8e15:: with SMTP id e21mr2845840iod.296.1566976735508;
 Wed, 28 Aug 2019 00:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com> <20190814104520.6001-6-darekm@google.com>
 <1e7fdf30-3723-857a-68fd-139f396856b7@xs4all.nl>
In-Reply-To: <1e7fdf30-3723-857a-68fd-139f396856b7@xs4all.nl>
From:   Dariusz Marcinkiewicz <darekm@google.com>
Date:   Wed, 28 Aug 2019 09:18:43 +0200
Message-ID: <CALFZZQFN4M_3vjigmwLbCvP+060hyR5ogx-e2W+=R1NafHcapQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] drm: tda998x: use cec_notifier_conn_(un)register
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sun, Aug 25, 2019 at 3:12 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> You dropped a 'if (!notifier)' before the return!
>
> After adding back this 'if' it worked fine on my BeagleBone Black board,
> so after fixing this you can add my:
>
> Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>
Submitted v7.2. Thank you for testing!
