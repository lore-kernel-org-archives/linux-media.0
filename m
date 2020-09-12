Return-Path: <SRS0=WE7C=CV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E0C43461
	for <linux-media@archiver.kernel.org>; Sat, 12 Sep 2020 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A732087C
	for <linux-media@archiver.kernel.org>; Sat, 12 Sep 2020 19:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgILTvv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 12 Sep 2020 15:51:51 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:39888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgILTvu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 12 Sep 2020 15:51:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1375E18225E17;
        Sat, 12 Sep 2020 19:51:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing39_1814c5f270fa
X-Filterd-Recvd-Size: 2043
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Sep 2020 19:51:45 +0000 (UTC)
Message-ID: <4bf9b441669e98fc2d055c063460c79175bdf685.camel@perches.com>
Subject: Re: [PATCH] media: vidtv: fix 32-bit warnings
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Date:   Sat, 12 Sep 2020 12:51:44 -0700
In-Reply-To: <008267108695f5cdf6744d861b2b6e5084bedfee.1599902564.git.mchehab+huawei@kernel.org>
References: <008267108695f5cdf6744d861b2b6e5084bedfee.1599902564.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sat, 2020-09-12 at 11:22 +0200, Mauro Carvalho Chehab wrote:
> There are several warnings produced when the driver is built
> for 32-bit archs. Solve them.
[]
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_common.c b/drivers/media/test-drivers/vidtv/vidtv_common.c
[]
> diff --git a/drivers/media/test-drivers/vidtv/vidtv_pes.c b/drivers/media/test-drivers/vidtv/vidtv_pes.c
[]
> @@ -91,13 +91,13 @@ static u32 vidtv_pes_write_pts_dts(struct pes_header_write_args args)
>  		return 0;
>  
>  	#ifdef __BIG_ENDIAN
> -	mask1 = GENMASK(30, 32);
> -	mask2 = GENMASK(15, 29);
> -	mask3 = GENMASK(0, 14);
> +	mask1 = GENMASK_ULL(30, 32);
> +	mask2 = GENMASK_ULL(15, 29);
> +	mask3 = GENMASK_ULL(0, 14);

These are broken as GENMASK_ULL takes arguments
in high then low order.

>  	#else
> -	mask1 = GENMASK(32, 30);
> -	mask2 = GENMASK(29, 15);
> -	mask3 = GENMASK(14, 0);
> +	mask1 = GENMASK_ULL(32, 30);
> +	mask2 = GENMASK_ULL(29, 15);
> +	mask3 = GENMASK_ULL(14, 0);
>  	#endif

The #ifdef can be removed instead.


