Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA05C433ED
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 12:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91AA61073
	for <linux-media@archiver.kernel.org>; Tue, 27 Apr 2021 12:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhD0M3b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Apr 2021 08:29:31 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:35011 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235426AbhD0M3b (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Apr 2021 08:29:31 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id bMpVlZt5giDzSbMpYldT43; Tue, 27 Apr 2021 14:28:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619526526; bh=AtStPtSqLQe8/gTyl6XxnhEiqIhdlmzOvXyfJkm1pDc=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=LX1w7Cs/c7h6sVIENoDRJ/MGLBTi2HTdTy6uquuMCy18URwhpbkIKedjmIGaX5YRq
         TyNCovQoHq/Gkq529ddPCQYQX7Uqrp/Om71cpS2bk58I993zNOTah124rC7gX61GMW
         5RSxtFvNlWvOs7hTfnQLcWGffIYALWV6WyVpeH+2sz7DRiDZTDtTVt2ABzhAcgjL3B
         6Xvx0Fnh1041H1ksYU8yA2ftsqV3q4AlygHTk52vIGLRdap/GjJL6jYZ9/P1JE5zKU
         kTkC1k0ibs0l3xiblNJuQ5Pb+i7S5AzZYOAHlvvwmI8iqkUycP/bALp88ufJtlCm99
         za8RST+cGlm8g==
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        John Cox <jc@kynesim.co.uk>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Dynamic array control support: please test!
Message-ID: <c423e924-9380-0806-b9dd-26cb2caf9fa7@xs4all.nl>
Date:   Tue, 27 Apr 2021 14:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHZoWdPgsGSELl7eXigsQTSmo/jN8bY0l2qjPsAEMZP4YCtFtiIKSaGo+DdLS4VR9GFaGWmj/HtmQCwKzXrzcYJ78BLeSi1g1BehlErUE4eqQTjpM8+d
 fuJ7hJYAFByDGofrsuo58F8HuAYdCET/kYvfZF/Q0SwCRS6YYB5NgD2mDucPUbr0ffyEHecG5ppwL5YuervJKb6yFvA4KmdgV65+Z+ZIcR87jfCC22iFG1iM
 XhOMdPZDZig0cjby7/4vfA==
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ezequiel, John,

After creating extensive new compliance tests for this feature I am now
confident enough about the implementation.

You can find it here:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=ctrl-refactor

There are two items that I want to fix before I will post this:

1) The new flag needs to be documented
2) I think there are some simplifications possible w.r.t. storing the
   size of the new array, I want to look at that a bit more.

In the meantime it would be great if some testing of this series can be
done with real drivers instead of just vivid.

Regards,

	Hans
