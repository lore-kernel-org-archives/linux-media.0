Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F64C433FE
	for <linux-media@archiver.kernel.org>; Tue, 14 Sep 2021 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EA46108B
	for <linux-media@archiver.kernel.org>; Tue, 14 Sep 2021 12:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhINMoS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:44:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:41718 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232664AbhINMoO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Sep 2021 08:44:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="220107107"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220107107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 05:42:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="544055574"
Received: from ocascan-mobl.ger.corp.intel.com (HELO [10.213.234.116]) ([10.213.234.116])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 05:42:52 -0700
Subject: Re: [Intel-gfx] [PATCH 17/26] drm/i915: use new iterator in
 i915_gem_object_wait_priority
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org
References: <20210913131707.45639-1-christian.koenig@amd.com>
 <20210913131707.45639-18-christian.koenig@amd.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <23f10a18-925f-cffe-a335-3d6c745d263a@linux.intel.com>
Date:   Tue, 14 Sep 2021 13:42:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913131707.45639-18-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 13/09/2021 14:16, Christian König wrote:
> Simplifying the code a bit.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_wait.c | 29 ++++--------------------
>   1 file changed, 5 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> index 13174541f6c8..e2173a55e527 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -120,31 +120,12 @@ i915_gem_object_wait_priority(struct drm_i915_gem_object *obj,
>   			      unsigned int flags,
>   			      const struct i915_sched_attr *attr)
>   {
> -	struct dma_fence *excl;
> -
> -	if (flags & I915_WAIT_ALL) {
> -		struct dma_fence **shared;
> -		unsigned int count, i;
> -		int ret;
> -
> -		ret = dma_resv_get_fences(obj->base.resv, &excl, &count,
> -					  &shared);
> -		if (ret)
> -			return ret;
> -
> -		for (i = 0; i < count; i++) {
> -			i915_gem_fence_wait_priority(shared[i], attr);
> -			dma_fence_put(shared[i]);
> -		}
> -
> -		kfree(shared);
> -	} else {
> -		excl = dma_resv_get_excl_unlocked(obj->base.resv);
> -	}
> +	struct dma_resv_cursor cursor;
> +	struct dma_fence *fence;
>   
> -	if (excl) {
> -		i915_gem_fence_wait_priority(excl, attr);
> -		dma_fence_put(excl);
> +	dma_resv_for_each_fence_unlocked(obj->base.resv, &cursor,
> +					 flags & I915_WAIT_ALL, fence) {
> +		i915_gem_fence_wait_priority(fence, attr);

Do you know if the RCU lock is actually held here? I tried following the 
KMS code paths but got lost in core helpers and driver vfuncs.

Regards,

Tvrtko

>   	}
>   	return 0;
>   }
> 
