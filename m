Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69294C4332F
	for <linux-media@archiver.kernel.org>; Wed,  9 Nov 2022 06:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKIGlL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 9 Nov 2022 01:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIGlK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 9 Nov 2022 01:41:10 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C615733;
        Tue,  8 Nov 2022 22:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667976048; bh=s2xnc8dtE9RdQHld1qiAbNnZOdtNe2s+3N0KAhbpfss=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ndkZyXusVJy9VW0jXi8vkuuV13fsCt/56qU728chMOc2JpCE9kTefADbxnUar/XZm
         57OMxk53j5ZQRPy0AU3esFAWUQt9a6H3neQoMExVrjFBs7oy9uf/3PvLMLckzXPBP6
         onkglGt2BakIfxgSo1wNSLgj/CmT09/K+yQFVt6k=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 07:40:48 +0100 (CET)
X-EA-Auth: F61TFAW5EIxTOLGMc0AqWx1vFt0VZ8WWn5l9nu0xUmZiOFCbHY9NJ+7ODh/iOVr28E2+bZFRA3PVvl3YE6fgdY81AlgJbShA
Date:   Wed, 9 Nov 2022 12:10:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Dan Carpenter <error27@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: patches for staging:media drivers
Message-ID: <Y2tLZaPSUT45TF4f@qemulion>
References: <Y2eSCZJNWn6DzCUu@qemulion>
 <48f4bda9-b5e3-9649-aab9-b529889bf110@linaro.org>
 <Y2oO7fU4whKr+3hb@kadam>
 <Y2q7tFF7YeX16H20@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2q7tFF7YeX16H20@lunn.ch>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Nov 08, 2022 at 09:27:32PM +0100, Andrew Lunn wrote:
> On Tue, Nov 08, 2022 at 11:10:21AM +0300, Dan Carpenter wrote:
>
> I cannot say anything about the media subsystem, but for networking
> patches, i will be much more willing to help somebody going from
> Outreach to being a full kernel developers if they decide to take on
> something more than just some Coccinelle changes. If it looks like you
> have the hardware and want to make it better, have a vision where the
> driver should go, then you are likely to get more help from me. So if
> media drivers are what you interested in, go buy some hardware which
> uses one of the drivers in staging, look at the TODO file, and submit
> bigger patches than just -1 to -ENOMEM.

Hello Andrew,
Thank you so much for your kind advice and willingness to help a newbie
become a valued kernel developer. I am committed to acquire necessary
knowledge and skills to contribute more than current cleanup and minor
correction patches. I am sure that the upcoming Coccinelle based project
work [if I am shortlisted] will be much more complex and meaningful.

I will explore the staging directory to identify a hardware I can afford.
I would welcome suggestion on a driver that is not much expensive and
complex to start with. Anything for the networking subsystem???

Thank you once again!
./drv

>
>      Andrew
>


