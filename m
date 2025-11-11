Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF255E53
	for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904032; cv=none; b=d3FDUcH+8Bjvn5zOl9o8j6UzXVoPRwO5O8EFvhUQ+yNPTEjUTyGb6yt1McIAMz+7JrHomiu1DqAgUDqIl3/xSXYXuBwNORFuLY5XJBgowlcd9hLh+9s6a5sOLFAnas4aeJ60AcaXvAivYAwpTSEU9785woy6wvdsuYJgUR/AlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904032; c=relaxed/simple;
	bh=K+YwAaQgBHNTGlsWqsDyDMVJC7SMDCTsUaCI08C1ncA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEiy/rB8h7KlwR9QdTHj0mgd9N+DK2o0pIGwq+fn4zYInRRf1sxTHMPT3kd1rAqhZ/3++ojNKIkgro2OSjc8KHbB2N5j1hrcUCRIbd3b+67xfH7wnJPoqv9H6wlepm4eyvLdz+rKdl9M01a++23AI2b7+mtuMB/ICfJs3he/avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=I3kxVN81; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="I3kxVN81"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29844c68068so1927855ad.2
        for <linux-media@vger.kernel.org>; Tue, 11 Nov 2025 15:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762904027; x=1763508827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjo2gwUi9bR6UkvLLEiGtPGxExrUE5bT0hwf9+P8s6w=;
        b=I3kxVN81EwOMR2AIVMbt9oYpCAMCYcOpNjJBFHkcecl2nNL7htg1elbPuGymH8QjES
         UmcxdgIk0BySKpveHsH9SRUEpD0iAKOdrU6E1XKYzIbMrNTjC5cxlS06PYlW6ctBU/DD
         5iHgnDRDNvVxXO4fyvpaETiDvDf+BuNFbO8ief8Y9C1dl+BJ51TCpFlRZDBivASAZwSr
         5z6oD5lbUEn1u17MGaYKNpjdRvXTPb5Jd9zK1NTlaUDOHINn0kA/O3DOwEYaJQQkY/Kq
         YJAMYZbYV3iKg5zba6S+buJeDQgZo6Ylj1ARpSCjRnFE2L5QsB/a1WvMMlqiyMgcOvLt
         ZhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904027; x=1763508827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjo2gwUi9bR6UkvLLEiGtPGxExrUE5bT0hwf9+P8s6w=;
        b=wR40+2tsd5BuT2C8lEz/Pg/70wNtHvHMEQfgnMC587PQq6fWZ6/Rv4WimLfLhXbWgN
         TDe9NQnzuFbb/hD97UR9VjmfDXxN4HliAL6EhLjPH8b4E8uB9vI2ShGyvIFeFfGMO2Ke
         iPhhNvPBqBOiVz/IPWZfMGyhK4haytSf8xd1AhU75i+UaGl6jfdum3GcAWlHWJI2LOMB
         Cdzl1IH52qvl7clrCzmthAcZUzFPyiUrt5q7B9dhwzRAvyzw2+EMMHDZ76PMblmpalPh
         Bqjuph4wuelG4GA5MZKqrWdBwDr4nSxVct6tG2F+5xaak2XZEKYA6u0TqEVJM4jogChX
         S0xA==
X-Forwarded-Encrypted: i=1; AJvYcCWq7fRXxDiYEma3/iuKf9y6MqAw5PAOFpgmS1w+rtIGeBQZfWVb8nqxOtx/sfLaj9b0LlB+dpKEN4SzNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGo3f8P9/eykltVK65XY0pbB4oVxXcLjmtPpMe8oUem1kV5GW
	l8gxzgdkk9Dn0YHgIGy/YiyhHSUnJi+DdJH9NJQE2T414ZrzphGN63HOkqTs64wgHs0d
