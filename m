Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B32EC433DB
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 21:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C284723120
	for <linux-media@archiver.kernel.org>; Wed,  6 Jan 2021 21:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAFVSc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:18:32 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:57798 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbhAFVSc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 Jan 2021 16:18:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D782D100E7B45;
        Wed,  6 Jan 2021 21:17:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: love44_6310349274e4
X-Filterd-Recvd-Size: 2444
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Jan 2021 21:17:49 +0000 (UTC)
Message-ID: <c5781c80a582cc68e1ae1bdc106c50cb263f81bf.camel@perches.com>
Subject: Re: [PATCH] media: atomisp: ov2722: replace hardcoded function name
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Filip Kolev <fil.kolev@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date:   Wed, 06 Jan 2021 13:17:47 -0800
In-Reply-To: <20210106193633.GK2809@kadam>
References: <20210105202945.26913-1-fil.kolev@gmail.com>
         <X/VsF364jpGz6oze@kroah.com>
         <dcdda829-89d6-badd-4f22-72d95d24e9e3@gmail.com>
         <X/X45909l1Tk7Bni@kroah.com>
         <c9284a7f1443146b3885e8ceae3dcf113c531a36.camel@perches.com>
         <20210106193633.GK2809@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, 2021-01-06 at 22:36 +0300, Dan Carpenter wrote:
> On Wed, Jan 06, 2021 at 10:25:26AM -0800, Joe Perches wrote:
> > On Wed, 2021-01-06 at 18:52 +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 06, 2021 at 07:43:42PM +0200, Filip Kolev wrote: 
> > > > On 06-Jan-21 09:51, Greg Kroah-Hartman wrote:
> > > > > On Tue, Jan 05, 2021 at 10:29:18PM +0200, Filip Kolev wrote:
> > > > > > There is a debug message using hardcoded function name instead of the
> > > > > > __func__ macro. Replace it.
> > > > > > 
> > > > > > Report from checkpatch.pl on the file:
> > > > > > 
> > > > > > WARNING: Prefer using '"%s...", __func__' to using 'ov2722_remove', this function's name, in a string
> > > > > > +	dev_dbg(&client->dev, "ov2722_remove...\n");
[]
> > There are quite a lot of these relatively useless function tracing like
> > uses in the kernel:
> > 
> > $ git grep -P '"%s[\.\!]*\\n"\s*,\s*__func__\s*\)' | wc -l
> > 1065
> 
> These are printing other stuff besides just the function name.

No, these are printing _only_ the function name.

> Maybe grep for '", __func__\)'?

No, that wouldn't work as there are many many uses like:

	printk('%s: some string\n", __func__);


