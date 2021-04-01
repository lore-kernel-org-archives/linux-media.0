Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41673C4363F
	for <linux-media@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F4B60FEF
	for <linux-media@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhDASRq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhDASJj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 1 Apr 2021 14:09:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE31C0225A9;
        Thu,  1 Apr 2021 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=miloN6DGw1sq8TwRfQqBfE3nU1vq3X8oB+icH0CHsp8=; b=ih5mRSpb3Oj6LJUx+Ph6Z6FA+B
        VMfYDwEsuVumiZWxiEz7wgQAlhLEGqEsDVz7leYoL9HqW94qxnvzAi8pzK3zNxCZ27faXCsIAE4Io
        lCI6eiYrHkkWanKTjaNUbEuXRE14U4i+KLJLX1RtUnbBtHARwh0fMmDCFOfm/GJ+7FTaZCOdw/a2h
        C24cvu70+OFvDA3OiGBgV/apvynx3MdNmBLMNkK3w7womxDmjxwwUlRlLYUHMbL3FixGSAdvhuTF3
        +8DJSuphaZHfc5zUktTD8SJM8AV9/GfPSt3epB7J9HlhZBy9CYU4acRqL+YRdhD+MJSxOxbGpokm2
        8mCmwhvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRzGX-006IJe-F0; Thu, 01 Apr 2021 15:29:51 +0000
Date:   Thu, 1 Apr 2021 16:29:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 2/2] staging: media: omap4iss: align
 arguments with open parenthesis
Message-ID: <20210401152949.GG351017@casper.infradead.org>
References: <cover.1617287509.git.martinsdecarvalhobeatriz@gmail.com>
 <475dbbe5774cbfed2d924807d8a3cfeb84b3d845.1617287509.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475dbbe5774cbfed2d924807d8a3cfeb84b3d845.1617287509.git.martinsdecarvalhobeatriz@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Apr 01, 2021 at 04:07:39PM +0100, Beatriz Martins de Carvalho wrote:
>  		subdev = v4l2_i2c_new_subdev_board(&iss->v4l2_dev, adapter,
> -				board_info->board_info, NULL);
> +						   board_info->board_info, NULL);

Also not a readability improvement.  This checkpatch warning should
be disregarded.
