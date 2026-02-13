Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6135B125;
	Fri, 13 Feb 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983111; cv=pass; b=fXOzeSERNyREvN2ANvZPaLxZkw8zMoq1o1j7IBUZ+X9ew1gNlOsuQThrxBgV1KSoj+4wnUK+nrWxhsiEn4oWtbV9peeUVPWEaok7YCFVzMRyjLYZkPsYX4Qdswowz+nBvuBn/TnTXsdaHKwgN30ugGMUm3w0izmm3e4MRgG7HVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983111; c=relaxed/simple;
	bh=DB5qjPSAAM6rauvzy6lMN/AEb43l1row1IeS1rkx/l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oii4nlLhK0IpZipitHJfK5GUvfkaZL7TvXqe7/QWIiyaeQ46BuxruXD8KND6p9mLzcG0FeXobcw/FfOBYgSrax1rvzigbWTRrxZ3OAU/HdRLdHjgsHso5myBOVP04SbebnLhr1beUDToULRJ/rxNic/jl10KOfWkWfSCl6w1MFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=BU8n4brf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BU8n4brf"
ARC-Seal: i=1; a=rsa-sha256; t=1770983083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hWiD/FcZAWVBKdf0sspVNjQ6D3cjhLhHZNgRw/wrK8zrMTJtE+1wTEYniJMrFv4pC0TXVn7rha6o4EJ/nqIc44QHU/Q/w3k1JErO9K3Y6Q9/QoaR14g+bu3IuFrLhTIRT2vTIm1aQQ0UiWz0gzNCKvGlOsDYXm5cqx39nZRx7UM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770983083; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZLbVdNEejozZqGDqI/aB8FgvL/GWNw3Zw5wV/RFoJ2c=; 
	b=gXogV8U/OSU6OYcpeC06aOEwLrNRoZWxu9KpD7a8ARjHfNhYf4pQAfPUOnehmJn3IKTaYDARFGFVGcnOk45QbCQNdcOFAqYOfGMbx5h7OPIplAo6j77o8AwlRvZ7mgRrRUKeGmAXVm1EOrOEaX2ELXG8vEf2MK6Ve+fSSHrpBdY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770983083;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZLbVdNEejozZqGDqI/aB8FgvL/GWNw3Zw5wV/RFoJ2c=;
	b=BU8n4brf23VzSgHCS4M2z/GeiyjrZilKmXCfpPwkrr2ntxHMBEQafLloeFBtvTVu
	adRBiPtFumIHuEAc8M1S8gkxru/w4XjKscBNu6vZHb0cJSnsi4pAe/vr+OXFLoczBeO
	isg0HmnkuPQhN3h1q/sS21epR+3q0+ctFEUbdQIg=
Received: by mx.zohomail.com with SMTPS id 1770983081453682.9318082269693;
	Fri, 13 Feb 2026 03:44:41 -0800 (PST)
Message-ID: <e0b52b0e-c889-4b38-8fb4-cef35289367c@collabora.com>
Date: Fri, 13 Feb 2026 14:44:35 +0300
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: synopsys: hdmirx: replace use of
 system_unbound_wq with system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20260212092846.61602-1-marco.crivellari@suse.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260212092846.61602-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/12/26 12:28, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
> Changes in v2:
> - improved commit log
> - rebased on v6.19
> 
>  drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> index c3007e09bc9f..9839a5143d54 100644
> --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> @@ -1735,7 +1735,7 @@ static void process_signal_change(struct snps_hdmirx_dev *hdmirx_dev)
>  			   FIFO_UNDERFLOW_INT_EN |
>  			   HDMIRX_AXI_ERROR_INT_EN, 0);
>  	hdmirx_reset_dma(hdmirx_dev);
> -	queue_delayed_work(system_unbound_wq,
> +	queue_delayed_work(system_dfl_wq,
>  			   &hdmirx_dev->delayed_work_res_change,
>  			   msecs_to_jiffies(50));
>  }
> @@ -2190,7 +2190,7 @@ static void hdmirx_delayed_work_res_change(struct work_struct *work)
>  
>  		if (hdmirx_wait_signal_lock(hdmirx_dev)) {
>  			hdmirx_plugout(hdmirx_dev);
> -			queue_delayed_work(system_unbound_wq,
> +			queue_delayed_work(system_dfl_wq,
>  					   &hdmirx_dev->delayed_work_hotplug,
>  					   msecs_to_jiffies(200));
>  		} else {
> @@ -2209,7 +2209,7 @@ static irqreturn_t hdmirx_5v_det_irq_handler(int irq, void *dev_id)
>  	val = gpiod_get_value(hdmirx_dev->detect_5v_gpio);
>  	v4l2_dbg(3, debug, &hdmirx_dev->v4l2_dev, "%s: 5v:%d\n", __func__, val);
>  
> -	queue_delayed_work(system_unbound_wq,
> +	queue_delayed_work(system_dfl_wq,
>  			   &hdmirx_dev->delayed_work_hotplug,
>  			   msecs_to_jiffies(10));
>  
> @@ -2441,7 +2441,7 @@ static void hdmirx_enable_irq(struct device *dev)
>  	enable_irq(hdmirx_dev->dma_irq);
>  	enable_irq(hdmirx_dev->det_irq);
>  
> -	queue_delayed_work(system_unbound_wq,
> +	queue_delayed_work(system_dfl_wq,
>  			   &hdmirx_dev->delayed_work_hotplug,
>  			   msecs_to_jiffies(110));
>  }

Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
