Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCACC433FE
	for <linux-media@archiver.kernel.org>; Fri,  4 Dec 2020 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9302B22A83
	for <linux-media@archiver.kernel.org>; Fri,  4 Dec 2020 13:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgLDNqI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:46:08 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33373 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLDNqI (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 4 Dec 2020 08:46:08 -0500
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 16F06100005;
        Fri,  4 Dec 2020 13:45:25 +0000 (UTC)
Date:   Fri, 4 Dec 2020 14:45:32 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, martinax.krasteva@linux.intel.com
Subject: Re: [PATCH 0/2] Subdev link validation and format documentation
 improvements
Message-ID: <20201204134532.pm3rjlftsom663tv@uno.localdomain>
References: <20201202181955.18165-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202181955.18165-1-sakari.ailus@linux.intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Sakari,
   much apreciated

On Wed, Dec 02, 2020 at 08:19:53PM +0200, Sakari Ailus wrote:
> Hello,
>
> I wrote these small patches to improve the documentation regarding
> requirements for subdev drivers to implement format related ops as well as
> the link_validate op.
>
> Sakari Ailus (2):
>   Documentation: v4l: Remove reference to video ops
>   Documentation: v4l: Document that link_validate op is valid for sink
>     only

For the series
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>
>  Documentation/driver-api/media/v4l2-subdev.rst | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> --
> 2.27.0
>
