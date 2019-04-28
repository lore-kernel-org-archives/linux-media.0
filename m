Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D436C43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D232064A
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BroiY2sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfD1Ufs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:35:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37131 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfD1Ufs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 16:35:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id y5so11615323wma.2
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=IZAy47XcoSM8oaf+24nONRYgmpJ1wMLHcNESne/0ILE=;
        b=BroiY2sHfoh63xVR0xXA5FXbM+VHAv1rv4LsbOwztaw9UfMhfLyeXOlbSaHyKuEg3k
         XV1Co4muhFvyu6AOZPktVSecY55Td+EDeBTF+CWw83W11mmeAX45FOEHpyjxXGC/dybh
         DEIs4chJOLQkE1zLYhBwbsN56bT1rmrwXEz7grVuxTAtOQJw1Oq3PD/Nn+y92/UrnlFQ
         NlWcxlr9o6DAuvezVY5EQmCSS1fhMcZpzuSDDxB2giJ9OQZIytDUZedM0w7z7LvqlIVU
         tTmMTvruGpltiUUT0LDMgn+yJV0o1UAvVjErnA8ZjZUQ5qPMIYmBE/RZwaOBCB7HBDZ5
         CPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=IZAy47XcoSM8oaf+24nONRYgmpJ1wMLHcNESne/0ILE=;
        b=ZhjsuKYF76bdSn4LKIlizpYkDlo/M+jumJbFqDGe9PEjTJLDj0cUDlt0x9c2m0IA41
         UKpG5/b5bK8U3NinQWGahMCy/MNd4KU2gYRaE+gzSnZV35aQAelaJpA/iM3qkKSt+lpO
         uk6jGTPvMJJ5I7G2KeOxhgSaCey3l+MO1heWG8vO+HM/hmbmK2AbrFoNfaxfCEOmuYUY
         05cblQMQ0F1W1OC6VOBS7xDX6v5SCUP8V9LlOh9Fe60mbTA/nuMH/xsr1DrP5SX7mXsT
         Ro+WoaxqSAiEqf4k2RMdpg8n8f1zG0UCEokk3BSzb3groWFiDYZDY0XSZGyHQ1KgLTrj
         WniQ==
X-Gm-Message-State: APjAAAVIjEzGrF/exR3FiUFxIeL4jmncadP5IIsIqf619SmBROGC8rMZ
        WcwiffN+Q6IQBloxQKY++VJtgLzjNWg=
X-Google-Smtp-Source: APXvYqzIJ5IbEB6QgZ35qPVMUP+lOzBHASkLpXOrREvmF5t+xGKUFobpaLc0Fmm5yCDeE3X7L7yC1g==
X-Received: by 2002:a1c:4d1a:: with SMTP id o26mr2423373wmh.133.1556483744571;
        Sun, 28 Apr 2019 13:35:44 -0700 (PDT)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id e7sm28046130wme.37.2019.04.28.13.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:35:43 -0700 (PDT)
References: <20190412164400.1270-1-rui.silva@linaro.org> <a375ed17-72e3-21d7-59c1-60b1fbe4b166@gmail.com>
User-agent: mu4e 1.2.0; emacs 27.0.50
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     driverdev-devel@linuxdriverproject.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: staging/imx: add media device to capture register
In-reply-to: <a375ed17-72e3-21d7-59c1-60b1fbe4b166@gmail.com>
Date:   Sun, 28 Apr 2019 21:35:42 +0100
Message-ID: <m3wojdx3z5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Steve,
On Sun 28 Apr 2019 at 19:53, Steve Longerbeam wrote:
> Hi Rui,
>
> On second thought, there is no reason to pass the media device to 
> imx_media_capture_device_register(), because it is already available via 
> v4l2_dev->mdev. I will be posting a patch in v2 of the "Switch to sync 
> registration for IPU subdevs" series that fixes this.

That make sense to me. I've already took a look to v2 and I like
the ideas in there, I will give it a proper test and review
tomorrow. Will send feedback afterwards.

Thanks so much for your work on this.

---
Cheers,
	Rui

