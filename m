Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B2C47082
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 06:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7715613D6
	for <linux-media@archiver.kernel.org>; Wed, 26 May 2021 06:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhEZGo0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 26 May 2021 02:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhEZGoZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 26 May 2021 02:44:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E48EC613C3;
        Wed, 26 May 2021 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622011373;
        bh=lEpDCkdGFxeAtsrwix5D4X1FiG+U93Ll7WS12qIJF1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MA5ONux5V0tTneMn7Of6bbOMAxEYY3vkFYvARGb4wbTeAH5AJYidLmZxwSxg4fQLJ
         Lk9PQCjml2RMsDLy+iRyO8+y1vH6b36scZTH8HHMHDbW7qzvdKAF15vVfI1uHZatmI
         OTdye/DISGOOo5dLCpK4S0x/kRT/f3EzYtJYNF5U=
Date:   Wed, 26 May 2021 08:42:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     daniel@ffwll.ch, Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kernel-team@android.com, john.stultz@linaro.org, surenb@google.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] dmabuf: Add the capability to expose DMA-BUF stats in
 sysfs
Message-ID: <YK3t6+kOVSkGOuyb@kroah.com>
References: <20210525183720.1739480-1-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210525183720.1739480-1-hridya@google.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, May 25, 2021 at 11:37:13AM -0700, Hridya Valsaraju wrote:
> This patch allows statistics to be enabled for each DMA-BUF in
> sysfs by enabling the config CONFIG_DMABUF_SYSFS_STATS.
> 
> The following stats will be exposed by the interface:
> 
> /sys/kernel/dmabuf/buffers/<inode_number>/exporter_name
> /sys/kernel/dmabuf/buffers/<inode_number>/size
> /sys/kernel/dmabuf/buffers/<inode_number>/attachments/<attach_uid>/device
> /sys/kernel/dmabuf/buffers/<inode_number>/attachments/<attach_uid>/map_counter
> 
> The inode_number is unique for each DMA-BUF and was added earlier [1]
> in order to allow userspace to track DMA-BUF usage across different
> processes.
> 
> Currently, this information is exposed in
> /sys/kernel/debug/dma_buf/bufinfo.
> However, since debugfs is considered unsafe to be mounted in production,
> it is being duplicated in sysfs.
> 
> Procfs also uses the proc/<pid>/fdinfo/<fd> file to expose some
> information about DMA-BUF fds. However, the existing procfs interfaces
> can only provide information about the buffers for which processes
> hold fds or have the buffers mmapped into their address space.
> The sysfs interface also exposes attachment statistics for each buffer.
> 
> This information will be used to derive DMA-BUF
> per-exporter stats and per-device usage stats for Android Bug reports.
> The corresponding userspace changes can be found at [2].
> Telemetry tools will also capture this information(along with other
> memory metrics) periodically as well as on important events like a
> foreground app kill (which might have been triggered by Low Memory
> Killer). It will also contribute to provide a snapshot of the system
> memory usage on other events such as OOM kills and Application Not
> Responding events.
> 
> A shell script that can be run on a classic Linux environment to read
> out the DMA-BUF statistics can be found at [3](suggested by John
> Stultz).
> 
> The patch contains the following major improvements over v1:
> 1) Each attachment is represented by its own directory to allow creating
> a symlink to the importing device and to also provide room for future
> expansion.
> 2) The number of distinct mappings of each attachment is exposed in a
> separate file.
> 3) The per-buffer statistics are now in /sys/kernel/dmabuf/buffers
> inorder to make the interface expandable in future.
> 
> All of the improvements above are based on suggestions/feedback from
> Daniel Vetter and Christian König.
> 
> [1]: https://lore.kernel.org/patchwork/patch/1088791/
> [2]: https://android-review.googlesource.com/q/topic:%22dmabuf-sysfs%22+(status:open%20OR%20status:merged)
> [3]: https://android-review.googlesource.com/c/platform/system/memory/libmeminfo/+/1549734
> 
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
