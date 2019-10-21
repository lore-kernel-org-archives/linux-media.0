Return-Path: <SRS0=v3Zd=YO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BA4CA9EAF
	for <linux-media@archiver.kernel.org>; Mon, 21 Oct 2019 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060D02084B
	for <linux-media@archiver.kernel.org>; Mon, 21 Oct 2019 21:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfJUVit (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:38:49 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:42791 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbfJUVit (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 21 Oct 2019 17:38:49 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id MfNyiXmJNo1ZhMfO1iO7Px; Mon, 21 Oct 2019 23:38:47 +0200
Subject: Re: Userspace support libraries for touch pad devices?
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Florian Echtler <floe@butterbrot.org>,
        Nick Dyer <nick@shmanahar.org>
Cc:     Vandana BN <bnvandana@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <0573a188-5f5c-d14c-3d38-e1d82e30f9f8@xs4all.nl>
Message-ID: <c43a22d5-d5eb-6330-8106-0f340d0d2421@xs4all.nl>
Date:   Mon, 21 Oct 2019 23:38:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0573a188-5f5c-d14c-3d38-e1d82e30f9f8@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC6XQIjNk5iNWVhCteq09Veb5kWCDmB6IvhmK0s11CNuVKJXKpRW+67/7qavxuZjAwmgSjRb9SuKVhDpK0sSXebhaloHFIvjpoJYrVoBxWRRWjarpWuw
 b5iOMG7lBh1hjZeYnxcS6XSkiC6WeulGk0qy/pJaw0DZXAkZ7MlhckzQ4lm8wSJGqOocCAekvvOJ04sAAxAY2owiFRa1D0tvjD96EKrCndP6+7U/obEsp/mf
 M/JiuV4w5B1F42ZCK6gCQ7aV0N7USiBIEpp0aU1UVdc=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Ping!

Regards,

	Hans

On 10/14/19 11:05 AM, Hans Verkuil wrote:
> Hi Florian, Nick,
> 
> You both added V4L2 touch pad drivers to the kernel, but I was wondering
> about userspace support for such devices. Is there a library somewhere that
> can interpret the data?
> 
> The only link I found is https://github.com/ndyer/heatmap/commits/heatmap-v4l
> but that appears to be mostly a test utility.
> 
> Vandana is adding touch device emulation to the vivid driver, so it would be
> interesting to see if a library exists for such devices to simplify testing.
> 
> Regards,
> 
> 	Hans
> 