>
> Steve
>
>
> On 4/12/19 9:44 AM, Rui Miguel Silva wrote:
>> When register the capture media device it is assumed that the device
>> data is the media device. In the imx6 case is but in the imx7 is not
>> case. The device data is the csi structure.
>>
>> Add the explicit argument of the media device that we want to
>> associate with the capture device.
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>   drivers/staging/media/imx/imx-ic-prpencvf.c   | 2 +-
>>   drivers/staging/media/imx/imx-media-capture.c | 6 +++---
>>   drivers/staging/media/imx/imx-media-csi.c     | 2 +-
>>   drivers/staging/media/imx/imx-media.h         | 3 ++-
>>   drivers/staging/media/imx/imx7-media-csi.c    | 2 +-
>>   5 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> index 5c8e6ad8c025..3ca1422f6154 100644
>> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
>> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
>> @@ -1270,7 +1270,7 @@ static int prp_registered(struct v4l2_subdev *sd)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = imx_media_capture_device_register(priv->vdev);
>> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
>> index 9703c85b19c4..7688238a3396 100644
>> --- a/drivers/staging/media/imx/imx-media-capture.c
>> +++ b/drivers/staging/media/imx/imx-media-capture.c
>> @@ -706,7 +706,8 @@ void imx_media_capture_device_error(struct imx_media_video_dev *vdev)
>>   }
>>   EXPORT_SYMBOL_GPL(imx_media_capture_device_error);
>>   
>> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
>> +int imx_media_capture_device_register(struct imx_media_dev *md,
>> +				      struct imx_media_video_dev *vdev)
>>   {
>>   	struct capture_priv *priv = to_capture_priv(vdev);
>>   	struct v4l2_subdev *sd = priv->src_sd;
>> @@ -715,8 +716,7 @@ int imx_media_capture_device_register(struct imx_media_video_dev *vdev)
>>   	struct v4l2_subdev_format fmt_src;
>>   	int ret;
>>   
>> -	/* get media device */
>> -	priv->md = dev_get_drvdata(sd->v4l2_dev->dev);
>> +	priv->md = md;
>>   
>>   	vfd->v4l2_dev = sd->v4l2_dev;
>>   
>> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
>> index 3b7517348666..3408ec023d29 100644
>> --- a/drivers/staging/media/imx/imx-media-csi.c
>> +++ b/drivers/staging/media/imx/imx-media-csi.c
>> @@ -1806,7 +1806,7 @@ static int csi_registered(struct v4l2_subdev *sd)
>>   	if (ret)
>>   		goto free_fim;
>>   
>> -	ret = imx_media_capture_device_register(priv->vdev);
>> +	ret = imx_media_capture_device_register(priv->md, priv->vdev);
>>   	if (ret)
>>   		goto free_fim;
>>   
>> diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
>> index ae964c8d5be1..c3a8512bd10f 100644
>> --- a/drivers/staging/media/imx/imx-media.h
>> +++ b/drivers/staging/media/imx/imx-media.h
>> @@ -271,7 +271,8 @@ int imx_media_of_add_csi(struct imx_media_dev *imxmd,
>>   struct imx_media_video_dev *
>>   imx_media_capture_device_init(struct v4l2_subdev *src_sd, int pad);
>>   void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
>> -int imx_media_capture_device_register(struct imx_media_video_dev *vdev);
>> +int imx_media_capture_device_register(struct imx_media_dev *md,
>> +				       struct imx_media_video_dev *vdev);
>>   void imx_media_capture_device_unregister(struct imx_media_video_dev *vdev);
>>   struct imx_media_buffer *
>>   imx_media_capture_device_next_buf(struct imx_media_video_dev *vdev);
>> diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
>> index 3fba7c27c0ec..a907c5feb3eb 100644
>> --- a/drivers/staging/media/imx/imx7-media-csi.c
>> +++ b/drivers/staging/media/imx/imx7-media-csi.c
>> @@ -1124,7 +1124,7 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	ret = imx_media_capture_device_register(csi->vdev);
>> +	ret = imx_media_capture_device_register(csi->imxmd, csi->vdev);
>>   	if (ret < 0)
>>   		return ret;
>>   
>
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

