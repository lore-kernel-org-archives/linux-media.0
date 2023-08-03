Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF45C001DF
	for <linux-media@archiver.kernel.org>; Thu,  3 Aug 2023 08:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjHCIGo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Aug 2023 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjHCIGR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Aug 2023 04:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8865C5B8E
        for <linux-media@vger.kernel.org>; Thu,  3 Aug 2023 00:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BED61C37
        for <linux-media@vger.kernel.org>; Thu,  3 Aug 2023 07:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA017C433C8;
        Thu,  3 Aug 2023 07:57:00 +0000 (UTC)
Message-ID: <7056dd5c-de1c-2d1c-beb2-a88b1e023214@xs4all.nl>
Date:   Thu, 3 Aug 2023 09:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: smatch error in rdacm21.c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

I discovered that the rdacm20/21 drivers were disabled in the smatch build. After
enabling them I got this smatch error:

drivers/media/i2c/rdacm21.c:373 ov10640_check_id() error: uninitialized symbol 'val'.

Can you take a look?

Thank you!

	Hans
