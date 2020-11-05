Return-Path: <SRS0=XB3O=EL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A855FC00A89
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B6A20756
	for <linux-media@archiver.kernel.org>; Thu,  5 Nov 2020 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604580835;
	bh=Xo08oFlDR6VuFzXpK4Xn5bMeyapeJHlddCAWV7RlCpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ex7sO9l0eOiaNRh3NzBu3CAJR8Qn49pYMyt9JrP2GpagNXgD6eeYJ4gi4PdDvX+d2
	 WtvZZ91eERNODI16VfKpI5RUe41nUfqH4lha0E/kogvdFqh6VTrUnbcRym1W5AHAar
	 2TvPJUl59BMpzJ6fRXJ2bSfKXlyN/Mym7WiMipOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgKEMxy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:53:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKEMxy (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 5 Nov 2020 07:53:54 -0500
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FF820756;
        Thu,  5 Nov 2020 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604580833;
        bh=Xo08oFlDR6VuFzXpK4Xn5bMeyapeJHlddCAWV7RlCpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qI56511fKnVuhaXVxMLq3L1orihQh1eBsDa04+7Oa00y8P3IjIMXhbTacKHJMOJox
         I54pjdGtvnoqXLiUW6NXzC8pCK+wO+lLzGIjNUjF7WRGKvjeT2/M/ZGt/TjAz4f0vi
         wfQPU9tg5uKTNX1NKXb7tIChrY0GsvPI6BhNEuCM=
Date:   Thu, 5 Nov 2020 13:53:50 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH v2 033/106] ccs: Add CCS static data parser library
Message-ID: <20201105135350.6fbfe79a@coco.lan>
In-Reply-To: <20201105111807.GB26150@paasikivi.fi.intel.com>
References: <20201007084505.25761-1-sakari.ailus@linux.intel.com>
        <20201007084557.25843-1-sakari.ailus@linux.intel.com>
        <20201007084557.25843-26-sakari.ailus@linux.intel.com>
        <20201105115032.53381197@coco.lan>
        <20201105111807.GB26150@paasikivi.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 5 Nov 2020 13:18:07 +0200
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> Hi Mauro,
> 
> Thanks for the review.
> 
> On Thu, Nov 05, 2020 at 11:50:32AM +0100, Mauro Carvalho Chehab wrote:
> 
> ...
> 
> > > +struct __ccs_data_block_end {
> > > +	uint8_t crc[4];
> > > +} __attribute__((packed));
> > > +
> > > +#endif /* __CCS_DATA_DEFS_H__ */  
> > 
> > Nitpick: why all the above struct/enums start with "__"?  
> 
> We have two sets of data structure: those that are related to the binary
> file format (these, so they're packed) as well as the in-kernel
> representation. So I've used the underscores to designate these are the
> binary format ones. They're only used in ccs-data.c.
> 

Ok for me, but, IMHO, you should document it somewhere about such
convention.

Thanks,
Mauro
