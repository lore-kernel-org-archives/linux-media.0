Return-Path: <SRS0=NEJa=6P=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C415C4724C
	for <linux-media@archiver.kernel.org>; Fri,  1 May 2020 03:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D1A207DD
	for <linux-media@archiver.kernel.org>; Fri,  1 May 2020 03:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgEAD3z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgEAD3z (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 30 Apr 2020 23:29:55 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EE1C035494;
        Thu, 30 Apr 2020 20:29:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 37AAA12773B14;
        Thu, 30 Apr 2020 20:29:54 -0700 (PDT)
Date:   Thu, 30 Apr 2020 20:29:53 -0700 (PDT)
Message-Id: <20200430.202953.2091105199865668501.davem@davemloft.net>
To:     weiyongjun1@huawei.com
Cc:     vz@mleia.com, slemieux.tyco@gmail.com, sumit.semwal@linaro.org,
        stigge@antcom.de, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: lpc-enet: fix error return code in
 lpc_mii_init()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200427121507.23249-1-weiyongjun1@huawei.com>
References: <20200427121507.23249-1-weiyongjun1@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Apr 2020 20:29:54 -0700 (PDT)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 27 Apr 2020 12:15:07 +0000

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: b7370112f519 ("lpc32xx: Added ethernet driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
