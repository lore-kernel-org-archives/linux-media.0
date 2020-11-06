Return-Path: <SRS0=vajg=EM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F2C55178
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 22:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A65720882
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604702906;
	bh=Oj1ydksyNqQ3ZwyWkWH+O74qkDDreoYI/9+2rwNutow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yQlUW6unr2FT/sjfMCr14CludV0J5ir39T3oj/CUqhUaEQaUORfsQSEkX+KutIUUP
	 iSqQbOj2YTc6/GVfTyeJd6U66FT0H+A3yi8Yl64gl5um7bf/aNH6tJGgjJ1aq9SFt9
	 FN221vq//N49OMqA4RLubzzCs+8ZBfLuBtN3rHT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgKFWsX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgKFWsN (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 6 Nov 2020 17:48:13 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9578E2087E;
        Fri,  6 Nov 2020 22:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604702893;
        bh=Oj1ydksyNqQ3ZwyWkWH+O74qkDDreoYI/9+2rwNutow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GgJzvJbYnUHZVh/KVjPbUkpsfTIS+ixIdR5hDbc8e6O11e3cdgusrJ+SXHU1mNK02
         T1pf6Ysk+sGbT7IeHtbS79IjEOVb10BsqWj7Z/BpfjH8Hjsl5L51bZ3setY8WJNtnr
         JcdIhGHQmomXcxD8lLvJYy+d8B/elDLs+I2TO9iQ=
Date:   Fri, 6 Nov 2020 14:48:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?ISO-8859-1?Q? "Christian_K=F6nig" ?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: mmap: fix fput in error path v2
Message-Id: <20201106144811.cf228ca9278ec78887d42960@linux-foundation.org>
In-Reply-To: <20201106114806.46015-2-christian.koenig@amd.com>
References: <20201106114806.46015-1-christian.koenig@amd.com>
        <20201106114806.46015-2-christian.koenig@amd.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri,  6 Nov 2020 12:48:05 +0100 "Christian K=F6nig" <ckoenig.leichtzumer=
ken@gmail.com> wrote:

> Patch "495c10cc1c0c CHROMIUM: dma-buf: restore args..."
> adds a workaround for a bug in mmap_region.
>=20
> As the comment states ->mmap() callback can change
> vma->vm_file and so we might call fput() on the wrong file.
>=20
> Revert the workaround and proper fix this in mmap_region.
>=20

Seems correct, best I can tell.  Presumably all ->mmap() instances will
correctly fput() to original file* if they're rewriting vma->vm_file.



