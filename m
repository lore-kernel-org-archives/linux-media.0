Return-Path: <SRS0=Zegy=33=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14FC352A2
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A66E217BA
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGLu5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:50:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGLu5 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 7 Feb 2020 06:50:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 56AC729482C
Subject: Re: [PATCH 0/4] Hantro VPU JPEG encoder fixes
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        devel@driverdev.osuosl.org
Cc:     linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>
References: <20200127143009.15677-1-andrzej.p@collabora.com>
 <1d83a74c24269c7bcf6d6d8a789c88dbf7370dbb.camel@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <8a526fdb-cbfb-fe75-e24f-83f7c09a13a5@collabora.com>
Date:   Fri, 7 Feb 2020 12:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1d83a74c24269c7bcf6d6d8a789c88dbf7370dbb.camel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi All,

<snip>

> I've just tested RK3288, and this series is indeed fixing
> these issues. So for all patches:
> 
> Tested-by: Ezequiel Garcia <ezequiel@collabora.com>

A kind reminder.

The series fixes serious encoding quality problems in both rk3399 and rk3288,
so it seems it should be included. A review is needed, though, at least for
patches 2-4.

Thank you,

Andrzej
