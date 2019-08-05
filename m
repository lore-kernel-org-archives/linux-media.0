Return-Path: <SRS0=pkzJ=WB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF85C433FF
	for <linux-media@archiver.kernel.org>; Mon,  5 Aug 2019 08:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0720B1F
	for <linux-media@archiver.kernel.org>; Mon,  5 Aug 2019 08:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHEI5z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:57:55 -0400
Received: from www.linuxtv.org ([130.149.80.248]:57168 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEI5z (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 5 Aug 2019 04:57:55 -0400
X-Greylist: delayed 1045 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 04:57:55 EDT
Received: from 140-211-167-10-openstack.osuosl.org ([140.211.167.10] helo=builder.linuxtv.org)
        by www.linuxtv.org with esmtp (Exim 4.84_2)
        (envelope-from <jenkins@linuxtv.org>)
        id 1huYXV-0003eV-UY; Mon, 05 Aug 2019 08:40:22 +0000
Received: from [127.0.0.1] (helo=builder.linuxtv.org)
        by builder.linuxdvb.org with esmtp (Exim 4.92)
        (envelope-from <jenkins@linuxtv.org>)
        id 1huYXW-0007Ld-Rq; Mon, 05 Aug 2019 08:40:22 +0000
From:   Jenkins <jenkins@linuxtv.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        mchehab+samsung@kernel.org, linux-media@vger.kernel.org
Cc:     builder@linuxtv.org
Subject: Re: [GIT PULL for v5.4] Venus updates - stateful decoder, take 2
Date:   Mon,  5 Aug 2019 08:40:22 +0000
Message-Id: <20190805084022.28203-1-jenkins@linuxtv.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805083436.30921-1-stanimir.varbanov@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: builder@linuxtv.org

Pull request: https://patchwork.linuxtv.org/patch/57908/
Build log: https://builder.linuxtv.org/job/patchwork/2194/
Build time: 00:05:12

Summary: 0 issues, being 0 build regressions
