Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E6AC433EF
	for <linux-media@archiver.kernel.org>; Wed, 22 Jun 2022 15:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358635AbiFVPZb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiFVPZa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jun 2022 11:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A039160;
        Wed, 22 Jun 2022 08:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16F961655;
        Wed, 22 Jun 2022 15:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958B2C34114;
        Wed, 22 Jun 2022 15:25:26 +0000 (UTC)
Message-ID: <f14cd01b-e0fa-005c-0a90-3aaaa3dd7c12@xs4all.nl>
Date:   Wed, 22 Jun 2022 17:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: sta2x11: remove VIRT_TO_BUS dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Federico Vaga <federico.vaga@gmail.com>,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc:     =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220616085254.2275372-1-arnd@kernel.org>
 <CAK8P3a3O1CEuahB+VeKfFe3iycTwG=1RH2hq2eMn6rGwGA0p=g@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAK8P3a3O1CEuahB+VeKfFe3iycTwG=1RH2hq2eMn6rGwGA0p=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 16/06/2022 11:32, Arnd Bergmann wrote:
> On Thu, Jun 16, 2022 at 10:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
>> index a96e170ab04e..118b922c08c3 100644
>> --- a/drivers/media/pci/sta2x11/Kconfig
>> +++ b/drivers/media/pci/sta2x11/Kconfig
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  config STA2X11_VIP
>>         tristate "STA2X11 VIP Video For Linux"
>> -       depends on PCI && VIDEO_DEV && VIRT_TO_BUS && I2C
>> +       depends on PCI && VIDEO_DEV && I2C
>>         depends on STA2X11 || COMPILE_TEST
> 
> As I resent this one out of series, I guess I should clarify: I would
> like to merge the patch to remove VIRT_TO_BUS through the
> asm-generic tree for 5.20, which would make STA2X11_VIP
> impossible to select, unless this patch gets applied as well.
> 
> I can take the patch through the asm-generic tree as well if anyone
> cares about bisectibility here.
> 
>          Arnd

I'll take this patch through the media subsystem for 5.20.

Regards,

	Hans
