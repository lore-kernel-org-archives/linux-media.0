Return-Path: <SRS0=ZgJ+=6E=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE36C3815B
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DC620857
	for <linux-media@archiver.kernel.org>; Mon, 20 Apr 2020 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587411490;
	bh=st5ryvnuuzHW/y5jQcD6ktJkLyF7FZY29U4HdlKnUxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPUe7vLUIilmaslNdyEXqjvJpeJx+bbP3ppgxabA5UGc7eXzWU1oAwJN6/+/d3KFp
	 C9DUrS0qaARGFKITFNIQBb3FdeFxOUQAxMN2sA96AFUpHVVEcNlJ+6P+ZbfHczek7B
	 joBjEONuy6fcESE0k8yFoQHOVsjFfbhpLNHRfhGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTTiK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTTiK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 20 Apr 2020 15:38:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FC920782;
        Mon, 20 Apr 2020 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587411489;
        bh=st5ryvnuuzHW/y5jQcD6ktJkLyF7FZY29U4HdlKnUxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2wD1wB3o85g4p18KfuQgQ3nh5QvCYEtTG0WYpX2GAGyHlT6o9hYsCH9TMSUvirVCH
         NtzWAtFykY9kByx0zNIJvrMTE+0mik2BW1te8Ol1bf0wRVpyOz8//ClGC0CwkfIjpC
         9O07/3WEqn3OTereZBM+G5I0mN7USdlnCHZyGqV4=
Date:   Mon, 20 Apr 2020 21:38:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        YueHaibing <yuehaibing@huawei.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] media: usbvision: depends on USB
Message-ID: <20200420193806.GB300350@kroah.com>
References: <a0ed60978af23b398d128d1075a7961ef57f0694.1587401420.git.mchehab+huawei@kernel.org>
 <7034ba29-035c-6f0b-e553-68a369e8aaf8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7034ba29-035c-6f0b-e553-68a369e8aaf8@infradead.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 20, 2020 at 10:41:28AM -0700, Randy Dunlap wrote:
> On 4/20/20 9:50 AM, Mauro Carvalho Chehab wrote:
> > When built with:
> > 	CONFIG_USB=m
> > 	CONFIG_VIDEO_USBVISION=y
> > 
> > It causes ld errors:
> > 
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_write_reg_irq':
> > usbvision-core.c:(.text+0x8a4): undefined reference to `usb_submit_urb'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_isoc_irq':
> > usbvision-core.c:(.text+0x2ee8): undefined reference to `usb_submit_urb'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_read_reg':
> > usbvision-core.c:(.text+0x30ad): undefined reference to `usb_control_msg'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_write_reg':
> > usbvision-core.c:(.text+0x3178): undefined reference to `usb_control_msg'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_output':
> > usbvision-core.c:(.text+0x344e): undefined reference to `usb_control_msg'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_input':
> > usbvision-core.c:(.text+0x3b9b): undefined reference to `usb_control_msg'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_setup':
> > usbvision-core.c:(.text+0x4009): undefined reference to `usb_control_msg'
> > ld: drivers/staging/media/usbvision/usbvision-core.o:usbvision-core.c:(.text+0x417f): more undefined references to `usb_control_msg' follow
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_set_alternate':
> > usbvision-core.c:(.text+0x4518): undefined reference to `usb_set_interface'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_init_isoc':
> > usbvision-core.c:(.text+0x4673): undefined reference to `usb_alloc_urb'
> > ld: usbvision-core.c:(.text+0x46a5): undefined reference to `usb_alloc_coherent'
> > ld: usbvision-core.c:(.text+0x4765): undefined reference to `usb_submit_urb'
> > ld: drivers/staging/media/usbvision/usbvision-core.o: in function `usbvision_stop_isoc':
> > usbvision-core.c:(.text+0x4837): undefined reference to `usb_kill_urb'
> > ld: usbvision-core.c:(.text+0x485f): undefined reference to `usb_free_coherent'
> > ld: usbvision-core.c:(.text+0x4874): undefined reference to `usb_free_urb'
> > ld: usbvision-core.c:(.text+0x48f1): undefined reference to `usb_set_interface'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_release':
> > usbvision-video.c:(.text+0x1a8a): undefined reference to `usb_free_urb'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_disconnect':
> > usbvision-video.c:(.text+0x1b74): undefined reference to `usb_put_dev'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_radio_close':
> > usbvision-video.c:(.text+0x1c89): undefined reference to `usb_set_interface'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_probe':
> > usbvision-video.c:(.text+0x1e4b): undefined reference to `usb_get_dev'
> > ld: usbvision-video.c:(.text+0x20e1): undefined reference to `usb_alloc_urb'
> > ld: usbvision-video.c:(.text+0x2797): undefined reference to `usb_put_dev'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_exit':
> > usbvision-video.c:(.exit.text+0x37): undefined reference to `usb_deregister'
> > ld: drivers/staging/media/usbvision/usbvision-video.o: in function `usbvision_init':
> > usbvision-video.c:(.init.text+0xf9): undefined reference to `usb_register_driver'
> > ld: drivers/staging/media/usbvision/usbvision-i2c.o: in function `usbvision_i2c_write':
> > usbvision-i2c.c:(.text+0x2f4): undefined reference to `usb_control_msg'
> > 
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
