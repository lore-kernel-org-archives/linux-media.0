Return-Path: <SRS0=DyX0=UX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17184C43613
	for <linux-media@archiver.kernel.org>; Mon, 24 Jun 2019 12:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4731205F4
	for <linux-media@archiver.kernel.org>; Mon, 24 Jun 2019 12:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfFXMfu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:35:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:14694 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfFXMfu (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Jun 2019 08:35:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 05:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="336491091"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 05:35:47 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id D030E2056B; Mon, 24 Jun 2019 15:35:46 +0300 (EEST)
Date:   Mon, 24 Jun 2019 15:35:46 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, hverkuil@xs4all.nl
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainers for Media Controller
Message-ID: <20190624123546.xhrd4kwizbzrl6pc@paasikivi.fi.intel.com>
References: <20190620141753.15983-1-sakari.ailus@linux.intel.com>
 <20190620141955.GF5720@pendragon.ideasonboard.com>
 <20190624093012.3a1b5101@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624093012.3a1b5101@coco.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On Mon, Jun 24, 2019 at 09:30:12AM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 20 Jun 2019 17:19:55 +0300
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> 
> > Hi Sakari,
> > 
> > Thank you for the patch.
> > 
> > On Thu, Jun 20, 2019 at 05:17:53PM +0300, Sakari Ailus wrote:
> > > When Media Controller was merged to mainline long, long time ago, no-one
> > > bothered to think what its MAINTAINERS entry should be. Now that Media
> > > Controller is moved into its own directory, address this at the same time.
> > > 
> > > So tell people to mail patches to myself and Laurent Pinchart.
> > > 
> > > Note that the patches are still merged through the Media tree, just like
> > > any other driver or framework bits that have separate "mail patches to"
> > > entries different from the main drivers/media one.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>  
> > 
> > This will help me catching changes to the media controller, and being
> > more active on reviews, so I welcome that change.
> 
> Ok, but please notice that this is a core part of the subsystem, and
> not a driver one.
> 
> So, you should be sure that you'll have enough bandwidth to not
> get patches accumulated here for no more than a reasonable time
> (a couple of weeks).
> 
> If both you and Sakari are ok with that, I'll pick it.

I already do review MC patches (at least as long as I've noticed the
patches myself, I believed a few have slipped past my eyes over the years),
so this isn't really adding to my workload.

So to answer the question, yes, I've prepared to do this.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
