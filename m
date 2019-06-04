Return-Path: <SRS0=wOjJ=UD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A034C282CE
	for <linux-media@archiver.kernel.org>; Tue,  4 Jun 2019 13:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3C124B0A
	for <linux-media@archiver.kernel.org>; Tue,  4 Jun 2019 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFDNli (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:41:38 -0400
Received: from ms.lwn.net ([45.79.88.28]:55676 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfFDNli (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 4 Jun 2019 09:41:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 375467DE;
        Tue,  4 Jun 2019 13:41:38 +0000 (UTC)
Date:   Tue, 4 Jun 2019 07:41:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [lwn:docs-next 25/31] htmldocs: /bin/bash:
 ./scripts/sphinx-pre-install: No such file or directory
Message-ID: <20190604074137.7cf859d6@lwn.net>
In-Reply-To: <20190604063318.34c7bde5@coco.lan>
References: <201905310424.Zhlxo3ky%lkp@intel.com>
        <20190530153239.57f321c9@lwn.net>
        <20190604063318.34c7bde5@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 4 Jun 2019 06:33:18 -0300
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Hi Jon,
> 
> The fix is incomplete... there are other occurrences of this
> within the Makefile:

Argh...at least I was on the right track :)  I'll clean up the rest today.

Thanks,

jon
