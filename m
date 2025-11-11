Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E22F291D
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873237; cv=none; b=JgBpMabGpjHDUpDaIz10X3B3/v+AzrSIlBg9HC/T2yyN1xoAt88fybSarkIC564c20Fip9j9b2738PhqJoMoKgTSXuWhBYfZTnAR0uyqJgM+B4Jwbx4QbJboCFxSd8pinUIw3xn/vzwUk0QsAx761e8ygMwgcLC8wr8RL8hyFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873237; c=relaxed/simple;
	bh=4tvEkmpo98UdQsxL4ekIarhxa3oc0Q/FfAC/l6oqKAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsEaC3nZnvOj6m6F1IcOotE8hDudJ49JsxDc5KrO3fB8wC9GRFCsJP8BjXxwwkIc2IGGUZNul7YzaQWin1p50eF/5NcFcb67/qEOIpUevjwI1W+gY8kf0OtY8ZMFYfDAKp/LzcghZD1g0C87KISvOx0zUs3rI361uJaGhEpA8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=VjE7LSED; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="VjE7LSED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1762873232; bh=4tvEkmpo98UdQsxL4ekIarhxa3oc0Q/FfAC/l6oqKAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjE7LSED29NXWtVTfLt/CGUsYGmjbva4lxyDjBesnxaoWnzNGrMlyim1wCTZRcnuf
	 c+hBWPQcxBpSTZmwROnC+0bU3irKRJlQPWC5n3/teShDnV/4AuTiS3eaoT+8OKF5q4
	 EW/qN/Lg0TKWVOrEMWaXZcy7olm8ryBarFkoyvmuU7xG40nkpmY+wEdavHs5W1emVv
	 PX7aM3Ql2KVrqWABe8RdkIy1KExx2F5Z0ZFBYn4fLMV1ZItXydAlWVtILudceOEIXf
	 dRkgJsxenA+p46uDEbfxkopDiP/QpthHP6t2OzNyR1LCc8ROqQ4ouB/BJdOzvu0hTA
	 v9ZGcgyMc+1EA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id C8BAA1000D4; Tue, 11 Nov 2025 15:00:32 +0000 (GMT)
Date: Tue, 11 Nov 2025 15:00:32 +0000
From: Sean Young <sean@mess.org>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: linux-media@vger.kernel.org
Subject: Re: [PATCH] media: prevent memory leak in cx25840_ir_probe
Message-ID: <aRNPkBX-EKAz79Q-@gofer.mess.org>
References: <20250904082222.928-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904082222.928-1-chenyufeng@iie.ac.cn>

Hi Chen,

On Thu, Sep 04, 2025 at 04:22:22PM +0800, Chen Yufeng wrote:
> In cx25840_ir_probe if kfifo_alloc fails the allocated memory for ir_state
> should be released.
> 
> A patch similar to commit a7b2df76b42b ("media: rc: prevent memory leak in 
> cx23888_ir_probe").
> 
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>  drivers/media/i2c/cx25840/cx25840-ir.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/cx25840/cx25840-ir.c b/drivers/media/i2c/cx25840/cx25840-ir.c
> index 8cef9656c612..ee80867755e5 100644
> --- a/drivers/media/i2c/cx25840/cx25840-ir.c
> +++ b/drivers/media/i2c/cx25840/cx25840-ir.c
> @@ -1199,8 +1199,10 @@ int cx25840_ir_probe(struct v4l2_subdev *sd)
>  
>  	spin_lock_init(&ir_state->rx_kfifo_lock);
>  	if (kfifo_alloc(&ir_state->rx_kfifo,
> -			CX25840_IR_RX_KFIFO_SIZE, GFP_KERNEL))
> +			CX25840_IR_RX_KFIFO_SIZE, GFP_KERNEL)) {
> +		devm_kfree(&state->c->dev, ir_state);
>  		return -ENOMEM;
> +	}

Since the memory is allocated with devm, why do we need an explicit devm_kfree()?

The memory will be freed anyway, or am I missing something?

Thanks,

Sean

>  
>  	ir_state->c = state->c;
>  	state->ir_state = ir_state;
> -- 
> 2.34.1
> 
