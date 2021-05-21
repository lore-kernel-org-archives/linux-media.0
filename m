Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA4C43460
	for <linux-media@archiver.kernel.org>; Fri, 21 May 2021 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905B5610CB
	for <linux-media@archiver.kernel.org>; Fri, 21 May 2021 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhEUNkU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 21 May 2021 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhEUNkD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 21 May 2021 09:40:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66822C06138C
        for <linux-media@vger.kernel.org>; Fri, 21 May 2021 06:38:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e10so16617299ilu.11
        for <linux-media@vger.kernel.org>; Fri, 21 May 2021 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=NDr61RfLLnF+gQBIiMtqzi7vpbFZjTAEQ/3snixCdg1v/fEnAITaDrsuFLzVjPCdhd
         Lmzrnxe9Halzpk0OlPiHVvJthHoZhrECa3Q3BLCOpC1LuNqyOKRaAeJTL5rtPeL1i1ej
         CzBGsLziVQgkGuT5f2q8JI8zWMkMzjTLPtZrBcLt07IWpu03LiJhUz7pfM2vyco362dF
         bJESuQwJc8CPrw9DK3P/gOs6s/WU07rNftjUU/WWGpMijP1jIvGdkBnMZts8k6SW/elN
         sX/ZnvCC6SW9U1rnkRAmmHVeBGL0bT/0u+T/HmLlS3VCwov+oxESpTAJbi18cUHNdlLe
         1tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=I/YEqd1HOrWoBVPlFryQAUDMnrj8oPzHp30yQYQjPuPTBWGL5HpOPXii4vp4w93hcf
         WFTaoDOOxPsdabMJxwzpTdM93cSL5G90PTTWGT6MMaO5FWTvxmZAJcMM2BKBjPWBGkLE
         PmGuk2rEGeL81bepkw3pHHkqJ4dHpLviiPe6Haz1Jrgc5nGX1/ufbOH6vjZ5ZZvqu4Nm
         0Zm+qPU/6tDi3w8xbMa8QHF6D+w/0btZ3hv3b+pRjFqQV/mK/vz+H0D+dDtY1hGDc1hl
         UdWKa9zBXNVeFU2EutaeWlARQiI3SwwjhDtc2S8XG4QtU/zBupgJjDnVXqTME0x9NmKT
         BPaA==
X-Gm-Message-State: AOAM530patRG650taUElpeB4KIe/pdoDSgvBfK798oZC63mD9VBdoyCB
        TF9qUHtSnWQDj7EqcMsi1gcE53g65hwTZpEj1N/PYQ==
X-Google-Smtp-Source: ABdhPJy/pKbvVZY2/ULXOE3xI/TcxMMBcvpBSC+29wPkgzlKokgXyeEvamPfYmJfaNpUd1aCuAwQoKJVrbi12TOABqk=
X-Received: by 2002:a92:c74b:: with SMTP id y11mr13202440ilp.302.1621604314599;
 Fri, 21 May 2021 06:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-15-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-15-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:38:23 +0800
Message-ID: <CA+Px+wWAZE2ea7pfMEF3Xg_w+H4n8QAK6qcOyA2TAOkYd5_GBg@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] media: mtk-vcodec: enable MT8183 decoder
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> [acourbot: refactor, cleanup and split]
> Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
