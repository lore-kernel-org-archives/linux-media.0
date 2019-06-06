Return-Path: <SRS0=7IOK=UF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C4C04AB5
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 12:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0552070B
	for <linux-media@archiver.kernel.org>; Thu,  6 Jun 2019 12:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfFFMLg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:11:36 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:49423 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfFFMLg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 6 Jun 2019 08:11:36 -0400
Received: from tschai.fritz.box ([46.9.252.75])
        by smtp-cloud7.xs4all.net with ESMTPA
        id YrExhzc7c3qlsYrF0hma8Q; Thu, 06 Jun 2019 14:11:34 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/9] vicodec: fixes and sync with v4 of codec spec
Date:   Thu,  6 Jun 2019 14:11:22 +0200
Message-Id: <20190606121131.37110-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOn0xyroRqL5QP8liqsoTsLycAN2IBYMo8Q3SNQCOA0k+iBTi8+pKVp8arNb/HcMLRnep9VamkauqlctVcItfilNYM/JmofT87+ttE719AFWE8JnEtL1
 RbMJnJh+HqaYKjUeta6XEgh4jc897u+bNU4YOPHae+s3mTbKUVwy8SJwGqot4gMlPo8yBiAYl3Ha9A==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series fixes a number of bugs and compliance failures in the
vicodec driver. Combined with new/fixed tests in v4l2-compliance
(see https://git.linuxtv.org/hverkuil/v4l-utils.git/log/?h=vicodec)
vicodec can now be used in regression testing.

There will probably be a few more changes once the codec spec is
finalized, but I'm hopeful that those changes will be minor.

Having this merged will make it easier to work on improved codec
core support in v4l2-mem2mem.c.

Regards,

	Hans

Hans Verkuil (9):
  vicodec: move v4l2_ctrl_request_complete after spin_unlock
  vicodec: always return a valid format.
  vicodec: fix initial stateless sizeimage value
  vicodec: pass on enc output format to capture side
  vicodec: add V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
  vicodec: set KEY/PFRAME flag when decoding
  vicodec: use correct sizeimage value when draining
  vicodec: stateless codecs do not have EOS and SOURCE_CHANGE events
  vicodec: improve handling of ENC_CMD_STOP/START

 drivers/media/platform/vicodec/vicodec-core.c | 257 ++++++++++++++----
 1 file changed, 199 insertions(+), 58 deletions(-)

-- 
2.20.1

