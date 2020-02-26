Return-Path: <SRS0=hlfS=4O=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE6C4BA09
	for <linux-media@archiver.kernel.org>; Wed, 26 Feb 2020 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E500720732
	for <linux-media@archiver.kernel.org>; Wed, 26 Feb 2020 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582682064;
	bh=LuY1aImj6PEVlETfQcjlClopOVm/sK8P/ZzP4XBR+/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TdQPJVa15DoqwLxOSNXZBbNxUbArO5HJ7PqWYcfkoR55tvKQ3256bB2LXCNTnPdp2
	 c+LgrtXb5PMOZhMfLsaZuD8lBxFUFUEgQHIWSr8RHsZRkxj6rdBcz6sRm+T75rY1TH
	 w9cvjot3VvT71g6MsoIZ78mJh2P3h0ovfu7u2oA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgBZByU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbgBZByT (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 25 Feb 2020 20:54:19 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CAE820732;
        Wed, 26 Feb 2020 01:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582682059;
        bh=LuY1aImj6PEVlETfQcjlClopOVm/sK8P/ZzP4XBR+/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EE9BrAeaUKw0b4AC+J+IaooQvru8TwnlXy/gE1MLEOsM2l9haCbFKp1H23KixzFY3
         qFZTSOWbbcYB2IvvP5Gl/FEPR+o1e43H7tl+T4iFmxNK+9xKLkKpcSlkomJ3ddkASf
         8FQ7bZZqJb8EXIna6OyFsxxWDTWN+StwgpKDTOvI=
Date:   Tue, 25 Feb 2020 17:54:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com,
        Chenbo Feng <fengc@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] dma-buf: free dmabuf->name in dma_buf_release()
Message-Id: <20200225175418.2d3af2180cbf895b727ce4b1@linux-foundation.org>
In-Reply-To: <20200225204446.11378-1-xiyou.wangcong@gmail.com>
References: <20200225204446.11378-1-xiyou.wangcong@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 25 Feb 2020 12:44:46 -0800 Cong Wang <xiyou.wangcong@gmail.com> wrote:

> dma-buff name can be set via DMA_BUF_SET_NAME ioctl, but once set
> it never gets freed.
> 
> Free it in dma_buf_release().
> 
> ...
>
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -108,6 +108,7 @@ static int dma_buf_release(struct inode *inode, struct file *file)
>  		dma_resv_fini(dmabuf->resv);
>  
>  	module_put(dmabuf->owner);
> +	kfree(dmabuf->name);
>  	kfree(dmabuf);
>  	return 0;
>  }

ow.  Is that ioctl privileged?
