Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E423C432BE
	for <linux-media@archiver.kernel.org>; Fri, 20 Aug 2021 03:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D14610FA
	for <linux-media@archiver.kernel.org>; Fri, 20 Aug 2021 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhHTDaP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 19 Aug 2021 23:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhHTDaO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 19 Aug 2021 23:30:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7143C061575
        for <linux-media@vger.kernel.org>; Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h1so591660pjs.2
        for <linux-media@vger.kernel.org>; Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0sG6HNEqWhqC0CeVVryRPgZqvHD/ht80kWZ9SsRV5Q=;
        b=D00ouktdQh5MbXzxcNc6u9fD9+yFYjduyXj/ggJG2HjjkeiB6ybDKUgSwcv1gbKSpV
         jq1SU1lO9XHuwcb2aFzzAhIuPSUsiE70Bp74Qo4zTlUIRiGwsAujiFed2M5zKISDeD1v
         ci94pzNGtWzMuN5Cy32TGj85vvbN1bKIoruAhxen2YVEO7i3OZ7XJJ+B9CTcse9FyK+c
         DxiUqPuEjRZeQkoKziqQzf8K8hR5aAIh87qQ/k+WkAcc/tQk5/NO/g+tElhuscvLEmau
         UsYy+DVAEUeWW0d7QVPnfNe2u1Jnu5/K2XexzZdcJb5U2K18yHYnf+8Ne8nhCJHl3Yz1
         PITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0sG6HNEqWhqC0CeVVryRPgZqvHD/ht80kWZ9SsRV5Q=;
        b=e27Rsn29Hw3GcLbqU8cUaRPnHqIY9CGHcf8TQvsQPGA7Doq5Tj9CYowV/U7heG5y6I
         cMWrYZUgvUPiyt2ce+H7lgEq7WljqruNBnyLmWXc1yT37J70F1p7hQJFwprRnVsk9JFO
         YUFeccl8VedzjWCI6eMsZnxFLQ2/hNubqBQecnlzqe9YWTOEQ6DwlMteLccFXlXWprXa
         0s2CHn8dgBIvSgd0kg411OoepjnI4ezdIiUalSyVweH/FhAxj3N/ymMqk+FvlRGszn/1
         bCU/+lgZtDUmwzd6XyxyYbFsAk9B/IYcHhWLero2K4mhhftYJeuw37zGo2ZM5XJZPVVS
         BcQA==
X-Gm-Message-State: AOAM530obalWBpM6M0paiR1WCw7fvd6SsvZK9pL26yfX4hDMxiZ3RqYn
        suyiepdpLnLJrgEALBoXtHMYUA==
X-Google-Smtp-Source: ABdhPJzsWONpn/nU+p39za84qQxpK6KZY9p6xu70i+SP/EhBA6Jmd3xqATtzwKo2xEmQ8jepckPaLA==
X-Received: by 2002:a17:90a:fb97:: with SMTP id cp23mr2346062pjb.93.1629430177117;
        Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:549a:ad5a:e5bd:8c8a])
        by smtp.gmail.com with ESMTPSA id l2sm4864369pfc.157.2021.08.19.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:29:36 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:29:32 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        George Sun <george.sun@mediatek.com>
Subject: Re: [PATCH v5, 01/15] media: mtk-vcodec: Get numbers of register
 bases from DT
Message-ID: <YR8hnAiKHLpa1bri@google.com>
References: <20210811025801.21597-1-yunfei.dong@mediatek.com>
 <20210811025801.21597-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811025801.21597-2-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Aug 11, 2021 at 10:57:47AM +0800, Yunfei Dong wrote:
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
