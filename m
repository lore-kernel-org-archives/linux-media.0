Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03875C433E2
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 06:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970C52177B
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 06:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DkrMD+0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgIHGlB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgIHGlA (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 8 Sep 2020 02:41:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A97C061573
        for <linux-media@vger.kernel.org>; Mon,  7 Sep 2020 23:41:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B226635;
        Tue,  8 Sep 2020 08:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599547259;
        bh=li/lSqELN5fJrItXrMvNLCKi0qx0hPXYGOIXCBGzhA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkrMD+0d9f/F/aMub59fNA0z2C7B3CUsQ1rhK4eBN5BbJU+4DZWrkKEupZRZhgsNf
         QYzKSJnDFOHHXTGkCRk0pFqpTExw6nDAEQCG0qRSJH23CqC1U5pNG6NogKzSe33Dpb
         PQLMsQLrcoGUKeUxxLtJuOLVSpcZZywZ08lyysk0=
Date:   Tue, 8 Sep 2020 09:40:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     mchehab@kernel.org
Cc:     Jenkins Builder Robot <jenkins@linuxtv.org>,
        linux-media@vger.kernel.org, libcamera-devel@lists.libcamera.org
Subject: Re: [libcamera-devel] Build failed in Jenkins: libcamera #285
Message-ID: <20200908064032.GX6047@pendragon.ideasonboard.com>
References: <1076588385.8.1599495496997@builder.linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1076588385.8.1599495496997@builder.linuxtv.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

On Mon, Sep 07, 2020 at 04:18:16PM +0000, Jenkins Builder Robot wrote:
> See <https://builder.linuxtv.org/job/libcamera/285/display/redirect?page=changes>
> 
> Changes:
> 
> [kieran.bingham] meson: Provide build configuration summary
> 
> 
> ------------------------------------------
> Started by an SCM change
> Running as SYSTEM
> Building remotely on slave1 in workspace <https://builder.linuxtv.org/job/libcamera/ws/>
> No credentials specified
> Cloning the remote Git repository
> Cloning repository git://linuxtv.org/libcamera.git
>  > git init <https://builder.linuxtv.org/job/libcamera/ws/> # timeout=10
> Fetching upstream changes from git://linuxtv.org/libcamera.git
>  > git --version # timeout=10
>  > git --version # 'git version 2.20.1'
>  > git fetch --tags --force --progress -- git://linuxtv.org/libcamera.git +refs/heads/*:refs/remotes/origin/* # timeout=10
>  > git config remote.origin.url git://linuxtv.org/libcamera.git # timeout=10
>  > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
>  > git config remote.origin.url git://linuxtv.org/libcamera.git # timeout=10
> Fetching upstream changes from git://linuxtv.org/libcamera.git
>  > git fetch --tags --force --progress -- git://linuxtv.org/libcamera.git +refs/heads/*:refs/remotes/origin/* # timeout=10
>  > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
>  > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10
> Checking out Revision 094b3001fd7dc755f3a2804f7de73c09ea27dc8b (refs/remotes/origin/master)
>  > git config core.sparsecheckout # timeout=10
>  > git checkout -f 094b3001fd7dc755f3a2804f7de73c09ea27dc8b # timeout=10
> Commit message: "meson: Provide build configuration summary"
>  > git rev-list --no-walk 8117ab0a320029f97540aed2a9eebf3c759b8879 # timeout=10
> [libcamera] $ /bin/sh -xe /tmp/jenkins3670769587014002804.sh
> + rm -rf build
> + meson setup build
> The Meson build system
> Version: 0.49.2
> Source dir: <https://builder.linuxtv.org/job/libcamera/ws/>
> Build dir: <https://builder.linuxtv.org/job/libcamera/ws/build>
> Build type: native build
> Project name: libcamera
> Project version: 0.0.0
> Native C compiler: ccache cc (gcc 8.3.0 "cc (Debian 8.3.0-6) 8.3.0")
> Native C++ compiler: ccache c++ (gcc 8.3.0 "c++ (Debian 8.3.0-6) 8.3.0")
> Build machine cpu family: x86_64
> Build machine cpu: x86_64
> Header <execinfo.h> has symbol "backtrace" : YES
> Header <stdlib.h> has symbol "secure_getenv" : YES
> Compiler for C supports arguments -Wno-c99-designator -Wc99-designator: NO
> Configuring version.h using configuration
> Program openssl found: YES (/usr/bin/openssl)
> Library atomic found: YES
> Library dl found: YES
> Library gnutls found: YES
> Found pkg-config: /usr/bin/pkg-config (0.29)
> Dependency libudev found: YES 241
> Dependency threads found: YES 
> Dependency Boost found: NO 
> 
> src/ipa/raspberrypi/meson.build:5:0: ERROR:  Dependency "boost" not found

This isn't a new issue, it has been reported previously as a failure in
build #172 and then got resolved. Has anything changed on the build
server ?

> A full log can be found at <https://builder.linuxtv.org/job/libcamera/ws/build/meson-logs/meson-log.txt>
> Build step 'Execute shell' marked build as failure

-- 
Regards,

Laurent Pinchart
