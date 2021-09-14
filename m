Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9FAC433F5
	for <linux-media@archiver.kernel.org>; Tue, 14 Sep 2021 12:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4640610D1
	for <linux-media@archiver.kernel.org>; Tue, 14 Sep 2021 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhINM31 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:29:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:60387 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhINM3U (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Sep 2021 08:29:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="202149936"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="202149936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 05:28:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="432975337"
Received: from ocascan-mobl.ger.corp.intel.com (HELO [10.213.234.116]) ([10.213.234.116])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 05:28:01 -0700
Subject: Re: [Intel-gfx] [PATCH 18/26] drm/i915: use new iterator in
 i915_gem_object_last_write_engine
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     daniel@ffwll.ch, intel-gfx@lists.freedesktop.org
References: <20210913131707.45639-1-christian.koenig@amd.com>
 <20210913131707.45639-19-christian.koenig@amd.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <46a40614-b448-7f2d-7b6b-0705c4277e2b@linux.intel.com>
Date:   Tue, 14 Sep 2021 13:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913131707.45639-19-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 13/09/2021 14:16, Christian König wrote:
> This is maybe even a fix since the RCU usage here looks incorrect.

What you think is incorrect? Pointless extra rcu locking?

Also, FWIW, I submitted a patch to remove this function altogether since 
its IMO pretty useless, just failed in getting anyone to ack it so far.

Regards,

Tvrtko

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_object.h | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> index e9eecebf5c9d..3343922af4d6 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> @@ -500,16 +500,15 @@ static inline struct intel_engine_cs *
>   i915_gem_object_last_write_engine(struct drm_i915_gem_object *obj)
>   {
>   	struct intel_engine_cs *engine = NULL;
> +	struct dma_resv_cursor cursor;
>   	struct dma_fence *fence;
>   
> -	rcu_read_lock();
> -	fence = dma_resv_get_excl_unlocked(obj->base.resv);
> -	rcu_read_unlock();
> -
> -	if (fence && dma_fence_is_i915(fence) && !dma_fence_is_signaled(fence))
> -		engine = to_request(fence)->engine;
> -	dma_fence_put(fence);
> -
> +	dma_resv_for_each_fence_unlocked(obj->base.resv, &cursor, false,
> +					 fence) {
> +		if (fence && dma_fence_is_i915(fence) &&
> +		    !dma_fence_is_signaled(fence))
> +			engine = to_request(fence)->engine;
> +	}
>   	return engine;
>   }
>   
> 
