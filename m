Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3AC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E72171F
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GEWh4qBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDLLOn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:14:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38355 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLLOm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 07:14:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412111441euoutp020750a6bfe65d8b21c721b45cdcde4c66~UtdEt7ySl1166111661euoutp02g
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 11:14:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412111441euoutp020750a6bfe65d8b21c721b45cdcde4c66~UtdEt7ySl1166111661euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555067681;
        bh=5ergXk1lRsUZdZ2OOoLLXXPaMZr8QVAdBkkoI2zau+o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GEWh4qBxf+9tmSA6q5aujcUwArkxq9idOKTG8rwONaVDAvEIMDQeHJt21BmmQSCzJ
         Ymaf0C+/dVNpKiW2g7RKRhQVb7d2hCRzJd85Jy7mRtSjqNMZfU+2FHklw9fKSF4/SG
         0Qdrk4ZfWkBBVNQqLqWDRLwLg4eF+4FaX5uobB+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412111440eucas1p2f49cd1ef6b895330a8f4d7be4f9414f9~UtdEEmE5E1199111991eucas1p2Z;
        Fri, 12 Apr 2019 11:14:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 52.04.04377.02370BC5; Fri, 12
        Apr 2019 12:14:40 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412111439eucas1p162723f171603c0d0c16e7a0c6c8e947e~UtdDWkgel0964009640eucas1p15;
        Fri, 12 Apr 2019 11:14:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190412111439eusmtrp1ec974c045bbcdad3bdb803ad274f0e0a~UtdDIfspu2940229402eusmtrp1C;
        Fri, 12 Apr 2019 11:14:39 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ed-5cb073207f85
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.2C.04146.F1370BC5; Fri, 12
        Apr 2019 12:14:39 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412111439eusmtip247b6ee355a6289d2edb7b90424843419~UtdCojFEU2269722697eusmtip2E;
        Fri, 12 Apr 2019 11:14:39 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <512d5fd1-e4d3-c074-1b13-886747e8db97@samsung.com>
Date:   Fri, 12 Apr 2019 13:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1c4fc9c3-4c9e-475a-262a-1479f77e267b@xs4all.nl>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURjFuzszu6M1dluV/dJS2ZRQSlOCpoeWZTBShEKGVJSbDhr5YifL
        R4FalusjNCN1NdnwLWSb1vroYSmpaZpGfxgWVpRFqFiriQ+2nMbI/37nu+ee7x64NKEcoBzo
        07FneW2sJlottyZNnbOvNrsIxuNbykuA7X3ZI2MrZltl7KQhnO0pGJWxjf05FKvLr1CwOcYH
        FFvVsCBjf/a0EOzLtlo5a86wyPes5EpSB0nuxvw9imt+X4G4ksxiiuuYvk1yDXU6Odf4LZvg
        zA1OXM+0WRFkddR6VwQfffocr/XyC7OOas/3jdfZJE6a75GpqGplFrKiAW+Fx71XURayppW4
        BkHlQN2SmEKgS2tRiC4lNiPIbWT+3bhjMpGSqRrB8PfyJTGOwGhIk4suW3wATPonMvHADtfI
        oKStlRIFgbMQ/Hpd+tclx96Q+/za4kKaZrAfzAzai2MSu0GTLh+JbI9DYaTTSInM4DXwovgz
        KbIV9oUvHcV/YwisgvSpWkpiZ2gaLyXEXYCnFfDs7QIp5gMOgPov+6UKtvC9675C4nXQW5BD
        Sv5LCHIeDiskkYdgpMuAJNdO6OgapMQgArvD3VYvKdMfhspCJLSBofE10hNs4LqpkJDGDGRe
        UUoZrjBfVyiT2AGyP/8m85Bav6yYflkZ/bIy+v9rDYisQyo+QYiJ5AWfWP68p6CJERJiIz3D
        42Ia0OI/67V0TTWj1oVT7QjTSL2KCfW/e1xJac4JSTHtCGhCbcccJhdHTIQmKZnXxp3UJkTz
        QjtypEm1iklZ8eGYEkdqzvJneD6e1/47ldFWDqlow60LZUeeqkIDo+4YxoLKI4PnFnKLgm1m
        0it9kl2qJ3arL651+jiRctDWgx1eH+BqcSt6N2F8ZFnNhmX05x7qYxxdBva6b1RV+3X/GLWM
        DeWN9bl+3VQfkDDaHVIZF0htNyeulZ9w2PEmxWi7L/mmIgJddiYD57bpo6uMs2ON3Z/UpBCl
        8fYgtILmDxjU17NjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7ryxRtiDNbeUrE4feYUk8WSn7uY
        LD4sSLY4NfkZk8Xmcz2sFp0Tl7Bb9GzYymqxbNMfJotPp3YyW5zZv5LN4nPrPzYHbo/ZDRdZ
        PKb83sjqsePuEkaP2R0zWT0Of13I4rFpVSebx+YX3cwenzfJeZz6+pk9gDNKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PQRNuCTr6KD583sjQw
        LuPuYuTkkBAwkVi7bRtLFyMXh5DAUkaJmy/XADkcQAkpifktShA1whJ/rnWxQdS8ZpR493k7
        C0hCWMBbYtusfUwgCRGBVUwSu5sfsYM4zAJdjBK/D3YyQrT8Y5S4u+8+M0gLm4ChRO/RPkaQ
        FbwCdhLfL4qChFkEVCW2d05kBLFFBSIkzrxfAbaBV0BQ4uTMJ2A2p4CtxNPDM9lAbGYBdYk/
        8y4xQ9jiEk1fVrJC2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJu
        cWleul5yfu4mRmAMbzv2c/MOxksbgw8xCnAwKvHwBlitjxFiTSwrrsw9xCjBwawkwhvCAhTi
        TUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGB6ySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCe
        WJKanZpakFoE08fEwSnVwJh/qHyt/tY86QXi0QHF2jdsT27yvGV41HQ5s52xAbdYe+iTuvX9
        Roui73HNCXzUdnHdsvAPy4V+RJ3h8P5yrsgrI5P13cLJzlZpCnPdvXrE2VqTjl/I8Sj7ee+k
        oeBhtY0Bc0PCdD5PmvBDqv7ZHdU9bxbm1Qtfu7fgrvdZmSmu+wq7N4W/a1ViKc5INNRiLipO
        BACdsWj89wIAAA==
