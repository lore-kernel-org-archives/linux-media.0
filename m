Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F41C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30F6218A2
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 15:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfC2P30 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:29:26 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:35417 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728720AbfC2P3Z (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 11:29:25 -0400
Received: from test-no.fritz.box ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9tRYhPNkWUjKf9tRchwWqH; Fri, 29 Mar 2019 16:29:24 +0100
From:   hverkuil-cisco@xs4all.nl
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna3@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [RFC PATCH 0/5] vicodec: sync with stateful codec specs
Date:   Fri, 29 Mar 2019 16:29:15 +0100
Message-Id: <20190329152920.30179-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfC2k2zGZ74dUk36SqrnOE6Rybhehj+vS4rBH6Ifr424c6+AMeZpDHsdw6NEI/tOTcnr57WRKGjmUSG6oF0x0l8BKGWrlFRweYgEMMgMtYqyCLH9C9O7v
 GudIHCec00RSQ5qjX2zrJ/4rEPMbQ/FEb82o9aTq+kTTnE7UwDodq5z3Qpmaa0QYNKoe5xPvOkhu4IQ02ftGvFsom2PbGdQZBqHNP1m7sAG5BOXWl1JEzeaM
 FTdj4RtZa4JH4VOUTgizHQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

This RFC series fixes vicodec to conform to the upcoming version
of the codec specs.

This is RFC since the decoder side isn't done yet (missing compliance
tests) and the last patch isn't fully verified.

I pushed most of the compliance tests for the stateful encoder, but
some depend on the final OK from Tomasz. You can find the latest
version here:

https://git.linuxtv.org/hverkuil/v4l-utils.git/log/?h=vicodec

Regards,

	Hans

Hans Verkuil (5):
  vicodec: always return a valid format.
  vicodec: pass on enc output format to capture side
  vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
  videobuf2-v4l2: set last_buffer_dequeued in dqbuf
  vicodec: improve handling of ENC_CMD_STOP/START

 .../media/common/videobuf2/videobuf2-v4l2.c   |  10 +-
 drivers/media/platform/vicodec/vicodec-core.c | 216 ++++++++++++++----
 2 files changed, 177 insertions(+), 49 deletions(-)

-- 
2.20.1

