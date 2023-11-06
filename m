Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE8C4167B
	for <linux-media@archiver.kernel.org>; Mon,  6 Nov 2023 12:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjKFMou (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMou (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Nov 2023 07:44:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782EE100;
        Mon,  6 Nov 2023 04:44:46 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D5566607483;
        Mon,  6 Nov 2023 12:44:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274685;
        bh=Ri0yYh82tmpSsPL/9GQYnHY9qIfhLuzQCQdFwyp4wiI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hGjMpE3kxfzVhiNwWFTeHuo9VQ82iwCYaOek19o3z/NGsWjAfSrXXbqUUJY1s45na
         m9CaJo9GUf96DvULrlqiB9lAHasgQWudwC159hkmi29OEBia5ygshsrtqGDMGP5MAx
         MKAFmg+Pagpr5VLgWuGxqqguL7R6f157Zz8GhVf1LVAN91LlYgHOK1oM2swR8gQMfn
         DORCoIs1SolaprzLUrVfTOB8i8i35kL+3pAYzLV4kEvSoQtK+3WKzvaNLAh5Xt6NF7
         eUgLGIDW6wDFPzHMYck2cE9e8Jxd4ZUXnF0BIOMFlbAukMdGYj5dG/72fT05iwZ4hF
         VqN7NbqjxOmQQ==
Message-ID: <5445c24a-3bd4-4fb2-9cf0-ec9fd61da6e1@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/12] media: platform: mtk-mdp3: add mt8195 shared
 memory configurations
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-11-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-11-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 30/10/23 11:06, Moudy Ho ha scritto:
> The configuration of the MT8195 components in the shared memory
> is defined in the header file "mdp_sm_mt8195.h".
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


