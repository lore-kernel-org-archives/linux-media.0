Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61207C433FE
	for <linux-media@archiver.kernel.org>; Fri,  6 May 2022 14:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442189AbiEFOaO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 May 2022 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiEFOaN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 6 May 2022 10:30:13 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4036833C;
        Fri,  6 May 2022 07:26:30 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 87C7F20050;
        Fri,  6 May 2022 17:26:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1651847186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jbcfhtkfj44DUN+KwICkdDcQ2trt5zuMXEyDuwl3YAg=;
        b=XtaoWl3pLkjVFeCW7D3gP1lm4FuIPVQwoy7HIcZuTjFOAoCgaEjIhR928DkYqL0ij+C6KD
        wYIIXqzW7zRFfY7l851fK1P5nFU3AbMU0jccb97TbzVYLuJXspgNMu5oUpdLu8P02UKTwQ
        t8IpXHuxm20Es8K98ZmY71ttVBJAoHg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id BB1BE634C91;
        Fri,  6 May 2022 17:26:24 +0300 (EEST)
Date:   Fri, 6 May 2022 17:26:24 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     jacopo@jmondi.org, paul.j.murphy@intel.com,
        daniele.alessandrelli@intel.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        robert.foss@linaro.org, hfink@snap.com, jgrahsl@snap.com,
        dmitry.baryshkov@linaro.org, vladimir.zapolskiy@linaro.org
Subject: Re: [PATCH v5 4/4] media: i2c: imx412: Add bulk regulator support
Message-ID: <YnUwEKkjrbQQBiGZ@valkosipuli.retiisi.eu>
References: <20220415115954.1649217-1-bryan.odonoghue@linaro.org>
 <20220415115954.1649217-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415115954.1649217-5-bryan.odonoghue@linaro.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1651847186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jbcfhtkfj44DUN+KwICkdDcQ2trt5zuMXEyDuwl3YAg=;
        b=tzXMn6Emp0vIsypfxN+0rAq2BaTNeJAC9CfsnOVmsLKI250xj1LmUmQBUwKdTOHsbne2m6
        vmAKPcxcyWcPjqKAuP0bHaJMht5PehBShQCnWUFW/nzNugx/KILzBNwi2HabAkZVtMryKN
        AJw1vlWWJ8PYFejN/3APp/5MWGY4hcY=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1651847186; a=rsa-sha256; cv=none;
        b=Iyyw47v5DEMp3dvQZQU+iyyFOza32BWPd3QZyCPM01kuzZij2aQw3+hmwkW/QFINpvU0wm
        83WnQzZwJCQU4b9YDY5/FFFM+AjaOh2ChNa4vXfvtkPQvMPL45nDdpByFWgnvGLRdjZTm6
        aM4/lu72EZ4bBgTNmleJMRABtD3+/u0=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 15, 2022 at 12:59:54PM +0100, Bryan O'Donoghue wrote:
> Depending on the platform we may need to enable and disable three separate
> regulators for the imx412.
> 
> - DOVDD
> Digital I/O power
> 
> - AVDD
> Analog power
> 
> - DVDD
> Digital core power
> 
> The addition of these regulators shouldn't affect existing users using
> fixed-on/firmware-controlled regulators.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Squashed this bit into the patch:

diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index 1795a6180d60d..a1394d6c14320 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -116,6 +116,7 @@ static const char * const imx412_supply_names[] = {
  * @pad: Media pad. Only one pad supported
  * @reset_gpio: Sensor reset gpio
  * @inclk: Sensor input clock
+ * @supplies: Regulator supplies
  * @ctrl_handler: V4L2 control handler
  * @link_freq_ctrl: Pointer to link frequency control
  * @pclk_ctrl: Pointer to pixel clock control

-- 
Sakari Ailus