X-Gm-Gg: ASbGnctD8YdSLvtCc9qyErLlR7fzwkc9AofbpbZVVyBiSa81i6h3qjCWubFQRZV6jKC
	aANXmO24rVU4aeL3KuIZFVeGWzq/MP3o7xA8/Wrav9S6YGr3b4QPtAHJdXpR9CIBeh7bd5bHu3t
	Pnyj5KlK5KqiNq0WI/rSHYzCbGKH/EH0QLOZI/w7T2YFXuSkTYAtke3lSmOyj50iiMQvjiiYjPu
	ALM5gfnetEH+loPZiHx8iz7NeM9Rmeakgc6tCYGCCID0Yj7tspxjC4JSmJYWea1kqxh4CZOJdLl
	0o5yIwwm3eAvbsYHHhj7soa/9Wztm2QnyETTn0/jj1yQWrDFffIQ74/ocGh5g61Z6K4+QFJY8rL
	QpWOQTfbknbwhTlb+83yJpApOSZDI9VIFq/72z6LdeHub7zyaXfgS78JTHg4Fa9G7ihSm8v2mSL
	bWPyE2RlwMtglw3Q==
X-Google-Smtp-Source: AGHT+IHOj8YNWi+mk68xhriHCfF+Pfmcf6xGe5863lzhdwZWXW52qU39peEkD3G2tO50yNhqOYu2dg==
X-Received: by 2002:a17:902:ce90:b0:294:fc1d:9d0 with SMTP id d9443c01a7336-2984edcb530mr11866685ad.40.1762904026766;
        Tue, 11 Nov 2025 15:33:46 -0800 (PST)
