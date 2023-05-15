Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8257EC7EE24
	for <linux-media@archiver.kernel.org>; Mon, 15 May 2023 06:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjEOG5t (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 May 2023 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbjEOG5c (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 May 2023 02:57:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D61C30D8;
        Sun, 14 May 2023 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133783; x=1715669783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2s/sQUrgk3zH2BjViwKh9Ia0HIryBCXLFC30hNYcXq4=;
  b=TXfrif3v3w8x5mammNTK55vAiKfWj6ulvg4oftbDDhTjGink/DvXpRyf
   GDyD84YiX52K1iQ/vHYm+D569va9gHrlBIRgqWCiMw/KQOQFu+4wRliP7
   Hq00mpdcxN/kRBEzV0H/9AiH+tu8ovyybWbYXeEq1jV6B3cdYR8D7eCgH
   ceboKZVrvfqi0fFeJ6UhruvI6E/KG0Dg7kmFHxBuu8ku3UIchmqXJG/QJ
   QHn/rUojH0mRmjBGXyvYgbuLVfPCIMTPZsDAFpA2q4jp9ZlyMIfdyuIcJ
   i2TxFHRfGNhm+nDD2KUAXu38bU6R6h03hDP/C4cwNLL+0N+oW+P3frazn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="331497689"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="331497689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="812831530"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="812831530"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:54:46 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 92E74120279;
        Mon, 15 May 2023 09:54:43 +0300 (EEST)
Date:   Mon, 15 May 2023 06:54:43 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev.h: document client_caps at struct
 v4l2_subdev_fh
Message-ID: <ZGHXM8dtTxBPzVUM@kekkonen.localdomain>
References: <382ce82fe2b186c7d8067d8b4e945a947c7c7047.1684130460.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382ce82fe2b186c7d8067d8b4e945a947c7c7047.1684130460.git.mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On Mon, May 15, 2023 at 07:01:11AM +0100, Mauro Carvalho Chehab wrote:
> Gets rid of this documentation warning:
> 
> 	./include/media/v4l2-subdev.h:1130: warning: Function parameter or member 'client_caps' not described in 'v4l2_subdev_fh'
> 
> By adding a documentation about such new field.
> 
> Fixes: f57fa2959244 ("media: v4l2-subdev: Add new ioctl for client capabilities")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Tomi has sent a patch for this which I'm planning to include in my next PR:

<URL:https://lore.kernel.org/linux-media/20230418105924.126608-1-tomi.valkeinen@ideasonboard.com/#t>

-- 
Regards,

Sakari Ailus
