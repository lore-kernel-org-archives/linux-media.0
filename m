Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6073C10F11
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AFF20811
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sWJjayK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfDXKK2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:10:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44406 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfDXKK2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 06:10:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190424101025euoutp022635b74b2e7f76dadde6cd23da38f5f0~YYUZLTOna2221522215euoutp02i
        for <linux-media@vger.kernel.org>; Wed, 24 Apr 2019 10:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190424101025euoutp022635b74b2e7f76dadde6cd23da38f5f0~YYUZLTOna2221522215euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556100625;
        bh=woiPCXTXFBirC19dPqDxMyOUQWHS+MrhSrIJjhm4f/A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sWJjayK7MskgthnwKlUfo+fDqaNJDifrLvf7SySujUq4IW6X4r/P9gYtNEGPTpx4B
         23HCWrDbULNSlIPhTKdGKIsVt/+uLUrjOwgGk0f8+y3sXRauhOGnBmLLC8MJAGDWAh
         6pUlk4w8sJ7SNypnot1On5rRSPIyxZa4dKlTkSCw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190424101025eucas1p103201117fcf28fe09ef0e249892457b8~YYUYihy1a2232022320eucas1p1Y;
        Wed, 24 Apr 2019 10:10:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0B.0E.04298.01630CC5; Wed, 24
        Apr 2019 11:10:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190424101024eucas1p17797d6856edbece34fefd468c6e1feff~YYUXtiR4G1447914479eucas1p12;
        Wed, 24 Apr 2019 10:10:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190424101023eusmtrp2a573715f172b5d2d1dfae8bfc4533463~YYUXfgjwl0993909939eusmtrp2Z;
        Wed, 24 Apr 2019 10:10:23 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-11-5cc036101c97
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.31.04146.F0630CC5; Wed, 24
        Apr 2019 11:10:23 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190424101023eusmtip1cd0a9be948c7f2762ce15b42a078ccf2~YYUXAjnRM1149311493eusmtip1m;
        Wed, 24 Apr 2019 10:10:23 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] media: v4l2: Make sure all drivers set _MPLANE
 caps in vdev->device_caps
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <371f8176-7d9d-45b2-89c4-9bca35fa1d1b@samsung.com>
Date:   Wed, 24 Apr 2019 12:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416120313.6005-1-boris.brezillon@collabora.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b13u05X12n4sMRg5A+DNEviRmkaUYuggv4ME+w2rx+oUza1
        XAXLPvA7DfNjSpnOUvNzM3VKaEpOnWlKZSSmkZRFgjkFzdK2XSX/nec8z3nPOfCSmHiAkJAx
        yiRWpWTipHwh3tq3MrKPOtQdtv+b6SBtGRrk0fqVDh49X66gjcPZBJ2RrxfQ2U3PCfqJ4Q+P
        Xhg0YfRQVw2ftt5Z4wcLZaXaUVxWsNpMyNon9UhWml5CyHqXHuMyQ20GX2aczcJkVoPXeTJU
        eDSCjYtJYVV+QZeE0dU/P2KJf12uDneO8bVoXJiJnEigAsDa8x63YzFVjeCh5XQmEtrwIoLm
        erOAG6wIqpq7BZuKiv7XG4unCHJ+LWLcMIegdanY8ZYbFQmLLdOEHbtTYVC21EnYjzDKyIPq
        F2bMvuBT/pDzKhfZsYgKgq7iBw4BTnlD8UihA++k5DDV10RwN64wUDLjMHCijsOb31OOSBjl
        AWmLNQSHd0PbXJkjEVCfBPCsoQTjcp+AsfzbiMNu8MPcstHHE9ZNj3ic4BaC7M4JATfkIZgy
        l28ojkCvedRmQdosfKCxw4+jQ6Dhy00HDdR2+DDnyoXYDvdbizCOFkH6XTF3vQdWa4t4HJZA
        1sw6noekui3VdFvq6LbU0f33LUd4LfJgk9XxUazaX8le8VUz8epkZZSvIiHegGwfzLJmXmhH
        S2OXexBFIqmLSO7WFSYmmBR1anwPAhKTuosC2myUKIJJ1bCqhHBVchyr7kG7SFzqIbq2bfqi
        mIpikthYlk1kVZtbHukk0aKWyHuT0P/SVEk66/RvLTW147lfZ1wXdOemPSdWPh9z946pR4cD
        J9K0gT5rsZrZDEnUScmNIsMy4wQzZw5UKi7IfdcNFtflUMX3kJq62VOjYhcvUHhCXbikfmi+
        UFMV/u7swEpaRXDKslYunS+w5mkI/o7GcPy6s6EkxyiU4upoxn8vplIz/wD/CzaaXAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7r8ZgdiDD6sNbc4feYUk8WSn7uY
        LD4sSLbYfK6H1aJz4hJ2i54NW1ktlm36w2Tx6dROZosz+1eyWXxu/cfmwOUxu+Eii8eU3xtZ
        PXbcXcLoMbtjJqvH4a8LWTw2repk89j8opvZ4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MFW9uMRf85ak4t/sSWwPjda4uRk4OCQET
        iUUnzrJ3MXJxCAksZZR41XqQuYuRAyghJTG/RQmiRljiz7UuNoia14wSf2b+YAFJCAukSXzZ
        8oAVxBYRiJFYcv4mM0gRs8BmJon5q+dBTZ3KKNF04SlYFZuAoUTv0T5GEJtXwE5i/4ypYHEW
        AVWJGeengdmiAhESZ96vYIGoEZQ4OfMJmM0p4CRx4dd9dhCbWUBd4s+8S8wQtrhE05eVrBC2
        vMT2t3OYJzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGLHb
        jv3cvIPx0sbgQ4wCHIxKPLwBPPtjhFgTy4orcw8xSnAwK4nwmmwHCvGmJFZWpRblxxeV5qQW
        H2I0BXpuIrOUaHI+MJnklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+Lg
        lGpg5DYXdlMXZ9MPfezHGiX3PWK3l3m39u8KQ4FFVjPkkph+cF2SOP+prKn9vJzOr5caPrMO
        Pr3KfkL9/IsbIg8/rpYWr4mfJsJ+SoDhtrpf0MK3Jxo2nLktvvHaJRUj2TNL//QdlCreyfVt
        lWytzVx582aedftsdVJWn/2hKi38e/HEhF+ZK9/2KrEUZyQaajEXFScCAB5tXl7uAgAA
