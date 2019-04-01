Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F6C4360F
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4820870
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDAMcZ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:32:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:37771 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDAMcZ (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 08:32:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 05:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="287685985"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2019 05:32:22 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 20FE1206EA; Mon,  1 Apr 2019 15:32:21 +0300 (EEST)
Date:   Mon, 1 Apr 2019 15:32:21 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 00/31] v4l: add support for multiplexed streams
Message-ID: <20190401123220.slp7wooyjspmsmre@paasikivi.fi.intel.com>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
 <20190329011707.2m2mgckmlxj3edby@kekkonen.localdomain>
 <20190329083251.3otgywm573dd4lir@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329083251.3otgywm573dd4lir@uno.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Mar 29, 2019 at 09:32:51AM +0100, Jacopo Mondi wrote:
> Hi Sakari,
> 
> On Fri, Mar 29, 2019 at 03:17:11AM +0200, Sakari Ailus wrote:
> > Hi Jacopo,
> >
> > On Thu, Mar 28, 2019 at 09:05:37PM +0100, Jacopo Mondi wrote:
> > > Hello,
> > >    new iteration of multiplexed stream support patch series.
> > >
> > > V3 available at:
> > > https://patchwork.kernel.org/cover/10839889/
> > >
> > > V2 sent by Niklas is available at:
> > > https://patchwork.kernel.org/cover/10573817/
> > >
> > > Series available at:
> > > git://jmondi.org/linux v4l2-mux/media-master/v4
> > >
> > > Few changes compared to v3:
> > > - Rebased on latest media master
> > > - Include Sakari's and Luca's comments on documentation patch
> > > - Improve connected pad operator as suggested by Ian and Sakari
> > > - Fix a bogus -EINVAL return in 31/31 as suggested by Sakari
> > > - Improve adv748x afe has_route as suggested by Luca and Sakari
> > > - Closed some checkpatch warnings (there are still a few though)
> >
> > Thank you for working on this.
> >
> > I still need to read the documentation tomorrow, but this begins to look
> > like material for merging. Your SoB seems to be missing from the patches
> > you haven't written. Shouldn't it be there?
> 
> Should it? As "someone in the patch deliery path" (quoting
> submitting-patches.rst) I probably should. I didn't as Niklas didn't
> do that in v2, but I can add it to v5.
> 
> Thanks for pointing it out!

It's basically telling that the patch has passed through your hands, so I
think it should be there. No need to resend for that IMO though.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
