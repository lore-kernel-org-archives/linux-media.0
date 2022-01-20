Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A125C4332F
	for <linux-media@archiver.kernel.org>; Thu, 20 Jan 2022 07:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiATHuK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:50:10 -0500
Received: from verein.lst.de ([213.95.11.211]:43353 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbiATHuJ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 20 Jan 2022 02:50:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F36368AFE; Thu, 20 Jan 2022 08:50:05 +0100 (CET)
Date:   Thu, 20 Jan 2022 08:50:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christoph Hellwig <hch@lst.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2-dma-contig: Invalidate vmap range
 before DMA range
Message-ID: <20220120075005.GA4737@lst.de>
References: <20220119081417.20604-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119081417.20604-1-senozhatsky@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