Received: from sultan-box ([142.147.89.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dc9f8f1sm8649795ad.54.2025.11.11.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:33:46 -0800 (PST)
Date: Tue, 11 Nov 2025 15:33:42 -0800
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
Message-ID: <aRPH1hV7bEfagPtE@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
 <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com>

On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
> 
> On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
> 
> > On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> > > Thank you, Sultan, for your time, big effort, and constant support.
> > > Apologies for my delayed reply for being occupied a little with other
> > > matters.
> > > 
> > > On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > > > Hi Bin,
> > > > 
> > > > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > > > Hi Bin,
> > > > > 
> > > > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > > > further about specific changes if you have any questions.
> > > > > 
> > > > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > > > I should send what I've got so far.
> > > > > 
> > > > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > > > protecting the list_del() anymore. I also checked the compiler output when using
> > > > > guard() versus scoped_guard() in that function and there is no difference:
> > > > > 
> > > > >     sha1sum:
> > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > > > >     5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > > > 
> > > > > So guard() should be used there again, which I've done in my patch.
> > > > > 
> > > > > I also have a few questions:
> > > > > 
> > > > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > > > >      faster to use that than using disable_irq_nosync() to disable the IRQ from
> > > > >      the CPU's side.
> > > > > 
> > > > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > > > >      beforehand to mask all pending interrupts from the ISP so that there isn't a
> > > > >      bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > > > 
> > > > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > > > >      when the ISP posts a new response _after_ the kthread determines there are no
> > > > >      more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > > > 
> > > > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > > > >      there is a mix of several lines wrapped to 80 cols and many lines going
> > > > >      beyond 80 cols. And there are multiple places where code is wrapped before
> > > > >      reaching 80 cols even with lots of room left, specifically for cases where it
> > > > >      wouldn't hurt readability to put more characters onto each line.
> > > > 
> > > > I've attached a new, complete patch of changes to apply on top of v5. You may
> > > > ignore the incomplete patch from my previous email and use the new one instead.
> > > > 
> > > > I made many changes and also answered questions 1-3 myself.
> > > > 
> > > > Please apply this on top of v5 and let me know if you have any questions.
> > > > 
> > > 
> > > Sure, will review, apply and test your patch accordingly. Your contribution
> > > is greatly appreciated, will let you know if there is any question or
> > > problem.
> > > 
> > > > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > > > time you use cheese after using it one time, the video will freeze after 30-60
> > > > seconds with this message printed to dmesg:
> > > >     [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > > > 
> > > > And the video never unfreezes. I haven't found the cause for the regression yet;
> > > > can you try to reproduce it?
> > > > 
> > > 
> > > Really weird, we don't see this issue either in dev or QA test. Is it 100%
> > > reproducible and any other fail or err in the log?
> > 
> > Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
> > 
> > Sometimes there is a stop stream error when I close cheese after it froze:
> > 
> >    [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
> >    [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
> >    [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> > 
> > When I revert to v4 I cannot reproduce it at all. It seems to be something in
> > v4 -> v5 that is not fixed by any of my changes.
> > 
> 
> Hi Sultan, could you please try following modifications on top of v5 to see
> if it helps?
> 
> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> index 39c2265121f9..d571b3873edb 100644
> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
> @@ -97,7 +97,7 @@
> 
> #define ADDR_SPACE_TYPE_GPU_VA          4
> 
> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
> 
> /*
>   * standard ISP mipicsi=>isp
> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
> b/drivers/media/platform/amd/isp4/isp4_subdev.c
> index 248d10076ae8..acbc80aa709e 100644
> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
> @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
> isp4_subdev *isp_subdev)
>         return 0;
> }
> 
> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
> irq_enabled)
> {
>         struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>         unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
> @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
> *isp_subdev)
>                 return 0;
>         }
> 
> -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> -               disable_irq(isp_subdev->irq[i]);
> +       if (irq_enabled)
> +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
> +                       disable_irq(isp_subdev->irq[i]);
> 
>         isp4sd_stop_resp_proc_threads(isp_subdev);
>         dev_dbg(dev, "isp_subdev stop resp proc streads suc");
> @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
> *isp_subdev)
> 
>         return 0;
> err_unlock_and_close:
> -       isp4sd_pwroff_and_deinit(isp_subdev);
> +       isp4sd_pwroff_and_deinit(isp_subdev, false);
>         return -EINVAL;
> }
> 
> @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
> on)
>         if (on)
>                 return isp4sd_pwron_and_init(isp_subdev);
>         else
> -               return isp4sd_pwroff_and_deinit(isp_subdev);
> +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
> }
> 
> static const struct v4l2_subdev_core_ops isp4sd_core_ops = {

No difference sadly; same symptoms as before. FYI, your email client broke the
patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
replaced tabs with spaces, and removed leading spaces on each context line, so I
had to apply it manually. To confirm I applied it correctly, here is my diff:

diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
index 39c2265121f9..d571b3873edb 100644
--- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
+++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
@@ -97,7 +97,7 @@
 
 #define ADDR_SPACE_TYPE_GPU_VA          4
 
-#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
+#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
 
 /*
  * standard ISP mipicsi=>isp
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
index 4bd2ebf0f694..500ef0af8a41 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
 	return 0;
 }
 
-static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
+static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
 {
 	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
 	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
@@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
 		return 0;
 	}
 
-	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
-		disable_irq(isp_subdev->irq[i]);
+	if (irq_enabled)
+		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
+			disable_irq(isp_subdev->irq[i]);
 
 	isp4sd_stop_resp_proc_threads(isp_subdev);
 	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
@@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
 
 	return 0;
 err_unlock_and_close:
-	isp4sd_pwroff_and_deinit(isp_subdev);
+	isp4sd_pwroff_and_deinit(isp_subdev, false);
 	return -EINVAL;
 }
 
@@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
 	if (on)
 		return isp4sd_pwron_and_init(isp_subdev);
 	else
-		return isp4sd_pwroff_and_deinit(isp_subdev);
+		return isp4sd_pwroff_and_deinit(isp_subdev, true);
 }
 
 static const struct v4l2_subdev_core_ops isp4sd_core_ops = {

> On the other hand, please also add the patch in amdgpu which sets *bo to
> NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.

Yep, I have been doing all v5 testing with that patch applied. 

BTW, I have verified the IRQ changes are not the cause for the regression; I
tested with IRQs kept enabled all the time and the issue still occurs.

I did observe that ISP stops sending interrupts when the video stream freezes.
And, if I replicate the bug enough times, it seems to permanently break FW until
a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
the ISP when this happens.

As an improvement to the driver, can we do a hard reset of ISP on driver probe?
I am assuming hardware doesn't need too long to settle after hard reset, maybe
a few hundred milliseconds? This would ensure ISP FW is always in a working
state when the driver is loaded.

Thanks,
Sultan
