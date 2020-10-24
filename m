Return-Path: <SRS0=y9/N=D7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEA5C388F9
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 00:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE41241A4
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="joPX14W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbgJXA3Q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 23 Oct 2020 20:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463294AbgJXA3Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 23 Oct 2020 20:29:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0644C0613CE;
        Fri, 23 Oct 2020 17:29:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80AD49BF;
        Sat, 24 Oct 2020 02:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1603499351;
        bh=IlzYRBOsDD97czhYETs7QIf9PdFJSskIenhWtRzn4PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joPX14W8Yq06KznIRrxKnuvb+f2QR1HTUedDdIku3TRdlCdgFLgxF7WQGM9PnkKiA
         X3KTUjeFCH0BdCqE++Iq93Zdq3UUb5dtADSO6UFmy7epLXU2OTf/5or6K17EZAme7E
         4lMr9uvjtKNnX+PfVcLGiDY+V9BETP6uxNwwmMEo=
Date:   Sat, 24 Oct 2020 03:28:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        heikki.krogerus@linux.intel.com, dmitry.torokhov@gmail.com,
        laurent.pinchart+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, jacopo+renesas@jmondi.org,
        robh@kernel.org, davem@davemloft.net, linux@rasmusvillemoes.dk,
        andriy.shevchenko@linux.intel.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, pmladek@suse.com, mchehab@kernel.org,
        tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        sakari.ailus@linux.intel.com, yong.zhi@intel.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, kitakar@gmail.com,
        dan.carpenter@oracle.org
Subject: Re: [RFC PATCH v3 5/9] ipu3-cio2: Add T: entry to MAINTAINERS
Message-ID: <20201024002825.GQ5979@pendragon.ideasonboard.com>
References: <20201019225903.14276-1-djrscally@gmail.com>
 <20201019225903.14276-6-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019225903.14276-6-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Mon, Oct 19, 2020 at 11:58:59PM +0100, Daniel Scally wrote:
> Development for the ipu3-cio2 driver is taking place in media_tree, but
> there's no T: entry in MAINTAINERS to denote that - rectify that oversight
> 
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes in v3:
> 	- patch introduced.
> 	
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43a025039..5d768d5ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8851,6 +8851,7 @@ M:	Bingbu Cao <bingbu.cao@intel.com>
>  R:	Tianshu Qiu <tian.shu.qiu@intel.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
>  F:	drivers/media/pci/intel/ipu3/

-- 
Regards,

Laurent Pinchart
