Return-Path: <SRS0=rRrk=3R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B175C33CB3
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8E524683
	for <linux-media@archiver.kernel.org>; Tue, 28 Jan 2020 20:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1Um5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:42:57 -0500
Received: from ms.lwn.net ([45.79.88.28]:43504 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1Um5 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 Jan 2020 15:42:57 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8EA524B7;
        Tue, 28 Jan 2020 20:42:56 +0000 (UTC)
Date:   Tue, 28 Jan 2020 13:42:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: filesystems: add overlayfs to index.rst
Message-ID: <20200128134255.1f94ef36@lwn.net>
In-Reply-To: <3b8e7783b1fcc71e4f94af5ea8e5fa264392f8c4.1580193653.git.mchehab+huawei@kernel.org>
References: <00008303fde6b4e06d027d3b76ae7032614a7030.1580193653.git.mchehab+huawei@kernel.org>
        <3b8e7783b1fcc71e4f94af5ea8e5fa264392f8c4.1580193653.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 28 Jan 2020 07:41:01 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> While the document is there, it is currently missing at the
> index file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

jon
