Return-Path: <SRS0=AAu9=CI=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA2C433E6
	for <linux-media@archiver.kernel.org>; Sun, 30 Aug 2020 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF06208CA
	for <linux-media@archiver.kernel.org>; Sun, 30 Aug 2020 09:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgH3JO4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgH3JO4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 30 Aug 2020 05:14:56 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F6C061573
        for <linux-media@vger.kernel.org>; Sun, 30 Aug 2020 02:14:55 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 963AFC63F6; Sun, 30 Aug 2020 10:14:53 +0100 (BST)
Date:   Sun, 30 Aug 2020 10:14:53 +0100
From:   Sean Young <sean@mess.org>
To:     Simon Liddicott <simon@liddicott.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        oliver@schinagl.nl
Subject: Re: dtv-scan-tables maintenance
Message-ID: <20200830091453.GA18260@gofer.mess.org>
References: <CALuNSF479bQ0wPZbX_aK_j1JRuuwLhT=96ou420Wwdi2v1zR3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALuNSF479bQ0wPZbX_aK_j1JRuuwLhT=96ou420Wwdi2v1zR3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On Tue, Aug 04, 2020 at 03:05:48PM +0100, Simon Liddicott wrote:
> Hi
> 
> Who is maintaining the dtv-scan-tables tree?
> 
> There are a few outstanding patches.

I've started handling these patches. Let me know if anything is missing.

Thanks,

Sean
