Return-Path: <SRS0=ILh3=DN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D2C47095
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 18:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A65206F7
	for <linux-media@archiver.kernel.org>; Tue,  6 Oct 2020 18:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgJFSNj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:13:39 -0400
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:44622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgJFSNi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 6 Oct 2020 14:13:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C308F837F24D;
        Tue,  6 Oct 2020 18:13:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light72_11076f4271c8
X-Filterd-Recvd-Size: 1709
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 18:13:35 +0000 (UTC)
Message-ID: <9a065558a24de42395d1175798f05272b07311c2.camel@perches.com>
Subject: Re: [PATCH 2/2] media: staging: atomisp: Removed else branch in
 function
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leonid Kushnir <leonf008@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org
Date:   Tue, 06 Oct 2020 11:13:34 -0700
In-Reply-To: <20201006180410.GH4282@kadam>
References: <20201006081721.GA35979@linux> <20201006180410.GH4282@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2020-10-06 at 21:04 +0300, Dan Carpenter wrote:
> Code should generally do "error handling" instead of "success handling".

Maybe something to add to coding-style
(in '6} Functions' maybe?)...

> That way the success path is always indented one tab and the error path
> is indented two tabs.  I like to say that the call and the error handling
> are part of the same thing, but with success handling, it's like
> do the call, do more stuff, go back to the error handling from the
> earlier call.
[]
> Anyway, TLDR, please write it like this:
> 
> 	if (on == 0)
>  		return power_down(sd);
> 
> 	ret = power_up(sd);
> 	if (ret)
> 		return ret;
> 
> 	return gc0310_init(sd);

Much nicer, thanks for taking the time to write it.



