Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656AC433ED
	for <linux-media@archiver.kernel.org>; Tue,  6 Apr 2021 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E1E613B8
	for <linux-media@archiver.kernel.org>; Tue,  6 Apr 2021 13:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhDFNUF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 6 Apr 2021 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDFNUF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 6 Apr 2021 09:20:05 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Apr 2021 06:19:57 PDT
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795DEC06174A
        for <linux-media@vger.kernel.org>; Tue,  6 Apr 2021 06:19:57 -0700 (PDT)
Received: from hps2020.home.selasky.org (unknown [178.17.145.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id A7C6D260752;
        Tue,  6 Apr 2021 15:13:27 +0200 (CEST)
Subject: Re: [PATCH] Rudimentary support for mi_media_detect_type on FreeBSD.
To:     Trenton Schulz <trenton@norwegianrockcat.com>,
        linux-media@vger.kernel.org
References: <20210404134430.4537-1-trenton@norwegianrockcat.com>
From:   Hans Petter Selasky <hps@selasky.org>
Message-ID: <055d59d5-da2f-0f42-9ae0-328ce1ac51cc@selasky.org>
Date:   Tue, 6 Apr 2021 15:12:19 +0200
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210404134430.4537-1-trenton@norwegianrockcat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/4/21 3:44 PM, Trenton Schulz wrote:
> +#else // Not Linux
> +	int fd = open(device, O_RDONLY);
> +	if (fd >= 0) {
> +		struct v4l2_capability caps;
> +		if (ioctl(fd, VIDIOC_QUERYCAP, &caps) == 0) {

Hi,

You should close the "fd" before all returns, in this function. Else it 
might leak.

int error;
error = ioctl(fd ...);
close(fd);

if (error == 0) {
...

--HPS
