Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1EC4332F
	for <linux-media@archiver.kernel.org>; Mon,  6 Nov 2023 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjKFMZM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjKFMZL (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Nov 2023 07:25:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C097
        for <linux-media@vger.kernel.org>; Mon,  6 Nov 2023 04:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699273508; x=1730809508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMjeIr7i7Orp5vpe8NGQuH2OiKNIrjurrFfov2J5Pj8=;
  b=OtkKKkhi8TSBC2p9sWO+tvS3voi64TBv/8EC9tvfwWk5AfznYoN9NJsM
   QofyKXqBp2i2Jt/nQP6XA6jtRR3jir9lECb5GmLNne1SXmngbg3Kgw9SC
   LdYl1S0rD4tX0FOA5Ah1zhbh0q0d+owhKxTS5zuYYkOgS+jBEduhwJcNJ
   mGT2PiNprQLqodi3XIdZja3ErsvZGnlHHK2iUfypS/ZwO9rvqmoOpsROt
   0+0opIoFdyM/u5UGkSbbkiU6A7ofJ9FIroxe/delG8+2QNy9xQduRWHzK
   C5aSllj6xeQvJTeg8kPgNbLmrLgC2pCcJdMR0eBYJl82rnN6Avvhw0Zns
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="374292130"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="374292130"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="906042107"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="906042107"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:25:05 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 413E211F724;
        Mon,  6 Nov 2023 14:25:03 +0200 (EET)
Date:   Mon, 6 Nov 2023 12:25:03 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        tomi.valkeinen@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        bingbu.cao@intel.com, hongju.wang@intel.com,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH v6 0/8] Unify sub-device state access functions
Message-ID: <ZUjbH5AFW0CoIvJ9@kekkonen.localdomain>
References: <20231106121805.1266696-1-sakari.ailus@linux.intel.com>
 <20231106122109.GC16995@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106122109.GC16995@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent,

On Mon, Nov 06, 2023 at 02:21:09PM +0200, Laurent Pinchart wrote:
> On Mon, Nov 06, 2023 at 02:17:57PM +0200, Sakari Ailus wrote:
> > Hi folks,
> > 
> > This set unifies historical and stream-aware sub-device state access
> > functions into one set of functions called
> > v4l2_subdev_state_get_{format,crop,compose}. No functional change is
> > intended.
> > 
> > This happened after Tomi suggested adding a num_pads field to struct
> > v4l2_subdev_state.
> > 
> > I'd like to merge these somewhat soon, assuming there's a rough consensus
> > on them, as this is a fairly hot set, touching 136 files.
> 
> All patches have been reviewed, so I think the consensus is there.
> 
> Could you please push this to a branch that the 0-day bot tracks ? The
> series touches many drivers, so it would be good to give the bot a week
> to compile-test different configurations.

I'm about to push this my git.linuxtv.org tree master branch. Just did
final checks before doing so... and hence we have v6.

-- 
Sakari Ailus
