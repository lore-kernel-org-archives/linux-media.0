Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DAEC64E7B
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D29D2084C
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 12:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="s2/JI1pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgLAMpc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:45:32 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:38041 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728623AbgLAMpc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 1 Dec 2020 07:45:32 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id k51SkssSADuFjk51Wk2RXz; Tue, 01 Dec 2020 13:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1606826690; bh=DUmPpsQQfap12+4P0438mc8sEcvY//9EmKgUyqufcRo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=s2/JI1pzXxW9QUPShjiU5WVmw/3Xihayn+FP0osK6KpDzpRs/qDtTFVqyNlSEjxOd
         j+THZnMs/S2zu/4VHfOUuU0UHWyfVw5HldF51K3XWojpED5G+AxAzrLN5GsCk3CQXI
         tbMWe6XqhB2Om+kUzL5qx1we5Y3wxFFonAl4J42v8A7ZOUt/xkXOG0zI3/hzw4OVIs
         ctS/nWFvcJ7GbxrtT7fCUm+cgbYIJtpj1ceUxDitzv6B6Fdzslsqpcyz1nBfoi6q4W
         lyolLYq8dVSfUruw4Vu18fDHbA+RowsbO06UdZkR7UygyymE5FMSA/YUBDumgLgLh0
         +lBLhXHqLyEFw==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv3 0/7] media: poll fixes
Date:   Tue,  1 Dec 2020 13:44:39 +0100
Message-Id: <20201201124446.448595-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFkHQGEe/WNE17j2Pqpap/I6PUyHGeDV+XAwspn8n04YoldWB3SG1os5YmmaHEO8O2DYHvzAsTuGAy9KEibQhJWP+8d2KtFBGo89vNSkFYVL3bNJ7Wns
 R+MjOyFFvIlFZS9PXyL49MklCX/5NlrTcMAeW5HNHnipF+LmGjN+lRXDigdSiIpVUuJtPmGC9Kpf3xHBG3H5SormMS0rSZY9Kg5mbRpMuBQo9uJlPwt3NRvW
 OaQwIPYs8zLiC07GFGQTvWnqzvcR51IL8iQQksWBM9gDuiqSfAM6J/cU4S2x+XBp
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series fixes various poll bugs.

The first patch fixes a vivid bug w.r.t. the disconnect error injection.
It is identical to:

https://patchwork.linuxtv.org/project/linux-media/patch/74c0afae-3925-29c2-fa73-6c773c8d10c6@xs4all.nl/

This fix allows us to test disconnect using vivid in v4l2-compliance
(a patch for that will be posted separately).

The next two patches are from Alexandre and are unchanged from his
v2 series:

https://patchwork.linuxtv.org/project/linux-media/cover/20201123151843.798205-1-gnurou@gmail.com/

See that link for more info about these two patches.

The fourth patch introduces v4l2_event_wake_all(), which needs to
be called when unregistering a video device since otherwise any
processes that wait for an event won't wake up.

The fifth patch does the same for the vivid disconnect error
injection functionality. Again, this allows us to test that this
works using vivid and v4l2-compliance.

The last two patches add EPOLLPRI to the event mask when poll()
sees that the video or cec device is unregistered. This is needed
because if select() is called and it only checks for exceptions,
then it will only return if EPOLLPRI is set.

I'll post a patch for v4l2-compliance separately that will test
this special case using vivid.

Regards,

	Hans

Alexandre Courbot (2):
  media: videobuf2: always call poll_wait() on queues
  media: v4l2-mem2mem: always call poll_wait() on queues

Hans Verkuil (5):
  vivid: fix 'disconnect' error injection
  v4l2-dev/event: add v4l2_event_wake_all()
  vivid: call v4l2_event_wake_all() on disconnect
  v4l2-dev: add EPOLLPRI in v4l2_poll() when dev is unregistered
  cec: add EPOLLPRI in poll() when dev is unregistered

 drivers/media/cec/core/cec-api.c              |  2 +-
 .../media/common/videobuf2/videobuf2-core.c   | 11 +++-
 drivers/media/test-drivers/vivid/vivid-core.c | 65 ++++++++++++-------
 drivers/media/test-drivers/vivid/vivid-core.h |  1 +
 .../media/test-drivers/vivid/vivid-ctrls.c    | 27 +++++---
 drivers/media/v4l2-core/v4l2-dev.c            | 15 +++--
 drivers/media/v4l2-core/v4l2-event.c          | 17 +++++
 drivers/media/v4l2-core/v4l2-mem2mem.c        | 15 ++++-
 include/media/v4l2-event.h                    | 13 +++-
 9 files changed, 123 insertions(+), 43 deletions(-)

-- 
2.29.2

