Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381C277C9E
	for <linux-media@vger.kernel.org>; Thu, 13 Nov 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027651; cv=none; b=Yf8cN1KFdYdLAP3fpgZyg0qQAmS9yZic0WH85XzKE0vz0K5Y/MGdyQv2XLdpWQr4Tn6+AEsAc/+ekgjM01yNdpJ/f9UFr9hautHWJzW93E+KD96k9C8XdabTeiHdIudRo1UQLpFEBjKk9fp/8bdBkZ+smWky6xpt7NnVRB24Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027651; c=relaxed/simple;
	bh=6kVQ0dg0hjvUZTKT522Eho34hvYeH0YFpmHshfGY7NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxqnCTQsNhXWmhhQdh4cs9EI5QLFLW1E4S0evhxkEmszGI2Q52/hXDuYW0KvzjeX9SiUD+nWskPkjvNKD8ebYos9DxtqcOGj/ysaT9iknPPDDlvzX35zsJDZTzKy+1d1UkVOkQUxHfvhhJ/huSTZNmQLCo+N4yNrA7qt/QHn+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECd94qi5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECd94qi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214ECC4CEF8;
	Thu, 13 Nov 2025 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763027650;
	bh=6kVQ0dg0hjvUZTKT522Eho34hvYeH0YFpmHshfGY7NM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECd94qi5evKsWeBR++Y/F7OJtuvb2NJ/esMN8NY3qkQwPs/X42DkmjXMd6pcDlRA/
	 YzHH0/41lrsLMbmIPbtXNPcV1Ak77euHP/zRDYtXSmZaP7pvtwahh0KMCKWjrAGJJH
	 WIDW++viNYMa5y+MEJt1kmwrWrssmXf2qF5B6MjHu8QDCzQH75QQ444CAAqguAuwHf
	 8+7ZsVCjOAT6WtdzLRlCwsbP2TfcE34ZFYOCkGj5p9+BHqk9dhiB/igm5bbNjsbTv5
	 A4b5j5rE+QFXN0s4xWnsGn7tydKoik6hxFy8M8odJBEiLBBNxlEkvuURxlx4Dv7toG
	 6MGbmE1I+jZ/g==
Message-ID: <499a9287-a488-4c50-a03f-d05f26d337a9@kernel.org>
Date: Thu, 13 Nov 2025 10:54:06 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] media: i2c: ov01a10: Register tweaks for ov01a1s
 model
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Bingbu Cao <bingbu.cao@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org
References: <20251014174033.20534-1-hansg@kernel.org>
 <20251014174033.20534-26-hansg@kernel.org>
 <7fd4qbgendumnwahn7bqu7zyczvr6l3htbxxurq56cb6th7gyv@jncmh7kihgd6>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <7fd4qbgendumnwahn7bqu7zyczvr6l3htbxxurq56cb6th7gyv@jncmh7kihgd6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Medhi,

On 7-Nov-25 10:17 AM, Mehdi Djait wrote:
> Hi Hans,
> 
> Thank you for the patches!
> 
> On Tue, Oct 14, 2025 at 07:40:33PM +0200, Hans de Goede wrote:
>> The out of tree drivers from:
>> https://github.com/intel/ipu6-drivers/tree/master/drivers/media/i2c
>>
>> Have a separate driver for the ov01a1s. This driver is 95% the same as
>> the ov01a10 driver (same sensor, different color-filters) but there are
>> a couple of registers for which the out of tree ov01a1s driver uses
>> different values.
>>
>> Add a per model reg_sequence to struct ov01a10_sensor_cfg and apply
>> the register tweaks from the out of tree driver to the ov01a1s model.
>>
>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>> ---
>>  drivers/media/i2c/ov01a10.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
>> index 058ff311a289..08cab1e4be1d 100644
>> --- a/drivers/media/i2c/ov01a10.c
>> +++ b/drivers/media/i2c/ov01a10.c
>> @@ -161,7 +161,6 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>>  	{0x3815, 0x01},
>>  	{0x3816, 0x01},
>>  	{0x3817, 0x01},
>> -	{0x3822, 0x13},
>>  	{0x3832, 0x28},
>>  	{0x3833, 0x10},
>>  	{0x3b00, 0x00},
>> @@ -186,7 +185,6 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>>  	{0x4800, 0x64},
>>  	{0x481f, 0x34},
>>  	{0x4825, 0x33},
>> -	{0x4837, 0x11},
>>  	{0x4881, 0x40},
>>  	{0x4883, 0x01},
>>  	{0x4890, 0x00},
>> @@ -203,6 +201,17 @@ static const struct reg_sequence ov01a10_global_setting[] = {
>>  	{0x0325, 0xc2},
>>  };
>>  
>> +static const struct reg_sequence ov01a10_regs[] = {
>> +	{0x3822, 0x13},
>> +	{0x4837, 0x11},
>> +};
>> +
>> +static const struct reg_sequence ov01a1s_regs[] = {
>> +	{0x3822, 0x03},
>> +	{0x4837, 0x14},
>> +	{0x373d, 0x24},
>> +};
> 
> How about the 0x4800 register ?
> we write 0x64 for the ov01a10 driver but the out-of-tree driver for
> ov01a1s does not write that value

Right. I left that one in for all models on purpose.

Looking at other similar OVxxxxx sensor datasheets the 0x4800
register is the MIPI_CTRL00 register which controls things
like disabling the CSI clock during blank periods to save power.

Since this is in no way related to the installed color filter
I went with the assumption that the tweaks (changes from power-
on-rest default) done for the ov01a10 were done on purpose and
that these would also benefit the other 2 variants.

I did test the ov01a1b and ov01a1s with this setting and they
worked fine.

So this does deviate from what the ov01a1s driver does but it
is on purpose (and for the ov01a1b we have no other driver
to reference).

Also note that the ov01a1s already works fine without this
commit, but as the commit msg says I assume these tweaks were
done for a reason so I'm adding them here.

Regards,

Hans



