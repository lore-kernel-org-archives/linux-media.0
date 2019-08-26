Return-Path: <SRS0=igqM=WW=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB00C3A5A4
	for <linux-media@archiver.kernel.org>; Mon, 26 Aug 2019 11:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDE321881
	for <linux-media@archiver.kernel.org>; Mon, 26 Aug 2019 11:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfHZLxU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:53:20 -0400
Received: from retiisi.org.uk ([95.216.213.190]:46636 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfHZLxT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 26 Aug 2019 07:53:19 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id B341E634C88;
        Mon, 26 Aug 2019 14:53:09 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1i2DYb-0000Nz-IT; Mon, 26 Aug 2019 14:53:09 +0300
Date:   Mon, 26 Aug 2019 14:53:09 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Louis Kuo <louis.kuo@mediatek.com>
Cc:     hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        tfiga@chromium.org, keiichiw@chromium.org, matthias.bgg@gmail.com,
        mchehab@kernel.org, yuzhao@chromium.org, zwisler@chromium.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Sean.Cheng@mediatek.com,
        sj.huang@mediatek.com, christie.yu@mediatek.com,
        holmes.chiou@mediatek.com, frederic.chen@mediatek.com,
        Jerry-ch.Chen@mediatek.com, jungo.lin@mediatek.com,
        Rynn.Wu@mediatek.com, linux-media@vger.kernel.org,
        srv_heupstream@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH V3 2/4] media: platform: Add Mediatek sensor
 interface driver KConfig
Message-ID: <20190826115309.GC826@valkosipuli.retiisi.org.uk>
References: <1559815233-24796-1-git-send-email-louis.kuo@mediatek.com>
 <1559815233-24796-3-git-send-email-louis.kuo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559815233-24796-3-git-send-email-louis.kuo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Jun 06, 2019 at 06:00:31PM +0800, Louis Kuo wrote:
> This patch adds KConfig for sensor interface driver. Sensor interface
> driver
> is a MIPI-CSI2 host driver, namely, a HW camera interface controller.
> It support a widely adopted, simple, high-speed protocol primarily
> intended
> for point-to-point image and video transmission between cameras and host
> devices.
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> ---
>  drivers/media/platform/mtk-isp/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 drivers/media/platform/mtk-isp/Kconfig
> 
> diff --git a/drivers/media/platform/mtk-isp/Kconfig b/drivers/media/platform/mtk-isp/Kconfig
> new file mode 100644
> index 0000000..bc7fd01
> --- /dev/null
> +++ b/drivers/media/platform/mtk-isp/Kconfig
> @@ -0,0 +1,17 @@
> +config MTK_SENINF
> +	bool "Mediatek mipi csi2 driver"
> +	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
> +	depends on MEDIA_CAMERA_SUPPORT
> +	select V4L2_FWNODE
> +
> +	default n
> +	help
> +	    This driver provides a mipi-csi2 host driver used as a
> +	    interface to connect camera with Mediatek's
> +	    MT8183 SOCs. It is able to handle multiple cameras
> +	    at the same time.
> +
> +	    Choose y if you want to use Mediatek SoCs to create image
> +	    capture application such as video recording and still image
> +	    capture.

Rather than being a separate patch, this should go in with the driver.

The DT bindings should precede the driver, and you'll need a MAINTAINERS
entry for the driver, too.

-- 
Sakari Ailus
