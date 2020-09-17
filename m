Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62BC433E2
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F032083B
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 07:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600327241;
	bh=cGR7Ut51zyLqgr7LZIC637tRgQYLhYGs8GRiX0vbHCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ApaXFtrDJft5DzSSFowk5DxxySg0Hm1R9mryXSnZ20F6tZj0OF4D/ih4jS+7bJX3T
	 u9zNpo6mqiA7URxIRbRqJx0/rs6YUOGte4BiHypdnKdb1YaRTiKPAL6w0FIcFL4vYo
	 sy8vsxd0Ja6vMvzN+RhU78pbayM4l9T9DRB4vGcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIQHUh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgIQHUc (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 03:20:32 -0400
Received: from coco.lan (ip5f5ad5d2.dynamic.kabel-deutschland.de [95.90.213.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CE82072E;
        Thu, 17 Sep 2020 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600327229;
        bh=cGR7Ut51zyLqgr7LZIC637tRgQYLhYGs8GRiX0vbHCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CeTWPfybY1e5B/MvRn7EcJfdpPsk8tyVGogFoFBp8W8QlpNZ6cvijSC16/GXMsucw
         ofb0ahkJ+8gipBlCN691ijerT8TjVXnhjz5Vd4dE6fJju1RFp0PpkVTjjS8pHweLPa
         dj2viqwW25AeTqpDaUmcFSeAeFfll5C0pvgOs0Es=
Date:   Thu, 17 Sep 2020 09:20:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [GIT FIXES FOR v5.9] Remove V4L2_FLAG_MEMORY_NON_CONSISTENT
 flag
Message-ID: <20200917092025.285f18a5@coco.lan>
In-Reply-To: <9347220a-a039-93ff-5dd7-f35613631a29@xs4all.nl>
References: <9347220a-a039-93ff-5dd7-f35613631a29@xs4all.nl>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 11 Sep 2020 12:52:57 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> From the commit log of the patch:
> 
> --------------------------------------------------------------------
> The patch partially reverts some of the UAPI bits of the buffer
> cache management hints. Namely, the queue consistency (memory
> coherency) user-space hint because, as it turned out, the kernel
> implementation of this feature was misusing DMA_ATTR_NON_CONSISTENT.
> 
> The patch revers both kernel and user space parts: removes the
> DMA consistency attr functions, rolls back changes to v4l2_requestbuffers,
> v4l2_create_buffers structures and corresponding UAPI functions
> (plus compat32 layer) and cleans up the documentation.
> --------------------------------------------------------------------
> 
> The intention is that this feature will return once proper low-level support
> for this has been sorted. A patch to revert the v4l-utils changes is ready
> to be merged once this patch made it's way to our master branch:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20200911030952.74468-1-sergey.senozhatsky@gmail.com/
> 
> I've tested this with the test-media script.
> 
> Regards,
> 
> 	Hans
> 
> The following changes since commit 93c16fabdb74a9c1a427402fc1fe588a45130c5b:
> 
>   media: ov8856: Add support for 3264x2448 mode (2020-09-10 14:29:35 +0200)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.9-mem
> 
> for you to fetch changes up to d36642b40255022dda1cfcaebe82e40a592d4ee8:
> 
>   media/v4l2: remove V4L2_FLAG_MEMORY_NON_CONSISTENT flag (2020-09-11 12:26:54 +0200)

This caused a warning when building the html books. Not sure why the robot
didn't warn. I'll be posting a fix at the ML.

Thanks,
Mauro
