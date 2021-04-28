Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3FC433B4
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D9A613F8
	for <linux-media@archiver.kernel.org>; Wed, 28 Apr 2021 07:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhD1Hoa (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:44:30 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:58697 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhD1Ho3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Apr 2021 03:44:29 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id berElg92niDzSberHlgHHK; Wed, 28 Apr 2021 09:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619595824; bh=U2/UAiMIHhA5HdFoVKfJSv1kcpgY5QZKcTC+RSPZodk=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=oVl5tYX5Zm2aQ+fZ88RMVRkXlzO5jeIl4gqyPNRBbCAsQncOfqvxuiAPwhUV5Ejce
         DC5kWrDs2tSTy4zNzwIQSDjH8VP2Xihl2yn52U5ejJYApMZ+lEAWf4yc2uOrHCjGeb
         edlo8j7AGwAqFT832sd0/159xR+rEO1yFDX5qg6UEOdV5PpncO+BHdVVod5CXUgtnQ
         D64+GqPel15l7W4C+ZpG9YigtHm0EItAkfIlc3xEzeLF6jiQjz+Sr0/pwnfWwk2jBs
         6UT0s3e1FmJ4XKaTSrbVncwOyPgEZrpe3NVOBAlTGwpANcad73IuJColU39I9vXRkF
         TX/qLzAdlfTcw==
Subject: Re: Add dprintk calls for control validation in v4l2-ctrls.c?
To:     Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com
References: <f7f6d636-1791-fb90-d4f4-0eb58993cb4d@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4f18966e-1be6-95ed-f6db-eb91a141e1f5@xs4all.nl>
Date:   Wed, 28 Apr 2021 09:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f7f6d636-1791-fb90-d4f4-0eb58993cb4d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEzCqfp9vTawWLaNIq8e1k1dxEAtZS9+SdA177sa0bIqRaKAtrc+0BWs7Z+tSbpZYx9hdrsjVLj1WAqZxKjfqYyYAyYgfG27tz5ziIhTA4FZZTS9x12C
 EZFVfrtrXur+jP0KOLRL+pXm3AbX7FOP/qeEOVjtUqXWIdY1pYp2RkctDktJZdE67ZOWsLh8vdEBgrOxIwu8mrCt5GSTuu15gerpG0VTmwpdpLJteHr3uhxW
 XJGfdgyvIwCffkpmnoh7uQWmgPLlImKdb78O8j9lnriu5B0MtRDNjPL/QOmUdqg1a4aKwJl0oCnRrw35ZMxBYg==
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Daniel,

On 27/04/2021 02:17, Daniel Almeida wrote:
> Hi Hans, Ezequiel & all.
> 
> I find it a bit hard to debug my own code when it invariably sneaks in a 
> bad control value with the VIDIOC_S_EXT_CTRLS ioctl.
> 
> 
> I feel that it would be tremendously beneficial to encourage the use of 
> dprintk calls in v4l2-ctrls.c to inform the user about what pieces of 
> data were actually rejected in the validation functions.

Makes sense!

> 
> #define dprintk(vdev, fmt, arg...) do {					\
> 	if (!WARN_ON(!(vdev)) && ((vdev)->dev_debug & V4L2_DEV_DEBUG_CTRL)) \
> 		printk(KERN_DEBUG pr_fmt("%s: %s: " fmt),		\
> 		       __func__, video_device_node_name(vdev), ##arg);	
> 
> 
> Unfortunately the dprintk macro above takes a pointer to struct 
> video_device as argument. This is not available in the places I want to 
> actually place the calls, as far as I could tell.
> 
> E.g. here:
> 
> static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
> 				 union v4l2_ctrl_ptr ptr)
> 
> I'd like to make the changes to make this possible, if any, or be 
> pointed at another solution if there is one - such as calling pr_err 
> directly or something along these lines - please.

I have no problem with changing the prototypes to pass a vdev pointer
along. The validate_new function is the starting point for that.

However, keep in mind that it can also be called from a driver via e.g.
__v4l2_ctrl_s_ctrl(), in which case there is no video_device, so the
debug code has to be able to handle the case where vdev == NULL, and
not do a WARN_ON in that case.

I would postpone working on this though. Early in the next cycle I want
to merge a large refactor patch found here:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=ctrl-refactor

where v4l2-ctrls.c is split up in several pieces. I suggest you wait until
that's merged before making patches for the control framework.

Regards,

	Hans

> 
> Kindly advise?
> 
> -- thanks
> -- Daniel
> 

