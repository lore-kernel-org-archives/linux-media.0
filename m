Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF502C433ED
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F5E61078
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 00:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0ARu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Apr 2021 20:17:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0ARu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Apr 2021 20:17:50 -0400
Received: from [IPv6:2804:14d:72b1:a2ff:e1:848c:62d:7304] (unknown [IPv6:2804:14d:72b1:a2ff:e1:848c:62d:7304])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1DEF71F42327;
        Tue, 27 Apr 2021 01:17:05 +0100 (BST)
From:   Daniel Almeida <daniel.almeida@collabora.com>
Subject: Add dprintk calls for control validation in v4l2-ctrls.c?
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com
Message-ID: <f7f6d636-1791-fb90-d4f4-0eb58993cb4d@collabora.com>
Date:   Mon, 26 Apr 2021 21:17:02 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans, Ezequiel & all.

I find it a bit hard to debug my own code when it invariably sneaks in a 
bad control value with the VIDIOC_S_EXT_CTRLS ioctl.


I feel that it would be tremendously beneficial to encourage the use of 
dprintk calls in v4l2-ctrls.c to inform the user about what pieces of 
data were actually rejected in the validation functions.

#define dprintk(vdev, fmt, arg...) do {					\
	if (!WARN_ON(!(vdev)) && ((vdev)->dev_debug & V4L2_DEV_DEBUG_CTRL)) \
		printk(KERN_DEBUG pr_fmt("%s: %s: " fmt),		\
		       __func__, video_device_node_name(vdev), ##arg);	


Unfortunately the dprintk macro above takes a pointer to struct 
video_device as argument. This is not available in the places I want to 
actually place the calls, as far as I could tell.

E.g. here:

static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
				 union v4l2_ctrl_ptr ptr)

I'd like to make the changes to make this possible, if any, or be 
pointed at another solution if there is one - such as calling pr_err 
directly or something along these lines - please.

Kindly advise?

-- thanks
-- Daniel
