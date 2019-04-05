Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEBC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 15:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EF21726
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDEP3e (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:29:34 -0400
Received: from gofer.mess.org ([88.97.38.141]:56387 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEP3e (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 11:29:34 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 6C37B60247; Fri,  5 Apr 2019 16:29:33 +0100 (BST)
Date:   Fri, 5 Apr 2019 16:29:33 +0100
From:   Sean Young <sean@mess.org>
To:     Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH v4 4/4] pvrusb2: Add Hauppauge HVR1955/1975 devices
Message-ID: <20190405152933.s2wswweflnhvdyij@gofer.mess.org>
References: <1545421223-3577-1-git-send-email-brad@nextdimension.cc>
 <1551294966-12564-1-git-send-email-brad@nextdimension.cc>
 <1551294966-12564-5-git-send-email-brad@nextdimension.cc>
 <20190405152423.76fsvdrpzz4kwxsg@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405152423.76fsvdrpzz4kwxsg@gofer.mess.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 05, 2019 at 04:24:24PM +0100, Sean Young wrote:
> On Wed, Feb 27, 2019 at 01:16:06PM -0600, Brad Love wrote:
 > +		pr_info("%s(): resetting 160xxx demod\n", __func__);
> > +		/* TODO: not sure this is proper place to reset once only */
> > +		pvr2_issue_simple_cmd(hdw,
> > +				     FX2CMD_HCW_DEMOD_RESET_PIN |
> > +				     (1 << 8) |
> > +				     ((0) << 16));
> > +		msleep(10);
> 
> usleep_range() is preferred (for delays <= 10), I think. Maybe 10ms is too
> long anyway and msleep(1) is enough.

Sorry that was wrong. usleep_range() is preferred 1ms - 20ms, see:

https://www.kernel.org/doc/Documentation/timers/timers-howto.txt



Sean
