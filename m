Return-Path: <SRS0=sOwM=XP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A77C49ED7
	for <linux-media@archiver.kernel.org>; Fri, 20 Sep 2019 05:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CAC2086A
	for <linux-media@archiver.kernel.org>; Fri, 20 Sep 2019 05:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392287AbfITFaO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:30:14 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:48132 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390482AbfITFaN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 20 Sep 2019 01:30:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C534080422AC;
        Fri, 20 Sep 2019 05:30:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: honey36_3b89e0c6eb21c
X-Filterd-Recvd-Size: 3226
Received: from [10.10.16.41] (unknown [113.161.206.70])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Sep 2019 05:30:08 +0000 (UTC)
Message-ID: <cfbe9a092f60f1ce5d1fb3ab5260dd56193bd8fb.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH] media: add a subsystem profile
 documentation
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Date:   Thu, 19 Sep 2019 22:29:33 -0700
In-Reply-To: <20190919070856.GG2959@kadam>
References: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
         <434c05bddd2b364e607e565227487910a8dd9793.1568391461.git.mchehab+samsung@kernel.org>
         <20190918123620.GA6306@pendragon.ideasonboard.com>
         <20190918105728.24e7eb48@coco.lan>
         <20190918172705.GC4734@pendragon.ideasonboard.com>
         <20190918154831.3dd0d040@coco.lan> <20190919070856.GG2959@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2019-09-19 at 10:08 +0300, Dan Carpenter wrote:
> On Wed, Sep 18, 2019 at 03:48:31PM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 18 Sep 2019 20:27:05 +0300
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> > 
> > > > Anyway, not sure if the other sub-maintainers see the same way. From my side,
> > > > I prefer not to be c/c, as this is just more noise, as I just rely on
> > > > patchwork for media patches. What about changing this to:
> > > > 
> > > > 	Patches for the media subsystem should be sent to the media mailing list
> > > > 	at linux-media@vger.kernel.org as plain text only e-mail. Emails with
> > > > 	HTML will be automatically rejected by the mail server. It could be wise 
> > > > 	to also copy the sub-maintainer(s).  
> > > 
> > > That works for me. As this is really a personal preference, is there a
> > > way it could be encoded in MAINTAINERS in a per-person fashion ?
> > > Something that would allow you to opt-out from CC from linux-media (but
> > > possibly opt-in for other parts of the kernel), and allow me to opt-in
> > > for the drivers I maintain ?
> > 
> > I don't think so. Perhaps we could add, instead, something like that at the
> > sub-maintainers section of the profile.
> 
> Of course there is a way to add yourself as a maintainer for a specific
> .c file...  Maybe people feel like MAINTAINERS is too crowded?
> 
> We could update get_maintainer.pl to grep the .c files for a specific
> tag instead of putting everything in a centralized MAINTAINERS file.

Another option is to split the MAINTAINERS file into multiple
distributed files.  get_maintainer.pl already supports that.

https://lwn.net/Articles/730509/
https://lore.kernel.org/lkml/1501350403.5368.65.camel@perches.com/

> But it doesn't make sense to try store that information MY BRAIN!  I
> can't remember anything from one minute to the next so I have no idea
> who maintains media submodules...

Nor I.  Nor should I have to.


