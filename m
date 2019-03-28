Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B711C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6333520811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfC1UFW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:05:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54566 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1UFW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:05:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id F0380280B76
Message-ID: <81754d3621042384b272700d724336582ff1a94c.camel@collabora.com>
Subject: Re: [PATCH v2 07/11] rockchip/vpu: Open-code media controller
 register
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Date:   Thu, 28 Mar 2019 17:05:13 -0300
In-Reply-To: <CAAFQd5AVgcj9vMsnE4yKm3uNnFPJ_1KpvX8t9bioVg4Cp2Wy=Q@mail.gmail.com>
References: <20190304192529.14200-1-ezequiel@collabora.com>
         <20190304192529.14200-8-ezequiel@collabora.com>
         <CAAFQd5AVgcj9vMsnE4yKm3uNnFPJ_1KpvX8t9bioVg4Cp2Wy=Q@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-03-28 at 16:11 +0900, Tomasz Figa wrote:
> On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > In preparation to support decoders, using a single memory-to-memory
> > device, we need to roll our own media controller entities registration.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../staging/media/rockchip/vpu/rockchip_vpu.h |  35 ++++
> >  .../media/rockchip/vpu/rockchip_vpu_drv.c     | 181 ++++++++++++++++--
> >  2 files changed, 204 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > index 76ee24abc141..084f58cadda1 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu.h
> > @@ -71,6 +71,38 @@ enum rockchip_vpu_codec_mode {
> >         RK_VPU_MODE_JPEG_ENC,
> >  };
> > 
> > +/*
> > + * struct rockchip_vpu_mc - media controller data
> > + *
> > + * @source:            &struct media_entity pointer with the source entity
> > + *                     Used only when the M2M device is registered via
> > + *                     v4l2_m2m_unregister_media_controller().
> 
> _register? (and few other places below)
> 
> But I'm really confused, because this patch exactly removes the uses
> of v4l2_m2m_(un)register_media_controller() in this driver.
> 

Those comments are bad copy paste, should be dropped.

> > + * @source_pad:                &struct media_pad with the source pad.
> > + *                     Used only when the M2M device is registered via
> > + *                     v4l2_m2m_unregister_media_controller().
> > + * @sink:              &struct media_entity pointer with the sink entity
> > + *                     Used only when the M2M device is registered via
> > + *                     v4l2_m2m_unregister_media_controller().
> > + * @sink_pad:          &struct media_pad with the sink pad.
> > + *                     Used only when the M2M device is registered via
> > + *                     v4l2_m2m_unregister_media_controller().
> > + * @proc:              &struct media_entity pointer with the M2M device itself.
> > + * @proc_pads:         &struct media_pad with the @proc pads.
> > + *                     Used only when the M2M device is registered via
> > + *                     v4l2_m2m_unregister_media_controller().
> > + * @intf_devnode:      &struct media_intf devnode pointer with the interface
> > + *                     with controls the M2M device.
> > + */
> > +struct rockchip_vpu_mc {
> > +       struct media_entity     *source;
> > +       struct media_pad        source_pad;
> > +       struct media_entity     sink;
> > +       struct media_pad        sink_pad;
> > +       struct media_entity     proc;
> > +       struct media_pad        proc_pads[2];
> > +       struct media_intf_devnode *intf_devnode;
> > +};
> > +
> >  /**
> >   * struct rockchip_vpu_dev - driver data
> >   * @v4l2_dev:          V4L2 device to register video devices for.
> > @@ -78,6 +110,8 @@ enum rockchip_vpu_codec_mode {
> >   * @mdev:              media device associated to this device.
> >   * @vfd_enc:           Video device for encoder.
> >   * @pdev:              Pointer to VPU platform device.
> > + * @mc:                        Array of media controller topology structs
> 
> Is it just me or there is something wrong with indentation here?
> 

It seems to be fine here -- it's all tabs.

> > + *                     for encoder and decoder.
> >   * @dev:               Pointer to device for convenient logging using
> >   *                     dev_ macros.
> >   * @clocks:            Array of clock handles.
> > @@ -95,6 +129,7 @@ struct rockchip_vpu_dev {
> >         struct media_device mdev;
> >         struct video_device *vfd_enc;
> >         struct platform_device *pdev;
> > +       struct rockchip_vpu_mc mc[2];
> >         struct device *dev;
> >         struct clk_bulk_data clocks[ROCKCHIP_VPU_MAX_CLOCKS];
> >         void __iomem *base;
> > diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > index 1a6dd36c71ab..af2481ca2228 100644
> > --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
> > @@ -332,7 +332,7 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
> >  {
> >         const struct of_device_id *match;
> >         struct video_device *vfd;
> > -       int function, ret;
> > +       int ret;
> > 
> >         match = of_match_node(of_rockchip_vpu_match, vpu->dev->of_node);
> >         vfd = video_device_alloc();
> > @@ -359,21 +359,169 @@ static int rockchip_vpu_video_device_register(struct rockchip_vpu_dev *vpu)
> >         }
> >         v4l2_info(&vpu->v4l2_dev, "registered as /dev/video%d\n", vfd->num);
> > 
> > -       function = MEDIA_ENT_F_PROC_VIDEO_ENCODER;
> > -       ret = v4l2_m2m_register_media_controller(vpu->m2m_dev, vfd, function);
> > -       if (ret) {
> > -               v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem media controller\n");
> > -               goto err_unreg_video;
> > -       }
> >         return 0;
> > -
> > -err_unreg_video:
> > -       video_unregister_device(vfd);
> >  err_free_dev:
> >         video_device_release(vfd);
> >         return ret;
> >  }
> > 
> > +static int rockchip_vpu_register_entity(struct media_device *mdev,
> > +       struct media_entity *entity, const char *entity_name,
> > +       struct media_pad *pads, int num_pads, int function,
> > +       struct video_device *vdev)
> > +{
> > +       unsigned int len;
> > +       char *name;
> > +       int ret;
> > +
> > +       entity->obj_type = MEDIA_ENTITY_TYPE_BASE;
> > +       if (function == MEDIA_ENT_F_IO_V4L) {
> > +               entity->info.dev.major = VIDEO_MAJOR;
> > +               entity->info.dev.minor = vdev->minor;
> > +       }
> > +       len = strlen(vdev->name) + 2 + strlen(entity_name);
> > +       name = kmalloc(len, GFP_KERNEL);
> > +       if (!name)
> > +               return -ENOMEM;
> > +       snprintf(name, len, "%s-%s", vdev->name, entity_name);
> 
> How about using kasprintf()?
> 

Indeed.

> > +       entity->name = name;
> > +       entity->function = function;
> > +
> > +       ret = media_entity_pads_init(entity, num_pads, pads);
> > +       if (ret)
> > +               return ret;
> > +       ret = media_device_register_entity(mdev, entity);
> > +       if (ret)
> > +               return ret;
> 
> How about the memory allocated for entity->name?
> 

Oops.

> > +
> > +       return 0;
> > +}
> > +
> > +static int rockchip_register_mc(struct media_device *mdev,
> > +                               struct rockchip_vpu_mc *mc,
> > +                               struct video_device *vdev,
> > +                               int function)
> > +{
> > +       struct media_link *link;
> > +       int ret;
> > +
> > +       /* Create the three encoder entities with their pads */
> > +       mc->source = &vdev->entity;
> > +       mc->source_pad.flags = MEDIA_PAD_FL_SOURCE;
> > +       ret = rockchip_vpu_register_entity(mdev, mc->source,
> > +                       "source", &mc->source_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mc->proc_pads[0].flags = MEDIA_PAD_FL_SINK;
> > +       mc->proc_pads[1].flags = MEDIA_PAD_FL_SOURCE;
> > +       ret = rockchip_vpu_register_entity(mdev, &mc->proc,
> > +                       "proc", mc->proc_pads, 2, function, vdev);
> > +       if (ret)
> > +               goto err_rel_entity0;
> > +
> > +       mc->sink_pad.flags = MEDIA_PAD_FL_SINK;
> > +       ret = rockchip_vpu_register_entity(mdev, &mc->sink,
> > +                       "sink", &mc->sink_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> > +       if (ret)
> > +               goto err_rel_entity1;
> > +
> > +       /* Connect the three entities */
> > +       ret = media_create_pad_link(mc->source, 0, &mc->proc, 1,
> > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +       if (ret)
> > +               goto err_rel_entity2;
> > +
> > +       ret = media_create_pad_link(&mc->proc, 0, &mc->sink, 0,
> > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +       if (ret)
> > +               goto err_rm_links0;
> > +
> > +       /* Create video interface */
> > +       mc->intf_devnode = media_devnode_create(mdev,
> > +                       MEDIA_INTF_T_V4L_VIDEO, 0,
> > +                       VIDEO_MAJOR, vdev->minor);
> > +       if (!mc->intf_devnode) {
> > +               ret = -ENOMEM;
> > +               goto err_rm_links1;
> > +       }
> > +
> > +       /* Connect the two DMA engines to the interface */
> > +       link = media_create_intf_link(mc->source,
> > +                       &mc->intf_devnode->intf,
> > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +       if (!link) {
> > +               ret = -ENOMEM;
> > +               goto err_rm_devnode;
> > +       }
> > +
> > +       link = media_create_intf_link(&mc->sink,
> > +                       &mc->intf_devnode->intf,
> > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > +       if (!link) {
> > +               ret = -ENOMEM;
> > +               goto err_rm_intf_link;
> > +       }
> > +       return 0;
> > +
> > +err_rm_intf_link:
> > +       media_remove_intf_links(&mc->intf_devnode->intf);
> 
> Do we need to explicitly remove the links here? The entity removal
> functions remove the links implicitly.
> 

You mean the media_devnode_remove, right? In that case, seems you are right.

> > +err_rm_devnode:
> > +       media_devnode_remove(mc->intf_devnode);
> > +err_rm_links1:
> > +       media_entity_remove_links(&mc->sink);
> > +err_rm_links0:
> > +       media_entity_remove_links(&mc->proc);
> > +       media_entity_remove_links(mc->source);
> > +err_rel_entity2:
> > +       media_device_unregister_entity(&mc->proc);
> > +       kfree(mc->proc.name);
> > +err_rel_entity1:
> > +       media_device_unregister_entity(&mc->sink);
> > +       kfree(mc->sink.name);
> > +err_rel_entity0:
> > +       media_device_unregister_entity(mc->source);
> > +       kfree(mc->source->name);
> > +       return ret;
> > +}
> > +
> > +static void rockchip_unregister_mc(struct rockchip_vpu_mc *mc)
> > +{
> > +       media_remove_intf_links(&mc->intf_devnode->intf);
> > +       media_devnode_remove(mc->intf_devnode);
> > +       media_entity_remove_links(mc->source);
> > +       media_entity_remove_links(&mc->sink);
> > +       media_entity_remove_links(&mc->proc);
> > +       media_device_unregister_entity(mc->source);
> > +       media_device_unregister_entity(&mc->sink);
> > +       media_device_unregister_entity(&mc->proc);
> > +       kfree(mc->source->name);
> > +       kfree(mc->sink.name);
> > +       kfree(mc->proc.name);
> > +}
> > +
> > +static int rockchip_register_media_controller(struct rockchip_vpu_dev *vpu)
> > +{
> > +       int ret;
> > +
> > +       /* We have one memory-to-memory device, to hold a single queue
> 
> Coding style:
> 
> /*
>  * We have one [...]

Right.

Thanks,
Eze

