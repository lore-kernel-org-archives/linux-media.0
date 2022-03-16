Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6134C433F5
	for <linux-media@archiver.kernel.org>; Wed, 16 Mar 2022 03:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350184AbiCPDwB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 15 Mar 2022 23:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiCPDwB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 15 Mar 2022 23:52:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CAC5F8EF;
        Tue, 15 Mar 2022 20:50:46 -0700 (PDT)
X-UUID: 734cacb41e7f4e69a2c2c425b2af9b79-20220316
X-UUID: 734cacb41e7f4e69a2c2c425b2af9b79-20220316
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 562391288; Wed, 16 Mar 2022 11:50:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Mar 2022 11:50:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 11:50:34 +0800
Message-ID: <ada140c4418b90a5a5bf7282b4bcce7baa502208.camel@mediatek.com>
Subject: Re: [PATCH v13 4/6] dt-bindings: soc: mediatek: add gce-client-reg
 for MUTEX
From:   CK Hu <ck.hu@mediatek.com>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Jernej Skrabec" <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 16 Mar 2022 11:50:34 +0800
In-Reply-To: <20220315061031.21642-5-moudy.ho@mediatek.com>
References: <20220315061031.21642-1-moudy.ho@mediatek.com>
         <20220315061031.21642-5-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi, Moudy:

On Tue, 2022-03-15 at 14:10 +0800, Moudy Ho wrote:
> In order to allow modules with latency requirements such as MDP3
> to set registers through CMDQ, add the relevant GCE property.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml  | 8
> ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index 4adc67cafd29..06106779d129 100644
> ---
> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++
> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -56,6 +56,14 @@ properties:
>        include/dt-bindings/gce/<chip>-gce.h of each chips.
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>  
> +  mediatek,gce-client-reg:
> +    description: The register of client driver can be configured by
> gce with
> +      4 arguments defined in this property, such as phandle of gce,
> subsys id,
> +      register offset and size. Each GCE subsys id is mapping to a
> client
> +      defined in the header include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg

