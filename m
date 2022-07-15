Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F8AC433EF
	for <linux-media@archiver.kernel.org>; Fri, 15 Jul 2022 04:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiGOElk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Jul 2022 00:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGOElj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Jul 2022 00:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC278234
        for <linux-media@vger.kernel.org>; Thu, 14 Jul 2022 21:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1192062209
        for <linux-media@vger.kernel.org>; Fri, 15 Jul 2022 04:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116D9C34115
        for <linux-media@vger.kernel.org>; Fri, 15 Jul 2022 04:41:35 +0000 (UTC)
Date:   Fri, 15 Jul 2022 06:41:34 +0200
From:   "Hans Verkuil" <hverkuil@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: cron job: media_tree daily build: ERRORS
Message-Id: <20220715044136.116D9C34115@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This message is generated daily by a cron job that builds media_tree for
the kernels and architectures in the list below.

Results of the daily build of media_tree:

date:			Fri Jul 15 05:00:07 CEST 2022
media-tree git hash:	e670f5d672ef3d00b0b8c69eff09a019e6dd4ef9
media_build git hash:	0fe857b86addf382f6fd383948bd7736a3201403
v4l-utils git hash:	ae7f823bb2ea355bf2ea7039449ed2c71ec879be
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
linux-git-arm-multi: OK
linux-git-arm-davinci: OK
linux-git-powerpc64: OK
linux-git-arm-pxa: OK
linux-git-arm64: OK
linux-git-i686: OK
linux-git-x86_64: OK
Check COMPILE_TEST: WARNINGS: VIDEO_AR0521
Check for strcpy/strncpy/strlcpy: OK
apps: OK
spec-git: OK
virtme: OK: Final Summary: 2989, Succeeded: 2989, Failed: 0, Warnings: 0
virtme-32: OK: Final Summary: 3100, Succeeded: 3100, Failed: 0, Warnings: 0
sparse: OK
smatch: ERRORS
kerneldoc: OK

Detailed results are available here:

https://hverkuil.home.xs4all.nl/logs/Friday.log

Detailed regression test results are available here:

https://hverkuil.home.xs4all.nl/logs/Friday-test-media.log
https://hverkuil.home.xs4all.nl/logs/Friday-test-media-32.log
https://hverkuil.home.xs4all.nl/logs/Friday-test-media-dmesg.log

Full logs are available here:

https://hverkuil.home.xs4all.nl/logs/Friday.tar.bz2

The Media Infrastructure API from this daily build is here:

https://hverkuil.home.xs4all.nl/spec/index.html
