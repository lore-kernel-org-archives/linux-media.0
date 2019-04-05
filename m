Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42AAC10F24
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC2721738
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfDEQQy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:16:54 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:56488 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfDEQQy (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 12:16:54 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A0FC43C00C5;
        Fri,  5 Apr 2019 18:16:50 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uHAvInRGDHxV; Fri,  5 Apr 2019 18:16:43 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 2D52F3C00C3;
        Fri,  5 Apr 2019 18:16:43 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 5 Apr 2019
 18:16:42 +0200
Date:   Fri, 5 Apr 2019 18:16:39 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-media@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        <harsha.manjulamallikarjun@in.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190405161639.GA10433@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524101452.GC31036@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Niklas, Jacopo cc: Steve

Apologize for reviving this old thread. Just one question below.

On 2018-05-24 10:14:52, Niklas Söderlund wrote:

> Hi Jacopo,

> Thanks for your patch.
>
> On 2018-05-18 16:40:39 +0200, Jacopo Mondi wrote:
>> As CSI-2 subdevices are shared between several VIN instances, a shared
>> notifier to collect the CSI-2 async subdevices is required. So far, the
>> rcar-vin driver used the notifier of the last VIN instance to probe but
>> with the forth-coming introduction of parallel input subdevices support
>> in mc-compliant code path, each VIN may register its own notifier if any
>> parallel subdevice is connected there.
>> 
>> To avoid registering a notifier twice (once for parallel subdev and one
>> for the CSI-2 subdevs) create a group notifier, shared by all the VIN
>> instances.
>> 
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> ---
>>  drivers/media/platform/rcar-vin/rcar-core.c | 39 +++++++++++------------------
>>  drivers/media/platform/rcar-vin/rcar-vin.h  |  7 +++---
>>  2 files changed, 18 insertions(+), 28 deletions(-)

[..]

>> +
>>  #define vin_to_source(vin)		((vin)->parallel->subdev)

> This in particular I hate and at some point I hope to remove it or
> move  it to rcar-v4l2.c. :-) But that is a task for later and not
> related to  your patch-set.

What about below patch excerpt (courtesy of Steve) which is currently
under review in our tree? If we are on the same page here, we would
happily contribute a patch to you based on below.

Subject: [PATCH] media: rcar-vin: Generalize vin_to_source()

Change the vin_to_source() macro to an inline function that will
retrieve the source subdevice for both media-control and non
media-control mode.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
[..]

diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
index 0b13b34d03e3..29d8c4a80c35 100644
--- a/drivers/media/platform/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/rcar-vin/rcar-vin.h
@@ -217,7 +217,21 @@ struct rvin_dev {
 	v4l2_std_id std;
 };
 
-#define vin_to_source(vin)		((vin)->parallel->subdev)
+static inline struct v4l2_subdev *
+vin_to_source(struct rvin_dev *vin)
+{
+	if (vin->info->use_mc) {
+		struct media_pad *pad;
+
+		pad = media_entity_remote_pad(&vin->pad);
+		if (!pad)
+			return NULL;
+
+		return media_entity_to_v4l2_subdev(pad->entity);
+	}
+
+	return vin->parallel->subdev;
+}
 
 /* Debug */
 #define vin_dbg(d, fmt, arg...)		dev_dbg(d->dev, fmt, ##arg)

Best regards,
Eugeniu.
