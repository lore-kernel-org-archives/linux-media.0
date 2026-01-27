Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6C345740;
	Tue, 27 Jan 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511015; cv=none; b=LtINmD6qhlNxZ5pmP6OioQszNUxD6LGWT3S7WixZuqzxsPN2ENh2KnuP9pJZW84teENovx8LgwJeYmpr+Ek5l31pkSBr3iCXFYl341b8UWKV7muyjeXUC3bsRlWe/v7LHyDFAzfluS05e4DuaiiSezEu/o4Cpx8708hF20Q0bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511015; c=relaxed/simple;
	bh=oCRxYaJ3dVs6zyq2Qx+o3ba3M/+PTiMwsgzMhchJ9mY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lim+Bav5sexHSe2+IuUy+jqlViD3h3G9JJ+zgw0Oovf3iIzl+S7JqLsh1x1O7cW/dQBTXRjiMmeRXfmVP91kyj2D0fxN3mBhmE23fy4W+0SfojLp+OJEHgGZQaHdFCl7tGaOUl3JG6A/jrOPpgulWZH/XgugPI9x193r9U9nR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDsXngw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDsXngw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A45EC116C6;
	Tue, 27 Jan 2026 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769511014;
	bh=oCRxYaJ3dVs6zyq2Qx+o3ba3M/+PTiMwsgzMhchJ9mY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=FDsXngw7jeCg5MGaVnnYzMxqSyOZKIcf9+FXM9+wwnx6IAd6WuSIBamk3/ypJPDSH
	 jH5jwbaGusk57yNf9Zb8W16Ph7xyrVB2pyZtWQAH+biFIG4BlIHNSVBci68a7L83EL
	 DiL693ZGLC+XNxpuiq2A8vUdwS9X2n/hsOMJen33saCHe/QI3LeLE3EdjFwvoxfE33
	 6R/iAMUrucUE4c2j4kIzaVuxAX2wT4rfMC5aAFyDLb4vzYRi7Y48pgP4BJHscg445M
	 GENNuf+LPp2/1dHkwtZU8Co8sxrT40Vu+Jsr62mFyc6lXbsaGfsVm3CXPhBoL9xolS
	 /um7/jkw/HT8w==
Message-ID: <b544605d-3952-4c99-aa33-1d7d8bb02a75@kernel.org>
Date: Tue, 27 Jan 2026 11:50:10 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] media: i2c: ov02c10: Correct power-on sequence and
 timing
From: Hans de Goede <hansg@kernel.org>
To: Saikiran <bjsaikiran@gmail.com>, linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, rfoss@kernel.org, todor.too@gmail.com,
 bryan.odonoghue@linaro.org, bod@kernel.org, vladimir.zapolskiy@linaro.org,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, stable@vger.kernel.org
References: <20260126173444.10228-1-bjsaikiran@gmail.com>
 <20260126173444.10228-3-bjsaikiran@gmail.com>
 <a1108367-30dd-49fb-8a36-bab9a242bd51@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <a1108367-30dd-49fb-8a36-bab9a242bd51@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 27-Jan-26 11:40, Hans de Goede wrote:

...

>> @@ -676,27 +685,53 @@ static int ov02c10_power_on(struct device *dev)
>>  	struct ov02c10 *ov02c10 = to_ov02c10(sd);
>>  	int ret;
>>  
>> -	ret = clk_prepare_enable(ov02c10->img_clk);
>> -	if (ret < 0) {
>> -		dev_err(dev, "failed to enable imaging clock: %d", ret);
>> -		return ret;
>> +	if (ov02c10->reset) {
>> +		gpiod_set_value_cansleep(ov02c10->reset, 1);
>> +		usleep_range(10000, 11000);
>>  	}
> 
> Ack for asserting the reset for 10 ms here, that is the only part
> of this patch which seems to actually be useful.

Quick note on this, your commit msg says the datasheet requires 5 ms,
so 10 seems a bit much for the next version please
use a usleep_range() with 5 - 7 ms. Or just use fsleep(5000) which
turns this into a usleep_range() for you.

Regards,

Hans


