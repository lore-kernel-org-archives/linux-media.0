Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363622EF4
	for <linux-media@vger.kernel.org>; Tue, 20 Aug 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118779; cv=none; b=ni9JvMBZCEXurIBltKAzXwZ7zWV6MumiOjmiZDchWfxSNfQwt7Fz4lb3xLXSrazkXseFtNhogoAc3zSyU3CgJQ/jtz4wrqspnHKEJGK6hto+AqIlUNOU25cIsSclG3NH/CgytrXSDmxWaVZnyyoAu4kRZJK5vKTfERZvrAarGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118779; c=relaxed/simple;
	bh=XubxA/ZtJBGonWhTZmftnDM+Gp+X5yTOfMX5/F0u/gE=;
	h=Date:From:To:Subject:Message-Id; b=rIiBXg3PtcXhJjLiAzAwNDB621JwZ8scwu4YrADRqMqkflWaBxD8WkJxNILuxUNIIzjFWvT2ONTDh63aWUldAa6vKtfMIw6hulYaLFDeETSD7XwfS9CgdUsreFVg6I0f975aUCg0wYv7MjTbJKv8Ft/hU/LRo6b7C0N5LBGLeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E6C32782
	for <linux-media@vger.kernel.org>; Tue, 20 Aug 2024 01:52:58 +0000 (UTC)
Date: Tue, 20 Aug 2024 03:52:56 +0200
From: "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
To: linux-media@vger.kernel.org
Subject: cron job: media_tree daily build: OK
Message-Id: <20240820015258.EE4E6C32782@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>

This message is generated daily by a cron job that builds media_tree for
the architectures in the list below.

Results of the daily build of media_tree:

date:			Tue Aug 20 03:00:13 CEST 2024
media-tree git repo:	git://linuxtv.org/hverkuil/media_tree.git
media-tree git branch:	media_stage/master
media-tree git hash:	a043ea54bbb975ca9239c69fd17f430488d33522
v4l-utils git hash:	a1ebb4dad512025a7fbb2e7ff6ab6e5f5e604987
edid-decode git hash:	590a1ae57a3be3d590b5ab401086e7ec9672e3f5
gcc version:		i686-linux-gcc (GCC) 14.1.0
smatch/sparse repo:     git://repo.or.cz/smatch.git
smatch version:		v0.5.0-8688-g8ea74b5a
sparse version:		v0.5.0-8688-g8ea74b5a
build-scripts repo:     https://git.linuxtv.org/hverkuil/build-scripts.git
build-scripts git hash: 6315b97764c964464fbdbae5543cfd95225e251a
host hardware:		x86_64
host os:		6.5.0-35-generic

linux-git-arm: OK
linux-git-powerpc64: OK
linux-git-arm64: OK
linux-git-i686: OK
linux-git-x86_64: OK
no-of.config: OK
no-acpi.config: OK
no-pm.config: OK
no-pm-sleep.config: OK
no-debug-fs.config: OK
sparse: OK
smatch: OK
COMPILE_TEST: OK
strcpy/strncpy/strlcpy: OK
abi-compliance: ABI OK
pahole: ABI OK
utils: OK
spec-git: OK
kerneldoc: OK

date:			Tue Aug 20 03:13:36 CEST 2024
virtme-64: OK: Final Summary: 3435, Succeeded: 3435, Failed: 0, Warnings: 0
virtme-32: OK: Final Summary: 3546, Succeeded: 3546, Failed: 0, Warnings: 0

date:			Tue Aug 20 03:51:51 CEST 2024

Detailed results are available here:

https://hverkuil.home.xs4all.nl/logs/Tuesday.log

Detailed regression test results are available here:

https://hverkuil.home.xs4all.nl/logs/Tuesday-test-media-64.log
https://hverkuil.home.xs4all.nl/logs/Tuesday-test-media-64-dmesg.log
https://hverkuil.home.xs4all.nl/logs/Tuesday-test-media-32.log
https://hverkuil.home.xs4all.nl/logs/Tuesday-test-media-32-dmesg.log

Full logs are available here:

https://hverkuil.home.xs4all.nl/logs/Tuesday.tar.bz2

The Media Infrastructure API from this daily build is here:

https://hverkuil.home.xs4all.nl/spec/index.html
