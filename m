Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1851C433FE
	for <linux-media@archiver.kernel.org>; Wed, 13 Apr 2022 08:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiDMIae (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiDMIae (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 13 Apr 2022 04:30:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363F344F9;
        Wed, 13 Apr 2022 01:28:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6696A1F44F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649838493;
        bh=4Vsn1aejkGeE8Y8/vxFrCuw1ZIGPg0ZCck+uLh9HLCE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ETExv/OWpWWJ0YGn0PuMmlTHavSLhE5Q/BNJFC6Zh3E0TssffX6/DK0TAPz3ugrpc
         m6bsEAfN4KeCFByoQoH2peSDhnhVEMolAA0cgSqGbLd1P2gMzFO7+Cvl04zjBJAi6n
         NsHNy1mMvcMm1qXFCDHgwn+wrq1VZ2pFhzu+UFNMkKq32HQoISHJ238HIozt2PCbkX
         HZJXWjaMNsfTmRPuXlIhq+GkcKa86kxGdjrpfCRzKfWAolOc7J6kRXt93ZBw/8DUcV
         Zvmtz6o3ZE6tkZH2WBHRFXFxnSCdTkjshm2DO+LN2FvWgc/hVLYtdjwX2fUkCWbSGN
         OJDLQTradvQHA==
Message-ID: <08985897-d732-366d-fddb-5c622b732726@collabora.com>
Date:   Wed, 13 Apr 2022 10:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v14 2/6] soc: mediatek: mutex: add 8183 MUTEX MOD settings
 for MDP
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220411072403.24016-1-moudy.ho@mediatek.com>
 <20220411072403.24016-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220411072403.24016-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Il 11/04/22 09:23, Moudy Ho ha scritto:
> For the purpose of module independence, related settings should be moved
> from MDP to the corresponding driver.
> This patch adds 8183 MUTEX MOD settings for MDP.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

