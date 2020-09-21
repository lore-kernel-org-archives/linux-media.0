Return-Path: <SRS0=F5P7=C6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027EC43463
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 05:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80AB20866
	for <linux-media@archiver.kernel.org>; Mon, 21 Sep 2020 05:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600664575;
	bh=a505D1kBjZumg+CJScAbd3YgGO2ghyLanOA34IE58ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H6MT+mLjrOoJBOtGxZbfts+TCHir+cLhf6WccvjUYG7ptYhC+KTkmt7hWngLE4l+o
	 sSbQdRtrv4orDOPBpEk8Y+o/dcOalOeNxIl2+fLVOIRKNDu2YNTWwwtxiebAQ0qroR
	 dbkmfQMyqPeVQxaeBApAVhFDJGnrU4HkQLqqnMng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUFCz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Sep 2020 01:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgIUFCz (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Sep 2020 01:02:55 -0400
Received: from coco.lan (ip5f5ad5b1.dynamic.kabel-deutschland.de [95.90.213.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 015EC2084C;
        Mon, 21 Sep 2020 05:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600664574;
        bh=a505D1kBjZumg+CJScAbd3YgGO2ghyLanOA34IE58ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rJEZ9lgIBdmyfi+kMyERIORg2e7Xcwq465Ac7PnNAUs/aVxigGHGyZ9xRwbRTKxUM
         L+/dLDQ7eBYk0Yd/l8/3aiMEJKa6N5+y2XzHFDr0tA6gjpNWFH3C11ApPynTs4lEiC
         KhgmGF4OtJ7Z5eqdV0a+Fz0Jd0bb9LY6WxKS0YxU=
Date:   Mon, 21 Sep 2020 07:02:50 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jordi Coma Garcia <jordicoma22@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: Error saa7134 Avermedia Hibrid 16AR
Message-ID: <20200921070250.18d823aa@coco.lan>
In-Reply-To: <CAOcvHs6Te1N3Vv_KcWEGpCy6uajfjs2-DUJi_JzZ6n2znMOHBw@mail.gmail.com>
References: <CAOcvHs6Te1N3Vv_KcWEGpCy6uajfjs2-DUJi_JzZ6n2znMOHBw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Sun, 20 Sep 2020 14:14:39 +0200
Jordi Coma Garcia <jordicoma22@gmail.com> escreveu:

> Hello,
> 
> I'm trying to run the tv dvb-t card Avermedia hybrid 16ar on the linux
> 5.8.10 an arch linux. I can sintonize but I'm getting errors with kaffeine.
> 
> 
> [image: imatge.png]
> When running the lts kernel of arch ( 5.4.66-1) I have no errors and it
> works fine.
> 
> Hope you can help

Based on the Kaffeine logs, I suspect that the sqlite database got
somehow corrupted (perhaps because some distro upgrade?).

Kaffeine stores its configuration, plus the channels found by scan 
and the EPG data on some files:


	$ file ~/.local/share/kaffeine/*
	~/.local/share/kaffeine/config.dvb:   ASCII text
	~/.local/share/kaffeine/epgdata.dvb:  data
	~/.local/share/kaffeine/playlistsK4:  data
	~/.local/share/kaffeine/scanfile.dvb: ASCII text
	~/.local/share/kaffeine/sqlite.db:    SQLite 3.x database, last written using SQLite version 3033000

You could try to backup those files to some different place and then
remove the sqlite ones (epgdata.dvb and sqlite.db) and re-run the
Kaffeine's channel scan.

Thanks,
Mauro
