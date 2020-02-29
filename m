Return-Path: <SRS0=w1B8=4R=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1724BC3F2C6
	for <linux-media@archiver.kernel.org>; Sat, 29 Feb 2020 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9982A246AE
	for <linux-media@archiver.kernel.org>; Sat, 29 Feb 2020 12:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hXacLHP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgB2MHh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:07:37 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:44173 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgB2MHh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 29 Feb 2020 07:07:37 -0500
Received: from [IPv6:2001:983:e9a7:1:8145:294e:5dac:9725]
 ([IPv6:2001:983:e9a7:1:8145:294e:5dac:9725])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 80u6jRbWejmHT80u7jsFie; Sat, 29 Feb 2020 13:07:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582978055; bh=Pt7MPr7Mu6yDMwDY2bAQ8hL3kxRxus5BC7l6FTHLnzY=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=hXacLHP1RFlIRuoNh6+xFPZ3VgowJZFGtUGhp7V8P/QzejiZwn7k/nRyYS0QbN5yL
         cjshlmfPQnYooPZ6E42BK9nL6B3aUhMA5KksZSwI7jpHksnXZhUk8SNMpMCeHQGLFJ
         qKCtT/NXiXxJne+l/CYr8qs0cU3W9SrKBYoUOO1RuYAlR1ScYoAIkUF/31sMZY6qwu
         fv6nNGxQEFvWK6oqviW9DRvHQRT0Krrj4nKGj698//jCxWIQVgn6ke/72mM2K/Gnxr
         DkA1EWQi7wQiK0g4dI3PpeuEjxS7QwuVyYamsEKvbmDmiPR7TNDn9Lp0Z+4VY7ecZP
         cduPoa9JlTjgA==
Subject: Re: [V4l2-library] Macro Silicon M2106
To:     gert.cauwenberg@telenet.be
References: <1776591343.116854534.1582965890081.JavaMail.zimbra@telenet.be>
 <827808095.116935408.1582967209344.JavaMail.zimbra@telenet.be>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f3e95f98-1b70-d312-2cb7-467b4b31d72b@xs4all.nl>
Date:   Sat, 29 Feb 2020 13:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <827808095.116935408.1582967209344.JavaMail.zimbra@telenet.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNpgM0Krz7NHFxOL4ma/ESxICARZMbmeoVkQen5is3Syq8OnxClh1kY269OF6Vs9GTvxZ+g9YNEgp6bZDiOWSB0v6iplKUCx42RqlziIULzXw+SYqd4E
 D0D2u1USd1+cuh3QXPMnqLCS1FdE3SLJyjJV4Rn5nzOq7WW8BJgHTjstTktQrfg/PqnXQmrodLXB/xhu7wfX6H47RM5rJ/1ZOCd8JwQM9jhJ7noNYJVzSP95
 i34CwgJbLGx4EM79gT6Sa78yy7Lba1nIoq+H3YYLKa5/SC2ZyGQKueV8jzAkRb4xXoUpTQ8cxoqE3Frs4tgNYVNIk6avfkVjazsdVlnILRdHzQXaD9sBYilg
 NHWqWqFWHu0C3YPYnC477vMR7zhwCg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Gert,

(changed the mailinglist to linux-media since this topic is not related to libv4l2
and CCed Laurent who might know more about this)

On 2/29/20 10:06 AM, gert.cauwenberg@telenet.be wrote:
> Hello,
> 
> About a year ago a page about a new Easycap variant was added to the wiki -
> https://linuxtv.org/wiki/index.php/Talk:Easycap
> Has anybody been working on this? I just bought a video grabber - and it seems to be one of those...
> 
> Sold as BASETech BR116, but lsusb lists it as ID 534d:0021 MACROSILICON AV TO USB2.0

No, to my knowledge nobody is working on this.

It's not clear from the wiki what exactly is wrong, Laurent might have some insight in that.

Regards,

	Hans

> 
> Thanks,
> 
> 
> _______________________________________________
> V4L2-library mailing list
> V4L2-library@linuxtv.org
> https://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l2-library
> 

