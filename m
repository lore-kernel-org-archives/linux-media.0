Return-Path: <SRS0=bEWJ=3N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C379BC2D0DB
	for <linux-media@archiver.kernel.org>; Fri, 24 Jan 2020 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9760E20838
	for <linux-media@archiver.kernel.org>; Fri, 24 Jan 2020 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bI8RB+jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgAXPPO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:15:14 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:43881 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgAXPPN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Jan 2020 10:15:13 -0500
Received: from [IPv6:2001:983:e9a7:1:dded:8f92:97b:fe6e]
 ([IPv6:2001:983:e9a7:1:dded:8f92:97b:fe6e])
        by smtp-cloud7.xs4all.net with ESMTPA
        id v0fuiwtuXrNgyv0fvi65sI; Fri, 24 Jan 2020 16:15:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1579878912; bh=Tm+vTXtru4bGAh4Xv7jfraxF1msSerUpAezHWMhKLQA=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=bI8RB+jrRdaYvpYNQqGmgpAF9wHmaf7Q0/P3YwwmWJNGZQUPWM5cKRWDaVQJ2oR04
         m/cmZEnFC87mKrXJXhuVkX+zwwbPOJzdpj3ly314HzXXevlla5Dqv1qfo+kHupZ220
         dBaouhj1SzdoTGsjORzZPj59pqwBvb6oV8uENOJeWoLnEN3FwzJlwwI6MIaez71j/A
         33vHctcDuP4vXrDtjRP+e6Y6zBSt6MXRtw0jTU3pM+3PO65OzWJkO0Rcz5i24OF+Nu
         zQcWLyKV6kkVldVq6dwgOvqwKHc2KUH6UrlZIt8Cs3Lpv2LBFu07ajLXMypKypqvxx
         +o37futVuG5Vw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.6] Two pulse8-cec regression fixes
Message-ID: <524d2c07-c97f-4f6c-555a-7ec1840707dc@xs4all.nl>
Date:   Fri, 24 Jan 2020 16:15:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHqgbOo7dCDuGzfP1qopsaEqFPGha6iNOmYKE2gSmdrfZRQZntWW8lxa/NYhzVohVhRCfAb0OX7u2xw8+Sz+hPl5z6PVyRtHQyFECCZcE18Njf7b2yZw
 QIuZMwG8pKT66c8Zhwr0z3VXx3UVYnpdI1sRp75wUAtValgp8SftXmjaYWbCgv9RdMbiaF7BLwgorv0mYHZ8xfdSIwc5P5Fhdg8uGBlOur72pdD+FjzK5rTa
 bUSP16hnhMIM/xGhdRDyQ5WMyxPVzdrEicAP62g+iyg=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The following changes since commit 1697d98124819aab09b86602978bd4f50e101e2d:

  media: staging/intel-ipu3: remove TODO item about acronyms (2020-01-23 15:50:53 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.6n

for you to fetch changes up to d556af3df1c60a08c29b6d39785b3178e084ca51:

  pulse8-cec: close serio in disconnect, not adap_free (2020-01-24 15:55:32 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (2):
      pulse8-cec: INIT_DELAYED_WORK was called too late
      pulse8-cec: close serio in disconnect, not adap_free

 drivers/media/usb/pulse8-cec/pulse8-cec.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
