Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74205C77B76
	for <linux-media@archiver.kernel.org>; Wed, 19 Apr 2023 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDSBGd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Apr 2023 21:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDSBGc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Apr 2023 21:06:32 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CAA6193;
        Tue, 18 Apr 2023 18:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Lms0C4cT+76fgagWleJqEZcrYl+boMnYrcMJr37IMKM=; b=XU4aeWxty1DBSslTGWkRcU1mrm
        T0cqHBLDYAbr7oK0uIUwI/s3ejCbybWEj1WbaM2EsGGK7koPF+irsx4ouxGne/f/FxPXILPpHrRcj
        6H/6VxYeNU3I2FptzANzwq3XyNC6OCxyZUCIwvuN3zuPTCS++SgiFq/lGwcY5BxkjGYQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1powHB-00AebN-CS; Wed, 19 Apr 2023 03:06:25 +0200
Date:   Wed, 19 Apr 2023 03:06:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, opendmb@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Subject: Re: [PATCH net-next 5/6] net: phy: bcm7xxx: Add EPHY entry for 74165
Message-ID: <c967927d-c9ec-4453-8452-6e90f797bcfc@lunn.ch>
References: <1681863018-28006-1-git-send-email-justinpopo6@gmail.com>
 <1681863018-28006-6-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681863018-28006-6-git-send-email-justinpopo6@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 18, 2023 at 05:10:17PM -0700, Justin Chen wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> 74165 is a 16nm process SoC with a 10/100 integrated Ethernet PHY,
> utilize the recently defined 16nm EPHY macro to configure that PHY.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
