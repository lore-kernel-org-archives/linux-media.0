Return-Path: <SRS0=u2Sz=TG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C9EC04AAD
	for <linux-media@archiver.kernel.org>; Mon,  6 May 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A520830
	for <linux-media@archiver.kernel.org>; Mon,  6 May 2019 19:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mAg8m7rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfEFTuX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 May 2019 15:50:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46284 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfEFTuX (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 May 2019 15:50:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so8596748qkb.13
        for <linux-media@vger.kernel.org>; Mon, 06 May 2019 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=mAg8m7rSPAxM5D+1qNjO71dhsXUrQSGF8zaXxmrvN1W1e7B7fEhL/nFNC4QmlTH5S/
         9FjLthJrMSnJTSlBNmAzOuj+WEEEHBw1j3jchmVO404WkT8GTT4n4WekZCWvQcvu4KOF
         mx0V5cfxdymPVb2Ruxoza7w5KItB51NAJ5xivBL7H4fj5rRig8CXPXI75f55CKvkZyYC
         Gs093sJb6bHKcKo1jSkGyp2Pk8c68+e+QijlfKiUVNZuBsCjguF+Uc/8jtTaC+sffP6g
         22gO2vicgInFZL3gRZwFvB6M65AQIPZr/G+9s6iQjRuVRTS6fQK5LrCRIMT4SjvjNieX
         MViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESsJ96JGC0CvnjgihpL/0kogE+VQksbbiyHqcPsgGyM=;
        b=D4t2T75DEepze+tCJMnFHUwDnZVG8Fh90vryaq/dO6b4QcR2owkC02bmIJjoVm867Z
         OPkowl2u7VsHEyBhhXP7g1uytNSoTGMBvXeGzxbEC4yIwHE832tOEOFZ6rNASjCBgRx2
         Vjz/EfkumA0ayl/U/1C6824YgHkHmV/zIwPMMeeDsgOskz4UsXJaImVAohr8vtfg/xtj
         mrDwf2aPca0uokf4en15O5GgAE9aYf4gCYjWRCkrUBDPWWOIjEa+RaZ5Z12Cco3RbkmK
         Hs2OvRwiVb+SPrzAJNiOfT/vcgvGAjLHeIqsnfZFmEEAG93umunjoQgKTJJZ5Zz82E83
         YWeA==
X-Gm-Message-State: APjAAAUPnIZf/kbAsl2MGLcF4wXcaxNDjQvI2XSsC4rVzcY9MjB7fw9t
        NLsZN9TRaIJ1N30oSIvhbB473A==
X-Google-Smtp-Source: APXvYqweK3T+QR6CpnWc0KpWvE878/YztoCohPUsZDawCWkz4P9i6ckWrJvxSZLqhWTPckszjgD1bg==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr10803976qkj.34.1557172222493;
        Mon, 06 May 2019 12:50:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o44sm9303175qto.36.2019.05.06.12.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:50:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNjcy-0007kq-Cs; Mon, 06 May 2019 16:50:20 -0300
Date:   Mon, 6 May 2019 16:50:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 13/17] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190506195020.GD6201@ziepe.ca>
References: <cover.1557160186.git.andreyknvl@google.com>
 <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, May 06, 2019 at 06:30:59PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> 
> Untag user pointers in these functions.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)

I think this is OK.. We should really get it tested though.. Leon?

Jason
