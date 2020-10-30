Return-Path: <SRS0=wnq3=EF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509DDC00A89
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E57206A1
	for <linux-media@archiver.kernel.org>; Fri, 30 Oct 2020 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uXGh8JrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ3JRM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:17:12 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:44997 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgJ3JRM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 30 Oct 2020 05:17:12 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id YQWwknNCJWvjMYQWzkGnXW; Fri, 30 Oct 2020 10:17:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1604049429; bh=VnmiyJcHe1NYpGUSeiZBiBBcgCzW9UrVttLTx0n4F6A=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=uXGh8JrEqn0ApTzz3T3mByzFr6xoryFXAUFP3U8Iy0thEvbVS93PptzHpPa3iB88i
         x9ME51ScTqkdps7Uq88abrOiMYJymvaRVg7Y/o+dAZLUQWLkUwubw5xr3Wsk7qL/7i
         b8byDTBnIhgnGE7Q/67NUqsmOqc0qNvi0IYFwAwkqiy00DQgjt6PnARHDtSc48UcqT
         3Aoq4ixTr4XX1lYMiQ2hYWQF7btU2w30D81x+bTdPvBMsRdB5mKb0+My6FpPDY0blJ
         iXcogzjAA0HhuKINrX0Cb3dkLb9UJSAqIgJETLH3eZ76zRYoOvaty0Lf7QihB6VlmG
         gC/U9wIXONDLw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Helen Koike <helen.koike@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.11] rkisp1 fixes/changes
Message-ID: <613dc41c-7174-7c32-7c28-c05ff1e8348c@xs4all.nl>
Date:   Fri, 30 Oct 2020 10:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKEigmnJ3lCrgqFvTsFS0kzgKlizudHmV0wWWg8YYLNd59uXxGuNFIydOWF7g1AYp6Dw98iMOwL4A36W3j8vRCIOVnsamgdb6Q/0KOduBgigKxRMq4tm
 bxpq5rVSbcbFSjf/D03TyrubybkM527LJlJDlh+OP+LWHJOXbx4sCVBFQOkFZNKsjWKIlbRjArQp+0UOITWtTr8Mqxlq5jG0qg7/k64bDJZLcqNEg8uDd0eC
 nSplvX/I6PGxOH2P1R/0aMAMzUHn4ueJ2XGqobNZtRA=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

After this series there are only a handful patches remaining before this
driver can be moved out of staging.

Dafna, I marked the patches that need a bit more work as 'Changes Requested'.
It looks like it isn't much work to make a new version of those few patches.
It would be nice to get this done early in the v5.11 cycle.

Regards,

	Hans

The following changes since commit dfe3d19bd092cefb184c6e65b881602c793edd33:

  Merge tag 'v5.10-rc1' into patchwork (2020-10-29 09:03:21 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.11b

for you to fetch changes up to 698e29d26ee79103310dd09a2b7ba09d9febd41a:

  media: MAINTAINERS: rkisp1: add path to dt-bindings (2020-10-30 10:02:18 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Dafna Hirschfeld (9):
      media: staging: rkisp1: remove TODO item to document quantization handling
      media: staging: rkisp1: validate links before powering and streaming
      media: staging: rkisp1: params: in stop_streaming, use list_splice_init to move the buffers
      media: staging: rkisp1: initialize buffer lists only on probe
      media: staging: rkisp1: remove the 'is_streaming' field from stats and params
      media: staging: rkisp1: params: remove unnecessary "!!"
      media: staging: rkisp1: params: remove unnecessary parentheses
      media: staging: rkisp1: uapi: add "WITH Linux-syscall-note"
      media: staging: rkisp1: capture: set default quantization on 'set_fmt'

Helen Koike (8):
      media: staging: rkisp1: cap: refactor enable/disable stream to allow multistreaming
      media: staging: dt-bindings: rkisp1: add missing required nodes
      media: staging: dt-bindings: rkisp1: drop i2c unit address
      media: staging: dt-bindings: rkisp1: re-order properties
      media: staging: dt-bindings: rkisp1: drop parent unit address
      media: staging: rkisp1: remove unecessary clocks
      dt-bindings: media: rkisp1: move rockchip-isp1 bindings out of staging
      media: MAINTAINERS: rkisp1: add path to dt-bindings

 .../devicetree/bindings/media/rockchip-isp1.yaml                     |  81 +++++++----
 MAINTAINERS                                                          |   2 +
 drivers/staging/media/rkisp1/TODO                                    |   4 -
 drivers/staging/media/rkisp1/rkisp1-capture.c                        | 241 ++++++++++++++++---------------
 drivers/staging/media/rkisp1/rkisp1-common.h                         |  12 +-
 drivers/staging/media/rkisp1/rkisp1-dev.c                            |   8 +-
 drivers/staging/media/rkisp1/rkisp1-params.c                         |  87 ++++-------
 drivers/staging/media/rkisp1/rkisp1-stats.c                          |  21 ---
 drivers/staging/media/rkisp1/uapi/rkisp1-config.h                    |   2 +-
 9 files changed, 216 insertions(+), 242 deletions(-)
 rename {drivers/staging/media/rkisp1/Documentation => Documentation}/devicetree/bindings/media/rockchip-isp1.yaml (81%)
