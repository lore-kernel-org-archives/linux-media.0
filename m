Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38108C43334
	for <linux-media@archiver.kernel.org>; Tue, 21 Jun 2022 12:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiFUMRX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349197AbiFUMRL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Jun 2022 08:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D815837
        for <linux-media@vger.kernel.org>; Tue, 21 Jun 2022 05:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E69F61196
        for <linux-media@vger.kernel.org>; Tue, 21 Jun 2022 12:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB44C3411C;
        Tue, 21 Jun 2022 12:17:08 +0000 (UTC)
Message-ID: <771eb487-7973-fbe2-8161-87491b513ce1@xs4all.nl>
Date:   Tue, 21 Jun 2022 14:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     Xavier Roumegue <xavier.roumegue@oss.nxp.com>
Content-Language: en-US
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Add support for v4l2_ctrl_modify_dimensions()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Xavier,

I added support for v4l2_ctrl_modify_dimensions() to this branch:

https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=array_mod

It sits on top of the dynamic array control patches, which you already
have.

It's alpha quality and esp. request support hasn't been tested.

Let me know if this does what it needs to do, and then I'll clean
everything up and add more testing to v4l2-compliance.

Regards,

	Hans
