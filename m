Return-Path: <SRS0=7UeB=VA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961ECC0650E
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CC121882
	for <linux-media@archiver.kernel.org>; Wed,  3 Jul 2019 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCJXS (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:23:18 -0400
Received: from gofer.mess.org ([88.97.38.141]:50225 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfGCJXS (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Jul 2019 05:23:18 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 15EA560A67; Wed,  3 Jul 2019 10:23:16 +0100 (BST)
Date:   Wed, 3 Jul 2019 10:23:15 +0100
From:   Sean Young <sean@mess.org>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>, linux-media@vger.kernel.org
Subject: Re: Keymap with duplicate entries
Message-ID: <20190703092315.ij3dwtuxgwvkvdfz@gofer.mess.org>
References: <7d2bf66655bfdaeeea45ef0878e7920b485bb120.camel@hadess.net>
 <2b07545f-94b6-7c12-e569-0e0a341b961a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b07545f-94b6-7c12-e569-0e0a341b961a@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Jul 02, 2019 at 11:29:58PM +0100, Malcolm Priestley wrote:
> > Hey Malcolm,
> > 
> > There seems to be a problem in  the keymap you provided for inclusion
> > in the kernel.
> > 
> > In media/rc/keymaps/rc-it913x-v2.c, 2 keys are triggered by the same
> > keycode:
> >  53 ↦       { 0x866b18, KEY_VOLUMEDOWN },•
> >  55 ↦       { 0x866b18, KEY_CHANNELDOWN },•
> Hmm
> 
> I don't have this remote only the first one in this file.
> 
> I am pretty sure the values for the second type were forwarded to me by another user.

I'm pretty sure (although I have not tested this) that the second mapping
will overwite the first, so after the keymap is loaded 0x866b18 will be
mapped to KEY_CHANNELDOWN.

The current toml isn't loaded able but the kernel will set the initial
keymap.

So, do current kernels work correctly with the remote you have?

Thanks,

Sean
