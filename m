Return-Path: <SRS0=cCoD=3L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD9C2D0DB
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355EE24655
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 09:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgAVJQm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:16:42 -0500
Received: from gofer.mess.org ([88.97.38.141]:46571 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgAVJQm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jan 2020 04:16:42 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 2789711A001; Wed, 22 Jan 2020 09:16:41 +0000 (GMT)
Date:   Wed, 22 Jan 2020 09:16:41 +0000
From:   Sean Young <sean@mess.org>
To:     camden lindsay <camden.lindsay+kernel@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: ir-keytable segfault when writing keymap from file
Message-ID: <20200122091640.GA14036@gofer.mess.org>
References: <CABkW7JNg-7PNwSH2CsZVFHpqHdnaH5Ha4VS83r8_CaMox3wfQQ@mail.gmail.com>
 <CABkW7JNw2vzijzPuUVTOEC7oZ-opSgRp7YdpEdmhJrKc=GX7Ow@mail.gmail.com>
 <20200121092021.GA25590@gofer.mess.org>
 <CABkW7JNsiMPU9SP+pvojWDrDm7ckdrEaOnUmtRw-bhe5iKigsg@mail.gmail.com>
 <20200121164939.GA32565@gofer.mess.org>
 <CABkW7JNPtB9oyEzZ13dDfdqSbeskTY38z0qTBpNodmRhzxxyzA@mail.gmail.com>
 <20200121192943.GA2797@gofer.mess.org>
 <CABkW7JOMEKbRSJqrjShfis03MJHjoYGd_T4Cd+2QffzXMWKiaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkW7JOMEKbRSJqrjShfis03MJHjoYGd_T4Cd+2QffzXMWKiaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Camden,

On Tue, Jan 21, 2020 at 02:48:45PM -0800, camden lindsay wrote:
> Will do.
> 
> To do a quick test, i copied the sample config file out of the man
> page and tried loading it:
> [kodiuser@kodiarch ir-keytable]$ sudo ir-keytable -w /etc/ir-keytable/test.toml
> Read iMON Station RSC table
> /etc/ir-keytable/test.toml: keycode `KEY_MAX' not recognised, no

The KEY_MAX problem is fixed in master.

> mapping for scancode 8392834
> Wrote 42 keycode(s) to driver
> Protocols changed to nec
> Can't find imon_rsc bpf protocol in /etc/rc_keymaps/protocols or
> /usr/lib/udev/rc_keymaps/protocols
> [kodiuser@kodiarch ir-keytable]$
> 
> 
> Looks like perhaps i should file a bug against arch for the missing
> protocol file?

That would be great, however I don't think it affects the problem you are
having. 

> I have no idea what IR BPF decoding does.. but the pages i have
> skimmed about it (including running across your ramblings and  bpf man
> page description) seem to indicate it is more complex that what i'll
> need, given i'll be using the kernel IR decoders.  I think? heh.

For the most common IR protocols, the kernel includes a set of hand-written
decoders. There are many more protocols, or slight variants. So rather
than having a decoder for each, we use BPF for those. BPF decoders are
stored in /usr/lib/udev/rc_keymaps/protocols 

Having said all of that, it's likely that you can make do with the kernel
decoders (non-BPF).

I would suggest you try the "ir-keytable -p all -t" and see if you can
identify all the protocols and scancodes of your remote.


Sean
