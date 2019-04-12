Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A0C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453A920850
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLKcI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:32:08 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:57251 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfDLKcI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 06:32:08 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EtTZh09k6NG8zEtTahCLpx; Fri, 12 Apr 2019 12:32:06 +0200
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <CGME20190412092035epcas1p43412936a0fba75b1c548904e785fe23d@epcas1p4.samsung.com>
 <20190412092027.20410-1-boris.brezillon@collabora.com>
 <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1c4fc9c3-4c9e-475a-262a-1479f77e267b@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKYqeRbbQWsWjbiNks5T27aTZG8SlVNWcrGgnIa+3GJSxzLYw47r867dpIH3M1fU1o/sE8U7UaK3uvz/qWwYgLvI/Yz11rLE2sLcCuF6r9asB28RL3vZ
 SJTPdQr0Rgvt+lDZWpFTE6Y65NfxzaNkHLAEY9z3tMZLIoTXUVfZRLJoGXvi/i/cZPskXDzhnCGx6PXzrP5M9qi/Zwg+erkGk+q0rKhxxWQEZSRMjnV8otO1
 Me97hdsCksDLL4k2uRp8VbGGiiwTSYs38VnujBHHmxnKciWTHQNAkRRJxOczkAsR9qgfZrZzy1Bb1bnYwOpzInFzV43efIvnYI3gAeUskctD0OfzdB1ob9Ph
 9Y4g+3jnR9RSFcFvSUy53BQ0JPF2gdNVPzesidwrgEciOV95SvpCiYswMl6SbPFahT27LjmqfLKYO57kqY+tbFJbke/GbHq7c0K3FihKBTLiR7YeH4/U2VU8
 g3pbn3JdUSLiUyZHyAC29c3Yitxv2pxQk3FxEqk+ims19lXfk4/4O3tjsRZmOi2QnLaax7xkMFjA4ibJeR0iAML+xW2Wa8OoRWbShU+OegKjKpuWifKJvQd4
 ZF0PwGS16uKrkS+BJCFhV4LgnmceprAwRuwD/ctf06puEQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/19 12:16 PM, Sylwester Nawrocki wrote:
> Hi,
> 
> On 4/12/19 11:20, Boris Brezillon wrote:
>> The fimc-isp-video.c and fimc-lite.c were missing the
>> V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.
> 
> Th omission was intentional, as these video nodes cannot be used
> by "standard" V4L2 capture applications. Some sub-devices need to 
> be configured first in order to use these video nodes. It was 
> agreed to not set these capabilities in the driver, instead user
> space library, e.g. libv4l2 with driver-specific plugin handling
> the media controller and v4l2 subdev calls would set the capability
> for the applications. Has something changed?
> 

I remember that this was discussed, but nobody actually followed that
guideline. Just do:

git grep -l V4L2_CAP_VIDEO_CAPTURE drivers/media/platform

It really doesn't make sense to leave it out since userspace has to know if
it is single or multiplanar, and if you don't set this capability, then how
can it tell?

I always thought we need a separate CAP or some other way of signaling this,
but the few times I proposed something it was always shot down.

So to be consistent with the other MC drivers you should set this MPLANE cap
as well in the fimc driver.

Regards,

	Hans
