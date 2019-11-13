Return-Path: <SRS0=zAWw=ZF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14935C432C3
	for <linux-media@archiver.kernel.org>; Wed, 13 Nov 2019 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F49206E1
	for <linux-media@archiver.kernel.org>; Wed, 13 Nov 2019 19:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMTm6 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:42:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39042 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMTm6 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 13 Nov 2019 14:42:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B20A1287F0E
Message-ID: <e65ca03c095c99dc8482e9c36dcd099b6c69fc38.camel@collabora.com>
Subject: Re: [PATCH 0/5] v4l2 JPEG helpers and CODA960 JPEG decoder
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>, kernel@pengutronix.de
Date:   Wed, 13 Nov 2019 16:42:48 -0300
In-Reply-To: <20191113150538.9807-1-p.zabel@pengutronix.de>
References: <20191113150538.9807-1-p.zabel@pengutronix.de>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Philipp,

Thanks a lot for working on this. I'm so glad about
both efforts: the CODA JPEG support and the JPEG
helpers.

On Wed, 2019-11-13 at 16:05 +0100, Philipp Zabel wrote:
> Hi,
> 
> as far as I can tell we currently have three JPEG header parsers in the
> media tree (in the rcar_jpu, s5p-jpeg, and mtk-jpeg drivers). I would
> like to add support for the CODA960 JPEG decoder to the coda-vpu driver
> without adding yet another.
> 
> To this end, this patch series adds some common JPEG code to v4l2-core.
> For now this just contains header parsing helpers (I have tried to keep
> the terminology close to JPEG ITU-T.81) that should be usable for all of
> the current drivers. In the future we might want to move JPEG header
> generation for encoders and common quantization tables in there as well.
> 

Indeed, moving encoders to use these helpers sounds like the right thing
to do. IIRC, quantization tables are implementation defined, and not imposed
by anything. I believe gspca drivers use some tables that don't follow
any recomendation.

I guess it's fine to leave some drivers unconverted, without using any helpers,
and move others to use a helper-derived quantization table.  

> I have tested this on hardware only with coda-vpu, the other drivers are
> just compile-tested.
> 
> Feedback very welcome, especially whether this actually works for the
> other drivers, and if this could be structured any better. I'm a bit
> unhappy with the (current) need for separate frame/scan header and
> quantization/hfufman table parsing functions, but those are required
> by s5p-jpeg, which splits localization and parsing of the marker
> segments. Also, could this be used for i.MX8 JPEGDEC as is?
> 
[..]

Regards,
Ezequiel

