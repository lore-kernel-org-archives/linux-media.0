Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3E1C77B7A
	for <linux-media@archiver.kernel.org>; Tue,  6 Jun 2023 07:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFFH2l (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Jun 2023 03:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFFH2k (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Jun 2023 03:28:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0EEC;
        Tue,  6 Jun 2023 00:28:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CA9DE6602242;
        Tue,  6 Jun 2023 08:28:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686036517;
        bh=pyYwYgG/thDw/e7Th0o26z7PqRLB1l3MTnLTKnKnhvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c2chsJM784VPrrt2tC/268yFVqlR8UIxGiX3OAOk69aRouGNYw7rKUdVnB80DdmM1
         VoKM8I9otTX7zoaLFDO7juqw3ML+VuAX9LMSn+UbMvM1+Lz4O57mtIzK7wq+2YW1cQ
         tTXKhtIlofe+7QKrZxnox4l0r3l7mBef2KGn8yZ8ppzOHHLHTCz0uou2QgaQI1yis7
         liCyB9qyglR9dBZKIzhVaoo9qew7tOx0rdqmQTBq3v6CrDGLDM4cZAyk+/hLJLzFRs
         0YErAlu7yADh7fCMv0BODFUfgh46Ng7mT7p6f920bHaSb4Np3D1cPpJHCm8PXxKmHp
         UWfi0EN6gLAqQ==
Message-ID: <1b3dd7b7-3c4a-f18a-a7c2-acab39a77b3d@collabora.com>
Date:   Tue, 6 Jun 2023 09:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/6] media: dt-bindings: mediatek,vcodec: Don't require
 assigned-clocks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230605162030.274395-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 05/06/23 18:20, Nícolas F. R. A. Prado ha scritto:
> On MT8183 it's not necessary to configure the parent for the clocks.
> Remove the assigned-clocks and assigned-clock-parents from the required
> list.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

It should not be mandatory to configure clock parents manually on any model
anyway...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

