Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B793C10F14
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA27F2184B
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 20:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDKU2c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:28:32 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:60799 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDKU2c (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 16:28:32 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 564B43C013A;
        Thu, 11 Apr 2019 22:28:29 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id txFhsb4d-9L1; Thu, 11 Apr 2019 22:28:22 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id B50F43C00C6;
        Thu, 11 Apr 2019 22:28:22 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Apr
 2019 22:28:22 +0200
Date:   Thu, 11 Apr 2019 22:28:19 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-media@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        <harsha.manjulamallikarjun@in.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190411202819.GA8006@vmlxhi-102.adit-jv.com>
References: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
 <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
 <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
 <20190409205745.GB9750@pendragon.ideasonboard.com>
 <3c2c2d04-8028-3511-aba0-0ea6dd5bdc50@mentor.com>
 <20190409225948.GD9750@pendragon.ideasonboard.com>
 <69091709-a63f-6a11-4b4b-13fcf8d3e40a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69091709-a63f-6a11-4b4b-13fcf8d3e40a@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

Two simple questions:
 - I can only clone git://git.ragnatech.se/linux, but can't access it on
   the web, does it have some web interface?
 - Browsing through your v4l2/next/csi2/upport branch, it looks to be
   targeted for upstream. Could we rely on those commits already or
   they are still in development/testing?

TIA,
Eugeniu.
