Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="GpjuXaEF"
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 08:49:44 PST
Received: from ts201-smtpout75.ddc.teliasonera.net (ts201-smtpout75.ddc.teliasonera.net [81.236.60.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B4069B
	for <linux-media@vger.kernel.org>; Mon, 27 Nov 2023 08:49:44 -0800 (PST)
X-RG-Rigid: 6516966F025C2C69
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffktefuhgdpggftfghnshhusghstghrihgsvgdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhhohhmrghsucfjvghllhhsthhrnphmucdlkfhnthgvlhdmuceothhhohhmrghspghoshesshhhihhpmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelteegvedvjefgieejtdetffegteefteeuteeukeefvdfgtdeukefhkeefhedtjeenucfkphepkedurddvvdelrdejvddruddvjedpudefgedrudeluddrvdefvddrkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepmhgrihhluddrshhhihhpmhgrihhlrdhorhhgpdhinhgvthepkedurddvvdelrdejvddruddvjedpmhgrihhlfhhrohhmpehthhhomhgrshgpohhssehshhhiphhmrghilhdrohhrghdpnhgspghrtghpthhtohephedprhgtphhtthhopeetlhgvgigrnhguvghrrdffvghutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheptghkohgvnhhighdrlhgvihgthhhtiihumhgvrhhkvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphht
	thhopehlihhnrghrohdqmhhmqdhsihhgsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from mail1.shipmail.org (81.229.72.127) by ts201-smtpout75.ddc.teliasonera.net (5.8.716)
        id 6516966F025C2C69; Mon, 27 Nov 2023 17:48:03 +0100
Received: from [192.168.0.209] (unknown [134.191.232.83])
	by mail1.shipmail.org (Postfix) with ESMTPSA id 30C7D3606B4;
	Mon, 27 Nov 2023 17:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
	t=1701103682; bh=N6spvplnQJmWTN5fRtgemnRL8z3vIYOHsD5+Cv5u6D0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GpjuXaEFuFfB6+KC218RvbWuVKolEo6TaHQV6IM3mNy0t278N8YUMgV2eEcL3mRwi
	 hut37fZdIq3+pVMZy1nDOsIDd3HP8JQfFEbAClG3kNbL6UWzbCPEjRHW9ihw1ELtWV
	 uVV0MBK0kRGtyZE31dr16L8NCeIdukeQewgqEq8k=
Message-ID: <8e434475-94f5-8e93-e0bd-3693e4587824@shipmail.org>
Date: Mon, 27 Nov 2023 17:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH] dma-buf: fix check in
 dma_resv_add_fence
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alex Deucher <Alexander.Deucher@amd.com>
References: <20231115093035.1889-1-christian.koenig@amd.com>
 <e35e67dd-fd96-4ac5-a6ba-f351f12a146c@gmail.com>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
In-Reply-To: <e35e67dd-fd96-4ac5-a6ba-f351f12a146c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/27/23 14:24, Christian König wrote:
> Ping? Can I get an rb or acked-by for that?
>
> Thanks,
> Christian.
>
> Am 15.11.23 um 10:30 schrieb Christian König:
>> It's valid to add the same fence multiple times to a dma-resv object and
>> we shouldn't need one extra slot for each.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: a3f7c10a269d5 ("dma-buf/dma-resv: check if the new fence is 
>> really later")
>> Cc: stable@vger.kernel.org # v5.19+


Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>


>> ---
>>   drivers/dma-buf/dma-resv.c |  2 +-
>>   include/linux/dma-fence.h  | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
>> index 38b4110378de..eb8b733065b2 100644
>> --- a/drivers/dma-buf/dma-resv.c
>> +++ b/drivers/dma-buf/dma-resv.c
>> @@ -301,7 +301,7 @@ void dma_resv_add_fence(struct dma_resv *obj, 
>> struct dma_fence *fence,
>>             dma_resv_list_entry(fobj, i, obj, &old, &old_usage);
>>           if ((old->context == fence->context && old_usage >= usage &&
>> -             dma_fence_is_later(fence, old)) ||
>> +             dma_fence_is_later_or_same(fence, old)) ||
>>               dma_fence_is_signaled(old)) {
>>               dma_resv_list_set(fobj, i, fence, usage);
>>               dma_fence_put(old);
>> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>> index ebe78bd3d121..b3772edca2e6 100644
>> --- a/include/linux/dma-fence.h
>> +++ b/include/linux/dma-fence.h
>> @@ -498,6 +498,21 @@ static inline bool dma_fence_is_later(struct 
>> dma_fence *f1,
>>       return __dma_fence_is_later(f1->seqno, f2->seqno, f1->ops);
>>   }
>>   +/**
>> + * dma_fence_is_later_or_same - return true if f1 is later or same 
>> as f2
>> + * @f1: the first fence from the same context
>> + * @f2: the second fence from the same context
>> + *
>> + * Returns true if f1 is chronologically later than f2 or the same 
>> fence. Both
>> + * fences must be from the same context, since a seqno is not 
>> re-used across
>> + * contexts.
>> + */
>> +static inline bool dma_fence_is_later_or_same(struct dma_fence *f1,
>> +                          struct dma_fence *f2)
>> +{
>> +    return f1 == f2 || dma_fence_is_later(f1, f2);
>> +}
>> +
>>   /**
>>    * dma_fence_later - return the chronologically later fence
>>    * @f1:    the first fence from the same context
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
