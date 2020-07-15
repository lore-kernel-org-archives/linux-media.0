Return-Path: <SRS0=i11G=A2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964FC433E1
	for <linux-media@archiver.kernel.org>; Wed, 15 Jul 2020 22:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC6A2065D
	for <linux-media@archiver.kernel.org>; Wed, 15 Jul 2020 22:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOWXb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:23:31 -0400
Received: from retiisi.org.uk ([95.216.213.190]:53688 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgGOWXb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 15 Jul 2020 18:23:31 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 02E9E634C87;
        Thu, 16 Jul 2020 01:22:12 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1jvpn2-00039Z-2z; Thu, 16 Jul 2020 01:22:12 +0300
Date:   Thu, 16 Jul 2020 01:22:12 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [GIT PULL for 5.9] Camera sensor + V4L2 async patches
Message-ID: <20200715222211.GH836@valkosipuli.retiisi.org.uk>
References: <20200715222030.GG836@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715222030.GG836@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jul 16, 2020 at 01:20:30AM +0300, Sakari Ailus wrote:
> Hi Mauro,
> 
> Here's a stash of patches for 5.9. I wish there's still time to get them
> in.

There are a few rather trivial checkpatch.pl issues in the GMSL patches. I
asked Kieran to address them separately (some appear false positives, too).

-- 
Sakari Ailus
