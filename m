Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A380C433E0
	for <linux-media@archiver.kernel.org>; Mon,  1 Mar 2021 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE45164E41
	for <linux-media@archiver.kernel.org>; Mon,  1 Mar 2021 12:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhCAMnk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:43:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235105AbhCAMni (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Mar 2021 07:43:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7ECE64E31;
        Mon,  1 Mar 2021 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614602577;
        bh=dkHBbBE+JY13Jb5tzmDmGMXEzWaZdXecvhBxHseKjcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RD50p5cN9MF2AnyITW08DvxoHm1Dq5jphMR9sn3nZuC0ggKZdt2AvoR6IZZqC2gZS
         eumrea+n2N4hsDphhXpQ4Vdzge4TCfzcyTNIO36InzNFJUXnz8X3Iq3b716mrj6tBb
         wBI2MrSQMe2+vB2a8DEeonoTfXDop11rG+Z5fWJCc32bSzwdrW3OCbzxnbI4fDvdGI
         S6rtSwKU67xAzJRjqK06+JjQlkVg5cUsJ7muDLRH+rGKkSEWz/DzQ17mf3CiB9ioVu
         Y+pg+FJI2bYOZKDm/qsUk3xS06xxkPmjXut4PR4uDUz4re6XT7dyjhX0tJOPuAyzZD
         FKJlj0WbY7DdA==
Date:   Mon, 1 Mar 2021 13:42:52 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: add a subsystem profile documentation
Message-ID: <20210301134252.3d165cce@coco.lan>
In-Reply-To: <20210301103133.GK3@valkosipuli.retiisi.eu>
References: <bbe8dc3119b21317616535b7062811968a89b85e.1614591312.git.mchehab+huawei@kernel.org>
        <20210301103133.GK3@valkosipuli.retiisi.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 1 Mar 2021 12:31:34 +0200
Sakari Ailus <sakari.ailus@iki.fi> escreveu:

> > +Sensor drivers:
> > +  Sakari Ailus <sakari.ailus@linux.intel.com>  
> 
> Could you add me:
> 
> v4l2-async, v4l2-fwnode, v4l2-flash-led-class.

Adding in v5:

	v4l2-async, v4l2-fwnode, v4l2-flash-led-class and Sensor drivers:
	  Sakari Ailus <sakari.ailus@linux.intel.com>


> 
> ISP drivers are generally complicated; I wonder if it should be me, Laurent
> and Hans. It'd be nice to add ISPs, too.

Not sure how to add ISP. I mean, we're actually splitting the drivers
per API usage. Probably the main part of mapping an ISP into V4L would
be as codec drivers, but other drivers could be doing something else.

Suggestions?


> 

> If the order is reversed, that could be expressed fairly neatly.


Thanks,
Mauro
