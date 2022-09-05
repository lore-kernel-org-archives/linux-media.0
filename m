Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CE3C6FA83
	for <linux-media@archiver.kernel.org>; Mon,  5 Sep 2022 09:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiIEJZm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Sep 2022 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiIEJZk (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 5 Sep 2022 05:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470AC27164
        for <linux-media@vger.kernel.org>; Mon,  5 Sep 2022 02:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D818A61191
        for <linux-media@vger.kernel.org>; Mon,  5 Sep 2022 09:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D18C433C1;
        Mon,  5 Sep 2022 09:25:36 +0000 (UTC)
Message-ID: <704c46ed-59cb-a8a7-7d47-24ab9d051932@xs4all.nl>
Date:   Mon, 5 Sep 2022 11:25:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: edid-decode - Unsuccessful of installation on edid-decode
Content-Language: en-US
To:     Nicholas Chan <nicholasbmwsdml@gmail.com>,
        linux-media@vger.kernel.org
References: <CAEqQZgwaQZokbhNa81pXs9oKfCVRP8K99+SDVhvowELdROgbVA@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAEqQZgwaQZokbhNa81pXs9oKfCVRP8K99+SDVhvowELdROgbVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Nicolas,

On 03/09/2022 11:59, Nicholas Chan wrote:
> To whom it may concern
> 
> When installing the edid-decode, there are errors. Search through the
> web and still no solution could help. May I ask if you know how to
> solve this problem? The below are the message shown from Terminal
> after git clone. Xcode is updated and Gcc is available. For your
> information, I am currently using Mac OS X 12.5.1. As the code might
> be classified as spam which is a false alarm I think, only screen
> capture could be provided. Thank you for your help.

You can just delete that line, or do a 'git pull' to update to the latest
version. This line was added for the build of edid-decode.js, which most
people do not need, and gcc never complained, so I wasn't aware that
other compilers would have problems with it.

I've now added that line under #ifdef __EMSCRIPTEN__, so it should now
work again.

Let me know if you still run into issues!

Regards,

	Hans
