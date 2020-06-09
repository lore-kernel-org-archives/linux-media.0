Return-Path: <SRS0=lba3=7W=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F6C433E0
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 16:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D4720760
	for <linux-media@archiver.kernel.org>; Tue,  9 Jun 2020 16:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pUFrj5P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgFIQMT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIQMT (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Jun 2020 12:12:19 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7BC05BD1E;
        Tue,  9 Jun 2020 09:12:18 -0700 (PDT)
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 551CE291;
        Tue,  9 Jun 2020 18:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591719137;
        bh=hHbKh9ESqMiyA+FcNcJ2kUFb7qAQQnGOkiZEfnWIN9w=;
        h=Subject:To:Cc:References:From:Reply-To:Date:In-Reply-To:From;
        b=pUFrj5P4xpI/+74zCVd97WXN9dbGjrSf3vHIyrpGp6CreA+XHDPIMKtZt+Vx0rOVW
         Roh0z9dnVCsfQByhzAn9rT/c27F1H41/+2bngtqsKCMQ5J7l3U/6Hi3BLnETbfo0qs
         5Xt3XdKzWRFlywVokBNkITMPAv8NXo+TguY1fk3U=
Subject: Re: [RFC 3/5] mc-device.c: If graph completes status is available
 report it to user-space
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20200318213051.3200981-1-niklas.soderlund+renesas@ragnatech.se>
 <20200318213051.3200981-4-niklas.soderlund+renesas@ragnatech.se>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
Organization: Ideas on Board
Message-ID: <73bab328-94ba-5939-8fb3-4c810d7d183f@ideasonboard.com>
Date:   Tue, 9 Jun 2020 17:12:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200318213051.3200981-4-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas,

On 18/03/2020 21:30, Niklas Söderlund wrote:> If the media device
implements the graph_complete callback utilise it> and fill in the
completes of the graph in the struct media_device_info.> >
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/media/mc/mc-device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
> index da8088351135298a..64c786570b6df129 100644
> --- a/drivers/media/mc/mc-device.c
> +++ b/drivers/media/mc/mc-device.c
> @@ -75,6 +75,10 @@ static long media_device_get_info(struct media_device *dev, void *arg)
>  	info->driver_version = info->media_version;
>  	info->hw_revision = dev->hw_revision;
>  
> +	if (dev->ops && dev->ops->graph_complete)
> +		info->flags |= dev->ops->graph_complete(dev) ?
> +			MEDIA_INFO_FLAG_COMPLETE : MEDIA_INFO_FLAG_INCOMPLETE;

Aha, I see it was because of graph_complete being optional that leads to
having both states of the bool...

And I guess we can't 'default' to either state if graph_complete()
doesn't exist...

--
Kieran



> +
>  	return 0;
>  }
>  
> 

