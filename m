Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA1FC0032E
	for <linux-media@archiver.kernel.org>; Wed, 25 Oct 2023 10:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJYKq2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Oct 2023 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjJYKq1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Oct 2023 06:46:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114EA3
        for <linux-media@vger.kernel.org>; Wed, 25 Oct 2023 03:46:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 939C9669;
        Wed, 25 Oct 2023 12:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698230771;
        bh=3B8UXJ9PcYzoRJm+B7Dz7xMuzRnpMz29Xx7zrFcbnGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdkXLt/LwLzZ4VaOXcKqPmGpnYLeZzYsdwln6xygJ2stUpmkeM/zlsfZE75wsTvzd
         yKiZ0/kejLYvAzT5CBTIeFGK2kgacFfcvX/DQCGHTzXwZIrGigdhxiIGVI2GBggmyn
         aAyc0As8zmGKmbyGlBZsW6WRau5pydWIdzkxpESk=
Date:   Wed, 25 Oct 2023 13:46:30 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 2/2] staging: vc04_services: Drop completed TODO item
Message-ID: <20231025104630.GB481@pendragon.ideasonboard.com>
References: <20231025103300.340572-1-umang.jain@ideasonboard.com>
 <20231025103300.340572-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025103300.340572-3-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Oct 25, 2023 at 06:33:00AM -0400, Umang Jain wrote:
> Memory barries and remote_event_*() are documented.
> Drop the TODO item related to them.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/interface/TODO | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
> index 9c79ed549831..2d51f6928e0f 100644
> --- a/drivers/staging/vc04_services/interface/TODO
> +++ b/drivers/staging/vc04_services/interface/TODO
> @@ -33,13 +33,6 @@ such as dev_info, dev_dbg, and friends.
>  A short top-down description of this driver's architecture (function of
>  kthreads, userspace, limitations) could be very helpful for reviewers.
>  
> -* Review and comment memory barriers
> -
> -There is a heavy use of memory barriers in this driver, it would be very
> -beneficial to go over all of them and, if correct, comment on their merits.
> -Extra points to whomever confidently reviews the remote_event_*() family of
> -functions.
> -

Is vchiq so timing sensitive that it can't afford spinlocks ?

>  * Reformat core code with more sane indentations
>  
>  The code follows the 80 characters limitation yet tends to go 3 or 4 levels of

-- 
Regards,

Laurent Pinchart
