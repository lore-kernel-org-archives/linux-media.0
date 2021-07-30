Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF3C4338F
	for <linux-media@archiver.kernel.org>; Fri, 30 Jul 2021 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C520960EE6
	for <linux-media@archiver.kernel.org>; Fri, 30 Jul 2021 10:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhG3KVC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Jul 2021 06:21:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48424 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbhG3KVC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Jul 2021 06:21:02 -0400
Received: from [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c] (unknown [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CD41C1F44836;
        Fri, 30 Jul 2021 11:20:56 +0100 (BST)
Subject: Re: media: platform/rockchip/rkisp1 - v4l-compliance reports errors
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Jens Korinth <jens.korinth@trinamix.de>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>
References: <AM0PR04MB5825DA3C650C569F69B99EF898EB9@AM0PR04MB5825.eurprd04.prod.outlook.com>
 <CAAEAJfDjGBBO4gL3gnn7qsmMHb+2MT2LNJ_Ctt7EqRoycj934A@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <3a1c6ef4-603c-5d23-c999-6cdef90ffd62@collabora.com>
Date:   Fri, 30 Jul 2021 12:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAEAJfDjGBBO4gL3gnn7qsmMHb+2MT2LNJ_Ctt7EqRoycj934A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,


On 30.07.21 00:38, Ezequiel Garcia wrote:
> (Adding Dafna and Helen)
> 
> On Thu, 29 Jul 2021 at 09:36, Jens Korinth <jens.korinth@trinamix.de> wrote:
>>
>> Hi *,
>>
>> I am working on a camera system on Rockchip RK3399 board (Firefly ROC-RK3399-PC-Plus). Tried to use the rkisp1 driver, but was unable to connect to the rkisp1_mainpath output node, because format negotiation failed; so I ran v4l-compliance next and found that it reports several errors (see attached report).

Hi, thanks for testing and reporting. We added some new features in order to supported the driver that also needed new code in v4l-utils in order
to use v4l2-ctl and to pass compliance. Therefore you should clone the repo and compile those tools in order to use them for the driver:

git://linuxtv.org/v4l-utils.git


>>
>> Upon closer inspection I noticed in the VIDIOC_ENUM_FMT handler in drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c:1169+ that

The file rkisp1-dev.c does only the probe/remove function. The callbacks are implemented in other files.

>>
>> 1) the "reserved" member is not zeroed,
>> 2) the userspace pointer to the v4l2_fmtdesc f is not checked via access_ok, and
>> 3) it isn't copied from/to userspace using copy_from_user/copy_to_user.

Those things seems to me like something that should be in the v4l2-core.

Thanks,
Dafna

>>
>> I'm not sure if this is necessary in general, but at least on my platform the zeroing of the reserved member only worked correctly when I added the userspace copies. But even after these fixes, v4l-compliance reports further issues in format enumeration and negotiation. Is this a known issue?
>>
>> Thanks!
>> -Jens
