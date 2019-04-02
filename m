Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F697C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E83520882
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554215792;
	bh=G/8NkaYBrVVeJ+mlS7dm9/P23F7xNFoAt0Dg2jV54GE=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=tRRAOtgUFdQTAcc3FvIAJ8CLsUT25URWiv5sTOUFSMoMbZD5xUa48uTRWAj5k+fRH
	 cODifEnudNjW7jNvgofslJoluvnSPlYHy1Tmqa8RS2OeWXdEHOZvsqYlyGbziOMiTN
	 Wji5eUVmKB8kzNqE7bBO64/HlwYbiDgd8aG+RnjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfDBOgb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbfDBOgb (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Apr 2019 10:36:31 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F4D20857;
        Tue,  2 Apr 2019 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554215790;
        bh=G/8NkaYBrVVeJ+mlS7dm9/P23F7xNFoAt0Dg2jV54GE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=sKhavb/KzO7NB7Oxsy953AoWaE/5JI8PTBjeo1iYU+LwvOe5imEjxd6FDE2wrZYoC
         DSTbs5HwXZ7EgUlDUbjge8dMOxXb+S0fUBY7yr3y13Toe1KGCFrJ/ipvnO4nqSAxhV
         K8mZ3Ht4hwEj405hxkoj8AOtXEXGZOiyrGXE9me8=
Subject: Re: [PATCH v2] au0828: stop video streaming only when last user stops
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <4f9f2e84-f053-b84d-b3c7-6abe22bddf5d@xs4all.nl>
Cc:     shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <1770b1da-0290-7946-9fd1-5535ca8a10cb@kernel.org>
Date:   Tue, 2 Apr 2019 08:36:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4f9f2e84-f053-b84d-b3c7-6abe22bddf5d@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/2/19 1:24 AM, Hans Verkuil wrote:
> If the application was streaming from both videoX and vbiX, and streaming
> from videoX was stopped, then the vbi streaming also stopped.
> 
> The cause being that stop_streaming for video stopped the subdevs as well,
> instead of only doing that if dev->streaming_users reached 0.
> 
> au0828_stop_vbi_streaming was also wrong since it didn't stop the subdevs
> at all when dev->streaming_users reached 0.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
> Change since v1: v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 1)
> was done for video only, not for vbi. This is obviously wrong when starting
> vbi first, but also caused weird behavior since attempting to start a second
> vbi capture would stop the first.
> ---

Looks good. Attempting to start the second VBI stream capture doesn't
stop the active VBI stream.

Tested-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
