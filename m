Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E0C433FE
	for <linux-media@archiver.kernel.org>; Tue,  8 Mar 2022 10:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbiCHKGB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Mar 2022 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiCHKGB (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 8 Mar 2022 05:06:01 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F4E3FD9D
        for <linux-media@vger.kernel.org>; Tue,  8 Mar 2022 02:05:02 -0800 (PST)
X-KPN-MessageId: 35607a54-9ec7-11ec-a506-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 35607a54-9ec7-11ec-a506-00505699b430;
        Tue, 08 Mar 2022 11:04:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=1wJ+0H1ytXAp5iNnkF3IFNhQyeE5rGXO+z/GcyyfiqQ=;
        b=UKFbWFLnkqDeMOp/DDeyCcDAMV05W8jyXNOioxy8Rz42FsvbReMPaU0DAIGCI8s81OIBbsbGdlSJH
         le7yLHwu+O33oHh+oqW1CwcEAzdYnn43xhQx4Hms8WiBhWEDP85JCFUMzX2Xo7vVWgwFSswVgFxUu7
         5Y9hDNuzKTUDaQhbe6gwmaD87onxlbciiZG0GK5+llEYylXjrp6YcnVKR7/Ujnl8t2fF7bJ/4mUGCv
         2I1xKg+q3f0/2ghbXFP/xnDt/ViecEKI1P+KiZTDISiIPoI7UmoGRc1xI6Qf1fNyHzOzwHnpfL4e42
         poVb1hGFhIyNNUMdUvPkM5Mawq01xDQ==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|1vuL5+urtskp1bT5j/DNQyJwiBCAhPsphfnal+BK+YQKsFW8QYKFAqdUdqvgERq
 QNbR7yBlRx+06szfyGHOSQw==
X-Originating-IP: 173.38.220.60
Received: from [10.47.77.219] (unknown [173.38.220.60])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 36c0954f-9ec7-11ec-bc0d-00505699772e;
        Tue, 08 Mar 2022 11:05:00 +0100 (CET)
Message-ID: <c38a229a-92b5-07c1-7f65-bb944ae6e555@xs4all.nl>
Date:   Tue, 8 Mar 2022 11:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] media: fix Documentation label name
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220308095530.14099-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220308095530.14099-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

I've posted a patch for this already that also fixes an issue for the MM21 pix format:

https://patchwork.linuxtv.org/project/linux-media/patch/c0a9a647-5e27-52bd-65a0-b9663014887a@xs4all.nl/

So I'll mark this as obsoleted in patchwork.

Thank you for doing this, though.

Regards,

	Hans

On 3/8/22 10:55, Ming Qian wrote:
> the label name should use dash, not underline
> 
> change _V4L2_PIX_FMT_NV12M_8L128 to _V4L2-PIX-FMT-NV12M-8L128
> change _V4L2_PIX_FMT_NV12M_10BE_8L128 to _V4L2-PIX-FMT-NV12M-10BE-8L128
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 8b2ff1d29639..bd1a962a80a7 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -257,8 +257,8 @@ of the luma plane.
>  .. _V4L2-PIX-FMT-NV12-4L4:
>  .. _V4L2-PIX-FMT-NV12-16L16:
>  .. _V4L2-PIX-FMT-NV12-32L32:
> -.. _V4L2_PIX_FMT_NV12M_8L128:
> -.. _V4L2_PIX_FMT_NV12M_10BE_8L128:
> +.. _V4L2-PIX-FMT-NV12M-8L128:
> +.. _V4L2-PIX-FMT-NV12M-10BE-8L128:
>  
>  Tiled NV12
>  ----------

