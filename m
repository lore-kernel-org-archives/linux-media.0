Return-Path: <SRS0=oTdG=5K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC19C43331
	for <linux-media@archiver.kernel.org>; Wed, 25 Mar 2020 10:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E1B2078A
	for <linux-media@archiver.kernel.org>; Wed, 25 Mar 2020 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585130731;
	bh=nJwc46UoKsBYS1sNnl8QXdrd03hFSDdM/unfYLTUv40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oNKUAyvEEYHQEIanxrO3p/ktD2N407JmzpxwP0hxSxXdFN7+fSyj5QQ1nlZZCdSZJ
	 IUZcw+R+XcdOObmdGYU6WtU8nxJ4flpV2DqtrzPsx7LX4MWkQQy8/uv8eRHG0xqkrW
	 xRHs3EuFCgEylBi7MGO9sgbYwaA3pSolUB1U9du8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYKFb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgCYKFb (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Mar 2020 06:05:31 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA26D2077D;
        Wed, 25 Mar 2020 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585130730;
        bh=nJwc46UoKsBYS1sNnl8QXdrd03hFSDdM/unfYLTUv40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JvxSXNnPkAJWWixi9+FasM3KzDzSJELFD3SfhHBZYjhhunyihrqhFITOMeVvC2IhA
         GkUpvnVjA0jiK8vzpBZX2P3dm/BcbtQzGHUzoyF8DaVPHSpVrhpRmPsNv1sd4JXY0o
         wZifjykHuZTP10EF04N/3beGVwXr1FEb8BSfsYZc=
Date:   Wed, 25 Mar 2020 11:05:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>, Mike Isely <isely@pobox.com>
Subject: Re: [PATCH v3 22/22] media: Kconfig: better support hybrid TV
 devices
Message-ID: <20200325110524.433ef745@coco.lan>
In-Reply-To: <dc2d32af44bc03620bde14fc3c3ea5f9bde5530d.1585129041.git.mchehab+huawei@kernel.org>
References: <cover.1585129041.git.mchehab+huawei@kernel.org>
        <dc2d32af44bc03620bde14fc3c3ea5f9bde5530d.1585129041.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Wed, 25 Mar 2020 10:49:36 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Right now, if one has an hybrid TV card, it has to select
> both analog and digital TV support, as otherwise the needed
> core support won't be selected.
> 
> Change the logic to auto-select the core support for those
> drivers, as this is a way more intuitive.
> 
> It should be noticed that, as now both DVB_CORE and VIDEO_DEV
> defaults depends on selecting a hybrid cards, we had to remove
> the explicit dependencies there, in order to avoid circular
> dependencies. In order to get it right, we used a little trick,
> to ensure that the core will be built as "y" if any driver
> was built with "y".
> 
> Note: while here, moved two pure V4L2 PCI drivers out of the
> "hybrid" part of config and consider pvrusb2 as an hybrid
> device.

Found some issues on this patch. Please ignore it.

I'm trying to see if are there any other way of doing that
without incurring into circular dependencies nor allowing
errors at build time or warnings at make menuconfig time.

I remember I tried to do something like that in the past,
but the dependency chain is too complex.

Suggestions are welcomed.

Regards,
Mauro
