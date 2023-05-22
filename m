Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C04C7EE26
	for <linux-media@archiver.kernel.org>; Mon, 22 May 2023 09:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjEVJZl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 May 2023 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVJZa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 May 2023 05:25:30 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B282FA8;
        Mon, 22 May 2023 02:25:28 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:54090.881126371
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id AE497100219;
        Mon, 22 May 2023 17:25:25 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 0e1dd0b287294d5aa57c52fa68135f30 for kernel@xen0n.name;
        Mon, 22 May 2023 17:25:27 CST
X-Transaction-ID: 0e1dd0b287294d5aa57c52fa68135f30
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <e7f911cc-6588-bc0f-8e1e-759260f5187a@189.cn>
Date:   Mon, 22 May 2023 17:25:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
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
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 2023/5/21 20:21, WANG Xuerui wrote:
>> + * LS3A4000/LS3A5000/LS3A6000 CPU, they are equipped with on-board 
>> video RAM
>> + * typically. While LS2K0500/LS2K1000/LS2K2000 are low cost SoCs 
>> which share
>> + * the system RAM as video RAM, they don't has a dediacated VRAM.
>
> CPU models are not typically prefixed with "LS", so "Loongson 
> 3A4000/3A5000/3A6000".
>
Here is because when you do programming, variable name should prefix 
with letters.

> Also the description about the Loongson 2K series is a bit irrelevant 
> (we're focusing on VRAM here) so you could simplify the sentence a bit. 

We could reserve part of system RAM as VRAM for Loongson 2K series SoC.

Either reserved with 'of reserve memory' or  reserved by the firmware.

The reserve ram will not accessible by kernel itself it this case, and 
can still be managed by ttm.

