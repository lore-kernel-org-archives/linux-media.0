Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE43C0032E
	for <linux-media@archiver.kernel.org>; Wed, 25 Oct 2023 07:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjJYH14 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Oct 2023 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjJYH1u (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Oct 2023 03:27:50 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164CE5
        for <linux-media@vger.kernel.org>; Wed, 25 Oct 2023 00:27:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78F5B1C0009;
        Wed, 25 Oct 2023 07:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698218865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA6IuzY5sx5JDEBSOuw3moLIX6FshC0tssz1mVJBzVI=;
        b=E+Af5aUm4aYee00ZtrtOJUQ7QKJxCtX6agy/neXU60OH060VI2+FXa1Mqm+XizSv7imZPy
        f04fTVfWuBj/somm+KpEV++HV/AvFydAl15HzGnSSR5295WOcqRIazZy7Sha7P16iaInOW
        +bSN6SW/AGbfZx48ZrgygCJwwyy0xBtHbBrmmA+pR59T+b09uDmRcbCVD0cC9VhE5VvKBV
        ldbaOnoAb9nWJzAPDM8SqFNwOrNOCdE5Ib7bBPtTuBogvh4dEIikYs+CRIruo4CxEr5Kax
        wmqVSG2uBC2eYaZnfCP1mIOaSPEzMDq3JhIPlpt2fFlutTm6uvsrbUYLgjGnMA==
Date:   Wed, 25 Oct 2023 09:27:43 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [PATCH 5/7] media: tegra-video: Use accessors for pad config
 'try_*' fields
Message-ID: <20231025092743.02b79363@booty>
In-Reply-To: <20231023214011.17730-6-laurent.pinchart@ideasonboard.com>
References: <20231023214011.17730-1-laurent.pinchart@ideasonboard.com>
        <20231023214011.17730-6-laurent.pinchart@ideasonboard.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent,

On Tue, 24 Oct 2023 00:40:09 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> The 'try_*' fields of the v4l2_subdev_pad_config structure are meant to
> be accessed through helper functions. Replace direct access with usage
> of the v4l2_subdev_get_pad_format(), v4l2_subdev_get_pad_crop() and
> v4l2_subdev_get_pad_compose() helpers.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
