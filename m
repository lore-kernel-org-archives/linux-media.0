Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D12DC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67E12186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfDELRM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:17:12 -0400
Received: from retiisi.org.uk ([95.216.213.190]:40872 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730596AbfDELRM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 07:17:12 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 6783A634C7D;
        Fri,  5 Apr 2019 14:16:26 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hCMpf-0001mN-6v; Fri, 05 Apr 2019 14:16:27 +0300
Date:   Fri, 5 Apr 2019 14:16:27 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 0/9] Rework V4L2 fwnode parsing; add defaults and avoid
 iteration
Message-ID: <20190405111627.atbgsefad4gktlpp@valkosipuli.retiisi.org.uk>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 05, 2019 at 12:41:17PM +0300, Sakari Ailus wrote:
> - Add another patch to change fwnode refcounting for
>   v4l2_async_notifier_add_fwnode_subdev
> 
> - Add a patch to fix OF node refcounting and use / put order for
>   davinci-vpif

If you wondered why does adding two patches to an 8-patch set makes a
9-patch set, the explanation is that another patch got dropped: "[RFC 3/8]
v4l2-fwnode: Use v4l2_async_notifier_add_fwnode_remote_subdev". The
parse_endpoint() may use information from async sub-device filled by the
same function.

-- 
Sakari Ailus