X-CMS-MailID: 20190412111439eucas1p162723f171603c0d0c16e7a0c6c8e947e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412092035epcas1p43412936a0fba75b1c548904e785fe23d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412092035epcas1p43412936a0fba75b1c548904e785fe23d
References: <CGME20190412092035epcas1p43412936a0fba75b1c548904e785fe23d@epcas1p4.samsung.com>
        <20190412092027.20410-1-boris.brezillon@collabora.com>
        <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
        <1c4fc9c3-4c9e-475a-262a-1479f77e267b@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/19 12:32, Hans Verkuil wrote:
> On 4/12/19 12:16 PM, Sylwester Nawrocki wrote:
>> On 4/12/19 11:20, Boris Brezillon wrote:
>>> The fimc-isp-video.c and fimc-lite.c were missing the
>>> V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.
>>
>> Th omission was intentional, as these video nodes cannot be used
>> by "standard" V4L2 capture applications. Some sub-devices need to 
>> be configured first in order to use these video nodes. It was 
>> agreed to not set these capabilities in the driver, instead user
>> space library, e.g. libv4l2 with driver-specific plugin handling
>> the media controller and v4l2 subdev calls would set the capability
>> for the applications. Has something changed?
> 
> I remember that this was discussed, but nobody actually followed that
> guideline. Just do:
>
> git grep -l V4L2_CAP_VIDEO_CAPTURE drivers/media/platform
> 
> It really doesn't make sense to leave it out since userspace has to know if
> it is single or multiplanar, and if you don't set this capability, then how
> can it tell?

Presumably you can't by only querying the video device, this would require 
MC and driver-specific user space. 

> I always thought we need a separate CAP or some other way of signaling this,
> but the few times I proposed something it was always shot down.
> 
> So to be consistent with the other MC drivers you should set this MPLANE cap
> as well in the fimc driver.

I'm not against the $subject patch, rather the opposite. Especially if 
it is a part of reasonable API updates. But removing the capabilities was 
actually a requirement to get the driver merged, not a guideline.
And was rather painful then, now the driver is probably not in use any more
so I don't really mind.

-- 
Regards,
Sylwester
