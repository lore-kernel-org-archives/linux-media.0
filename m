Return-Path: <SRS0=741g=XS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C2C4CECF
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E514A20820
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 16:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfIWQEU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:04:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:51616 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbfIWQEU (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Sep 2019 12:04:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 705AE30A;
        Mon, 23 Sep 2019 16:04:17 +0000 (UTC)
Date:   Mon, 23 Sep 2019 10:04:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH] media: add a subsystem profile
 documentation
Message-ID: <20190923100411.418bf449@lwn.net>
In-Reply-To: <CAD=FV=XNys5BbzrYNnNFSEXOTUGD1LBxJHeuv8YHCcHmRQs28A@mail.gmail.com>
References: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
        <434c05bddd2b364e607e565227487910a8dd9793.1568391461.git.mchehab+samsung@kernel.org>
        <20190918123620.GA6306@pendragon.ideasonboard.com>
        <20190918105728.24e7eb48@coco.lan>
        <20190919065447.GF2959@kadam>
        <CAMuHMdU10J5zgQ0r8uoA+LFHRbyLB=AG6xygTmsxwc7T-ffdDw@mail.gmail.com>
        <20190920145352.GI12950@pendragon.ideasonboard.com>
        <CAD=FV=UjTT04pOf3q3H+ZdG9ixr6RWaRJfNs2Dk7xTTEMi-=xw@mail.gmail.com>
        <87k1a2yqmx.fsf@intel.com>
        <CAD=FV=XNys5BbzrYNnNFSEXOTUGD1LBxJHeuv8YHCcHmRQs28A@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 23 Sep 2019 08:58:28 -0700
Doug Anderson <dianders@chromium.org> wrote:

> I swear that I was involved in a conversation in the past where
> someone suggested to stop CCing LKML on patches and Jonathan Corbet
> jumped in and said that he supported CCing LKML on all patches.

I don't *think* I said that, I have no particular reason to argue for
doing that...?  There are people out there who feel that absolutely
everything needs to be on LKML, but I don't really have a strong opinion
on that matter.

jon
