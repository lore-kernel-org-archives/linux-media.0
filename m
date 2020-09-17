Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1AC433E2
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 10:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9799420678
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIQKZt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 06:25:49 -0400
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:43960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726730AbgIQKZr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 06:25:47 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 06:25:46 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 97A0F800B209
        for <linux-media@vger.kernel.org>; Thu, 17 Sep 2020 10:20:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 43966100E7B45;
        Thu, 17 Sep 2020 10:19:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: seed75_0f0fa9e27121
X-Filterd-Recvd-Size: 1757
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Sep 2020 10:19:23 +0000 (UTC)
Message-ID: <8274e9166ad6f7c95f0885403b9584081672a3ff.camel@perches.com>
Subject: Re: [RFC PATCH] Add bridge driver to connect sensors to CIO2 device
 via software nodes on ACPI platforms
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>
Cc:     yong.zhi@intel.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, davem@davemloft.net, robh@kernel.org,
        devel@driverdev.osuosl.org, jorhand@linux.microsoft.com,
        kieran.bingham@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kitakar@gmail.com
Date:   Thu, 17 Sep 2020 03:19:21 -0700
In-Reply-To: <20200917093407.GK4282@kadam>
References: <20200916213618.8003-1-djrscally@gmail.com>
         <20200917093407.GK4282@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, 2020-09-17 at 12:34 +0300, Dan Carpenter wrote:
> On Wed, Sep 16, 2020 at 10:36:18PM +0100, Daniel Scally wrote:
> > diff --git a/drivers/staging/media/ipu3/cio2-bridge.c b/drivers/staging/media/ipu3/cio2-bridge.c
[]
> > +		if (!dev->driver_data) {
> > +			pr_info("ACPI match for %s, but it has no driver\n",
> > +				supported_devices[i]);
> 
> put_device(dev);
> 
> > +			continue;
> > +		} else {

No need for an else either.

> > +			pr_info("Found supported device %s\n",
> > +				supported_devices[i]);

so this can be unindented too.


