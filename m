Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128ADC7EE29
	for <linux-media@archiver.kernel.org>; Mon, 29 May 2023 07:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjE2Hrj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 29 May 2023 03:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjE2Hrg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 29 May 2023 03:47:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F854A7
        for <linux-media@vger.kernel.org>; Mon, 29 May 2023 00:47:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126255106133.24.openmobile.ne.jp [126.255.106.133])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E62CA836;
        Mon, 29 May 2023 09:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685346434;
        bh=A74NItSZRfRMQ9vrsXTVw9dkpbVP86iM08sfE1QtKSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjyTg+fye/So2dFP23/5zMlpJBZ0+QnT4c/fC6l19GnnHYb429k+9BA7nuZcQUPvx
         BTlv9jrGc1MGEUeHgrSVUz1J3iusBOlXDslxUfCu0TOP84VZ4nBaa/wx60svI/IePN
         IiFK+M+fHIW4Afyw/qDn3E/56dVz4xJbjva6FGGU=
Date:   Mon, 29 May 2023 10:47:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com
Subject: Re: [PATCH v4 1/8] v4l2-ctl: Add routing and streams support
Message-ID: <20230529074735.GE25984@pendragon.ideasonboard.com>
References: <20230421124428.393261-1-tomi.valkeinen@ideasonboard.com>
 <20230421124428.393261-2-tomi.valkeinen@ideasonboard.com>
 <20230424070455.GC4926@pendragon.ideasonboard.com>
 <24ce5041-5fd7-5ef9-a8d3-52a1dcf6b80c@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24ce5041-5fd7-5ef9-a8d3-52a1dcf6b80c@ideasonboard.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, May 29, 2023 at 10:02:47AM +0300, Tomi Valkeinen wrote:
> On 24/04/2023 10:04, Laurent Pinchart wrote:
> 
> >> +		r = (v4l2_subdev_route *)routing.routes;
> >> +		ref = end = strdup(optarg);
> >> +		while ((tok = strsep(&end, ",")) != NULL) {
> >> +			if (sscanf(tok, "%u/%u -> %u/%u [%u]",
> >> +				   &r->sink_pad, &r->sink_stream,
> >> +				   &r->source_pad, &r->source_stream,
> >> +				   &flags) != 5) {
> > 
> > Requiring a space around '->' isn't nice, especially as it's not present
> > in the help text. MC link parsing makes spaces optional, please do the
> > same here.
> 
> The space are not required. sscanf skips white-space, so this parses 
> fine "1/2->3/4[1]".

I've learned something today :-)

-- 
Regards,

Laurent Pinchart
