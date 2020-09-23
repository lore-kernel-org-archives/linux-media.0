Return-Path: <SRS0=mA+5=DA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFEC4363D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 07:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A842220D
	for <linux-media@archiver.kernel.org>; Wed, 23 Sep 2020 07:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIWHGN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIWHGN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Sep 2020 03:06:13 -0400
X-Greylist: delayed 77048 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Sep 2020 00:06:13 PDT
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEBCC061755;
        Wed, 23 Sep 2020 00:06:13 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 37A9111A002; Wed, 23 Sep 2020 08:06:11 +0100 (BST)
Date:   Wed, 23 Sep 2020 08:06:11 +0100
From:   Sean Young <sean@mess.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V3 0/2] Add QoS support for cpuidle system.
Message-ID: <20200923070611.GA30617@gofer.mess.org>
References: <20200922190807.6830-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922190807.6830-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 23, 2020 at 03:08:05AM +0800, Joakim Zhang wrote:
> Add QoS support for cpuidle system.

Reviewed-by: Sean Young <sean@mess.org>

Rob, would you be able to review the device tree bindings please?

Thanks,

Sean


> 
> Joakim Zhang (2):
>   bindings: media: gpio-ir-receiver: add linux,autosuspend-period
>     property
>   media: rc: gpio-ir-recv: add QoS support for cpuidle system
> 
>  .../bindings/media/gpio-ir-receiver.txt       |  3 ++
>  drivers/media/rc/gpio-ir-recv.c               | 53 +++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> -- 
> 2.17.1
