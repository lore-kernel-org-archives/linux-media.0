Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6975C64ED6
	for <linux-media@archiver.kernel.org>; Thu, 23 Feb 2023 13:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbjBWNLR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjBWNLQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 23 Feb 2023 08:11:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D5567B8;
        Thu, 23 Feb 2023 05:10:54 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2DE52E4;
        Thu, 23 Feb 2023 14:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1677157852;
        bh=WYy+JIwjACK0ewwdjromDn+ooNvg12hqZ611KgIZSg4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DAYm/15WuaNLA/s+g6H/W878t69F1Wig+J58dDyvzoEWL26lQLsmwQ8ZG/vf32NzZ
         Qa1FAXZot+Yyc1o6MzOc14UDNNFtx4v2ltkZgFsAET9UCkT4bghaa4zjc0NA/65CW0
         MemuTKzhEFi9YV7HF3uI/PRrQ5Jl0L69TSJadiz0=
Message-ID: <029a92fa-d1e0-54da-76b9-a6e1dd65298e@ideasonboard.com>
Date:   Thu, 23 Feb 2023 15:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/7] media: Add Y210, Y212 and Y216 formats
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ming Qian <ming.qian@nxp.com>
References: <20221221092448.741294-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221221092448.741294-3-tomi.valkeinen+renesas@ideasonboard.com>
 <691e89bd57907c96cbb8e922cb12b1264b31d471.camel@ndufresne.ca>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <691e89bd57907c96cbb8e922cb12b1264b31d471.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 22/02/2023 17:28, Nicolas Dufresne wrote:
> Hi Tomi,
> 
> Le mercredi 21 décembre 2022 à 11:24 +0200, Tomi Valkeinen a écrit :
>> Add Y210, Y212 and Y216 formats.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> ---
>>   .../media/v4l/pixfmt-packed-yuv.rst           | 49 ++++++++++++++++++-
>>   drivers/media/v4l2-core/v4l2-ioctl.c          |  3 ++
>>   include/uapi/linux/videodev2.h                |  8 +++
>>   3 files changed, 58 insertions(+), 2 deletions(-)
> 
> It seems you omitted to update v4l2-common.c, Ming Qian had made a suplicated
> commit for this, I'll ask him if he can keep the -common changes you forgot.

Ah, I wasn't aware of the format list in that file.

I think you refer to the "media: imx-jpeg: Add support for 12 bit 
extended jpeg" series. Yes, I'm fine if he can add the -common changes 
there, but I can also send a separate patch. In fact, maybe a separate 
fix patch is better, so that we can have it merged in the early 6.3 rcs.

  Tomi

