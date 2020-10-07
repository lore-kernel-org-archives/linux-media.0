Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C30C4727E
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8ED62173E
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 17:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dz0OOWtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgJGRjN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 13:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgJGRjN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 13:39:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5BC0613D3
        for <linux-media@vger.kernel.org>; Wed,  7 Oct 2020 10:39:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so3785452qkd.9
        for <linux-media@vger.kernel.org>; Wed, 07 Oct 2020 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=muCEajJ6hDOPl6eL85j4HlmJ9WtV9zWU+bfCV/Cq9BI=;
        b=Dz0OOWtV09rElfhUKte1coDG1XmH70sU+t7XSvzch8QKv+JqccAMRzt3CfP44+/AfQ
         BSOmkO0/4DojdkfFvQXoQgyy0jQhFfYLuGtSpIEzw2ZgOz60sA9Vk6P6Joyx8mLM7oVI
         GulM3GKMb4JRE2TKQ53Eo7+b0LYA9pmvGiN/xhtwvUGDgP8zpeZiK3xp1njllpvHZ6s7
         +zEZsvi99NmVaNYy4acbivpnVkuHyfeEWt1WrvUqBOOC668uWgAj9EFU3nanuKQfFrvC
         NI/B5LDgDV7l6mq+xucfE4i5Vmh8E5S9NLZXdlnDCI7i7X4L/RR/AAH2/qqGFU9zUkKq
         IF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=muCEajJ6hDOPl6eL85j4HlmJ9WtV9zWU+bfCV/Cq9BI=;
        b=b4EOp1lRsRSI3jzmptbdHnupwRn4rjJiAgitInPO3TjtIBQxRdg0vqRIQtEv3azAdp
         dKFn8Krfo+P/Jzs54CrFb8QFE5n6aLFIdv2Oifhn+RSHRzmUqNwxZL/MYcKu/XytIh8H
         Rw+8/k+KnxJ4QenAipQgUIkawuPuZp9b/gLOB7Zhngdb+Zfx2n0qMaXQohhrCjGfSind
         gncpLN2N7yD/AVDj/IV7j2lMLHzrWRkt7nNVho2r+SBCjt21ENTw466BJqcC/yOEvP74
         mhV01v5qgrvYWv3QMdvtD9EVz51EJ7K2ShRpQrTIN056PrCXAhSxSwjjBpuWrkQglrw1
         jGpg==
X-Gm-Message-State: AOAM533d77ew2ynVukCR9BEDGwXFU+5AEkKyNDj8gR3eF0D+k62rkph+
        BwGxqRNFJ6UrWLIFqDF+G6q2dQ==
X-Google-Smtp-Source: ABdhPJwRH/CX2FYRARUgG1+mzIa/QuVNWzg4jQoHZB7NOT97+fmtc0eat9IRh9q/mSpxChFc0Hp56Q==
X-Received: by 2002:a05:620a:54f:: with SMTP id o15mr3905794qko.91.1602092352650;
        Wed, 07 Oct 2020 10:39:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d14sm2013598qtr.62.2020.10.07.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 10:39:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQDPD-00112O-7o; Wed, 07 Oct 2020 14:39:11 -0300
Date:   Wed, 7 Oct 2020 14:39:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 13/13] vfio/type1: Mark follow_pfn as unsafe
Message-ID: <20201007173911.GX5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007164426.1812530-14-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Oct 07, 2020 at 06:44:26PM +0200, Daniel Vetter wrote:
> The code seems to stuff these pfns into iommu pts (or something like
> that, I didn't follow), but there's no mmu_notifier to ensure that
> access is synchronized with pte updates.
> 
> Hence mark these as unsafe. This means that with
> CONFIG_STRICT_FOLLOW_PFN, these will be rejected.
> 
> Real fix is to wire up an mmu_notifier ... somehow. Probably means any
> invalidate is a fatal fault for this vfio device, but then this
> shouldn't ever happen if userspace is reasonable.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> ---
>  drivers/vfio/vfio_iommu_type1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5fbf0c1f7433..a4d53f3d0a35 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -421,7 +421,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  {
>  	int ret;
>  
> -	ret = follow_pfn(vma, vaddr, pfn);
> +	ret = unsafe_follow_pfn(vma, vaddr, pfn);
>  	if (ret) {
>  		bool unlocked = false;
>  
> @@ -435,7 +435,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
>  		if (ret)
>  			return ret;
>  
> -		ret = follow_pfn(vma, vaddr, pfn);
> +		ret = unsafe_follow_pfn(vma, vaddr, pfn);
>  	}

This is actually being commonly used, so it needs fixing.

When I talked to Alex about this last we had worked out a patch series
that adds a test on vm_ops that the vma came from vfio in the first
place. The VMA's created by VFIO are 'safe' as the PTEs are never changed.

Jason
