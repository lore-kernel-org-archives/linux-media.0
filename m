Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9252C433FE
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B5423D69
	for <linux-media@archiver.kernel.org>; Thu, 10 Dec 2020 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgLJKKN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgLJKKM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 10 Dec 2020 05:10:12 -0500
Date:   Thu, 10 Dec 2020 11:10:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607594972;
        bh=J7sv2iFrStp06XrBmboT+zD64Wiv3fsbAwBnnf2rAFs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=bh+goS4FrXP8/1kzLZDnLmQaoSt40yDsiBv/vec2SlhlXrPButujZB4EfKWJWFJQC
         GAFU/CVWCR6oknslGQ/DcIShKbeXC54JQqn328saa07awYE2Rzzq9sewvgYlzyh6Ic
         DC4j7g3W/LaqI33bDAcKBenlrJCsCLMeSflCicR8=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kernel-team@android.com, surenb@google.com, john.stultz@linaro.org
Subject: Re: [PATCH] dmabuf: Add the capability to expose DMA-BUF stats in
 sysfs
Message-ID: <X9H0JREcdxDsMtLX@kroah.com>
References: <20201210044400.1080308-1-hridya@google.com>
 <b5adfe46-8615-5821-d092-2b93feed5b79@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5adfe46-8615-5821-d092-2b93feed5b79@amd.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Dec 10, 2020 at 10:58:50AM +0100, Christian König wrote:
> In general a good idea, but I have a few concern/comments here.
> 
> Am 10.12.20 um 05:43 schrieb Hridya Valsaraju:
> > This patch allows statistics to be enabled for each DMA-BUF in
> > sysfs by enabling the config CONFIG_DMABUF_SYSFS_STATS.
> > 
> > The following stats will be exposed by the interface:
> > 
> > /sys/kernel/dmabuf/<inode_number>/exporter_name
> > /sys/kernel/dmabuf/<inode_number>/size
> > /sys/kernel/dmabuf/<inode_number>/dev_map_info
> > 
> > The inode_number is unique for each DMA-BUF and was added earlier [1]
> > in order to allow userspace to track DMA-BUF usage across different
> > processes.
> > 
> > Currently, this information is exposed in
> > /sys/kernel/debug/dma_buf/bufinfo.
> > However, since debugfs is considered unsafe to be mounted in production,
> > it is being duplicated in sysfs.
> 
> Mhm, this makes it part of the UAPI. What is the justification for this?
> 
> In other words do we really need those debug information in a production
> environment?

Production environments seem to want to know who is using up memory :)
