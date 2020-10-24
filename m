Return-Path: <SRS0=y9/N=D7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A5C55179
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 22:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C5D20A8B
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 22:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TFS+MoYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762764AbgJXWhT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 24 Oct 2020 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbgJXWhS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 24 Oct 2020 18:37:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA49C0613CE;
        Sat, 24 Oct 2020 15:37:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3632A19;
        Sun, 25 Oct 2020 00:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1603579034;
        bh=282So31S4Edjs+o+kbneEtLDpBVo85TaddaTf0dtw4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFS+MoYu5P+qqiloRcqhw0Fhsr2fD1nOMy+R38LIzuHbmuQfD3QhxV6itTqz7H/yF
         xqb9Ob7ZaTagEii3o09MRqmfu7zuaSNNCmOI3t4v/ZQdit6rbQBftjIGrfq7nS8zR1
         Q6uWD+nOUI1cl9jBrtQRbqqqlHIr5ZEBuzWXc5Ac=
Date:   Sun, 25 Oct 2020 01:36:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        heikki.krogerus@linux.intel.com, dmitry.torokhov@gmail.com,
        laurent.pinchart+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, jacopo+renesas@jmondi.org,
        robh@kernel.org, davem@davemloft.net, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, pmladek@suse.com, mchehab@kernel.org,
        tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        sakari.ailus@linux.intel.com, yong.zhi@intel.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, kitakar@gmail.com
Subject: Re: [RFC PATCH v3 9/9] ipu3-cio2: Add functionality allowing
 software_node connections to sensors on platforms designed for Windows
Message-ID: <20201024223628.GG3943@pendragon.ideasonboard.com>
References: <20201019225903.14276-1-djrscally@gmail.com>
 <20201019225903.14276-10-djrscally@gmail.com>
 <20201024012411.GT5979@pendragon.ideasonboard.com>
 <d188f8b5-ed3b-f91b-171a-26afeb7d213e@gmail.com>
 <20201024093702.GA3939@pendragon.ideasonboard.com>
 <748d34c3-a146-12fe-22c0-8dfef9006ea0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <748d34c3-a146-12fe-22c0-8dfef9006ea0@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dan,

On Sat, Oct 24, 2020 at 11:28:06PM +0100, Daniel Scally wrote:
> On 24/10/2020 10:37, Laurent Pinchart wrote:
> >
> >>> I wonder if we could avoid depending on the I2C device being created by
> >>> getting the fwnode from adev, and setting ->secondary manually. adev
> >>> would need to be passed to get_acpi_ssdb_sensor_data() instead of dev.
> >> Let me try that; I initially wanted to do
> >> set_secondary_fwnode(&adev->dev, fwnode) to avoid depending on the I2C
> >> dev being created but it turns out &adev->dev isn't the same pointer. I
> >> shall try it and see.
> 
> Actually, thinking on this further I think maybe we can't avoid that -
> it's not actually in this patch series but during assigning GPIO
> resources parsed from PMIC's ACPI node to the sensor, I'm using
> dev_name() on the i2c dev to pass to .dev_id member of gpiod_lookup_table

Any chance we can construct the I2C device name from the ACPI device,
the same way that the ACPI/I2C core does ? It may be a dead end, but if
we could avoid depending on the I2C device, I think it will make
initialization easier. I have a feeling that will be difficult though,
as we'll need the I2C bus number, which won't be readily available.

Maybe this calls for extending the gpiod lookup API, but that would then
likely be something we would build on top. I'm thinking about a way to
specify the GPIO mapping in the software node, and retrieving it from
there, the same way this is done for GPIOs in OF-based systems.

-- 
Regards,

Laurent Pinchart
