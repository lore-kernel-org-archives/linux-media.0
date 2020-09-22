Return-Path: <SRS0=5+7B=C7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F0C2D0E2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35ED72075E
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600766860;
	bh=VxFgH7Ev5rUGi3aRCl8C8jCW5freXl117SHPqM83i78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TdVkjdEY7LlpnH9lpQMhRNXjQyse6v4TmM3eyUE2SfBhOc2mmT2/r2I+bRIbhibXh
	 yfygDkjGaBnr6Dl/vLUnm1xAewQ5gyXkELdErKOKcTpTptn4TiJ9SkSEDtqTHsw7Z9
	 thkoo2wIwRdN2oDqvGmtbcLQ0hjoJo3w6aA8LChY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIVJ1g (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgIVJ1g (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 05:27:36 -0400
Received: from coco.lan (ip5f5ad5bc.dynamic.kabel-deutschland.de [95.90.213.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F67420BED;
        Tue, 22 Sep 2020 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600766856;
        bh=VxFgH7Ev5rUGi3aRCl8C8jCW5freXl117SHPqM83i78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SPr3dMqyGCY+VVlQoTe8XCBnE3dVciItQvAf7hxzeqpJNrME8+dvwKDcCSZ4okhfn
         JaP4nHSjzeKw3/VSZEFDpEC705UOPe91iyraLq6iHeBKxQnFcFOeZfrwjjaEHV+uE9
         /zNlNviWHM5AveopipKbPWa7DI5q09qdktRw4Blo=
Date:   Tue, 22 Sep 2020 11:27:29 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alan Cox <alan@linux.intel.com>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REBASE 0/3] atomisp: Rebased fixes
Message-ID: <20200922112729.313d454d@coco.lan>
In-Reply-To: <20200922090914.20702-1-alex.dewar90@gmail.com>
References: <21f18dc2-a1bc-0a37-0336-fc35170a40e9@gmail.com>
        <20200922090914.20702-1-alex.dewar90@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 22 Sep 2020 10:09:07 +0100
Alex Dewar <alex.dewar90@gmail.com> escreveu:

> Hi Mauro,
> 
> I've rebased the patches now, but there is a slight hiccup. For patches 2
> and 3 of this series there will now be a conflict with commit 9289cdf39992
> ("staging: media: atomisp: Convert to GPIO descriptors") in Greg's tree.
> 
> I'm not sure what the best way to handle this is? The merge conflicts
> will be trivial (due to a conversion between the gpio_* and gpiod_*
> APIs), but I could alternatively send these last two patches in via
> Greg's tree if that's easier for people. Let me know what works.

Maybe the best would be to re-send those after the merge window, when
both patches will arrive upstream.

Thanks,
Mauro
