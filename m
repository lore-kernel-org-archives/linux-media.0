Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA7C433E0
	for <linux-media@archiver.kernel.org>; Wed, 27 Jan 2021 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C74D2073A
	for <linux-media@archiver.kernel.org>; Wed, 27 Jan 2021 11:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhA0LJK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:09:10 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:55715 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbhA0LBt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 27 Jan 2021 06:01:49 -0500
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 748B3200018;
        Wed, 27 Jan 2021 11:00:32 +0000 (UTC)
Message-ID: <49e63342365d49eaac72a4ac7beddaf582dc9862.camel@hadess.net>
Subject: Re: Firefly X10 mouse mode?
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-media@vger.kernel.org
Cc:     Anssi Hannula <anssi.hannula@iki.fi>
Date:   Wed, 27 Jan 2021 12:00:31 +0100
In-Reply-To: <7fdd2459bd00c631c976cd1414842eae3f89417b.camel@hadess.net>
References: <7fdd2459bd00c631c976cd1414842eae3f89417b.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2021-01-25 at 14:33 +0100, Bastien Nocera wrote:
> Hey,
> 
> I have a SnapStream Firefly[1] X10 remote and couldn't figure out how
> to make the "mouse" buttons work the same way it does using the
> original software.

Filed this bug against libinput:
https://gitlab.freedesktop.org/libinput/libinput/-/issues/567

I'm not sure how prevalent this functionality is on remotes, but
supporting this properly likely would require some work in the kernel
as well as in user-space.

Cheers

