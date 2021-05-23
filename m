Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C61C47081
	for <linux-media@archiver.kernel.org>; Sun, 23 May 2021 02:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9185061175
	for <linux-media@archiver.kernel.org>; Sun, 23 May 2021 02:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEWCVx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 22 May 2021 22:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhEWCVv (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 22 May 2021 22:21:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56C92600D1;
        Sun, 23 May 2021 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621736426;
        bh=u7HTH9S9ACY+hVT9Ovfm/QbReRAQQfkwl0oBvq9HU6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx2DCXQTjHR+YAZBrasXd7UhBzbnAn4RMT8wU4QG34GPFREXAcdOqKX76+8CWn9Ns
         p74vHYXkK24spK0eQWVq5Bfi/g0dHv0r1gkjv0JkcsV/mlNPIY1fcyizLXJJJSen4O
         nU4tuTpcLxcwdfW6yV2pyQaY8amfDKW/JsaMhFC9nO4xLaMwggRptqzzBFbOGFTHMY
         9+OBBGrobuP/yNXWEeEhayR5+St3QGyqFtIbyUOUMa6CkGQZP04Irt8IiebLpzC1iK
         BW1ruPyjinSsls/hSSdltSWvKuleESv4wA1SjlQdinXPNJuM3RxhcDAQYalsQdKVgB
         2L1aY6gYED6Wg==
Date:   Sun, 23 May 2021 10:20:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     festevam@gmail.com, s.riedmueller@phytec.de,
        matthias.schiffer@ew.tq-group.com, leoyang.li@nxp.com,
        arnd@arndb.de, olof@lixom.net, s.hauer@pengutronix.de,
        kernel@pengutronix.de, prabhakar.csengg@gmail.com,
        mchehab@kernel.org, mchehab+huawei@kernel.org,
        krzysztof.kozlowski@canonical.com, krzk@kernel.org,
        robh+dt@kernel.org, linux@rempel-privat.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: add dasheng vendor prefix
Message-ID: <20210523022010.GH8194@dragon>
References: <1620104993-5850-1-git-send-email-dillon.minfei@gmail.com>
 <1620104993-5850-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620104993-5850-2-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, May 04, 2021 at 01:09:50PM +0800, dillon.minfei@gmail.com wrote:
> From: Dillon Min <dillon.minfei@gmail.com>
> 
> Add vendor prefix for DaSheng, Inc.
> 
> Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks.
