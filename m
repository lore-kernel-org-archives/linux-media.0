Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D8C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258B62186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfDELe3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:34:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:41815 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfDELe3 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 07:34:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 04:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,312,1549958400"; 
   d="scan'208";a="161701771"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2019 04:34:27 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 859DB2080B; Fri,  5 Apr 2019 14:34:26 +0300 (EEST)
Date:   Fri, 5 Apr 2019 14:34:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ian Arkver <ian.arkver.dev@gmail.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/9] davinci-vpif: Fix endpoint refcounting
Message-ID: <20190405113422.4fnrp23wdtubno6m@paasikivi.fi.intel.com>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
 <20190405094127.18975-3-sakari.ailus@linux.intel.com>
 <d38e015e-0177-194b-4275-fcd7ac22ef23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38e015e-0177-194b-4275-fcd7ac22ef23@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ian,

On Fri, Apr 05, 2019 at 12:30:07PM +0100, Ian Arkver wrote:
> Hi Sakari,
> 
> My mail client at least is showing two versions of patch [1/9] with
> different commit messages but (I think) the same content.

Thanks for spotting this. I used the same output directory for git
format-patch after changing the commit message. Oh well.

The other one is what I intended to send; please ignore this one.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
