Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EC0C433E0
	for <linux-media@archiver.kernel.org>; Thu, 11 Mar 2021 18:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A2664FD4
	for <linux-media@archiver.kernel.org>; Thu, 11 Mar 2021 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCKSkl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:40:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39902 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCKSjQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Mar 2021 13:39:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id D57E41F465DA
Message-ID: <777c3525dc495e75eb612a72b16522c417c9c50e.camel@collabora.com>
Subject: Re: [RFC PATCH] v4l2-controls.h: rename _MPEG_ to _CODEC_
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Thu, 11 Mar 2021 15:39:09 -0300
In-Reply-To: <b9b7133f-3fc7-6076-074e-ba4dafbd359e@xs4all.nl>
References: <b9b7133f-3fc7-6076-074e-ba4dafbd359e@xs4all.nl>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On Tue, 2021-03-09 at 09:35 +0100, Hans Verkuil wrote:
> The first codec that was supported in V4L2 was the MPEG codec.
> As a result of that all codec controls and related data structures
> where all prefixed with MPEG. This is confusing and in fact makes
> it hard to find the MPEG-specific controls since all controls have
> 'MPEG' in their name.
> 
> This patch renames all controls and data structures to use CODEC
> instead of MPEG, and adds defines for compatibility at the end.
> 
> Eventually those compatibility defines would come under #ifndef __KERNEL__
> to ensure that the kernel code can't use those anymore, but that can
> only be done once the use of the old names has been removed from the
> kernel.
> 
> This patch has no functional changes, only renames and the addition
> of compatibility defines at the end.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> Would this be acceptable? I really hate the old names, that was a
> lack of foresight at my end when I created them :-(
> 

The current names are indeed confusing, doubly so as it is
exposed to applications.

Getting rid of these, shows that the subsystem is not haunted
by historical choices, that don't make sense anymore, so seems
a good idea, and worth the trouble IMO.

And indeed distinguishing CODEC-specific from MPEG-specific controls
will be less painful.

> If this rename action is supported, then I can turn this in a proper
> patch series that renames the code in the drivers and documentation
> as well.

Would be great to script the change.

Thanks,
Ezequiel

