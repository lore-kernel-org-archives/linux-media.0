Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D740C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5213F2173C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dglc0g0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfC2HnS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:43:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41969 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfC2HnS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 03:43:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so934127oie.8
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/YcA/AARmO9aIZkQrJM/Vn1xePsyTTpRbZh5J9tBDQ=;
        b=dglc0g0M91AaE5lGwM2zq3/LzjlSQENw8GMOWbWaqBgdFj714q8ayMRdJO/QAEF718
         fmiMx3p31ADTld88/LD2WlC8U0VSRMUKC69VpFCEQ6D9D9lZCzcJNXO/sdobhcBNL6xi
         rPY6tHbweBctKXbLNhkFuWkUZLsXaLlj8F/24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/YcA/AARmO9aIZkQrJM/Vn1xePsyTTpRbZh5J9tBDQ=;
        b=Ur0D0M7ZL5A5rh5lphqOtapngXlFaY87jB2RxtmDBef8YdZbONPeGuy1pGAtDTNeo5
         ph/8LvsPDk/F65jDTDn6DlLrXZbYjuenxwdJtViSdlrw4A9QGjWb5Sf6bFg4o3CziAtG
         +BiIrM8f/nr6UEDoaiC0HeblYoYYiHh9KUi2TWIjYqmKcPpv3LuZTGwbATd3lwZ02sm/
         5zZR86VfwqQuYva7y4u8/uCV7pl12phJFAFHZb6GyKNZRQ6AS7cBmVFU9nwzY1mOgbZg
         0Yi5KwnHeHQ/svuY/nQz25j01t9CtpGgIBsYRho9pO/Q/LiAuoYmdb6Mbkkd72VWFxUy
         h3yg==
X-Gm-Message-State: APjAAAWzQPtTLNKuO4TStNwlBh0vPR2wN9x/8coRrWV2tNgomDSxNDM7
        wczIAnlrM3algCDHQlZTxZGXFllSSpCP3Q==
X-Google-Smtp-Source: APXvYqyOqFMziRzBzgJJGy7xqCuU22WtO1LcGaZWWsN/XhZvO0lyItHU6++aXjcyUuUBPFpWbyrw1w==
X-Received: by 2002:aca:5750:: with SMTP id l77mr2765142oib.54.1553845397356;
        Fri, 29 Mar 2019 00:43:17 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id a34sm592493otc.46.2019.03.29.00.43.15
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 00:43:15 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id k21so1300379otf.1
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 00:43:15 -0700 (PDT)
X-Received: by 2002:a9d:3f24:: with SMTP id m33mr32448712otc.147.1553845395165;
 Fri, 29 Mar 2019 00:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-8-ezequiel@collabora.com> <CAAFQd5AVgcj9vMsnE4yKm3uNnFPJ_1KpvX8t9bioVg4Cp2Wy=Q@mail.gmail.com>
 <81754d3621042384b272700d724336582ff1a94c.camel@collabora.com>
