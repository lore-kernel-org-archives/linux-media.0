Return-Path: <SRS0=nUH2=4K=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DA9C35671
	for <linux-media@archiver.kernel.org>; Sat, 22 Feb 2020 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEAB208C3
	for <linux-media@archiver.kernel.org>; Sat, 22 Feb 2020 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ozAGN4Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgBVL20 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:28:26 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:40285 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgBVL20 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 22 Feb 2020 06:28:26 -0500
Received: from [192.168.2.10] ([46.9.235.248])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 5SxIjzoxuPKvK5SxMjjud9; Sat, 22 Feb 2020 12:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582370904; bh=41VepjGwikv0CygR2YEl2g2PwjMr0oKYq3quSghw3Zk=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=ozAGN4OhwulB8XBwFRsUtXay5hecdLdlVePt4ESF0aoKbyZYgi76hJCgWumQu5Jpw
         8Rm+B3CERCViFVhO5DWShBpQyQTwAWDEwMUB0j7DmNS1swPX5kLpJw83UwsSaQCU0b
         YHuTuxM7GLnwQxvOCGsBL3mSbONOnVnMHUoTGAY/IhSaJNNYQBEaO/xLijbrFToBOE
         5+qiE9MQLykWum0M0A2A8YwxXCxeUJw4wRLZ/KxIJiyGB07VHYOLwipIaDC15PfKAf
         qt8vgsIaeAOqwxCtUIrbEeacprw2IZiWXMUfRVKSvriXom8l5NFUAowLOcfS+Eu29/
         w2fAFWXIqbPIw==
Subject: Re: cron job: media_tree daily build: ERRORS
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     linux-media@vger.kernel.org
References: <597f67aedc9d984674a3d8f8010b5883@smtp-cloud9.xs4all.net>
Message-ID: <ee6d223f-4a1e-dd23-13f2-f15a71787332@xs4all.nl>
Date:   Sat, 22 Feb 2020 12:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <597f67aedc9d984674a3d8f8010b5883@smtp-cloud9.xs4all.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNUOjNeO+jSItuxB7F1Xw7uINde1YUKI24lhImCEMvRUkYjG6ALz/u4X1SChbIi/sOFdrHF8tSL8tv2x76X2+mU9PLYfBFnbfV8lYlYtfdxOo0Np+ExD
 /ZrIEXOhF/3QlA6F7tozUBiWJ0wbrmVJJKveWPEpr+ujvNjfUW8mXQMW5fzOwUWRRNBqaLTAdKKeIQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2/22/20 5:58 AM, Hans Verkuil wrote:
> virtme: ERRORS: Final Summary: 2943, Succeeded: 2925, Failed: 18, Warnings: 0
> sparse: OK
> smatch: OK
> 
> Detailed results are available here:
> 
> http://www.xs4all.nl/~hverkuil/logs/Saturday.log
> 
> Detailed regression test results are available here:
> 
> http://www.xs4all.nl/~hverkuil/logs/Saturday-test-media.log

Looking at this it turns out that the new tests I added in v4l2-compliance
to check for USERPTR overwrites before the start/after the end of the
buffer caused failures in vivid and vim2m.

There was also a bug in the compliance code that turned one test in a NOP.
I've improved the compliance code, and unfortunately I'm now also getting
warnings in vimc and vicodec. I'll dig more into this on Monday.

It's an interesting test, and if it finds real bugs, then it would be
interesting to see if similar tests can be made for the MMAP streaming mode,
since ALL drivers support that.

Also, this test is only done with the configured format when v4l2-compliance
is called. There is a separate test that tries to stream with all available
formats, but that is MMAP-only. It would be interesting to support USERPTR
there as well.

Regards,

	Hans

> http://www.xs4all.nl/~hverkuil/logs/Saturday-test-media-dmesg.log
> 
> Full logs are available here:
> 
> http://www.xs4all.nl/~hverkuil/logs/Saturday.tar.bz2
> 
> The Media Infrastructure API from this daily build is here:
> 
> http://www.xs4all.nl/~hverkuil/spec/index.html
> 

