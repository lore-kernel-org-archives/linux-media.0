Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED47C3E8A3
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 01:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF864206B6
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 01:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfC2BR3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:17:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:49764 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfC2BR3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 21:17:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 18:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="144789748"
Received: from mgherza1-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.249.45.3])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Mar 2019 18:17:26 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 70BAC21E50; Fri, 29 Mar 2019 03:17:11 +0200 (EET)
Date:   Fri, 29 Mar 2019 03:17:11 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 00/31] v4l: add support for multiplexed streams
Message-ID: <20190329011707.2m2mgckmlxj3edby@kekkonen.localdomain>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On Thu, Mar 28, 2019 at 09:05:37PM +0100, Jacopo Mondi wrote:
> Hello,
>    new iteration of multiplexed stream support patch series.
> 
> V3 available at:
> https://patchwork.kernel.org/cover/10839889/
> 
> V2 sent by Niklas is available at:
> https://patchwork.kernel.org/cover/10573817/
> 
> Series available at:
> git://jmondi.org/linux v4l2-mux/media-master/v4
> 
> Few changes compared to v3:
> - Rebased on latest media master
> - Include Sakari's and Luca's comments on documentation patch
> - Improve connected pad operator as suggested by Ian and Sakari
> - Fix a bogus -EINVAL return in 31/31 as suggested by Sakari
> - Improve adv748x afe has_route as suggested by Luca and Sakari
> - Closed some checkpatch warnings (there are still a few though)

Thank you for working on this.

I still need to read the documentation tomorrow, but this begins to look
like material for merging. Your SoB seems to be missing from the patches
you haven't written. Shouldn't it be there?

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
