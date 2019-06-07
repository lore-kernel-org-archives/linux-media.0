Return-Path: <SRS0=oUk/=UG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF8C2BCA1
	for <linux-media@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCE5212F5
	for <linux-media@archiver.kernel.org>; Fri,  7 Jun 2019 10:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfFGK6y (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:58:54 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:46245 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbfFGK6y (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 7 Jun 2019 06:58:54 -0400
Received: from [IPv6:2001:420:44c1:2579:fc93:b89a:45f9:2c8a] ([IPv6:2001:420:44c1:2579:fc93:b89a:45f9:2c8a])
        by smtp-cloud7.xs4all.net with ESMTPA
        id ZCa9hCYID3qlsZCaChsEyq; Fri, 07 Jun 2019 12:58:53 +0200
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.3] vicodec fixes
Message-ID: <c7fa2fed-5f34-3999-aa0d-939206ddb281@xs4all.nl>
Date:   Fri, 7 Jun 2019 12:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBk3H2FmVulsEqFb8lDpkILBTPuWGhpVlPSeKKwqW2aqxpyD5Z5yzhHVscmG1JcDbPlmcXvS5HPf1NnJYyK2KAdkSs++Y7jXLg25NcEjfULb/Kj/zpUP
 RBddIhnXdGUthnfOnk9E+m1zn0nvnmpJobI7bkSYUHkdzQYMD7051QqIvRLDNg22vyYJLgW8pvqenfq3SBuIarC0YIJYeB1ZNyjkNHQ0PVVPMtMJu/XAFho3
 ls9WgQsALvM3WGGXPmpCYSAF24l7FuJ6okDbZcbnaocyVqQCMfgh98EGhDOXWMUs
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch series brings vicodec in line with v4 of the stateful codec
specification.

The next step after this is to make v4l2-mem2mem.c more intelligent
so some of the complexity can be offloaded from the driver to the core.

Regards,

	Hans

The following changes since commit edadd68031e5b7c1ba0c413a9549dce62a02844c:

  media: MAINTAINERS: update email address (2019-06-05 15:58:40 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.3n

for you to fetch changes up to be5d313f7b3458484bfbc505ebedc9538a031971:

  vicodec: improve handling of ENC_CMD_STOP/START (2019-06-06 13:55:42 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
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

 drivers/media/platform/vicodec/vicodec-core.c | 257 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 199 insertions(+), 58 deletions(-)
