Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4757CC433FE
	for <linux-media@archiver.kernel.org>; Fri, 25 Feb 2022 09:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiBYJYq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiBYJYl (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 25 Feb 2022 04:24:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B9269284;
        Fri, 25 Feb 2022 01:24:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C2C3D1F45AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645781049;
        bh=yW4gEvTplbIUHZxp9m+Js7rQRpC8PxBGMXAC4Ov2i7s=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=m9U0PRNKENRR9xiVxEuPncTvaS8KCkxL803Dl46Ra6VENRDmEW6bt+XOIU2B5YGMH
         RS9TMC7Wlw8lS7kVQyuILa6FlRJWq5MYV8r/U3+91li9UIVXkZLWt8OVW+xWIfN46t
         3g0vwNBfQQPCzr/svEFYtQA4QHXJ4IVWEgFib5pI3XV+ivqWs+Ga8PF2ARoeR8OMLT
         VT0VPgRHht6/ixv7oPgk8adPyLxkP8hXUpD3MCn8jnmOfFyNbRAgQ6CsqgYthKFHKe
         gQ8vBode5Bqu3arnu2YCgFd/TdYmBNLfOv1LIW+dPb6V9mWlRHvBl4z+W8ljZDWjGC
         2G4nEJxCBbP6g==
Message-ID: <74dd7968-6760-512c-39c2-561eeacbd3ff@collabora.com>
Date:   Fri, 25 Feb 2022 10:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v7, 07/15] media: mtk-vcodec: Refactor supported vdec
 formats and framesizes
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
 <20220223034008.15781-8-yunfei.dong@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220223034008.15781-8-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 23/02/22 04:40, Yunfei Dong ha scritto:
> Supported output and capture format types for mt8192 are different
> with mt8183. Needs to get format types according to decoder capability.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

