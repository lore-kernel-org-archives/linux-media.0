Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F3C43218
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1452089E
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 07:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfDZHGG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:06:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZHGG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 03:06:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id E4E20260BC9
Subject: Re: [STATUS UPDATE] test-media regression script status
To:     Hans Verkuil <hverkuil@xs4all.nl>
References: <37927084-3fd6-51dc-9868-4c84cf034f38@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHYcWCa2E=?= <michal.galka@collabora.com>,
        kernelci@groups.io
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <3c2c4099-b2cc-d925-8aff-6bbd3beb3837@collabora.com>
Date:   Fri, 26 Apr 2019 08:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <37927084-3fd6-51dc-9868-4c84cf034f38@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

On 13/03/2019 08:54, Hans Verkuil wrote:
> Hi all,
> 
> As you all know I have been working on creating a regression test script
> to help catch regressions before they get into released kernels.
> 
> The test-media script is in v4l-utils, contrib/test. It is currently testing
> with vivid, vim2m and vimc. Once vicodec is stable enough it will be added
> to the test suite as well.
> 
> It is already run as part of the daily build using a kernel config with many
> debug options enabled.

Sounds great.  Out of interest, do you have a config fragment or
the list of debug configs enabled in your builds somewhere?

> The daily build summary looks like this:
> 
> 	virtme: OK: Final Summary: 1981, Succeeded: 1981, Failed: 0, Warnings: 14
> 
> 	<snip>
> 
> 	Detailed regression test results are available here:
> 
> 	http://www.xs4all.nl/~hverkuil/logs/Wednesday-test-media.log
> 	http://www.xs4all.nl/~hverkuil/logs/Wednesday-test-media-dmesg.log
> 
> The daily build is currently only checking for failures in the compliance tests
> and ignores warnings. It also ignores issues in the kernel log.
[...]

> The test can be run on a system (or VM) running the kernel you want to test with
> by simply running it as root.
> 
> Usually for V4L2/MC changes it is enough to run it as:
> 
> sudo test-media mc
> 
> If you want the script to unload all media modules first, then add the -unload
> option. If you want the script to scan for memory leaks (and the corresponding
> debug option is enabled in the kernel), then add the -kmemleak option. To dump
> the kernel log when done, add the -dmesg option.
> 
> Run test-media without options to see a help text.
> 
> Note that 'mc' is shorthand for 'vivid vim2m vimc'.
> 
> There are also cec compliance tests and the 'all' test which tests everything
> (used in the daily build). The cec tests are slow (especially the cec-pwr tests),
> so unless you changed something in the cec subsystem you want to avoid running
> those.
> 
> The test script assumes that the very latest v4l-utils are installed.

This sounds very similar to what the KernelCI tests are doing.
The main differences are that your script has a neater way of
picking the media devices, and that the KernelCI tests break down
the results into individual cases to spot regressions
automatically [1].

At the moment we have a shell script to parse the output of
v4l2-compliance to find each test case result.  Ultimately, it
would be better to have some machine-readable output available,
as I believe we've already agreed.  It should then enable
KernelCI to run your test-media script directly, removing extra
post-processing and making the system more robust.

If this sounds like a good idea then we can discuss how to
proceed, i.e. agree on the format and command line options to
enable it.  A popular format which would seem suitable for this
is TAP 13 [2].  As Michał now has a fix to address the last issue
with the KernelCI email reports, we should be available to work
on this next.

[...]

> Future plans (besides adding vicodec support) is adding support for other drivers
> like uvc and perhaps au0828 (for testing the upcoming Media Device Allocator API).
> But those tests require real hardware to be connected, and there may be different
> variants of the same hardware. We'll see how that will work out.

This is obviously another strength of running the tests in
KernelCI, such hardware could be added to an existing test lab.

Best wishes,
Guillaume

[1] https://people.collabora.com/~gtucker/kernelci/doc/v4l2-compliance-uvcvideo-5.1-rc6.txt
[2] https://testanything.org/tap-version-13-specification.html