X-CMS-MailID: 20190424101024eucas1p17797d6856edbece34fefd468c6e1feff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190416120324epcas1p255f6a52103f335e58d612ad6831a6556
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190416120324epcas1p255f6a52103f335e58d612ad6831a6556
References: <CGME20190416120324epcas1p255f6a52103f335e58d612ad6831a6556@epcas1p2.samsung.com>
        <20190416120313.6005-1-boris.brezillon@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/16/19 14:03, Boris Brezillon wrote:
> This is needed if we want the core to be able to check _MPLANE support
> without having to call the ->vdioc_querycap() hook.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Changes in v4:
> - Add a hack in fimc-lite and fimc-isp-video ->querycap()
>   implementation to avoid reporting _MPLANE caps as userspace is not
>   ready for that
 

> diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> index bb35a2017f21..0fb474b608ba 100644
> --- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
> +++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> @@ -349,7 +349,15 @@ static int isp_video_querycap(struct file *file, void *priv,
>  {
>  	struct fimc_isp *isp = video_drvdata(file);
>  
> -	__fimc_vidioc_querycap(&isp->pdev->dev, cap, V4L2_CAP_STREAMING);
> +	__fimc_vidioc_querycap(&isp->pdev->dev, cap);
> +
> +	/*
> +	 * FIXME: Userspace does not expect V4L2_CAP_VIDEO_CAPTURE_MPLANE to
> +	 * be set when calling ioctl(QUERYCAP) but we need to set this bit
> +	 * in vdev->device_caps to let the v4l2 core do some consistency check.
> +	 * Let's clear it here until we find a better solution.
> +	 */
> +	cap->device_caps &= ~V4L2_CAP_VIDEO_CAPTURE_MPLANE;

If the common convention is that we set these caps then I don't see a reason
why we couldn't drop this hack, and in fimc-lite as well.
The chances that leaving these caps raised are not greater than zero on systems
where this driver could be used I'd say.
Otherwise the patches look good to me.

Thanks,
Sylwester
