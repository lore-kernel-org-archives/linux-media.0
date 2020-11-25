Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CEBC5519F
	for <linux-media@archiver.kernel.org>; Wed, 25 Nov 2020 04:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0839206F8
	for <linux-media@archiver.kernel.org>; Wed, 25 Nov 2020 04:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgKYEKr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Nov 2020 23:10:47 -0500
Received: from jpvw.nl ([80.127.100.2]:38118 "EHLO jpvw.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKYEKr (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Nov 2020 23:10:47 -0500
X-Greylist: delayed 2095 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 23:10:47 EST
Received: from [127.0.0.1] (helo=jpvw.nl)
        by jpvw.nl with esmtp (Exim 4.94)
        (envelope-from <jp@jpvw.nl>)
        id 1khlax-003iKg-Dg; Wed, 25 Nov 2020 04:35:51 +0100
Subject: Re: Logitech MeetUp
To:     Privacy <pirat@praes.eu>, linux-media@vger.kernel.org
References: <7f97de0f-5be6-35c0-3a28-bac057a1cc36@praes.eu>
From:   JP <jp@jpvw.nl>
Message-ID: <e462645e-50e9-fe40-728e-44649d2e8081@jpvw.nl>
Date:   Wed, 25 Nov 2020 04:35:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7f97de0f-5be6-35c0-3a28-bac057a1cc36@praes.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 11/24/20 11:07 PM, Privacy wrote:
> Hallo,
>
> die Loitech-Meetup Kamera funktioniert - aber leider nicht der Ton.
> Die Deive IDs:
>
> 046d:0867
> 046d:0866
> 046d:086a
>
> Irgendeine Idee?
>
> Skopeia
try (as root) modprobe snd-usb-audio

Jan Pieter
