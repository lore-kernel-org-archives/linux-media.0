Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398BFC74A44
	for <linux-media@archiver.kernel.org>; Sun, 12 Mar 2023 02:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCLCI2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLCI0 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 11 Mar 2023 21:08:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB511DBA7
        for <linux-media@vger.kernel.org>; Sat, 11 Mar 2023 18:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C400260EA1
        for <linux-media@vger.kernel.org>; Sun, 12 Mar 2023 02:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2725C433D2
        for <linux-media@vger.kernel.org>; Sun, 12 Mar 2023 02:08:23 +0000 (UTC)
Date:   Sun, 12 Mar 2023 03:08:21 +0100
Message-ID: <be70568b4abe8b777dec4bac9b7c5710.hverkuil@xs4all.nl>
From:   "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: cron job: media_tree daily build: ERRORS
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This message is generated daily by a cron job that builds media_tree for
the kernels and architectures in the list below.

Results of the daily build of media_tree:

date:			Sun Mar 12 03:00:08 CET 2023
media-tree git hash:	3e62aba8284de0994a669d07983299242e68fe72
media_build git hash:	0fe857b86addf382f6fd383948bd7736a3201403
v4l-utils git hash:	0a195181d771090f3c99d4a6ddb8151352509061
edid-decode git hash:	2d44e1b01c7ed7d65b20ecdce62d354841832201
gcc version:		i686-linux-gcc (GCC) 12.2.0
sparse repo:            git://git.kernel.org/pub/scm/devel/sparse/sparse.git
sparse version:		v0.6.4-39-gce1a6720-dirty
smatch repo:            git://repo.or.cz/smatch.git
smatch version:		v0.5.0-8291-ga0a35953-dirty
build-scripts repo:     https://git.linuxtv.org/hverkuil/build-scripts.git
build-scripts git hash: 3d2e7557e9d6b1ef39814a7580f6483836a79792
host hardware:		x86_64
host os:		6.1.0-5-amd64

linux-git-sh: OK
linux-git-arm-at91: OK
linux-git-arm-davinci: OK
linux-git-arm-stm32: OK
linux-git-arm-pxa: OK
linux-git-mips: OK
linux-git-arm-multi: OK
linux-git-powerpc64: OK
linux-git-arm64: OK
linux-git-i686: OK
linux-git-x86_64: OK
Check COMPILE_TEST: WARNINGS: VIDEOBUF_DMA_CONTIG
Check for strcpy/strncpy/strlcpy: OK
apps: ERRORS
spec-git: OK
virtme: ERRORS: Final Summary: 1, Succeeded: 0, Failed: 1, Warnings: 0
virtme-32: ERRORS
sparse: OK
smatch: WARNINGS
kerneldoc: OK

Detailed results are available here:

https://hverkuil.home.xs4all.nl/logs/Sunday.log

Detailed regression test results are available here:

https://hverkuil.home.xs4all.nl/logs/Sunday-test-media.log
https://hverkuil.home.xs4all.nl/logs/Sunday-test-media-32.log
https://hverkuil.home.xs4all.nl/logs/Sunday-test-media-dmesg.log

Full logs are available here:

https://hverkuil.home.xs4all.nl/logs/Sunday.tar.bz2

The Media Infrastructure API from this daily build is here:

https://hverkuil.home.xs4all.nl/spec/index.html
