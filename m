Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1F280A56
	for <linux-media@vger.kernel.org>; Wed, 12 Nov 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931210; cv=none; b=SwbhLfkP1xJXI8yMW34Y3V3ikiS4h2whZLUg3gS/A6JJgPhvLyJDcy4dMbzwmkgaAerAgdcE2wk3mgs8CmD5B4r00BFxNT1rootSGtA2cKxwDcdmALyxCtdN0Z1XmianAZAMFDks5f3wBjHnztvSjGRjsdteBRypjJdyxV57eQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931210; c=relaxed/simple;
	bh=nfwT5ifcpQPfQUpQyGVMtQn/QobvzUQtrdSfcZQ+zmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuEfaNCcgpQzAGssv4TAZ/sDxD8GkHg5Oc+0uCMr4xrbnqRmLW6tPyaviIskqLfwSwX8TK9Y+gK3dan46E25AU+cg8yX1qzH1gHrHHI/5WdTcnkeU43Gkz2RhVoh8JR4dm0NZWatF43lYRfIE/UiWczgl6CaSLTA+Mzn3Omk6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=bmZJ1wSf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="bmZJ1wSf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so563990b3a.1
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 23:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762931206; x=1763536006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SA/EjzE6ub0OETBeJbcZLd/3jKeOzVwpRvVbzygsTD8=;
        b=bmZJ1wSfuyxO2M8p89ZoKPh/2AhobRZxoIEJlw+dvb1S8+fZgMHIFGBpx9xpOyXVrC
         vo76g3sdOdGMZAtmlUsmqIRCM3zNH7SVE8an4Xz9piaLUeTZbcxxljx9VxzDbpYSoTp/
         P7OjoEZg4GN5zghlsGnkIlH1IntD6xWQRARqHRf+MoWvYnQUrdVQndWHxeAOWgFWjL3E
         71+dYUNiWMJ2DJeKLxDNm2OAOScz2P1H0xDLJTHZ9wEYQS4rLuqW70W+d2577KrdHtJg
         xtXYNCuHh86fP4bY8FsLyQWgl4vg4iBfCGTjjWo+oGCpa0/+EH6wupcFoLxy0+7V0zZ5
         1Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931206; x=1763536006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA/EjzE6ub0OETBeJbcZLd/3jKeOzVwpRvVbzygsTD8=;
        b=pZV1OxE6mmJ61zdc18hInGuF8uyECZKyjZA0WYx3TNyCXA/9QLDQx+ePkKHVjAOIcJ
         XLoJpGQntZE4ekJU7LPlq5AgkRl8XH5is/1N1WhNQqmYrj/Oe9/3IG3no0PdwZjZpHuY
         d1kyI2kAHC7PlXZjSpcFw7uAPO1RP/8glnSJOrgjP5MEjB5jaG9Vy0W6tbsgDNtppXBb
         E5Nkm+BH+vuD7/5IVLwlRrU0cW8Aj5jxg6+Qo0Z1UUlYHemizrN8n2WH17IcLYGwPNwu
         vMTaKziQiihvkFuIzcd0oTUpkurTxX7J9GLeviewanpmmJlRiJ+RmQMQY0+vQSQZlBka
         F/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU5eDHMSa0gTyn9upfTTfrbzDHRsXPA3C3x2jfcRcSovDH9tFaW6HACwtidjHvXZqZGcZ3/vWoIuIkKPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzegLVh+e7cud1nzJChccg7btCYT0Si/+/aRXO7P1T3QUuk+lls
	QaPr/zn0wsGJxG9Q4L3kZCQ9pO6TXUkaYha3Cyrb8QZptBZg8jnH0l4umIv59Z5zv7nQdvGlDUk
	nKpbsdw==
X-Gm-Gg: ASbGncsGTRLFO4lGwACUxYdBdDkhxNVRje9+zs/QtjOFN+OYyjnlLEbeEFl+Efk7G+V
	zneTe34Wr/fbJHcLPJ0hhKnxxegHvBHLlMVDXtZyo4D64rT0qcVeaIny1cQpNtE1QH/c0Aecxj1
	pk3LQnD6AB34A1nS5rb+J9gBtcKh/mO2Kte1meFCjGyiDEZzajoXL6CquskoNYWKaeTRBuPA4OF
	+T3W8wuSH1IVd+QK5NTQkl0OVQok8u6xj/AOcKj8H+a942oJOk/ppzazG9Zcl8nfNFGMMIUhc9W
	jHZ2+l7PSEeQfbwgH5YjrvhVENk0I5a4l76LxjLvrwdntInhSfXpePHyRhrCzS/5LEUxnWu1+Vo
	kuQaz+NoUZKEGG4zFrH7aDJ7/CbnjPEq7SWd7megzsQzORBE6Y15e3fL7d9omv0Y6xW5AIT0Axi
	3DApo=
