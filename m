Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FF30E0DF
	for <linux-media@vger.kernel.org>; Mon, 26 Jan 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422579; cv=none; b=XHeZwk6o9r4gQqD42j5zX1o9h0TpL8OIWcJW5sDZp5EDg+V8AgSjUAtn2bLe9K8yBJRus5LtMy+x05KNuML7PU3N8Ktks3P4n4jgc0p/Rz6qyJhR69sHgdovkoqu5IcCHvy/SPNrjd+SDg73G+5+miY6v/8BNFYxCtiEGJNJ+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422579; c=relaxed/simple;
	bh=xXXCLO57slMmFIDBYcmnTbw1lsmtgVkPj7qgdWoqSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HX5dycT/mIfaMAOschYOWRYISVXTyLb8LxcUA5kPtOXfSqargFLxwRkG1zEis3ZIa+u8aCJph95uzOB7WAZ+hhs89lkV4inYWB9QTaDloP7G/oVp7yW9C2+vL2/GpMt/v7eGtBKWRpykyLW9SlX0cd6Gb36WoY0pf1lWLjjorfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoU/pTIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoU/pTIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D51C116C6;
	Mon, 26 Jan 2026 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769422579;
	bh=xXXCLO57slMmFIDBYcmnTbw1lsmtgVkPj7qgdWoqSLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DoU/pTIqqoZR3fNOcLmPbHW0MmW0LQA/0rDiFGhCFMzFCPJP4fm2pvv5e3FORx2/2
	 kuIiM7/pKB9aBhYf3ASAChPObV0SjVl3L157g7LcpKEzUy48KvPnVEPvGDwUqlkKOG
	 RKpFm+wif8Doq5MIwxV01E/NR/0DM5PFmwugFVN4S0uY+bf3ABNDj4xqRTFhHwKDWL
	 TkDWzPaMInaB0/GQYhR9USDChD9zyzcDr0JuDq/CY8uk24sQOlPHKtM461wlwrsEZz
	 MUqsxl7p0sUdfmmBV9uyuxn7opdAswMU6OZ8LdUCMG2hxIQfl3KhUuYnGEF868kdJb
	 JSFGvAFywkPCA==
Message-ID: <dd65a573-182e-4517-a264-e2be4b508ac2@kernel.org>
Date: Mon, 26 Jan 2026 11:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: ov02c10: Fix race condition in remove and
 relax reset timings
To: Saikiran <bjsaikiran@gmail.com>, linux-media@vger.kernel.org
Cc: bod@kernel.org, sakari.ailus@linux.intel.com, mchehab@kernel.org
References: <20260124074402.7165-1-bjsaikiran@gmail.com>
 <20260124074402.7165-3-bjsaikiran@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260124074402.7165-3-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 24-Jan-26 08:43, Saikiran wrote:
> The ov02c10_remove() function has a race condition where v4l2_ctrl_handler
> and media_entity resources are freed before the device is powered off.
> If userspace (e.g., PipeWire/WirePlumber) accesses the device during
> removal, this causes a Use-After-Free leading to kernel oops with
> "Execute from non-executable memory" errors.
> 
> Fix by reordering cleanup: disable runtime PM and power off the device
> BEFORE freeing v4l2_ctrl_handler and media_entity resources.
> 
> Additionally, relax reset timings to prevent CCI I2C timeout errors.
> The sensor microcontroller occasionally fails to boot within the
> original timing windows, causing "master 1 queue 0 timeout" errors:
> - Assert reset delay: 2ms → 5ms
> - Post-reset boot delay: 5ms → 20ms
> 
> These two fixes address different but related stability issues that
> manifest during camera initialization and removal.
> 
> Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>

Please split this into 2 separate patches, 1 for the reset
timing change and one for moving the cleanup to after
the poweroff.

Regards,

Hans



> ---
>  drivers/media/i2c/ov02c10.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> index cf93d36032e1..b86cae3d2b74 100644
> --- a/drivers/media/i2c/ov02c10.c
> +++ b/drivers/media/i2c/ov02c10.c
> @@ -692,9 +692,9 @@ static int ov02c10_power_on(struct device *dev)
>  
>  	if (ov02c10->reset) {
>  		/* Assert reset for at least 2ms on back to back off-on */
> -		usleep_range(2000, 2200);
> +		usleep_range(5000, 5500);
>  		gpiod_set_value_cansleep(ov02c10->reset, 0);
> -		usleep_range(5000, 5100);
> +		usleep_range(20000, 21000);
>  	}
>  
>  	return 0;
> @@ -864,14 +864,14 @@ static void ov02c10_remove(struct i2c_client *client)
>  	struct ov02c10 *ov02c10 = to_ov02c10(sd);
>  
>  	v4l2_async_unregister_subdev(sd);
> -	v4l2_subdev_cleanup(sd);
> -	media_entity_cleanup(&sd->entity);
> -	v4l2_ctrl_handler_free(sd->ctrl_handler);
>  	pm_runtime_disable(ov02c10->dev);
>  	if (!pm_runtime_status_suspended(ov02c10->dev)) {
>  		ov02c10_power_off(ov02c10->dev);
>  		pm_runtime_set_suspended(ov02c10->dev);
>  	}
> +	v4l2_subdev_cleanup(sd);
> +	media_entity_cleanup(&sd->entity);
> +	v4l2_ctrl_handler_free(sd->ctrl_handler);
>  }
>  
>  static int ov02c10_probe(struct i2c_client *client)

