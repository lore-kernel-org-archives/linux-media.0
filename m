Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1335AC7EE45
	for <linux-media@archiver.kernel.org>; Wed, 24 May 2023 09:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjEXJWi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 May 2023 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbjEXJWh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 May 2023 05:22:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F3FC;
        Wed, 24 May 2023 02:22:13 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1kh7-0007zs-M9; Wed, 24 May 2023 11:22:09 +0200
Message-ID: <53ce7dba-24ec-22b2-d3e6-80ad68a09f88@leemhuis.info>
Date:   Wed, 24 May 2023 11:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
Content-Language: en-US, de-DE
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, m.tretter@pengutronix.de,
        didi.debian@cknow.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        kernel@pengutronix.de, regressions@lists.linux.dev
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
 <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
 <de161e23-1ec6-1c16-b1c4-f423a088b711@leemhuis.info>
 <e227724a-fb39-5d68-4453-f03fb532bfde@xs4all.nl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e227724a-fb39-5d68-4453-f03fb532bfde@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684920133;02d9476f;
X-HE-SMSGID: 1q1kh7-0007zs-M9
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 24.05.23 11:15, Hans Verkuil wrote:
> On 24/05/2023 11:06, Thorsten Leemhuis wrote:
>> On 23.05.23 18:36, Benjamin Gaignard wrote:
>>>
>>> Le 23/05/2023 à 18:25, Benjamin Gaignard a écrit :
>>>> This fixes the following issue observed on Odroid-M1 board:
>>> [...]
>>> Diederick, Marek, Michael,
>>> I have tested this patch on my boards and I see no regressions on
>>> decoder part and no more crash when probing the encoder.
>>> Could you test it on your side to confirm it is ok ?
>>
>> They all did, so that is done. Thx for your help, everybody!
>>
>> /me now hopes this patch will be quickly reviewed, accepted and sent to
>> Linus to prevent even more people running into this...
> 
> I plan to make a PR with 6.4 fixes today or tomorrow.

Ahh, fabulous, many thx!

Ciao, Thorsten
