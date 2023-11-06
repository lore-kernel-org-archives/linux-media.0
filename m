Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E8C4167D
	for <linux-media@archiver.kernel.org>; Mon,  6 Nov 2023 12:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjKFMpM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjKFMpG (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Nov 2023 07:45:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C910C1;
        Mon,  6 Nov 2023 04:44:59 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C8676607482;
        Mon,  6 Nov 2023 12:44:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274697;
        bh=IYhctRnsJfWr1S6xZVv9OU0HXSgl08A5U9Or74Nza4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nrewubOQD7kFZ83Gw+JrVL41Uxrj/RuMf1PnnZvEWj4AumWLGfD3oTFM58IOcDl4o
         C6hyJkRk8rdj8fs/iXZMVKi+sDv5/AAMB5nQWFQJVe6colvyj7uBT4Yg/llE7/lz9u
         wqmmrSG+71WiN7UkaXliOHUUodimmwuWVD/eDMmyAZ+9w7UTTbzL4s+y7I7F+wc3eN
         PnbRWo/r4aNODNuFbjnCWDez+JLnVOUXBYo9d8SJe+lhqZqfr3Mwhf8R13Qp7Ottw+
         vMJD20rXyXeFYbR/uPS4NkFwcgReKduhfGKXZj2mxAFpdzGnRVDfmn0YU3i9N/YZVo
         ELnTRvvRwlzXQ==
Message-ID: <6eb1bb96-8690-4ee7-9d03-c852b7395683@collabora.com>
Date:   Mon, 6 Nov 2023 13:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/12] media: platform: mtk-mdp3: add checks for dummy
 components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
 <20231030100626.12564-6-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231030100626.12564-6-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 30/10/23 11:06, Moudy Ho ha scritto:
> Some components act as bridges only and do not require full configuration.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

