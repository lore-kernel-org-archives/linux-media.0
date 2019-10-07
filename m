Return-Path: <SRS0=+Pgr=YA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC9C47404
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB12067B
	for <linux-media@archiver.kernel.org>; Mon,  7 Oct 2019 16:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJGQeI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:34:08 -0400
Received: from muru.com ([72.249.23.125]:35666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGQeI (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 7 Oct 2019 12:34:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5653C80A5;
        Mon,  7 Oct 2019 16:34:41 +0000 (UTC)
Date:   Mon, 7 Oct 2019 09:34:04 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Michael Allwright <allsey87@gmail.com>
Cc:     Michael Allwright <michael.allwright@upb.de>,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH RFC] DT support for omap4-iss
Message-ID: <20191007163404.GZ5607@atomide.com>
References: <CALcgO_6UXp-Xqwim8WpLXz7XWAEpejipR7JNQc0TdH0ETL4JYQ@mail.gmail.com>
 <20190628110441.42gdqidkg5csuxai@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628110441.42gdqidkg5csuxai@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

* Sakari Ailus <sakari.ailus@iki.fi> [190628 11:05]:
> Hi Michael,
> 
> On Mon, Aug 10, 2015 at 05:16:30PM +0200, Michael Allwright wrote:
> > Hi All,
> > 
> > The following PRELIMINARY patch adds DT support to the OMAP4 ISS. It
> > also fixes some problems a have found along the way. It is tightly
> > modelled after the omap3-isp media platform driver. This patch is a
> > work in progress as I would like feedback. It contains debugging
> > messages that need to be removed, as well as disgusting abuses of the
> > C language as required (i.e. clk_core_fake and clk_fake).
> 
> We'd like to restart the effort adding DT support for this driver. Would
> you be able to, if not address the comments, at least resend your old patch
> with your Signed-off-by: line so we could make use of what you've already
> done?

I think this email no longer works for Michael? Adding another
one from commit at [0] below.

Michael, care to email that patch to the lists with your
Signed-off-by so Sakari can use it? Or at least reply with
your Signed-off-by to this thread :)

Regards,

Tony

[0] https://github.com/allsey87/meta-builderbot/blob/master/recipes-kernel/linux/linux-stable-4.16/0008-omap4iss-Fix-multiple-bugs-and-use-device-tree.patch
