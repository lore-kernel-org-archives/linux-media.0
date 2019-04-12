Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A69BC10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5127C2083E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FFIhwWLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDLKQr (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:16:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48046 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfDLKQr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 06:16:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412101646euoutp026880b8c72ce20eaf67eaed2381a1e48e~UsqgCXnHb1437214372euoutp02X
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 10:16:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412101646euoutp026880b8c72ce20eaf67eaed2381a1e48e~UsqgCXnHb1437214372euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555064206;
        bh=gbutTIYBORDiEXJNIbhFjoxYZwUugoxMuuXriUHK8xA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FFIhwWLc+5/xTGxrlIL708SsbOdbhuZulaZC5F3v7HflJc6wa+vJ+E8b7SuK+RKpH
         2kuZ+nG/7LTa4GgFzhBEvXU/Qkwgj8WIWNqAoO4MIRUAhKCwAfBMc80MMMBu8A2CCz
         FRDkfejrjF8BYWS7iT7b8hJtfT7oKCis2SnCFHwU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412101645eucas1p2fa65b576d9c0ec3589379c54d2625a0c~UsqfXsjbV1943819438eucas1p2d;
        Fri, 12 Apr 2019 10:16:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 87.0D.04377.C8560BC5; Fri, 12
        Apr 2019 11:16:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190412101644eucas1p21fac257f4680791f14d38f3e48b3b7f6~Usqeo_XyH0368703687eucas1p2l;
        Fri, 12 Apr 2019 10:16:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190412101644eusmtrp1f3de4641b3668986495a54769886b463~Usqea6Am_2681626816eusmtrp1P;
        Fri, 12 Apr 2019 10:16:44 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-05-5cb0658ca081
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.63.04140.C8560BC5; Fri, 12
        Apr 2019 11:16:44 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412101643eusmtip1e47b5595ce6b613a097408cc9534c2bb~Usqd8tnJM2413724137eusmtip1J;
        Fri, 12 Apr 2019 10:16:43 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel@collabora.com, Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
Date:   Fri, 12 Apr 2019 12:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412092027.20410-1-boris.brezillon@collabora.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zlnO45mn2vhy7KCUXRDV9KPA6kohZyoKKhArKhlBxW3KTt5
        6+bSNF3LdCnqjJhiF9ePbLOlRgaKrqYZlaRkpYSVXSTRJYiX6niM/Pc87/NenufjowllB6Wm
        k42nOJNRp9dI5aSnc6on9ArXcGSLHzNd3T4JUzfVImHGHAmMu8dKMUWldTLG2vCAYm65ZiTM
        uK+ZYLqf1EuZifw5abScrTa/JNmy6fsU2/S+DrHVhVUU2/6rhmRdziIp6x65TLATrtX76Xh5
        xElOn5zBmbRRx+VJPz35krQCKquw+jNhRjbSgmga8DZoKYq2IDmtxHcQlEy6pSLxI5jOLyBF
        MoHAmVsvs6CA+Ym3nX1SASvxbQTFeaFi0yiC14/fUIKwHO8Gj71VIggqnCeBd+NWSiAEtiCY
        fHV9flyKt8KVjmIkGFHgKJi9uFeAJF4HPfYooWMFjoPBzob5nQocBM+qhkkBB+AdYHnWN18n
        cDDk+usX8Bp4OHqdEE4B/iADc/knqeh6J3TOlFMiXg7fvI0LaUKg65qVFAfyEFgfDchEUoJg
        0OtAYtd2aPe+pAR3BN4I91q04uPFQP+NQyIMhP7RINFDINg8FYRYVkBhgVLcsRamnRUSEavh
        8vBvsgRp7IuS2RelsS9KY/9/1oFIJwrm0nlDIseHG7nMMF5n4NONiWEJqQYX+vu5uua8/ibU
        MnOiDWEaaZYq4mLuHVFSugw+29CGgCY0KsVB8m9JcVKXfZozpR4zpes5vg2tpElNsOLMkqHD
        SpyoO8WlcFwaZ/qnSugAtRnltO5pbF7p0ySXpr0om0o5WztmG+nu3bXe7PpYFimv8p33apNm
        1baOTda7rW5j9M0D6g2Dmyst5/bF1RSqlsVra4/2xsYezdJ9l11qvqDSDzwPH/niaxqyXY0N
        udb/9WmO6kdNh+/sqj3hIf7ihHhIj3FEZlbyEQ6/6fC2gRO1XRqST9Jt3USYeN0f2/6+zFgD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7o9qRtiDDqfcVucPnOKyWLJz11M
        Fh8WJFtsPtfDatE5cQm7Rc+GrawWyzb9YbL4dGons8WZ/SvZLD63/mNz4PKY3XCRxWPK742s
        HjvuLmH0mN0xk9Xj8NeFLB6bVnWyeWx+0c3s8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G+22tTAVtrBUds58xNzBOYuli5OSQEDCR
        uHXsOlsXIxeHkMBSRolTa7cxdzFyACWkJOa3KEHUCEv8udYFVfOaUeLQrQnMIAlhAW+JbbP2
        MYEkRARamSRWXZoL5jALdDFK/D7YyQjRMo1RounEUkaQFjYBQ4neo32MICt4Bewk/rb4gpgs
        AqoS52bZgVSICkRInHm/Auw6XgFBiZMzn4DZnALOEl0nr7OC2MwC6hJ/5l1ihrDFJZq+rISK
        y0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgfG6
        7djPLTsYu94FH2IU4GBU4uENsFofI8SaWFZcmXuIUYKDWUmEN4QFKMSbklhZlVqUH19UmpNa
        fIjRFOi3icxSosn5wFSSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mD
        U6qBsT5KmduY6fD7bMb4ZJOTNfML+92Xp3U7mU5hSz1klmfALC9yWV17aci8j/lnz1+UNf0c
        bvQ79YXBnj2LWANum9vZMyU8iVf88ag47Yko18rMI7umT91varEwpIXrzO8tXcu/Nq/dELNh
        wpLZ71hMDwZtUee6xak4MWellcuFiVxpe0qnrDE4p8RSnJFoqMVcVJwIALzC/UjtAgAA
X-CMS-MailID: 20190412101644eucas1p21fac257f4680791f14d38f3e48b3b7f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412092035epcas1p43412936a0fba75b1c548904e785fe23d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412092035epcas1p43412936a0fba75b1c548904e785fe23d
References: <CGME20190412092035epcas1p43412936a0fba75b1c548904e785fe23d@epcas1p4.samsung.com>
        <20190412092027.20410-1-boris.brezillon@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 4/12/19 11:20, Boris Brezillon wrote:
> The fimc-isp-video.c and fimc-lite.c were missing the
> V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.

Th omission was intentional, as these video nodes cannot be used
by "standard" V4L2 capture applications. Some sub-devices need to 
be configured first in order to use these video nodes. It was 
agreed to not set these capabilities in the driver, instead user
space library, e.g. libv4l2 with driver-specific plugin handling
the media controller and v4l2 subdev calls would set the capability
for the applications. Has something changed?

-- 
Thanks,
Sylwester
