Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51ABC43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C932077B
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 09:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfDZJCN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:02:13 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:35239 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbfDZJCM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 05:02:12 -0400
Received: from [IPv6:2001:420:44c1:2579:108d:59b8:4aa1:d99c] ([IPv6:2001:420:44c1:2579:108d:59b8:4aa1:d99c])
        by smtp-cloud9.xs4all.net with ESMTPA
        id Jwk9hLsoNNExlJwkDhX1XB; Fri, 26 Apr 2019 11:02:10 +0200
Subject: Re: [STATUS UPDATE] test-media regression script status
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHYcWCa2E=?= <michal.galka@collabora.com>,
        kernelci@groups.io
References: <37927084-3fd6-51dc-9868-4c84cf034f38@xs4all.nl>
 <3c2c4099-b2cc-d925-8aff-6bbd3beb3837@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ba9dee5c-2f03-38d1-f3cf-0274ba1c27ff@xs4all.nl>
Date:   Fri, 26 Apr 2019 11:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3c2c4099-b2cc-d925-8aff-6bbd3beb3837@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDZy9Lo5LmZN/jk0j6Nh0Ebqs72AdOG0iqDicQD/6XfY2SjyeJOfqGtz3e50EZLSDB2WUklfSKg04x5Q4R34UaE79K+gGsrvZAJkIcFL+cKW9qPTIMXr
 7CtKbER/bb/qmATfmsuz7wwVBaly92VW+JG0++BKS5pMtd5k1lu6ORv8YmZLPpphgemdMLJP1BxXz68k8el8q3D9ef2BFXDdVNJW9D5+gFn42r1d+aCREIVq
 KKGbz0dDkPxeU0AFNcPE/ueE3EO8iCOEidAM5G40IyJxnXHLqMLo6pawaRyUVmcdSVceZxuL0vKsgNzKxSdYPdxgm3wKrMsgSwQgii3DUxSafx3q9kflOUDU
 N4MjCyYIwiAZ2lrhIDJXsDwbWcE1D717nBG515abGKWOp78L1TlcvZe9VarQ183lBf88eqzVU27LTdEDG+oNYdvijBm3ZwR1td4Qy0LAzohEL7nQP9wv185K
 cd/ZT3qnuXjMpFa5N3GTcM68d3drOKjxtvl0c+hnBcUbycEgRzCM2FCbAB5VWzTqicbJraW2vROlg2Dv7AM9+dJlIeP1OaZzEbxt7SOXotqKLzhVHkWPOCxj
 hZc=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/26/19 9:06 AM, Guillaume Tucker wrote:
> Hi Hans,
> 
> On 13/03/2019 08:54, Hans Verkuil wrote:
>> Hi all,
>>
>> As you all know I have been working on creating a regression test script
>> to help catch regressions before they get into released kernels.
>>
>> The test-media script is in v4l-utils, contrib/test. It is currently testing
>> with vivid, vim2m and vimc. Once vicodec is stable enough it will be added
>> to the test suite as well.
>>
>> It is already run as part of the daily build using a kernel config with many
>> debug options enabled.
> 
> Sounds great.  Out of interest, do you have a config fragment or
> the list of debug configs enabled in your builds somewhere?

https://git.linuxtv.org/hverkuil/build-scripts.git/tree/configs/virtme.config

> 
>> The daily build summary looks like this:
>>
>> 	virtme: OK: Final Summary: 1981, Succeeded: 1981, Failed: 0, Warnings: 14
>>
>> 	<snip>
>>
>> 	Detailed regression test results are available here:
>>
>> 	http://www.xs4all.nl/~hverkuil/logs/Wednesday-test-media.log
>> 	http://www.xs4all.nl/~hverkuil/logs/Wednesday-test-media-dmesg.log
>>
>> The daily build is currently only checking for failures in the compliance tests
>> and ignores warnings. It also ignores issues in the kernel log.
> [...]
> 
>> The test can be run on a system (or VM) running the kernel you want to test with
>> by simply running it as root.
>>
>> Usually for V4L2/MC changes it is enough to run it as:
>>
>> sudo test-media mc
>>
>> If you want the script to unload all media modules first, then add the -unload
>> option. If you want the script to scan for memory leaks (and the corresponding
>> debug option is enabled in the kernel), then add the -kmemleak option. To dump
>> the kernel log when done, add the -dmesg option.
>>
>> Run test-media without options to see a help text.
>>
>> Note that 'mc' is shorthand for 'vivid vim2m vimc'.
>>
>> There are also cec compliance tests and the 'all' test which tests everything
>> (used in the daily build). The cec tests are slow (especially the cec-pwr tests),
>> so unless you changed something in the cec subsystem you want to avoid running
>> those.
>>
>> The test script assumes that the very latest v4l-utils are installed.
> 
> This sounds very similar to what the KernelCI tests are doing.
> The main differences are that your script has a neater way of
> picking the media devices, and that the KernelCI tests break down
> the results into individual cases to spot regressions
> automatically [1].
> 
> At the moment we have a shell script to parse the output of
> v4l2-compliance to find each test case result.  Ultimately, it
> would be better to have some machine-readable output available,
> as I believe we've already agreed.  It should then enable
> KernelCI to run your test-media script directly, removing extra
> post-processing and making the system more robust.
> 
> If this sounds like a good idea then we can discuss how to
> proceed, i.e. agree on the format and command line options to
> enable it.  A popular format which would seem suitable for this
> is TAP 13 [2].  As Michał now has a fix to address the last issue
> with the KernelCI email reports, we should be available to work
> on this next.

Sure, not a problem. As long as the same command line option and same
format it implemented for both v4l2-compliance and cec-compliance.

It's probably best to write the machine-readable output to a file,
so an option like --tap13 <file> would be a natural choice.

Most (all?) tests are done like this:

               printf("\ttest VIDIOC_QUERYCAP: %s\n", ok(testCap(&node)));

This should probably change to:

	run_test("VIDIOC_QUERYCAP", testCap(&node));

And run_test() would then print the human readable text and, if enabled,
write the machine-readable results to a file.

There might be some corner cases where this is a bit more complex.

> 
> [...]
> 
>> Future plans (besides adding vicodec support) is adding support for other drivers
>> like uvc and perhaps au0828 (for testing the upcoming Media Device Allocator API).
>> But those tests require real hardware to be connected, and there may be different
>> variants of the same hardware. We'll see how that will work out.
> 
> This is obviously another strength of running the tests in
> KernelCI, such hardware could be added to an existing test lab.

Absolutely.

Regards,

	Hans

> 
> Best wishes,
> Guillaume
> 
> [1] https://people.collabora.com/~gtucker/kernelci/doc/v4l2-compliance-uvcvideo-5.1-rc6.txt
> [2] https://testanything.org/tap-version-13-specification.html
> 

