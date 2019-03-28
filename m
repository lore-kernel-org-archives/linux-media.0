Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80FC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F52173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I64xIjKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1HLv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:11:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35516 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1HLu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 03:11:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id m10so9751213otp.2
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmNJzCIsJVoVT6kzRUKP3n5BhG0TeVPoQ8O5Ost88IQ=;
        b=I64xIjKd9BTi3Sv6eAP1+2IxrgumWDzp1Ao/9ASDfBPOoVpo5XLTp2YcpIhu2Yvduw
         E+X6iJ49mIJB524mu70aQhxBIs5pp7ctetKwI7Bk9zjHzEzEq8UEf3i3WXH2gu2SOivF
         PrWCMFp0szeZoXyCTnYf55hTdCFdWt8aZfCKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmNJzCIsJVoVT6kzRUKP3n5BhG0TeVPoQ8O5Ost88IQ=;
        b=LBjCr9s4kC2DD7tWI3kuuFnyg+UUaZycPkrVonHqHfvlHtbvEYZaO/+ZaStT/1q4ii
         RqZptwdTC5gfhxMstwveSW4IQCvPalOtqIOxLY+Xa73lo5Cfez4I8bXbXMftH2w1OaZj
         eQLwQntOFfGpQxyVc7TaiE45HLcdjQvTjMgwR7gb50qB2MTz23ZPMO4bzA5sZ9q6aHcm
         bSIbDs0wrjEL5angjS3Z3X7TGP5L37ZZLm7uODcz8gb9/Fo1pmSqXd4YP6Ba+Sx49ocU
         rJGIULvqqtbLheY3kaqzx/Kdvk8S3zz/H12U+SWnzReNJt3PXiUOgl26peQd3YSOX7Lt
         bK7Q==
X-Gm-Message-State: APjAAAVFPiNMLHZRk6/R/cqY748YMO7GqPXqX59ZlX6+zPdU6LmcbyKu
        SjFGLO3/EuJIiF0hRCJS7/kUVcmnnFo=
X-Google-Smtp-Source: APXvYqwxhqd8QUFh3pgX5l4P6WiDVYaiAQJEyPkPTV35y4/eiiNWMy9vVacgQN+4c8YWNACdccfLmg==
X-Received: by 2002:a05:6830:2090:: with SMTP id y16mr20245714otq.97.1553757109530;
        Thu, 28 Mar 2019 00:11:49 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id x202sm6927525oix.54.2019.03.28.00.11.48
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 00:11:48 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id o74so17376307ota.3
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 00:11:48 -0700 (PDT)
X-Received: by 2002:a9d:3f24:: with SMTP id m33mr28306500otc.147.1553757107987;
 Thu, 28 Mar 2019 00:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com> <20190304192529.14200-8-ezequiel@collabora.com>
