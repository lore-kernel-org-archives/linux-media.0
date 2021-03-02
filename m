Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE4C4361A
	for <linux-media@archiver.kernel.org>; Tue,  2 Mar 2021 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591864F23
	for <linux-media@archiver.kernel.org>; Tue,  2 Mar 2021 17:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580240AbhCBRaz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Mar 2021 12:30:55 -0500
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:41533 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1578125AbhCBKfu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Mar 2021 05:35:50 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id H2MqlKlzoC40pH2Mulm6F0; Tue, 02 Mar 2021 11:35:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1614681308; bh=XxDrZDnZsyfUIAs9jd3e9RA2Lj6Ik5UXEZfwkBtLNlg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=VKydw3Q73edvsh8SCgh5jGzffkwg2PTftNkdjoE2c8I0zRdtAALntySCJx21zGANt
         DY5WK+C/Fak8EgiKFaB9E1vMBzTifaemieBRvPgZxKqtAFB5IFP+R6poy8FzDh65+H
         EuBzeR9ncm5WuGd+wIzvav0IqHnseVjotRlRgbKmBpN4pP3LE2PiA8C7QIiL9QLizD
         4qxOQlXRth6RVulUJp1rBDwR8WJodaujlgNZuBFfdS/fTzBNQCw2I+FRIKosXqMkmd
         LUK5gSgSQh5oOlTRZATPMwerUM5+RTSrkas/PeJPgkf3TOaIQEThx+Bwkxg2AufXx3
         8tQKDwcNt6/Og==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 0/2] v4l-utils: fix gettext problems
Date:   Tue,  2 Mar 2021 11:34:56 +0100
Message-Id: <20210302103458.819043-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOE/rhnHDjmszu4cYYwmvRspQ1M8KiVR7C7BhBrEKx4JcjRAQTTJIU3GBSZzk/x8zvymOl0uB8NiYFrhG8Z0ZMUWp/C9KFrFbU4PaOSrK0cdDLBFsxo8
 cjiWJQik0fqqZjfHrbFOaPUbqnOWB9qPs4VsZN9J+GninTMFVtBg1xJ22leVjjAM3FOoUH7yvZ+E3SVpzdv6le9BWwqwPZQqvwM+AKf7mb9NDXmawgAPF3LW
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Building with a gettext 0.21 environment caused various issues:

- configure.ac was updated automatically to a newer AM_GNU_GETTEXT_VERSION
  which is not something you want since it is under revision control.

- after a clean clone running make causes this error:
  *** error: gettext infrastructure mismatch: using a Makefile.in.in from
  gettext version 0.20 but the autoconf macros are from gettext
  version 0.19

These two patches fix these issues. Tested with both gettext 0.21 and
gettext 0.19.8. Autoconf was at 2.69.

Hopefully this will keep working once autoconf is bumped to 2.70.


