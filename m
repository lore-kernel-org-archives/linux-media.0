Return-Path: <SRS0=2MZP=AZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CCC433E7
	for <linux-media@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10CF20760
	for <linux-media@archiver.kernel.org>; Tue, 14 Jul 2020 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594734674;
	bh=AsJ/I2RJLvfz8A+sQ6DL4Bg36aA+bxlxgzqzMKU0rD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzGHI55oiws/2Gpfm3LuScn6fLXhOVf6nGCvHbVkIcw64Mju2k2viqbrEW+6j51uV
	 XigW8XIrUtMHBH7aYntJ477saYIgPYG066wTy9nkx0SqoYweGTDQko/pW8nwfNeDQh
	 BgDjA11b8xJWFxuvpGd2c3H+AFe8EvwDKVskWv20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGNNvL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgGNNvK (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Jul 2020 09:51:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE97F20760;
        Tue, 14 Jul 2020 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594734670;
        bh=AsJ/I2RJLvfz8A+sQ6DL4Bg36aA+bxlxgzqzMKU0rD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cifSuM6Q23ORTqYIYC5ayBNI5ZspEDh6iIyRf/F267+G1l8i8nrTy1U095oSlAoAN
         V2syaf4G9XwBVHtQJkoD5SAd0ledwjxdtj31uFF0pL0X0lfOXazBGMzlA4NWEmh53U
         QOJoWXeU0iA4DNKqYqmuU9YMI3TwveGYbGvI2OgM=
Date:   Tue, 14 Jul 2020 15:51:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: staging: media: atomisp: pci: css_2401_system:
 host: csi_rx.c: fixed a sparse warning by making undeclared symbols static
Message-ID: <20200714135108.GA1698833@kroah.com>
References: <20200714132350.naekk4zqivpuaedi@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714132350.naekk4zqivpuaedi@pesu-pes-edu>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Jul 14, 2020 at 09:23:50AM -0400, B K Karthik wrote:
> changed symbols N_SHORT_PACKET_LUT_ENTRIES, N_LONG_PACKET_ENTRIES,
> N_CSI_RX_FE_CTRL_DLANES, N_CSI_RX_BE_SID_WIDTH to static because they
> were not declared earlier.

Your subject line is a little bit crazy long.  Perhaps just:
	staging: media: atomisp: mark some csi_rx.c symbols static
?

thanks,

greg k-h
