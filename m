Return-Path: <SRS0=IKjz=AD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC88C433E0
	for <linux-media@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66F32547C
	for <linux-media@archiver.kernel.org>; Mon, 22 Jun 2020 07:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="a2vg1i3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgFVHoC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:44:02 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:33649 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731381AbgFVHoB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Jun 2020 03:44:01 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id nH7UjzaZNn3JWnH7XjYoW6; Mon, 22 Jun 2020 09:44:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1592811840; bh=4Xvbt69aqMUMXv6pfFyklNP3u7upA8j/VbWmXTD9ss4=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=a2vg1i3xri7g1Xa38g5ljsc+yLGvLbQB3vpJXnnhJvyxGklMZW9T9lhMoUGg2wmSt
         adIZeWEFcAebTXvdre4gBGj9xN7OazJ8/7KvVmJ60lX+siLpeCzVyqQP4Jc2189tNy
         N3ZvMLT7wu5AyfNpWFRsr8pHuBVWejoJzYjn+xIr/tKdqYW83FISrTI11TFi8iUX30
         b68gs5j0h2by2Kp30qBwsgGpK1GXr5RTslIK3bBdHhu0WnjBEUCQgU5VNmK4UaURy/
         mc6gOf/vZWENFzUJ+7yJ7rdJBfeTb3cOo9G8vbWbogQ5JJAu/6FZg39hddFfrFIcAr
         LNG4yn5pgxz3A==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.9] cec fixes
Message-ID: <4203a3a8-723a-8bb1-4fa1-161edf5bd51a@xs4all.nl>
Date:   Mon, 22 Jun 2020 09:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEHLZoKxfBMXlSunXksI7RunYny7giNrag3GTKCn1He5wuDfef9654H51JXVtIFanLiIHc+7AKBpGbiyZCPb8LoPLOYmKNlb3kLQSfnNouxqW/Zer7s2
 Q9DbA35DgiQhUkkTkP7vKL5ZybrL18iwQV36DsotegVeV8jfxG46vdBCv/DyAsiqAPx7DA7T7otfVg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-cec-vars

for you to fetch changes up to b65ca0d59a4a951caeb7bddfdc99062af322ff03:

  media/cec.h: document cec_adapter fields (2020-06-22 09:36:54 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (3):
      cec-ioc-adap-g-caps.rst: document available_log_addrs
      cec: remove unused waitq and phys_addrs fields
      media/cec.h: document cec_adapter fields

 Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst |  3 +++
 drivers/media/cec/core/cec-adap.c                             |  4 ----
 drivers/media/cec/core/cec-core.c                             |  1 -
 include/media/cec.h                                           | 51 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 52 insertions(+), 7 deletions(-)
