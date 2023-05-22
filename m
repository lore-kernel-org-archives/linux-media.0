Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5071CC7EE26
	for <linux-media@archiver.kernel.org>; Mon, 22 May 2023 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjEVJ3E (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 May 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVJ3D (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 May 2023 05:29:03 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DA95;
        Mon, 22 May 2023 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1684747740; bh=KkXKslg/Zzd8BjgEV84faQOq6rSzW9m7ilvwkM/8wAQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ff57pBylcjRybXsT25eqJQR1UkB793MTrDEW/8ll1l64wanfRd059GTGtrsoPNCP5
         iUuhApO8ybo8bxiBeIBPQ9wwRkxnjJvz7E4MEha7K8gyU07YpBCfD8wIzbblmgWI5+
         /zvTIsbcdlupFPLuw14EL1Nmn4XLhRLB7wsggp24=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 723C0600A6;
        Mon, 22 May 2023 17:28:59 +0800 (CST)
Message-ID: <ed795dc0-823a-f3d8-9e70-1cf33c0de7f0@xen0n.name>
Date:   Mon, 22 May 2023 17:28:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
References: <20230520105718.325819-1-15330273260@189.cn>
 <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
 <e7f911cc-6588-bc0f-8e1e-759260f5187a@189.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <e7f911cc-6588-bc0f-8e1e-759260f5187a@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2023/5/22 17:25, Sui Jingfeng wrote:
> Hi,
> 
> On 2023/5/21 20:21, WANG Xuerui wrote:
>>> + * LS3A4000/LS3A5000/LS3A6000 CPU, they are equipped with on-board 
>>> video RAM
>>> + * typically. While LS2K0500/LS2K1000/LS2K2000 are low cost SoCs 
>>> which share
>>> + * the system RAM as video RAM, they don't has a dediacated VRAM.
>>
>> CPU models are not typically prefixed with "LS", so "Loongson 
>> 3A4000/3A5000/3A6000".
>>
> Here is because when you do programming, variable name should prefix 
> with letters.

Commit messages, comments, and log messages etc. are natural language, 
so it's better to treat them differently. No problem to keep code as-is IMO.

>> Also the description about the Loongson 2K series is a bit irrelevant 
>> (we're focusing on VRAM here) so you could simplify the sentence a bit. 
> 
> We could reserve part of system RAM as VRAM for Loongson 2K series SoC.
> 
> Either reserved with 'of reserve memory' or  reserved by the firmware.
> 

What's an "of reserve memory"? Is it "DeviceTree-reserved"?

> The reserve ram will not accessible by kernel itself it this case, and 
> can still be managed by ttm.

Of course. Feel free to tweak.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

