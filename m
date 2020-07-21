Return-Path: <SRS0=lMHH=BA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B4C433E0
	for <linux-media@archiver.kernel.org>; Tue, 21 Jul 2020 10:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7725120729
	for <linux-media@archiver.kernel.org>; Tue, 21 Jul 2020 10:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGUKqw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:46:52 -0400
Received: from turbocat.net ([88.99.82.50]:44972 "EHLO mail.turbocat.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgGUKqv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Jul 2020 06:46:51 -0400
Received: from hps2020.home.selasky.org (unknown [178.17.145.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 2E0D7260300;
        Tue, 21 Jul 2020 12:46:48 +0200 (CEST)
Subject: Re: [PATCH] [MEDIA] Use standard integer types
To:     Sean Young <sean@mess.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
References: <4c32e020-1da4-5fbd-a445-121d361bd1e0@selasky.org>
 <20200721075707.GA1497@gofer.mess.org>
From:   Hans Petter Selasky <hps@selasky.org>
Message-ID: <ce7dc15a-9f8e-733d-ccac-d6510c9eae11@selasky.org>
Date:   Tue, 21 Jul 2020 12:46:26 +0200
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721075707.GA1497@gofer.mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2020-07-21 09:57, Sean Young wrote:
> On Mon, Jul 20, 2020 at 08:10:18PM +0200, Hans Petter Selasky wrote:
>> Fixes compilation under FreeBSD.
> 
> This looks good, but there are other places which uses the same types:
> 
> https://git.linuxtv.org/v4l-utils.git/tree/utils/keytable/keytable.c#n58
> 
> https://git.linuxtv.org/v4l-utils.git/tree/utils/keytable/keytable.c#n85
> 
> Do these not affect the build?
> 

I'll have a look. I currently have some scripts to fix the types in all 
C-files, before building on FreeBSD, so this may got missed. I'll update 
my patch.

--HPS

