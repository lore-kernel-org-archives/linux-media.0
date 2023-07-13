Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A59C001DC
	for <linux-media@archiver.kernel.org>; Thu, 13 Jul 2023 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjGMT1M (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMT1L (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Jul 2023 15:27:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA619BA;
        Thu, 13 Jul 2023 12:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5613561B2F;
        Thu, 13 Jul 2023 19:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665A6C433C8;
        Thu, 13 Jul 2023 19:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689276429;
        bh=D+OEaUWIThFo6Y+wPON7lvU8a9EaVxkzBStXyg9idHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjZnBGryNjyq2+WPsBVvobxZ6GGKMV/bpFqhHQd1qffzIJBoC9ztdoJxYL9iNotib
         EbBNOtSfDftwdrxjzNHzodTcRR4DCF9kIV9dCfVIeRbhZUGbEoU5Oy1sQ1yGLfPD14
         kl8jJuDHtqSAVJIeiVH0902x23QMX1HcPAVngMGs=
Date:   Thu, 13 Jul 2023 21:27:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        John Stultz <jstultz@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Message-ID: <2023071344-skinhead-send-33f7@gregkh>
References: <20230713191316.116019-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713191316.116019-1-afd@ti.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jul 13, 2023 at 02:13:16PM -0500, Andrew Davis wrote:
> +int sram_add_dma_heap(struct sram_dev *sram,
> +		      struct sram_reserve *block,
> +		      phys_addr_t start,
> +		      struct sram_partition *part)
> +{
> +	struct sram_dma_heap *sram_dma_heap;
> +	struct dma_heap_export_info exp_info;
> +
> +	dev_info(sram->dev, "Exporting SRAM Heap '%s'\n", block->label);

When drivers are working properly, they are quiet.

thanks,

greg k-h
