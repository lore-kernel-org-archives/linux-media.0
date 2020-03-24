Return-Path: <SRS0=HLWw=5J=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF2C4332B
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 11:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AE8208D5
	for <linux-media@archiver.kernel.org>; Tue, 24 Mar 2020 11:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585049455;
	bh=NRJtsCFmuKZxXLch4trFrq0LcMt2feHKVo2oLgHTZaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S/iDSnwTAz4EgthDP74zAf48MgCEnW6jkqnLjUs2i0HKR6oHgIWzwkf7V14O+jcVU
	 kdhl8a/F2H1M1uPyIkUErPj2o65qlrNq+r8psoGxgH986xGSBI2pEJRPU3X1habI6o
	 Jj7BKwR8kCO2cciYzwJjPJ8lCcWX6ccn7KObGk5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCXLar (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:30:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgCXLar (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Mar 2020 07:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=pgidfk1CzMJBNlrTU9Rz3yjEi/6uZEwyGV8n3CqpEdg=; b=R/d0WjIIt+6uNMGN5b50i7c+IJ
        GWccyT591AP+YueGzQdeZsjth3Qxjd9Yr91nwoJizBg36QvBy6NYJxk6EpWInf+INVKW+Dk0ZUVqp
        gpI18MUks279v9XEQH4i2dWvwkcodknjR/bFp+2J5I6h2pBacXtml0I/9yhOlERpo89YUqEcw1wJz
        rW6Hd4SecnzilvwlyaVh2zXkqlRocMNHVbg6whForKlqKVjBDcafAILe0hK76OlZdpBujQc+8eJFj
        C7Ykc1b8I4M70KXtPLqdGUFgEFh0lXRuvQkdybR5wp+GeeTKhEiWIAIhr93/6VcoUrGMZUXceKZs/
        cka76aCQ==;
Received: from ip5f5ad4e9.dynamic.kabel-deutschland.de ([95.90.212.233] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGhla-0005IZ-SL; Tue, 24 Mar 2020 11:30:43 +0000
Date:   Tue, 24 Mar 2020 12:30:33 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, sean@mess.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: A bit confused on i2c communication between modules
Message-ID: <20200324123033.5538c38d@coco.lan>
In-Reply-To: <20200324110122.GG1134@ninjato>
References: <55204992-9060-6008-31c7-c2855f712e70@gmail.com>
        <20200324082236.2c4d2ae4@coco.lan>
        <bc91be3d-802c-a58c-bd27-740e15516180@ideasonboard.com>
        <20200324095810.GC1134@ninjato>
        <63742e62-d0b6-9d7a-b491-d7969f8ea7e2@ideasonboard.com>
        <20200324102704.GD1134@ninjato>
        <7d82a76f-5165-5e7c-bcde-552f527da0d2@ideasonboard.com>
        <20200324110122.GG1134@ninjato>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 24 Mar 2020 12:01:22 +0100
Wolfram Sang <wsa@the-dreams.de> escreveu:

> On Tue, Mar 24, 2020 at 10:49:55AM +0000, Kieran Bingham wrote:
> > +cc: linux-i2c@vger.kernel.org
> > Moving /this/ to the linux-i2c list ;-)
> > 
> > Thanks Wolfram,
> > 
> > On 24/03/2020 10:27, Wolfram Sang wrote:  
> > >   
> > >> Maybe we should have a whole virtual I2C bus for virtual devices :-)
> > >>
> > >> (Hrm, that started out as a joke, and now I'm not sure if it's a real
> > >> option or not...)  
> > > 
> > > Just one final thought: I think this is actually the best option. Zero
> > > chance of address collisions (which could happen if you have a not
> > > perfectly-described real HW bus). No RPM mangling of real and virtual
> > > devices. A clear seperation what is real and what is virtual. Plus, you
> > > can implement it right away, no need to wait for the dynamic address
> > > assignment.  
> > 
> > Agreed - even better all round! But I presume we don't yet have a
> > 'virtual' i2c bus? So it's a patch-set to do first? Or is it already
> > feasible?  
> 
> From what I understand, you won't need an API for that. What I
> understand:
> 
> There will be a master device (a DVB or something). This will register
> its own i2c_adapter with a dummy .xfer callback. The sub-devices will be
> i2c_clients, then. 

Yes. That's what the current drivers that have integrated hardware
at the same silicon (like rtl28xx) do: their .xfer callback splits the
I2C addresses reserved for "internal" devices, and use a different set
of registers to handle those, instead of the normal ones used to
communicate with a real I2C hardware.

The cx231xx uses a different strategy: it has multiple I2C buses, being
one of them reserved for its own integrated I2C like bus.

> I don't know how you want communication between
> those. Maybe the .xfer callback will need to do some message parsing?
> 



Thanks,
Mauro
