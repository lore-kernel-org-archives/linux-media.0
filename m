Return-Path: <SRS0=yEzF=V2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C0C7618B
	for <linux-media@archiver.kernel.org>; Mon, 29 Jul 2019 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719BD2073F
	for <linux-media@archiver.kernel.org>; Mon, 29 Jul 2019 09:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfG2Jiq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:38:46 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:53215 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbfG2Jip (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 Jul 2019 05:38:45 -0400
Received: from [IPv6:2001:983:e9a7:1:3159:f139:4aff:7185] ([IPv6:2001:983:e9a7:1:3159:f139:4aff:7185])
        by smtp-cloud9.xs4all.net with ESMTPA
        id s279heLmCAffAs27AhgJ6t; Mon, 29 Jul 2019 11:38:44 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Johan Korsnes <johan.korsnes@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.3] vivid: fix missing cec adapter name
Message-ID: <2225b9ee-ea7f-f238-ae43-faf0a157898b@xs4all.nl>
Date:   Mon, 29 Jul 2019 11:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGMKqZTTkdjV6kWUp3a56EB9a2A/udkotAccuFibWng0ZORJ51FIH6mZiK5n4NElqCSreeBiZCHns1rhF081rZiw2vNelUhU9HYQTODvT6G4mp64oz5u
 TzsIkgQ6WfoAGkW7nrVCsn7oyEaneuucpu6hXNeslrwem2dfZXu19GEb9ks8ly5gJ1+CnRoFq/iAz7WRzDz7FZL9kllJiIi02hqPpnFMzhDlTMYPpoRdVtFc
 Y9iX30w1AdCZks/nGhdt9eg7K8vJuCg6DotwojZ+Ox0AOzgUr75iqRLbP1DGuTmNBOIIQbB50OEfG4z7LH1Zbg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Mauro,

Just one fix for vivid: this bug causes a regression in the test-media
cec tests.

Regards,

	Hans

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.3b

for you to fetch changes up to 1ff571f0d9ca71d799201d26ba154e5ef3457a9c:

  vivid: fix missing cec adapter name (2019-07-29 11:35:19 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      vivid: fix missing cec adapter name

 drivers/media/platform/vivid/vivid-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
