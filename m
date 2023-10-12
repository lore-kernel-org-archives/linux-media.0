Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F16C46CA1
	for <linux-media@archiver.kernel.org>; Thu, 12 Oct 2023 10:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbjJLK2D (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjJLK2C (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Oct 2023 06:28:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42FBA;
        Thu, 12 Oct 2023 03:28:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB5B6660730F;
        Thu, 12 Oct 2023 11:27:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697106479;
        bh=StSBtBFRveXYIL45dyE8XTnUqsdXxRTGDniwyzvzIfA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oVtSeUgOnNjwIhSKlvsoG4xYyhYvHT2ychbcXuS44WekMIc43Hn3rDATdeuikUMQh
         HVhbiGnS/Lc1rxphFfe7YcIoGC6C3XEsPWOuOpgTPNlE5l+hO5WnNXzaQMzsGLTcAg
         HI0HqdlOpe5VwlEk7PUYSRUGp/IBZEELktr6PrnHeW6Ybb7GOCLX5cSHI/Zk5Vl1E1
         MT3nlZvK5Dr3J6n8s6ADqnm9+XUPSx9vhZetzFDi7kCNGkXphMbubFhxPK5lVT7F9c
         o/pA9PwLCYmonX3ZoMWCEcTmRDPcrAyjeDknNWp4sozBfPj7ke9NsHNfPtVZp21yYU
         Bz3EJ5XxE5cQw==
Message-ID: <b1091d91-022a-578f-ab6c-1f9f80799afc@collabora.com>
Date:   Thu, 12 Oct 2023 12:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 03/16] dt-bindings: media: mediatek: mdp3: add config
 for MT8195 RDMA
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231012084037.19376-1-moudy.ho@mediatek.com>
 <20231012084037.19376-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012084037.19376-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 12/10/23 10:40, Moudy Ho ha scritto:
> Added the configuration for MT8195 RDMA. In comparison to MT8183, it
> no longer shares SRAM with RSZ, and there are now preconfigured 5 mbox.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

