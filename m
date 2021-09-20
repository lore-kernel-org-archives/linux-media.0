Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF01DC433F5
	for <linux-media@archiver.kernel.org>; Mon, 20 Sep 2021 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E2B60F6D
	for <linux-media@archiver.kernel.org>; Mon, 20 Sep 2021 10:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhITKCb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 Sep 2021 06:02:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:10821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232830AbhITKCa (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 Sep 2021 06:02:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="210179606"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="210179606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 03:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="473542972"
Received: from gbradyx-mobl2.ger.corp.intel.com (HELO [10.213.235.119]) ([10.213.235.119])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 03:01:01 -0700
Subject: Re: [Intel-gfx] [PATCH 16/26] drm/i915: use new iterator in
 i915_gem_object_wait_reservation v2
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     daniel@ffwll.ch
References: <20210917123513.1106-1-christian.koenig@amd.com>
 <20210917123513.1106-17-christian.koenig@amd.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <e0954bdd-2183-f662-8192-c44f931c602b@linux.intel.com>
Date:   Mon, 20 Sep 2021 11:00:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210917123513.1106-17-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 17/09/2021 13:35, Christian König wrote:
> Simplifying the code a bit.
> 
> v2: add missing rcu read unlock.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_wait.c | 57 ++++++------------------
>   1 file changed, 14 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> index f909aaa09d9c..e416cf528635 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -37,55 +37,26 @@ i915_gem_object_wait_reservation(struct dma_resv *resv,
>   				 unsigned int flags,
>   				 long timeout)
>   {
> -	struct dma_fence *excl;
> -	bool prune_fences = false;
> -
> -	if (flags & I915_WAIT_ALL) {
> -		struct dma_fence **shared;
> -		unsigned int count, i;
> -		int ret;
> -
> -		ret = dma_resv_get_fences(resv, &excl, &count, &shared);
> -		if (ret)
> -			return ret;
> -
> -		for (i = 0; i < count; i++) {
> -			timeout = i915_gem_object_wait_fence(shared[i],
> -							     flags, timeout);
> -			if (timeout < 0)
> -				break;
> -
> -			dma_fence_put(shared[i]);
> -		}
> -
> -		for (; i < count; i++)
> -			dma_fence_put(shared[i]);
> -		kfree(shared);
> -
> -		/*
> -		 * If both shared fences and an exclusive fence exist,
> -		 * then by construction the shared fences must be later
> -		 * than the exclusive fence. If we successfully wait for
> -		 * all the shared fences, we know that the exclusive fence
> -		 * must all be signaled. If all the shared fences are
> -		 * signaled, we can prune the array and recover the
> -		 * floating references on the fences/requests.
> -		 */
> -		prune_fences = count && timeout >= 0;
> -	} else {
> -		excl = dma_resv_get_excl_unlocked(resv);
> +	struct dma_resv_iter cursor;
> +	struct dma_fence *fence;
> +
> +	rcu_read_lock();
> +	dma_resv_iter_begin(&cursor, resv, flags & I915_WAIT_ALL);
> +	dma_resv_for_each_fence_unlocked(&cursor, fence) {
> +		rcu_read_unlock();
> +		timeout = i915_gem_object_wait_fence(fence, flags, timeout);

Converting this one could be problematic. It's the wait ioctl which used 
to grab an atomic snapshot and wait for that rendering to complete. With 
this change I think it has the potential to run forever keeps catching 
new activity against the same object.

I am not sure whether or not the difference is relevant for how 
userspace uses it but I think needs discussion.

Hm actually there are internal callers as well, and at least some of 
those have the object locked. Would a wider refactoring to separate 
those into buckets (locked vs unlocked) make sense?

Regards,

Tvrtko


> +		rcu_read_lock();
> +		if (timeout < 0)
> +			break;
>   	}
> -
> -	if (excl && timeout >= 0)
> -		timeout = i915_gem_object_wait_fence(excl, flags, timeout);
> -
> -	dma_fence_put(excl);
> +	dma_resv_iter_end(&cursor);
> +	rcu_read_unlock();
>   
>   	/*
>   	 * Opportunistically prune the fences iff we know they have *all* been
>   	 * signaled.
>   	 */
> -	if (prune_fences)
> +	if (timeout > 0)
>   		dma_resv_prune(resv);
>   
>   	return timeout;
> 