In-Reply-To: <20190304192529.14200-8-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 28 Mar 2019 16:11:36 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AVgcj9vMsnE4yKm3uNnFPJ_1KpvX8t9bioVg4Cp2Wy=Q@mail.gmail.com>
Message-ID: <CAAFQd5AVgcj9vMsnE4yKm3uNnFPJ_1KpvX8t9bioVg4Cp2Wy=Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] rockchip/vpu: Open-code media controller register
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> In preparation to support decoders, using a single memory-to-memory
> device, we need to roll our own media controller entities registration.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../staging/media/rockchip/vpu/rockchip_vpu.h |  35 ++++
>  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 181 ++++++++++++++++--
>  2 files changed, 204 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> index 76ee24abc141..084f58cadda1 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> @@ -71,6 +71,38 @@ enum rockchip_vpu_codec_mode {
>         RK_VPU_MODE_JPEG_ENC,
>  };
>
> +/*
> + * struct rockchip_vpu_mc - media controller data
> + *
> + * @source:            &struct media_entity pointer with the source entity
> + *                     Used only when the M2M device is registered via
> + *                     v4l2_m2m_unregister_media_controller().

_register? (and few other places below)

But I'm really confused, because this patch exactly removes the uses
of v4l2_m2m_(un)register_media_controller() in this driver.

> + * @source_pad:                &struct media_pad with the source pad.
> + *                     Used only when the M2M device is registered via
> + *                     v4l2_m2m_unregister_media_controller().
> + * @sink:              &struct media_entity pointer with the sink entity
> + *                     Used only when the M2M device is registered via
> + *                     v4l2_m2m_unregister_media_controller().
> + * @sink_pad:          &struct media_pad with the sink pad.
> + *                     Used only when the M2M device is registered via
> + *                     v4l2_m2m_unregister_media_controller().
> + * @proc:              &struct media_entity pointer with the M2M device itself.
> + * @proc_pads:         &struct media_pad with the @proc pads.
> + *                     Used only when the M2M device is registered via
> + *                     v4l2_m2m_unregister_media_controller().
> + * @intf_devnode:      &struct media_intf devnode pointer with the interface
> + *                     with controls the M2M device.
> + */
> +struct rockchip_vpu_mc {
> +       struct media_entity     *source;
> +       struct media_pad        source_pad;
> +       struct media_entity     sink;
> +       struct media_pad        sink_pad;
> +       struct media_entity     proc;
> +       struct media_pad        proc_pads[2];
> +       struct media_intf_devnode *intf_devnode;
> +};
> +
>  /**
>   * struct rockchip_vpu_dev - driver data
>   * @v4l2_dev:          V4L2 device to register video devices for.
> @@ -78,6 +110,8 @@ enum rockchip_vpu_codec_mode {
>   * @mdev:              media device associated to this device.
>   * @vfd_enc:           Video device for encoder.
>   * @pdev:              Pointer to VPU platform device.
> + * @mc:                        Array of media controller topology structs

Is it just me or there is something wrong with indentation here?

> + *                     for encoder and decoder.
>   * @dev:               Pointer to device for convenient logging using
>   *                     dev_ macros.
>   * @clocks:            Array of clock handles.
> @@ -95,6 +129,7 @@ struct rockchip_vpu_dev {
>         struct media_device mdev;
>         struct video_device *vfd_enc;
>         struct platform_device *pdev;
> +       struct rockchip_vpu_mc mc[2];
>         struct device *dev;
>         struct clk_bulk_data clocks[ROCKCHIP_VPU_MAX_CLOCKS];
>         void __iomem *base;
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> index 1a6dd36c71ab..af2481ca2228 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> @@ -332,7 +332,7 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
>  {
>         const struct of_device_id *match;
>         struct video_device *vfd;
> -       int function, ret;
> +       int ret;
>
>         match = of_match_node(of_rockchip_vpu_match, vpu->dev->of_node);
>         vfd = video_device_alloc();
> @@ -359,21 +359,169 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
>         }
>         v4l2_info(&vpu->v4l2_dev, "registered as /dev/video%d\n", vfd->num);
>
> -       function = MEDIA_ENT_F_PROC_VIDEO_ENCODER;
> -       ret = v4l2_m2m_register_media_controller(vpu->m2m_dev, vfd, function);
> -       if (ret) {
> -               v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem media controller\n");
> -               goto err_unreg_video;
> -       }
>         return 0;
> -
> -err_unreg_video:
> -       video_unregister_device(vfd);
>  err_free_dev:
>         video_device_release(vfd);
>         return ret;
>  }
>
> +static int rockchip_vpu_register_entity(struct media_device *mdev,
> +       struct media_entity *entity, const char *entity_name,
> +       struct media_pad *pads, int num_pads, int function,
> +       struct video_device *vdev)
> +{
> +       unsigned int len;
> +       char *name;
> +       int ret;
> +
> +       entity->obj_type = MEDIA_ENTITY_TYPE_BASE;
> +       if (function == MEDIA_ENT_F_IO_V4L) {
> +               entity->info.dev.major = VIDEO_MAJOR;
> +               entity->info.dev.minor = vdev->minor;
> +       }
> +       len = strlen(vdev->name) + 2 + strlen(entity_name);
> +       name = kmalloc(len, GFP_KERNEL);
> +       if (!name)
> +               return -ENOMEM;
> +       snprintf(name, len, "%s-%s", vdev->name, entity_name);

How about using kasprintf()?

> +       entity->name = name;
> +       entity->function = function;
> +
> +       ret = media_entity_pads_init(entity, num_pads, pads);
> +       if (ret)
> +               return ret;
> +       ret = media_device_register_entity(mdev, entity);
> +       if (ret)
> +               return ret;

How about the memory allocated for entity->name?

> +
> +       return 0;
> +}
> +
> +static int rockchip_register_mc(struct media_device *mdev,
> +                               struct rockchip_vpu_mc *mc,
> +                               struct video_device *vdev,
> +                               int function)
> +{
> +       struct media_link *link;
> +       int ret;
> +
> +       /* Create the three encoder entities with their pads */
> +       mc->source = &vdev->entity;
> +       mc->source_pad.flags = MEDIA_PAD_FL_SOURCE;
> +       ret = rockchip_vpu_register_entity(mdev, mc->source,
> +                       "source", &mc->source_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> +       if (ret)
> +               return ret;
> +
> +       mc->proc_pads[0].flags = MEDIA_PAD_FL_SINK;
> +       mc->proc_pads[1].flags = MEDIA_PAD_FL_SOURCE;
> +       ret = rockchip_vpu_register_entity(mdev, &mc->proc,
> +                       "proc", mc->proc_pads, 2, function, vdev);
> +       if (ret)
> +               goto err_rel_entity0;
> +
> +       mc->sink_pad.flags = MEDIA_PAD_FL_SINK;
> +       ret = rockchip_vpu_register_entity(mdev, &mc->sink,
> +                       "sink", &mc->sink_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> +       if (ret)
> +               goto err_rel_entity1;
> +
> +       /* Connect the three entities */
> +       ret = media_create_pad_link(mc->source, 0, &mc->proc, 1,
> +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> +       if (ret)
> +               goto err_rel_entity2;
> +
> +       ret = media_create_pad_link(&mc->proc, 0, &mc->sink, 0,
> +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> +       if (ret)
> +               goto err_rm_links0;
> +
> +       /* Create video interface */
> +       mc->intf_devnode = media_devnode_create(mdev,
> +                       MEDIA_INTF_T_V4L_VIDEO, 0,
> +                       VIDEO_MAJOR, vdev->minor);
> +       if (!mc->intf_devnode) {
> +               ret = -ENOMEM;
> +               goto err_rm_links1;
> +       }
> +
> +       /* Connect the two DMA engines to the interface */
> +       link = media_create_intf_link(mc->source,
> +                       &mc->intf_devnode->intf,
> +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> +       if (!link) {
> +               ret = -ENOMEM;
> +               goto err_rm_devnode;
> +       }
> +
> +       link = media_create_intf_link(&mc->sink,
> +                       &mc->intf_devnode->intf,
> +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> +       if (!link) {
> +               ret = -ENOMEM;
> +               goto err_rm_intf_link;
> +       }
> +       return 0;
> +
> +err_rm_intf_link:
> +       media_remove_intf_links(&mc->intf_devnode->intf);

Do we need to explicitly remove the links here? The entity removal
functions remove the links implicitly.

> +err_rm_devnode:
> +       media_devnode_remove(mc->intf_devnode);
> +err_rm_links1:
> +       media_entity_remove_links(&mc->sink);
> +err_rm_links0:
> +       media_entity_remove_links(&mc->proc);
> +       media_entity_remove_links(mc->source);
> +err_rel_entity2:
> +       media_device_unregister_entity(&mc->proc);
> +       kfree(mc->proc.name);
> +err_rel_entity1:
> +       media_device_unregister_entity(&mc->sink);
> +       kfree(mc->sink.name);
> +err_rel_entity0:
> +       media_device_unregister_entity(mc->source);
> +       kfree(mc->source->name);
> +       return ret;
> +}
> +
> +static void rockchip_unregister_mc(struct rockchip_vpu_mc *mc)
> +{
> +       media_remove_intf_links(&mc->intf_devnode->intf);
> +       media_devnode_remove(mc->intf_devnode);
> +       media_entity_remove_links(mc->source);
> +       media_entity_remove_links(&mc->sink);
> +       media_entity_remove_links(&mc->proc);
> +       media_device_unregister_entity(mc->source);
> +       media_device_unregister_entity(&mc->sink);
> +       media_device_unregister_entity(&mc->proc);
> +       kfree(mc->source->name);
> +       kfree(mc->sink.name);
> +       kfree(mc->proc.name);
> +}
> +
> +static int rockchip_register_media_controller(struct rockchip_vpu_dev *vpu)
> +{
> +       int ret;
> +
> +       /* We have one memory-to-memory device, to hold a single queue

Coding style:

/*
 * We have one [...]

Best regards,
Tomasz
