Return-Path: <SRS0=/AoO=ZB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5AFC17441
	for <linux-media@archiver.kernel.org>; Sat,  9 Nov 2019 01:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14E21019
	for <linux-media@archiver.kernel.org>; Sat,  9 Nov 2019 01:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LypQTBmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIBZG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:25:06 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45779 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfKIBZF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 8 Nov 2019 20:25:05 -0500
Received: by mail-lj1-f177.google.com with SMTP id n21so8063437ljg.12
        for <linux-media@vger.kernel.org>; Fri, 08 Nov 2019 17:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fxYqauIzcrCRw2x4T+Y7Lqt6oIlxxuHFmspesCjtx5Y=;
        b=LypQTBmu+fdpZ5zexKm62yEP74Z918egIJM7+N/O+1UQdrp0rbSjRH47SLoe6Jd34I
         WiJqwfILX0fjXAU71+jWTOXHGRwZ/7pdVOsjnPVW4zdKmp5EkSibLHoN7n/c2BYUQfa8
         bsIXyg4N9lW/3YLjxILteiW1qRitd44F0VCB7k1TjHQ07smmSgHgre/ZiHlxa7x3qmUU
         8R+rxS0iHIIzCqU0PrfL1slN/90hbww2ERXTLpw6kFFt5NY5sZIQ/a87js3pTK6Dqozl
         0JJLPE2OiXpX4T0edmB3QzigolzPwphtoprSlKYkI7ASVNCXjUMRyj8n/frm9YzMzNZQ
         aU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fxYqauIzcrCRw2x4T+Y7Lqt6oIlxxuHFmspesCjtx5Y=;
        b=uiJs0YqTzhoSQ2ENxl6LLvPy1esC0ixLMoWfn0KLg+BIoQhvVIAklEyvoByXM1H8V6
         cHaZTdXVhgz6rgK0QumQwMzd73ZFnokX4g3Javx3dVoE4sJQR2+TDg4U8hx+3Kd4ojaL
         ABmYpz64lDBCdvnCEZ6P9JvVxXEkVn7S3HnmJ8MzlAGsIi+Q5FegNiHf2ZMhXQ5rXpri
         z1MQjb/Uy4A2iOG/ciULxvpYH7x5hJzzqyg58HKoZiw/Ae0zQolhz9Qb/7tpsSH8QAor
         bTrDd5I4F/Vqvv04LUk+uzpZakTYZeAzZfRtP9mOmgiltpgJvGTX4zHqgBboGeC0JKK2
         h5HA==
X-Gm-Message-State: APjAAAWYZy420BRjY6bMk4Y7URUxNYhkoq6yHGFpQOAKaLZfF4ZR4bM4
        Tphf5+PvHuJd2bSbURouEH4zji1LouWhRVWhSJ+fYQ==
X-Google-Smtp-Source: APXvYqw6u1cvQP6cosIkFUHSOcU6fp1IbKZStvhjOp06d+jlTmn07Vvz14AGWiUyBV7edztn3xCGStANDyv0H8tLGU0=
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr8451070lja.28.1573262703448;
 Fri, 08 Nov 2019 17:25:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:4249:0:0:0:0:0 with HTTP; Fri, 8 Nov 2019 17:25:02 -0800 (PST)
From:   Vincent McIntyre <vincent.mcintyre@gmail.com>
Date:   Sat, 9 Nov 2019 12:25:02 +1100
Message-ID: <CAEsFdVO+Wn6mSn8dC9D8yR9oy13c0943dM0Or6-55xT4dQTqXQ@mail.gmail.com>
Subject: [patch] support building against a particular kernel
To:     linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Support building against a particular kernel

I find it helpful to be able to build the linux-media modules
for a kernel other than the one I am currently running.

signed-off-by: vincent.mcintyre@gmail.com

diff --git a/build b/build
index 2f6b3f4..c2067e7 100755
--- a/build
+++ b/build
@@ -14,6 +14,7 @@ my $check_only = 0;
 my $main_git = 0;
 my $depth;
 my @git;
+my $kernel_version = '';

 my $main_git_url = "git://linuxtv.org/media_tree.git";
 my $main_branch = "master";
@@ -27,6 +28,7 @@ GetOptions('v|verbose' => \$level,
           'main_git|main-git' => \$main_git,
           'depth=i' => \$depth,
           'git=s{2}' => \@git,
+          'version=s' => \$kernel_version,
          ) or pod2usage(2);
 pod2usage(1) if $help;
 pod2usage(-exitstatus => 0, -verbose => 2) if $man;
@@ -522,7 +524,12 @@ print "******************\n";
 print "* Start building *\n";
 print "******************\n";

-run("make allyesconfig", "can't select all drivers");
+if ($kernel_version =~ /\S/) {
+    print "Building for kernel version $kernel_version\n";
+    run("make allyesconfig VER=$kernel_version", "can't select all drivers");
+} else {
+    run("make allyesconfig", "can't select all drivers");
+}
 run("make", "build failed");

 print "**********************************************************\n";
@@ -539,7 +546,7 @@ build - Builds the media drivers without needing
to compile a new kernel
 =head1 SYNOPSIS

 build [--help] [--man] [--verbose] [--check-only] [<--git> [URL] [BRANCH]]
- [--main-git] [--depth [DEPTH]]
+ [--main-git] [--depth [DEPTH]] [--version [KERNELVERSION]]

 =head1 OPTIONS

@@ -579,6 +586,11 @@ depth parameter, in order to get a smaller tree.

 That helps to reduce disk storage and download time.

+=item B<--version> [KERNELVERSION]
+
+Build for a kernel version other than the running kernel. The format of
+the KERNELVERSION string is the same as the output from 'uname -r'.
+
 =back

 =head1 DESCRIPTION
