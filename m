Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58052C10F0F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 14:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FF72186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 14:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfDEORc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:17:32 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55828 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEORc (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 10:17:32 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 6A5653C00C4;
        Fri,  5 Apr 2019 16:17:29 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4zLWnWOQXSGu; Fri,  5 Apr 2019 16:17:22 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id EFE753C00C3;
        Fri,  5 Apr 2019 16:17:21 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 5 Apr 2019
 16:17:21 +0200
Date:   Fri, 5 Apr 2019 16:17:18 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        <linux-media@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v14,29/33] rcar-vin: add link notify for Gen3
Message-ID: <20190405141718.GA19980@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180414115726.5075-30-niklas.soderlund+renesas@ragnatech.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

jFYI/FWIW, checking the functionality of rcar-vin using the
procedure/commands described in https://elinux.org/R-Car/Tests:rcar-vin
on the recent Linux commit ea2cec24c8d429ee6f99040e4eb6c7ad627fe777, I
consistently reproduce below lockdep splat [2] (full log and .config at
https://gist.github.com/erosca/67a46451b3cb342fa59b558022278fff).

Since the locking primitives of rvin_group_link_notify (popping up in
the log) haven't suffered changes since v4.18-rc1 commit [1], I conclude
this thread [0] might be an appropriate place for reporting the issue.

Best regards,
Eugeniu.

[0] https://patchwork.kernel.org/patch/10341183/ [v14,29/33] rcar-vin: add link notify for Gen3
[1] c0cc5aef31704c ("media: rcar-vin: add link notify for Gen3")
[2] media-ctl -l "'rcar_csi2 feaa0000.csi2':1 -> 'VIN0 output':0 [1]"

======================================================
WARNING: possible circular locking dependency detected
5.1.0-rc3+ #27 Tainted: G        W        
------------------------------------------------------
media-ctl/2407 is trying to acquire lock:
00000000be992082 (&group->lock){+.+.}, at: rvin_group_link_notify+0xc4/0x4f4

but task is already holding lock:
0000000064693a2a (&mdev->graph_mutex){+.+.}, at: media_device_ioctl+0x1f8/0x2b8

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&mdev->graph_mutex){+.+.}:
       lock_acquire+0x144/0x39c
       __mutex_lock+0xe8/0xb54
       mutex_lock_nested+0x3c/0x4c
       media_device_register_entity+0x15c/0x308
       v4l2_device_register_subdev+0x1c8/0x288
       v4l2_async_match_notify+0x3c/0x200
       v4l2_async_notifier_try_all_subdevs+0xb8/0xc0
       __v4l2_async_notifier_register+0xac/0x214
       v4l2_async_notifier_register+0x68/0x80
       rcar_vin_probe+0x8d8/0xa0c
       platform_drv_probe+0x70/0xe4
       really_probe+0x2d8/0x3d8
       driver_probe_device+0x154/0x164
       device_driver_attach+0x98/0xa0
       __driver_attach+0xf0/0xf4
       bus_for_each_dev+0x114/0x13c
       driver_attach+0x38/0x44
       bus_add_driver+0x234/0x288
       driver_register+0x148/0x190
       __platform_driver_register+0x84/0x90
       rcar_vin_driver_init+0x20/0x28
       do_one_initcall+0x124/0x68c
       kernel_init_freeable+0xa5c/0xa60
       kernel_init+0x18/0x134
       ret_from_fork+0x10/0x18

-> #1 (list_lock){+.+.}:
       lock_acquire+0x144/0x39c
       __mutex_lock+0xe8/0xb54
       mutex_lock_nested+0x3c/0x4c
       v4l2_async_notifier_add_subdev+0x3c/0xdc
       __v4l2_async_notifier_parse_fwnode_ep+0x240/0x2b8
       v4l2_async_notifier_parse_fwnode_endpoints_by_port+0x4c/0x60
       rcar_vin_probe+0x858/0xa0c
       platform_drv_probe+0x70/0xe4
       really_probe+0x2d8/0x3d8
       driver_probe_device+0x154/0x164
       device_driver_attach+0x98/0xa0
       __driver_attach+0xf0/0xf4
       bus_for_each_dev+0x114/0x13c
       driver_attach+0x38/0x44
       bus_add_driver+0x234/0x288
       driver_register+0x148/0x190
       __platform_driver_register+0x84/0x90
       rcar_vin_driver_init+0x20/0x28
       do_one_initcall+0x124/0x68c
       kernel_init_freeable+0xa5c/0xa60
       kernel_init+0x18/0x134
       ret_from_fork+0x10/0x18

-> #0 (&group->lock){+.+.}:
       __lock_acquire+0x1c7c/0x1dd0
       lock_acquire+0x144/0x39c
       __mutex_lock+0xe8/0xb54
       mutex_lock_nested+0x3c/0x4c
       rvin_group_link_notify+0xc4/0x4f4
       __media_entity_setup_link+0x238/0x2f0
       media_device_setup_link+0x114/0x11c
       media_device_ioctl+0x21c/0x2b8
       __media_ioctl+0x78/0x84
       media_ioctl+0x58/0x68
       vfs_ioctl+0x68/0x78
       do_vfs_ioctl+0x134/0xbfc
       ksys_ioctl+0x68/0x98
       __arm64_sys_ioctl+0x4c/0x60
       el0_svc_common+0xd0/0x16c
       el0_svc_handler+0x94/0xa0
       el0_svc+0x8/0xc

other info that might help us debug this:

Chain exists of:
  &group->lock --> list_lock --> &mdev->graph_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mdev->graph_mutex);
                               lock(list_lock);
                               lock(&mdev->graph_mutex);
  lock(&group->lock);

 *** DEADLOCK ***

1 lock held by media-ctl/2407:
 #0: 0000000064693a2a (&mdev->graph_mutex){+.+.}, at: media_device_ioctl+0x1f8/0x2b8

stack backtrace:
CPU: 0 PID: 2407 Comm: media-ctl Tainted: G        W         5.1.0-rc3+ #27
Hardware name: Renesas Salvator-X board based on r8a7795 ES2.0+ (DT)
Call trace:
 dump_backtrace+0x0/0x1c0
 show_stack+0x24/0x30
 dump_stack+0xcc/0x128
 print_circular_bug.isra.16+0x22c/0x364
 check_prev_add.constprop.25+0x35c/0x1098
 __lock_acquire+0x1c7c/0x1dd0
 lock_acquire+0x144/0x39c
 __mutex_lock+0xe8/0xb54
 mutex_lock_nested+0x3c/0x4c
 rvin_group_link_notify+0xc4/0x4f4
 __media_entity_setup_link+0x238/0x2f0
 media_device_setup_link+0x114/0x11c
 media_device_ioctl+0x21c/0x2b8
 __media_ioctl+0x78/0x84
 media_ioctl+0x58/0x68
 vfs_ioctl+0x68/0x78
 do_vfs_ioctl+0x134/0xbfc
 ksys_ioctl+0x68/0x98
 __arm64_sys_ioctl+0x4c/0x60
 el0_svc_common+0xd0/0x16c
 el0_svc_handler+0x94/0xa0
 el0_svc+0x8/0xc
