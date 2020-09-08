Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8DC43461
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23062074B
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ijVsILa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgIHKdl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:33:41 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:35255 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729545AbgIHK0d (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:33 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id FapHkWzhXMeQuFapIkfd92; Tue, 08 Sep 2020 12:26:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599560772; bh=y3q/NFkms4C+IPVuEDwnLsuTWDd/l8XnKEWol9a4bUo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=ijVsILa3nGi7n06PLgOwKjgMGPaARnsMIjR83cV2d+lYYf24zzvuQuWEIyFWWrM0u
         dUYcaQfJrubUqs8Owln9djyzjaX+lojI/Y/VhD1OckYE23lTLv9cCEuyfhh8wCve3/
         VaZmT3+vmohmNCV4Xs6LgDkvv0F8fZrzg2OXYalTScXfWqYPBiPJuIjhpqiybxXwh/
         3KKZ1JkG8ZMVw3b5OP5Nu/u+Uk1+9Wpj07LeWTTBSO6i+mb0592jTOds4MjdU8N99P
         S9PYgMQUcbu0up5UXWznm8bJLZ2FdZ4ieuYVNHZKN7luARmQAscjkHT3lGwFH6UG+j
         efPKadRgBwu9Q==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/2] cec: improve robustness of the framework
Date:   Tue,  8 Sep 2020 12:26:09 +0200
Message-Id: <20200908102611.471265-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBN2Q8OdUTxNwwXZKp4mIW5k45gcUuld5aOh0wpvINrX/ZgTkWJw2/5rJe28JxnzNFzzD/qZ30AO02STTnm91z/poRB+6GsCItnNEfd08WIu1oS/LRZz
 V1uNcGd33Mxcg7OAbokpSI+jvNQyVPPvF12hEoKhF2aXOHNr/GTyLpMj4UGnmVURT2sjaPN9yYJNWxYAtDTZ64P8rq5Fz4Rlvl5W+4aCsPoE9o4uHcYQ+nve
 WY57kTo1wrGgfSMcenqNjQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add two patches that make the framework a bit more robust.

Regards,

	Hans

Hans Verkuil (2):
  cec-core.c: stop kthread_config before kthread
  cec-adap.c: add 'unregistered' checks

 drivers/media/cec/core/cec-adap.c | 6 ++++++
 drivers/media/cec/core/cec-core.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.27.0

