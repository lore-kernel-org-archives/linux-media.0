Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195DEC43334
	for <linux-media@archiver.kernel.org>; Sat,  9 Jul 2022 04:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGIEot (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 9 Jul 2022 00:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGIEor (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 9 Jul 2022 00:44:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117A3CBDB
        for <linux-media@vger.kernel.org>; Fri,  8 Jul 2022 21:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 393E1B8255E
        for <linux-media@vger.kernel.org>; Sat,  9 Jul 2022 04:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF4CC3411C
        for <linux-media@vger.kernel.org>; Sat,  9 Jul 2022 04:44:42 +0000 (UTC)
Date:   Sat, 09 Jul 2022 06:44:40 +0200
From:   "Hans Verkuil" <hverkuil@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: cron job: media_tree daily build: ERRORS
Message-Id: <20220709044442.7CF4CC3411C@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This message is generated daily by a cron job that builds media_tree for
the kernels and architectures in the list below.

Results of the daily build of media_tree:

date:			Sat Jul  9 05:00:08 CEST 2022
media-tree git hash:	e670f5d672ef3d00b0b8c69eff09a019e6dd4ef9
media_build git hash:	0fe857b86addf382f6fd383948bd7736a3201403
v4l-utils git hash:	33ad0c66db3aac8a9d72864ac84a2fb65d7a6878
edid-decode git hash:	582c935652b0303b87ddad4551e6f97f8bb883ac
gcc version:		i686-linux-gcc (GCC) 11.2.0
sparse repo:            git://git.kernel.org/pub/scm/devel/sparse/sparse.git
sparse version:		v0.6.4-39-gce1a6720-dirty
smatch repo:            git://repo.or.cz/smatch.git
smatch version:		v0.5.0-8093-gc82b58a1-dirty
build-scripts repo:     https://git.linuxtv.org/hverkuil/build-scripts.git
build-scripts git hash: d4d7757a52e4d94afde49d3080442d11dda83573
host hardware:		x86_64
host os:		5.18.0-2-amd64

linux-git-sh: OK
linux-git-mips: OK
linux-git-arm-stm32: OK
linux-git-arm-at91: OK
linux-git-arm-davinci: OK
linux-git-arm-multi: OK
linux-git-arm-pxa: OK
linux-git-powerpc64: OK
linux-git-arm64: OK
linux-git-i686: OK
linux-git-x86_64: OK
Check COMPILE_TEST: WARNINGS: VIDEO_AR0521
Check for strcpy/strncpy/strlcpy: OK
apps: OK
spec-git: OK
virtme: OK: Final Summary: 2989, Succeeded: 2989, Failed: 0, Warnings: 0
virtme-32: WARNINGS: Final Summary: 3100, Succeeded: 3100, Failed: 0, Warnings: 3
sparse: OK
smatch: ERRORS
kerneldoc: OK

Detailed results are available here:

https://hverkuil.home.xs4all.nl/logs/Saturday.log

Detailed regression test results are available here:

https://hverkuil.home.xs4all.nl/logs/Saturday-test-media.log
https://hverkuil.home.xs4all.nl/logs/Saturday-test-media-32.log
https://hverkuil.home.xs4all.nl/logs/Saturday-test-media-dmesg.log

Full logs are available here:

https://hverkuil.home.xs4all.nl/logs/Saturday.tar.bz2

The Media Infrastructure API from this daily build is here:

https://hverkuil.home.xs4all.nl/spec/index.html
