Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DBC001B0
	for <linux-media@archiver.kernel.org>; Fri,  3 Nov 2023 08:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjKCI3k (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjKCI3j (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 3 Nov 2023 04:29:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3011B6;
        Fri,  3 Nov 2023 01:29:33 -0700 (PDT)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 320D266073D1;
        Fri,  3 Nov 2023 08:29:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699000172;
        bh=Zpw0kWCcEIOsCFNF+ZDHr5z8RxhYpsctqAvhh991yE8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZwvI3y6gl9da2ulwCIgyN0HcoltT6OGy+kBDMR4LJxKwT1JtXtmtI3JpBge0pKqNc
         YN3b04ETjK261DvcYgA6AxW1B/46RLAF6LfKBGgwg5lTJkxCraXBQPfpOQBRlItQoD
         J8/5IjR8VUs93oKPHZxZ0JQHWA7k6PCDt71Ss6+Jna0/MDpH8yoRumydQ7ifGzHNMr
         Mky0j13u7CYxkgp+3oQtxDgwsLoo5D+uIBEUyvbXzuRRQAl0t2pnw1xbBzCeiRHVES
         e5FbHE7tFzYnhXZhhTLRbDwVUin1FH/xvk751dLdEJdgahvKV4Kv9JMnYeUVeUE7+P
         LpPzug06cmZmA==
Message-ID: <dc32d9db-901d-4d05-8c1c-6fd423be2849@collabora.com>
Date:   Fri, 3 Nov 2023 09:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/16] dt-bindings: media: mediatek: mdp3: add
 component TDSHP for MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
References: <20231031083357.13775-1-moudy.ho@mediatek.com>
 <20231031083357.13775-11-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231031083357.13775-11-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 31/10/23 09:33, Moudy Ho ha scritto:
> Add the fundamental hardware configuration of component TDSHP,
> which is controlled by MDP3 on MT8195.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

