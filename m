Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D072BC433FE
	for <linux-media@archiver.kernel.org>; Mon, 30 May 2022 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiE3GYk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 May 2022 02:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiE3GYi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 May 2022 02:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B76B7C5;
        Sun, 29 May 2022 23:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A4D6104E;
        Mon, 30 May 2022 06:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24427C34119;
        Mon, 30 May 2022 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653891876;
        bh=2YgSIJ3CE+xe2Ajc1vpcGq3Gs3/6x2CvG5Mak/cA7L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyxYb9+z2P1WLZlZFPTJ5XDW/T/yY/HCs50OBkPXyRKjIVAfk5/+HxhUvyUs0vQFF
         9rqptQZmTd/NhKQSM8kfwdUdcRxb486x9tGGb8t9bnW0654f36NWSzO8/ta7vfbdG5
         MTcPaI9y5Ev5EqvbMlUAtx6JeP/l9xAJagrEJa8k=
Date:   Mon, 30 May 2022 08:24:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Felipe Balbi <balbi@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Li Yang <leoyang.li@nxp.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v5 1/3] usb: gadget: add Aspeed ast2600 udc driver
Message-ID: <YpRjIXaJ2ZeuuWJ8@kroah.com>
References: <20220523030134.2977116-1-neal_liu@aspeedtech.com>
 <20220523030134.2977116-2-neal_liu@aspeedtech.com>
 <TY2PR06MB3213611D7D9DD6F9B47DBB4080DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR06MB3213611D7D9DD6F9B47DBB4080DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, May 30, 2022 at 01:27:16AM +0000, Neal Liu wrote:
> Gentle ping on this path, thanks.

Please never top-post.

Also, it is the middle of the merge window and we can not do anything
with new submissions.  Please wait until next week at the earliest
before we can even start to look at stuff like this.

What is the rush?

thanks,

greg k-h
