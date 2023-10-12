Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C7CDB47E
	for <linux-media@archiver.kernel.org>; Thu, 12 Oct 2023 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjJLKDc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjJLKDb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Oct 2023 06:03:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A61C9D;
        Thu, 12 Oct 2023 03:03:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 947A7660730F;
        Thu, 12 Oct 2023 11:03:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697105009;
        bh=vSR9Dv/F40nI015RR/8THaxAbwmFqoejsJwpTYtpx/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QBNYOs35EM11eNbq4zlUrZ7qdAJXpabM2HA//NhdL3bImajgCeWrHaU3P0EjuA1Tz
         R6j8DYqo7wSNnyXsHsPzEj0G0gc3+PIDIpjcCM9oqr+npTeYcII/m9KJKgTyfrfN9k
         Z5Nzzq+Xma2TSmMCOy+z3c08zm0E47lg+dqVMy/uMV/xvCPh4kPhjZJn6ezTDhH3EX
         XvXy4wLgOuUGTy3bbYqW5QEO/njdJbOZumzYDoaB8eDv6VyzXUxn86ckfkQWIfRtxi
         p6wRmjMkxMpMElFfpG5/ZGj0MDdML63z5ts5XOIprMDliB2UUTgc8JRkPlzmOeIl3w
         B6rrrKGGpWkyQ==
Message-ID: <9c811fd0-9584-0df9-9639-00806f9c89a6@collabora.com>
Date:   Thu, 12 Oct 2023 12:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] media: platform: mtk-mdp3: fix uninitialized variable
 in mdp_path_config()
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231011030037.22337-1-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231011030037.22337-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 11/10/23 05:00, Moudy Ho ha scritto:
> Fix the build warnings that were detected by the linux-media
> build scripts tool:
> 
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
> 	In function 'mdp_path_config.isra':
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
> 	warning: 'ctx' may be used uninitialized [-Wmaybe-uninitialized]
>        |                    out = CFG_COMP(MT8195, ctx->param, outputs[0]);
>        |                                           ~~~^~~~~~~
> drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h: note:
> 	in definition of macro 'CFG_COMP'
>        |         (IS_ERR_OR_NULL(comp) ? 0 : _CFG_COMP(plat, comp, mem))
>        |                         ^~~~
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
> 	note: 'ctx' was declared here
>        |         struct mdp_comp_ctx *ctx;
>        |
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


