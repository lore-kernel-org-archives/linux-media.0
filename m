Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E407C433FE
	for <linux-media@archiver.kernel.org>; Sat,  5 Dec 2020 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C522D58
	for <linux-media@archiver.kernel.org>; Sat,  5 Dec 2020 00:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLEARM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:17:12 -0500
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:43710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgLEARL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 4 Dec 2020 19:17:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D82A1837F24A;
        Sat,  5 Dec 2020 00:16:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bone03_630ff5d273c8
X-Filterd-Recvd-Size: 1253
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Dec 2020 00:16:29 +0000 (UTC)
Message-ID: <8b81eed584f971b1dd61132ca4d04c0853653b31.camel@perches.com>
Subject: Re: [PATCH] staging:rkvdec: Fixed "replace comma with semicolon"
 Warning:
From:   Joe Perches <joe@perches.com>
To:     Travis Carter <traviscarter2@gmail.com>, ezequiel@collabora.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Fri, 04 Dec 2020 16:16:28 -0800
In-Reply-To: <20201204233743.GA8530@linuxmint-midtower-pc>
References: <20201204233743.GA8530@linuxmint-midtower-pc>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 2020-12-04 at 17:37 -0600, Travis Carter wrote:
> drivers/staging/media/rkvdec/rkvdec.c

You might consider using Julia Lawall's cocci script for all of
drivers/staging or subsets of staging like drivers/staging/media/

https://lore.kernel.org/lkml/1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr/


