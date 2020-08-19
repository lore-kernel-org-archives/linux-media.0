Return-Path: <SRS0=Rva/=B5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58221C433E1
	for <linux-media@archiver.kernel.org>; Wed, 19 Aug 2020 11:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235672075E
	for <linux-media@archiver.kernel.org>; Wed, 19 Aug 2020 11:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="P5KuPayW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHSL4x (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:56:53 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:50085 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbgHSLvp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Aug 2020 07:51:45 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 8Md4kcCTMuuXO8Md6kgnPn; Wed, 19 Aug 2020 13:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597837904; bh=cczGzPsGMYTQf6u0cvcOwXUEN13ax9mS0NCaEzRpsKM=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=P5KuPayWfUC0iremjnXbWybrSux3VmuQv7TnKveltJOX05K3JbQg0i7j78pX4a7pu
         SXupZzqplms0DHY9jq34k4lv/O6kQkswzo8RYDP0xc9OZfLubYgz3pC5evht4+jndH
         +dnWLnOxqa+udMC6PmwqU7b2SXOWyt2MExQs3h/GM4ePuSb+W0de6rQZByfi1jY59O
         h5s9YOI/lNXgq95WxH+e4yMyuxd6pOpr2FufCxWkmBKvcmsISCo5Lfk7Qe6FIN9RdI
         YlceSC3Aw42ZIJOh9tjNVIp4vOq/DwVxirIpp+L52+OvCKi+w1X7vGLQILdMCwrhp8
         xhGsYzBV9iMag==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.9] v4l2_ctrl_request_hdl_put() fixes
Message-ID: <533e5d24-927a-8d9e-4725-700610246b6d@xs4all.nl>
Date:   Wed, 19 Aug 2020 13:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF0cIGMQAKJOihhUkByvth5Z/14Yo5fO4M7uprcLP+nZ8i4uczPgfEdJKyJr9q7PAs78VdnTGrBX5w5dj1EXrkvHjJ6cUo05gyzqWJBEH/pF585mrCCI
 WJVuIKoS8E6OAGV9tbvb44cHRC1sLFxgr9FA5/nEszRsBcTIpqjusQOxXLEtppFay69L9KRvhpRAsGuY3MZyL+75o0WOYLQ/7a6wDCB4BX4XoaQljnDfok53
 NsujFVXgxqnflmi/FN0Me1HDPCJbBTvRc0PjFFuiG6RHDfl4b152O+0qVDk5ERYzm2gDqIOEuA0F8N/Ks2MdNg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix two drivers that are missing a v4l2_ctrl_request_hdl_put() call,
causing memory leaks of request objects every time the driver is used.

Regards,

	Hans

The following changes since commit 9a538b83612c8b5848bf840c2ddcd86dda1c8c76:

  media: venus: core: Add support for opp tables/perf voting (2020-08-18 15:55:56 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.9l

for you to fetch changes up to 8e55dea4f1e6c608846e3e5c4450278d02286afc:

  cedrus: Add missing v4l2_ctrl_request_hdl_put() (2020-08-19 13:43:04 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Ezequiel Garcia (1):
      cedrus: Add missing v4l2_ctrl_request_hdl_put()

Hans Verkuil (1):
      vicodec: add missing v4l2_ctrl_request_hdl_put()

 drivers/media/test-drivers/vicodec/vicodec-core.c | 1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
