Return-Path: <SRS0=xzGM=3T=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD4C33C9E
	for <linux-media@archiver.kernel.org>; Thu, 30 Jan 2020 11:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7B20702
	for <linux-media@archiver.kernel.org>; Thu, 30 Jan 2020 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3LsO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:48:14 -0500
Received: from retiisi.org.uk ([95.216.213.190]:51580 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgA3LsN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 30 Jan 2020 06:48:13 -0500
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 0FFC1634C87;
        Thu, 30 Jan 2020 13:47:21 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1ix8I5-0002A5-1S; Thu, 30 Jan 2020 13:47:21 +0200
Date:   Thu, 30 Jan 2020 13:47:20 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Fix ti-vpe binding file line
Message-ID: <20200130114720.GA8280@valkosipuli.retiisi.org.uk>
References: <20200130083156.10959-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130083156.10959-1-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jan 30, 2020 at 10:31:56AM +0200, Sakari Ailus wrote:
> Add "F:" prefix to the ti,cal.yaml line to tell it's a file.
> 

There should have been one more line here:

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da05666e9ade..02e5aad82c94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16584,7 +16584,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  S:	Maintained
>  F:	drivers/media/platform/ti-vpe/
>  F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
> -	Documentation/devicetree/bindings/media/ti,cal.yaml
> +F:	Documentation/devicetree/bindings/media/ti,cal.yaml
>  
>  TI WILINK WIRELESS DRIVERS
>  L:	linux-wireless@vger.kernel.org
> -- 
> 2.20.1
> 

-- 
Sakari Ailus