X-Google-Smtp-Source: AGHT+IG85fDfHoBkKwif9p2iwE+ea7FXiRF4Wh2uQQl3DX4bE1vGW0Pm/mATyehtPrLkhpXur1Y8Ew==
X-Received: by 2002:a05:6a00:3c8c:b0:7aa:f791:4ece with SMTP id d2e1a72fcca58-7b7a337a584mr2319943b3a.11.1762931206357;
        Tue, 11 Nov 2025 23:06:46 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b811183c77sm840822b3a.20.2025.11.11.23.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:06:45 -0800 (PST)
Date: Tue, 11 Nov 2025 23:06:41 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aRQyAdyiQjhsC11h@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
 <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
 <aRPH1hV7bEfagPtE@sultan-box>
 <aRPhMCwJjpMqAROG@sultan-box>
 <d9afc6db-fd8a-4069-a8a8-1e2d74c1db3a@amd.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9afc6db-fd8a-4069-a8a8-1e2d74c1db3a@amd.com>

On Wed, Nov 12, 2025 at 02:32:51PM +0800, Du, Bin wrote:
> Thanks Sultan for your information.
> 
> On 11/12/2025 9:21 AM, Sultan Alsawaf wrote:
> > On Tue, Nov 11, 2025 at 03:33:42PM -0800, Sultan Alsawaf wrote:
> > > On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
> > > > 
> > > > On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
> > > > 
> > > > > On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> > > > > > Thank you, Sultan, for your time, big effort, and constant support.
> > > > > > Apologies for my delayed reply for being occupied a little with other
> > > > > > matters.
> > > > > > 
> > > > > > On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > > > > > > Hi Bin,
> > > > > > > 
> > > > > > > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > > > > > > Hi Bin,
> > > > > > > > 
> > > > > > > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > > > > > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > > > > > > further about specific changes if you have any questions.
> > > > > > > > 
> > > > > > > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > > > > > > I should send what I've got so far.
> > > > > > > > 
> > > > > > > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > > > > > > protecting the list_del() anymore. I also checked the compiler output when using
> > > > > > > > guard() versus scoped_guard() in that function and there is no difference:
> > > > > > > > 
> > > > > > > >      sha1sum:
> > > > > > > >      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > > > > > > >      5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > > > > > > 
> > > > > > > > So guard() should be used there again, which I've done in my patch.
> > > > > > > > 
> > > > > > > > I also have a few questions:
> > > > > > > > 
> > > > > > > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > > > > > > >       faster to use that than using disable_irq_nosync() to disable the IRQ from
> > > > > > > >       the CPU's side.
> > > > > > > > 
> > > > > > > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > > > > > > >       beforehand to mask all pending interrupts from the ISP so that there isn't a
> > > > > > > >       bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > > > > > > 
> > > > > > > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > > > > > > >       when the ISP posts a new response _after_ the kthread determines there are no
> > > > > > > >       more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > > > > > > 
> > > > > > > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > > > > > > >       there is a mix of several lines wrapped to 80 cols and many lines going
> > > > > > > >       beyond 80 cols. And there are multiple places where code is wrapped before
> > > > > > > >       reaching 80 cols even with lots of room left, specifically for cases where it
> > > > > > > >       wouldn't hurt readability to put more characters onto each line.
> > > > > > > 
> > > > > > > I've attached a new, complete patch of changes to apply on top of v5. You may
> > > > > > > ignore the incomplete patch from my previous email and use the new one instead.
> > > > > > > 
> > > > > > > I made many changes and also answered questions 1-3 myself.
> > > > > > > 
> > > > > > > Please apply this on top of v5 and let me know if you have any questions.
> > > > > > > 
> > > > > > 
> > > > > > Sure, will review, apply and test your patch accordingly. Your contribution
> > > > > > is greatly appreciated, will let you know if there is any question or
> > > > > > problem.
> > > > > > 
> > > > > > > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > > > > > > time you use cheese after using it one time, the video will freeze after 30-60
> > > > > > > seconds with this message printed to dmesg:
> > > > > > >      [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > > > > > > 
> > > > > > > And the video never unfreezes. I haven't found the cause for the regression yet;
> > > > > > > can you try to reproduce it?
> > > > > > > 
> > > > > > 
> > > > > > Really weird, we don't see this issue either in dev or QA test. Is it 100%
> > > > > > reproducible and any other fail or err in the log?
> > > > > 
> > > > > Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> > > > > 
> > > > > Sometimes there is a stop stream error when I close cheese after it froze:
> > > > > 
> > > > >     [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
> > > > >     [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
> > > > >     [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> > > > > 
> > > > > When I revert to v4 I cannot reproduce it at all. It seems to be something in
> > > > > v4 -> v5 that is not fixed by any of my changes.
> > > > > 
> > > > 
> > > > Hi Sultan, could you please try following modifications on top of v5 to see
> > > > if it helps?
> > > > 
> > > > diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > index 39c2265121f9..d571b3873edb 100644
> > > > --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > > @@ -97,7 +97,7 @@
> > > > 
> > > > #define ADDR_SPACE_TYPE_GPU_VA          4
> > > > 
> > > > -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> > > > +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> > > > 
> > > > /*
> > > >    * standard ISP mipicsi=>isp
> > > > diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > index 248d10076ae8..acbc80aa709e 100644
> > > > --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > > @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
> > > > isp4_subdev *isp_subdev)
> > > >          return 0;
> > > > }
> > > > 
> > > > -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
> > > > irq_enabled)
> > > > {
> > > >          struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > > >          unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > > > @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
> > > > *isp_subdev)
> > > >                  return 0;
> > > >          }
> > > > 
> > > > -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > -               disable_irq(isp_subdev->irq[i]);
> > > > +       if (irq_enabled)
> > > > +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > > +                       disable_irq(isp_subdev->irq[i]);
> > > > 
> > > >          isp4sd_stop_resp_proc_threads(isp_subdev);
> > > >          dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > > > @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
> > > > *isp_subdev)
> > > > 
> > > >          return 0;
> > > > err_unlock_and_close:
> > > > -       isp4sd_pwroff_and_deinit(isp_subdev);
> > > > +       isp4sd_pwroff_and_deinit(isp_subdev, false);
> > > >          return -EINVAL;
> > > > }
> > > > 
> > > > @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
> > > > on)
> > > >          if (on)
> > > >                  return isp4sd_pwron_and_init(isp_subdev);
> > > >          else
> > > > -               return isp4sd_pwroff_and_deinit(isp_subdev);
> > > > +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
> > > > }
> > > > 
> > > > static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> > > 
> > > No difference sadly; same symptoms as before. FYI, your email client broke the
> > > patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
> > > replaced tabs with spaces, and removed leading spaces on each context line, so I
> > > had to apply it manually. To confirm I applied it correctly, here is my diff:
> > > 
> > > diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > index 39c2265121f9..d571b3873edb 100644
> > > --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> > > @@ -97,7 +97,7 @@
> > >   #define ADDR_SPACE_TYPE_GPU_VA          4
> > > -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> > > +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> > >   /*
> > >    * standard ISP mipicsi=>isp
> > > diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > index 4bd2ebf0f694..500ef0af8a41 100644
> > > --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> > > @@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
> > >   	return 0;
> > >   }
> > > -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > > +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
> > >   {
> > >   	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
> > >   	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> > > @@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> > >   		return 0;
> > >   	}
> > > -	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > -		disable_irq(isp_subdev->irq[i]);
> > > +	if (irq_enabled)
> > > +		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> > > +			disable_irq(isp_subdev->irq[i]);
> > >   	isp4sd_stop_resp_proc_threads(isp_subdev);
> > >   	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> > > @@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
> > >   	return 0;
> > >   err_unlock_and_close:
> > > -	isp4sd_pwroff_and_deinit(isp_subdev);
> > > +	isp4sd_pwroff_and_deinit(isp_subdev, false);
> > >   	return -EINVAL;
> > >   }
> > > @@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
> > >   	if (on)
> > >   		return isp4sd_pwron_and_init(isp_subdev);
> > >   	else
> > > -		return isp4sd_pwroff_and_deinit(isp_subdev);
> > > +		return isp4sd_pwroff_and_deinit(isp_subdev, true);
> > >   }
> > >   static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
> > > 
> > > > On the other hand, please also add the patch in amdgpu which sets *bo to
> > > > NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.
> > > 
> > > Yep, I have been doing all v5 testing with that patch applied.
> > > 
> > > BTW, I have verified the IRQ changes are not the cause for the regression; I
> > > tested with IRQs kept enabled all the time and the issue still occurs.
> > > 
> > > I did observe that ISP stops sending interrupts when the video stream freezes.
> > > And, if I replicate the bug enough times, it seems to permanently break FW until
> > > a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
> > > the ISP when this happens.
> > > 
> > > As an improvement to the driver, can we do a hard reset of ISP on driver probe?
> > > I am assuming hardware doesn't need too long to settle after hard reset, maybe
> > > a few hundred milliseconds? This would ensure ISP FW is always in a working
> > > state when the driver is loaded.
> > > 
> 
> Actually, each time the camera is activated, the ISP driver powers on the
> ISP and initiates its firmware from the beginning; when the camera is
> closed, the ISP is powered off..

Hmm, well I am able to put the ISP in a completely unusable state that doesn't
recover when I unload and reload amd_capture. Or maybe it is the sensor that is
stuck in a broken state?

> > > Thanks,
> > > Sultan
> > 
> > A small update: I reproduced the issue on v4, but it took several more cycles of
> > closing/opening cheese and waiting 30s compared to v5.
> > 
> > Right now my best guess is that this is a timing issue with respect to FW that
> > was exposed by the v5 changes. v5 introduced slight changes in code timing, like
> > with the mutex locks getting replaced by spin locks.
> > 
> > I'll try to insert mdelays to see if I can expose the issue that way on v4.
> > 
> 
> Could you kindly provide the FW used?

  commit a89515d3ff79f12099f7a51b0f4932b881b7720e
  Author: Pratap Nirujogi <pratap.nirujogi@amd.com>
  Date:   Thu Aug 21 15:40:45 2025 -0400

      amdgpu: Update ISP FW for isp v4.1.1
      
      From internal git commit:
      24557b7326e539183b3bc44cf8e1496c74d383d6
      
      Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Sultan
