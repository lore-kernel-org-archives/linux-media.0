Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13590C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA788218A5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfC2UrF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:47:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:32894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbfC2UrF (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 16:47:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 13:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="146435503"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.147]) ([10.7.153.147])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2019 13:47:04 -0700
Subject: Re: [PATCH] media: platform: Fix a kernel warning on clk control
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org
References: <20190328212537.29511-1-jae.hyun.yoo@linux.intel.com>
 <db524edd-0c6c-2bb7-848d-2261286b4b21@linux.ibm.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <d91b27ce-ad96-7260-df6d-37a2fe3e89ab@linux.intel.com>
Date:   Fri, 29 Mar 2019 13:47:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <db524edd-0c6c-2bb7-848d-2261286b4b21@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Eddie,

On 3/29/2019 1:08 PM, Eddie James wrote:
> On 3/28/19 4:25 PM, Jae Hyun Yoo wrote:
>> To prevent this issue, this commit adds spinlock protection and clock
>> status checking logic into the Aspeed video engine driver.
> 
> Thanks Jae. Do you have a reliable way to reproduce this? Haven't seen 
> it myself.

It could be observed when user space releases a video engine dev entry
handle while video mode is changing. You could reproduce it by repeating
reload of KVM web page just after trigger a host reset. It rarely
happens.

>> +    bool is_video_on;
> 
> This can probably be a flag, like VIDEO_CLOCKS_ON, not a new boolean.

Okay, I'll add the bit field into video->flags.

>> +        aspeed_video_reset(video);
> I'm working on a patch to remove the use of the reset line too.

Right, since clk-aspeed module can trigger a reset while enabling the
vclk or eclk, it could be removed later, but this patch is not for that.
>> +    spin_lock(&video->lock);
> 
> Is there a reason you're locking extra code? Why not put the lock in the 
> aspeed_video_on/off functions?

aspeed_video_on() and aspeed_video_off() can be called from driver
context and from interrupt context so some video enable/disable
relating code also need to be serialized.

Will submit v2 soon after replacing the boolean variable with 
VIDEO_CLOCKS_ON flag.

Thanks,
Jae
