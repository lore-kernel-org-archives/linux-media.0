Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E1C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4646820833
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDHJFX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:05:23 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:45343 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfDHJFX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 05:05:23 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud7.xs4all.net with ESMTPA
        id DQDRhSPeWNG8zDQDShkkCJ; Mon, 08 Apr 2019 11:05:22 +0200
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
Date:   Mon, 8 Apr 2019 11:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408084558.2979-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCqf9BfuLQpPBb+Chr2C+uAR/H9/congkmiF/UppMb6VtK/q8uEhWMdAwEBDQAy9ZqM9xLdg/oVwta/0gtqzCOd3gD4Vv9W8VmpxnSb/LUDifVw9K8Si
 rPaK8hQgH8jVXYVxBMYx0ewbGELhHbMMjOktCqRXeTogwlrSC/3HT9gul8rlAwbjCXthzTJt9Hb7Ag2PhvOcQfyYkuArMGQRVBOth1hCgHC/j6cZ06TTuA1n
 EVjHlYFIuZgd1HMHPxZuJMIYJcEA3rjmJ1/OTmTPev6btwp/r5PK4o0LQpObLM0BWyxnLZ6X3kTN9NjFtsd6pw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Philipp,

On 4/8/19 10:45 AM, Philipp Zabel wrote:
> Hi,
> 
> not sure if anybody finds this as useful as I do to spot compliance
> failures and warnings in a sea of OKs more easily, but this patch adds
> some color escape codes to the output of v4l2-compliance. It marks "OK"
> green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
> terminal. I would have preferred to mark warnings yellow, but that
> doesn't work well on black-on-white terminals.

Hmm, I hate colors myself :-)

So I would prefer if an option is added to explicitly enable colors. And the
check for stdout can be replaced by a check for this new option.

Also, the same option and behavior should be added to cec-compliance as well.

I propose the option -C, --show-colors.

And don't forget to update the man pages for both utils!

Regards,

	Hans

> 
> regards
> Philipp
> 
> Philipp Zabel (2):
>   v4l2-compliance: use warn() in warn_once()
>   v4l2-compliance: add colors
> 
>  utils/v4l2-compliance/v4l2-compliance.cpp | 11 ++++++++---
>  utils/v4l2-compliance/v4l2-compliance.h   | 22 +++++++++++++---------
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 

