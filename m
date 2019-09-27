Return-Path: <SRS0=mTxV=XW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43112C4360C
	for <linux-media@archiver.kernel.org>; Fri, 27 Sep 2019 11:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125BD21848
	for <linux-media@archiver.kernel.org>; Fri, 27 Sep 2019 11:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfI0Le5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:34:57 -0400
Received: from retiisi.org.uk ([95.216.213.190]:58418 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfI0Le5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Sep 2019 07:34:57 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id CE9BA634C87;
        Fri, 27 Sep 2019 14:34:49 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1iDoWO-0000Qm-AL; Fri, 27 Sep 2019 14:34:48 +0300
Date:   Fri, 27 Sep 2019 14:34:48 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [RFC PATCH] media: rename VFL_TYPE_GRABBER to _VIDEO
Message-ID: <20190927113448.GH896@valkosipuli.retiisi.org.uk>
References: <54111b26-b5ff-6b4c-e13e-933180cd13f9@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54111b26-b5ff-6b4c-e13e-933180cd13f9@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On Thu, Sep 26, 2019 at 08:58:27AM +0200, Hans Verkuil wrote:
> We currently have the following devnode types:
> 
> enum vfl_devnode_type {
>         VFL_TYPE_GRABBER        = 0,
>         VFL_TYPE_VBI,
>         VFL_TYPE_RADIO,
>         VFL_TYPE_SUBDEV,
>         VFL_TYPE_SDR,
>         VFL_TYPE_TOUCH,
>         VFL_TYPE_MAX /* Shall be the last one */
> };
> 
> They all make sense, except for the first: GRABBER really refers to /dev/videoX
> devices, which can be capture, output or m2m, so 'grabber' doesn't even refer to
> their function anymore.
> 
> Let's call a spade a spade and rename this to VFL_TYPE_VIDEO.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> This patch converts the core files. If others are OK with this, then I can post
> a full series that also converts all drivers that use it (very easy search-and-replace)
> and finally remove the old GRABBER enum.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