In-Reply-To: <81754d3621042384b272700d724336582ff1a94c.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 29 Mar 2019 16:43:04 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CJbZ3EjhPBFdrHGuJeKdSr27we4Vy3U8J0dypcJkFPKg@mail.gmail.com>
Message-ID: <CAAFQd5CJbZ3EjhPBFdrHGuJeKdSr27we4Vy3U8J0dypcJkFPKg@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 5:05 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Thu, 2019-03-28 at 16:11 +0900, Tomasz Figa wrote:
> > On Tue, Mar 5, 2019 at 4:27 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
[snip]
> > > + * @source_pad:                &struct media_pad with the source pad.
> > > + *                     Used only when the M2M device is registered via
> > > + *                     v4l2_m2m_unregister_media_controller().
> > > + * @sink:              &struct media_entity pointer with the sink entity
> > > + *                     Used only when the M2M device is registered via
> > > + *                     v4l2_m2m_unregister_media_controller().
> > > + * @sink_pad:          &struct media_pad with the sink pad.
> > > + *                     Used only when the M2M device is registered via
> > > + *                     v4l2_m2m_unregister_media_controller().
> > > + * @proc:              &struct media_entity pointer with the M2M device itself.
> > > + * @proc_pads:         &struct media_pad with the @proc pads.
> > > + *                     Used only when the M2M device is registered via
> > > + *                     v4l2_m2m_unregister_media_controller().
> > > + * @intf_devnode:      &struct media_intf devnode pointer with the interface
> > > + *                     with controls the M2M device.
> > > + */
> > > +struct rockchip_vpu_mc {
> > > +       struct media_entity     *source;
> > > +       struct media_pad        source_pad;
> > > +       struct media_entity     sink;
> > > +       struct media_pad        sink_pad;
> > > +       struct media_entity     proc;
> > > +       struct media_pad        proc_pads[2];
> > > +       struct media_intf_devnode *intf_devnode;
> > > +};
> > > +
> > >  /**
> > >   * struct rockchip_vpu_dev - driver data
> > >   * @v4l2_dev:          V4L2 device to register video devices for.
> > > @@ -78,6 +110,8 @@ enum rockchip_vpu_codec_mode {
> > >   * @mdev:              media device associated to this device.
> > >   * @vfd_enc:           Video device for encoder.
> > >   * @pdev:              Pointer to VPU platform device.
> > > + * @mc:                        Array of media controller topology structs
> >
> > Is it just me or there is something wrong with indentation here?
> >
>
> It seems to be fine here -- it's all tabs.

Hmm, never mind then.

> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int rockchip_register_mc(struct media_device *mdev,
> > > +                               struct rockchip_vpu_mc *mc,
> > > +                               struct video_device *vdev,
> > > +                               int function)
> > > +{
> > > +       struct media_link *link;
> > > +       int ret;
> > > +
> > > +       /* Create the three encoder entities with their pads */
> > > +       mc->source = &vdev->entity;
> > > +       mc->source_pad.flags = MEDIA_PAD_FL_SOURCE;
> > > +       ret = rockchip_vpu_register_entity(mdev, mc->source,
> > > +                       "source", &mc->source_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       mc->proc_pads[0].flags = MEDIA_PAD_FL_SINK;
> > > +       mc->proc_pads[1].flags = MEDIA_PAD_FL_SOURCE;
> > > +       ret = rockchip_vpu_register_entity(mdev, &mc->proc,
> > > +                       "proc", mc->proc_pads, 2, function, vdev);
> > > +       if (ret)
> > > +               goto err_rel_entity0;
> > > +
> > > +       mc->sink_pad.flags = MEDIA_PAD_FL_SINK;
> > > +       ret = rockchip_vpu_register_entity(mdev, &mc->sink,
> > > +                       "sink", &mc->sink_pad, 1, MEDIA_ENT_F_IO_V4L, vdev);
> > > +       if (ret)
> > > +               goto err_rel_entity1;
> > > +
> > > +       /* Connect the three entities */
> > > +       ret = media_create_pad_link(mc->source, 0, &mc->proc, 1,
> > > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > > +       if (ret)
> > > +               goto err_rel_entity2;
> > > +
> > > +       ret = media_create_pad_link(&mc->proc, 0, &mc->sink, 0,
> > > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > > +       if (ret)
> > > +               goto err_rm_links0;
> > > +
> > > +       /* Create video interface */
> > > +       mc->intf_devnode = media_devnode_create(mdev,
> > > +                       MEDIA_INTF_T_V4L_VIDEO, 0,
> > > +                       VIDEO_MAJOR, vdev->minor);
> > > +       if (!mc->intf_devnode) {
> > > +               ret = -ENOMEM;
> > > +               goto err_rm_links1;
> > > +       }
> > > +
> > > +       /* Connect the two DMA engines to the interface */
> > > +       link = media_create_intf_link(mc->source,
> > > +                       &mc->intf_devnode->intf,
> > > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > > +       if (!link) {
> > > +               ret = -ENOMEM;
> > > +               goto err_rm_devnode;
> > > +       }
> > > +
> > > +       link = media_create_intf_link(&mc->sink,
> > > +                       &mc->intf_devnode->intf,
> > > +                       MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
> > > +       if (!link) {
> > > +               ret = -ENOMEM;
> > > +               goto err_rm_intf_link;
> > > +       }
> > > +       return 0;
> > > +
> > > +err_rm_intf_link:
> > > +       media_remove_intf_links(&mc->intf_devnode->intf);
> >
> > Do we need to explicitly remove the links here? The entity removal
> > functions remove the links implicitly.
> >
>
> You mean the media_devnode_remove, right? In that case, seems you are right.

Yep. And also media_device_unregister_entity().

Best regards,
Tomasz
