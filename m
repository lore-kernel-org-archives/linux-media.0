Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7906C10F14
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D250206BA
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 10:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLKYH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:24:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLKYG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 06:24:06 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 46965280AF6;
        Fri, 12 Apr 2019 11:24:04 +0100 (BST)
Date:   Fri, 12 Apr 2019 12:24:01 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: Re: [PATCH v3 1/2] media: exynos4-is: Properly report _MPLANE caps
Message-ID: <20190412122401.722bdf63@collabora.com>
In-Reply-To: <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
References: <CGME20190412092035epcas1p43412936a0fba75b1c548904e785fe23d@epcas1p4.samsung.com>
        <20190412092027.20410-1-boris.brezillon@collabora.com>
        <c1faa661-6631-00ae-836b-4f24b1ee408e@samsung.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 12 Apr 2019 12:16:42 +0200
Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:

> Hi,
> 
> On 4/12/19 11:20, Boris Brezillon wrote:
> > The fimc-isp-video.c and fimc-lite.c were missing the
> > V4L2_CAP_VIDEO_CAPTURE_MPLANE flag when reporting device caps.  
> 
> Th omission was intentional, as these video nodes cannot be used
> by "standard" V4L2 capture applications. Some sub-devices need to 
> be configured first in order to use these video nodes. It was 
> agreed to not set these capabilities in the driver, instead user
> space library, e.g. libv4l2 with driver-specific plugin handling
> the media controller and v4l2 subdev calls would set the capability
> for the applications. Has something changed?
> 

Hm, maybe I should just drop the extra consistency check I added in
v4l_enum_fmt() and call ->vidioc_enum_fmt_vid_{cap,out}()
unconditionally.
