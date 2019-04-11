Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338CC10F13
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 07:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F372133D
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 07:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKH7Z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:59:25 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:47811 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfDKH7Z (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 11 Apr 2019 03:59:25 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id EUcBhx5R1UjKfEUcChlAWw; Thu, 11 Apr 2019 09:59:21 +0200
Subject: Re: [RFC PATCH v2 1/7] media: v4l2: Get rid of
 ->vidioc_enum_fmt_vid_{cap,out}_mplane
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com
References: <20190404081700.30006-1-boris.brezillon@collabora.com>
 <20190404081700.30006-2-boris.brezillon@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c13c2c30-f78e-1cf2-26d3-1554e22947c3@xs4all.nl>
Date:   Thu, 11 Apr 2019 09:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404081700.30006-2-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCD1XsbztVrUQPUvAC6zJcgLk3PH8uer0BTmsvFQWgKsxl64j0C1L9ahhyd414MzGBCn98U5L4yB9Vm7CiHl+cnKcw2LsFY2IqA2PqjinmzUDvy5sc9m
 QZiSctvmn1oOu4AlW2P9MbRREWy5RpcBdlausjkChDFPxM2QTijA0kY9tE0N3AkY2fGms1JtJzjNZRVVgFNOnF5264Ew1QT4OzpELt31b2jWYLUey83b/akc
 UsSjo/pKbc1P/FxvKNJh8BnD5379ATfqk/jQw2UVamOPMbVeFLhL7os0PCLvbrYFGzpnHv8E8eNgBZFRaUeYLlLmFzdlL9XFjYewMFvpW8t8OD80d7zb7xlK
 5dxXWQoRuUo5x4HN+nQQoKVkINjHIyKdEuCUyQgwJVYaL1bys4kw3TCQWQeFw8AgUROD/KI+1Fl2hm/5PeRAPweKwxqWb+W/WHLzl58ewe4jDxA2axMxnZhy
 axpO9BjLoxPjCkEDr42Wvh4x51uGp34hGYyYHymdGYhNa4zOjLbzg4GwAMpNAUWVMCv1+9c6PsOIuEgwOKfroYVP/FrzjIrQzwWBJFX309DdXMfrS/0umis/
 fTb2tnjFBE7ur8TtKB1IaX2ZltBFs37dOSaOEKvWoGHevQ==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/4/19 10:16 AM, Boris Brezillon wrote:
> Support for multiplanar and singleplanar formats is mutually exclusive,
> at least in practice. In our attempt to unify support for support for
> mplane and !mplane in v4l, let's get rid of the
> ->vidioc_enum_fmt_{vid,out}_cap_mplane() hooks and call
> ->vidioc_enum_fmt_{vid,out}_cap() instead.

This is a good idea. This can be done separately from the other patches in
this series and merged.

One comment...

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Changes in v2:
> - None
> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  2 +-
>  drivers/media/platform/exynos-gsc/gsc-m2m.c   |  4 ++--
>  .../media/platform/exynos4-is/fimc-capture.c  |  2 +-
>  .../platform/exynos4-is/fimc-isp-video.c      |  2 +-
>  drivers/media/platform/exynos4-is/fimc-lite.c |  2 +-
>  drivers/media/platform/exynos4-is/fimc-m2m.c  |  4 ++--
>  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   |  4 ++--
>  drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c  |  4 ++--
>  .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  4 ++--
>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  4 ++--
>  .../media/platform/qcom/camss/camss-video.c   |  2 +-
>  drivers/media/platform/qcom/venus/vdec.c      |  4 ++--
>  drivers/media/platform/qcom/venus/venc.c      |  4 ++--
>  drivers/media/platform/rcar_fdp1.c            |  4 ++--
>  drivers/media/platform/rcar_jpu.c             |  4 ++--
>  drivers/media/platform/renesas-ceu.c          |  2 +-
>  drivers/media/platform/s5p-mfc/s5p_mfc_dec.c  |  4 ++--
>  drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |  4 ++--
>  drivers/media/platform/ti-vpe/vpe.c           |  4 ++--
>  drivers/media/platform/vicodec/vicodec-core.c |  2 --
>  drivers/media/platform/vivid/vivid-core.c     |  6 ++----
>  .../media/platform/vivid/vivid-vid-common.c   | 20 ------------------
>  .../media/platform/vivid/vivid-vid-common.h   |  2 --
>  drivers/media/v4l2-core/v4l2-dev.c            |  2 --
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 21 ++++++++++---------
>  drivers/staging/media/ipu3/ipu3-v4l2.c        |  4 ++--
>  .../media/rockchip/vpu/rockchip_vpu_enc.c     |  4 ++--
>  include/media/v4l2-ioctl.h                    | 14 ++-----------
>  28 files changed, 51 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index f8020ebe9f05..c3b3af3c3b2f 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -1174,7 +1174,7 @@ static const struct v4l2_file_operations cio2_v4l2_fops = {
>  
>  static const struct v4l2_ioctl_ops cio2_v4l2_ioctl_ops = {
>  	.vidioc_querycap = cio2_v4l2_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = cio2_v4l2_enum_fmt,
> +	.vidioc_enum_fmt_vid_cap = cio2_v4l2_enum_fmt,
>  	.vidioc_g_fmt_vid_cap_mplane = cio2_v4l2_g_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane = cio2_v4l2_s_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane = cio2_v4l2_try_fmt,
> diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> index c757f5d98bcc..9e2914d3d8f9 100644
> --- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
> +++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
> @@ -562,8 +562,8 @@ static int gsc_m2m_s_selection(struct file *file, void *fh,
>  
>  static const struct v4l2_ioctl_ops gsc_m2m_ioctl_ops = {
>  	.vidioc_querycap		= gsc_m2m_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= gsc_m2m_enum_fmt_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane	= gsc_m2m_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_cap	= gsc_m2m_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_out	= gsc_m2m_enum_fmt_mplane,

Please rename the functions as well, dropping the _mplane suffix. Here and in
the other drivers.

>  	.vidioc_g_fmt_vid_cap_mplane	= gsc_m2m_g_fmt_mplane,
>  	.vidioc_g_fmt_vid_out_mplane	= gsc_m2m_g_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= gsc_m2m_try_fmt_mplane,
> diff --git a/drivers/media/platform/exynos4-is/fimc-capture.c b/drivers/media/platform/exynos4-is/fimc-capture.c
> index 3e9fcf4f8a13..649c3a5b4d03 100644
> --- a/drivers/media/platform/exynos4-is/fimc-capture.c
> +++ b/drivers/media/platform/exynos4-is/fimc-capture.c
> @@ -1361,7 +1361,7 @@ static int fimc_cap_s_selection(struct file *file, void *fh,
>  static const struct v4l2_ioctl_ops fimc_capture_ioctl_ops = {
>  	.vidioc_querycap		= fimc_cap_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane	= fimc_cap_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_cap	= fimc_cap_enum_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= fimc_cap_try_fmt_mplane,
>  	.vidioc_s_fmt_vid_cap_mplane	= fimc_cap_s_fmt_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane	= fimc_cap_g_fmt_mplane,
> diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> index bb35a2017f21..ffe10a2ea6b0 100644
> --- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
> +++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
> @@ -551,7 +551,7 @@ static int isp_video_reqbufs(struct file *file, void *priv,
>  
>  static const struct v4l2_ioctl_ops isp_video_ioctl_ops = {
>  	.vidioc_querycap		= isp_video_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= isp_video_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_cap	= isp_video_enum_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= isp_video_try_fmt_mplane,
>  	.vidioc_s_fmt_vid_cap_mplane	= isp_video_s_fmt_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane	= isp_video_g_fmt_mplane,
> diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
> index 96f0a8a0dcae..b9c537d38a45 100644
> --- a/drivers/media/platform/exynos4-is/fimc-lite.c
> +++ b/drivers/media/platform/exynos4-is/fimc-lite.c
> @@ -954,7 +954,7 @@ static int fimc_lite_s_selection(struct file *file, void *fh,
>  
>  static const struct v4l2_ioctl_ops fimc_lite_ioctl_ops = {
>  	.vidioc_querycap		= fimc_lite_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= fimc_lite_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_cap	= fimc_lite_enum_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= fimc_lite_try_fmt_mplane,
>  	.vidioc_s_fmt_vid_cap_mplane	= fimc_lite_s_fmt_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane	= fimc_lite_g_fmt_mplane,
> diff --git a/drivers/media/platform/exynos4-is/fimc-m2m.c b/drivers/media/platform/exynos4-is/fimc-m2m.c
> index 61c8177409cf..278ab067e30f 100644
> --- a/drivers/media/platform/exynos4-is/fimc-m2m.c
> +++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
> @@ -533,8 +533,8 @@ static int fimc_m2m_s_selection(struct file *file, void *fh,
>  
>  static const struct v4l2_ioctl_ops fimc_m2m_ioctl_ops = {
>  	.vidioc_querycap		= fimc_m2m_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= fimc_m2m_enum_fmt_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane	= fimc_m2m_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_cap	= fimc_m2m_enum_fmt_mplane,
> +	.vidioc_enum_fmt_vid_out	= fimc_m2m_enum_fmt_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane	= fimc_m2m_g_fmt_mplane,
>  	.vidioc_g_fmt_vid_out_mplane	= fimc_m2m_g_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= fimc_m2m_try_fmt_mplane,
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index f761e4d8bf2a..3b199662cb34 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -536,8 +536,8 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>  
>  static const struct v4l2_ioctl_ops mtk_jpeg_ioctl_ops = {
>  	.vidioc_querycap                = mtk_jpeg_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = mtk_jpeg_enum_fmt_vid_cap,
> -	.vidioc_enum_fmt_vid_out_mplane = mtk_jpeg_enum_fmt_vid_out,
> +	.vidioc_enum_fmt_vid_cap	= mtk_jpeg_enum_fmt_vid_cap,
> +	.vidioc_enum_fmt_vid_out	= mtk_jpeg_enum_fmt_vid_out,
>  	.vidioc_try_fmt_vid_cap_mplane	= mtk_jpeg_try_fmt_vid_cap_mplane,
>  	.vidioc_try_fmt_vid_out_mplane	= mtk_jpeg_try_fmt_vid_out_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane    = mtk_jpeg_g_fmt_vid_mplane,
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> index 7d15c06e9db9..f094d1030331 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
> @@ -935,8 +935,8 @@ static int mtk_mdp_m2m_s_selection(struct file *file, void *fh,
>  
>  static const struct v4l2_ioctl_ops mtk_mdp_m2m_ioctl_ops = {
>  	.vidioc_querycap		= mtk_mdp_m2m_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= mtk_mdp_m2m_enum_fmt_mplane_vid_cap,
> -	.vidioc_enum_fmt_vid_out_mplane	= mtk_mdp_m2m_enum_fmt_mplane_vid_out,
> +	.vidioc_enum_fmt_vid_cap	= mtk_mdp_m2m_enum_fmt_mplane_vid_cap,
> +	.vidioc_enum_fmt_vid_out	= mtk_mdp_m2m_enum_fmt_mplane_vid_out,
>  	.vidioc_g_fmt_vid_cap_mplane	= mtk_mdp_m2m_g_fmt_mplane,
>  	.vidioc_g_fmt_vid_out_mplane	= mtk_mdp_m2m_g_fmt_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= mtk_mdp_m2m_try_fmt_mplane,
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> index d022c65bb34c..1d922b8dfb6b 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> @@ -1444,8 +1444,8 @@ const struct v4l2_ioctl_ops mtk_vdec_ioctl_ops = {
>  
>  	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane	= vidioc_vdec_enum_fmt_vid_cap_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane	= vidioc_vdec_enum_fmt_vid_out_mplane,
> +	.vidioc_enum_fmt_vid_cap	= vidioc_vdec_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_fmt_vid_out	= vidioc_vdec_enum_fmt_vid_out_mplane,
>  	.vidioc_enum_framesizes	= vidioc_enum_framesizes,
>  
>  	.vidioc_querycap		= vidioc_vdec_querycap,
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index c6b48b5925fb..6ee7ced96d84 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -725,8 +725,8 @@ const struct v4l2_ioctl_ops mtk_venc_ioctl_ops = {
>  	.vidioc_dqbuf			= vidioc_venc_dqbuf,
>  
>  	.vidioc_querycap		= vidioc_venc_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out_mplane,
> +	.vidioc_enum_fmt_vid_cap	= vidioc_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_fmt_vid_out	= vidioc_enum_fmt_vid_out_mplane,
>  	.vidioc_enum_framesizes		= vidioc_enum_framesizes,
>  
>  	.vidioc_try_fmt_vid_cap_mplane	= vidioc_try_fmt_vid_cap_mplane,
> diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
> index 58aebe7114cd..1d50dfbbb762 100644
> --- a/drivers/media/platform/qcom/camss/camss-video.c
> +++ b/drivers/media/platform/qcom/camss/camss-video.c
> @@ -703,7 +703,7 @@ static int video_s_input(struct file *file, void *fh, unsigned int input)
>  
>  static const struct v4l2_ioctl_ops msm_vid_ioctl_ops = {
>  	.vidioc_querycap		= video_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane	= video_enum_fmt,
> +	.vidioc_enum_fmt_vid_cap	= video_enum_fmt,
>  	.vidioc_g_fmt_vid_cap_mplane	= video_g_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane	= video_s_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane	= video_try_fmt,
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 282de21cf2e1..2a47b9b8c5bc 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -491,8 +491,8 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>  
>  static const struct v4l2_ioctl_ops vdec_ioctl_ops = {
>  	.vidioc_querycap = vdec_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = vdec_enum_fmt,
> -	.vidioc_enum_fmt_vid_out_mplane = vdec_enum_fmt,
> +	.vidioc_enum_fmt_vid_cap = vdec_enum_fmt,
> +	.vidioc_enum_fmt_vid_out = vdec_enum_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane = vdec_s_fmt,
>  	.vidioc_s_fmt_vid_out_mplane = vdec_s_fmt,
>  	.vidioc_g_fmt_vid_cap_mplane = vdec_g_fmt,
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 32cff294582f..406a47923996 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -616,8 +616,8 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
>  
>  static const struct v4l2_ioctl_ops venc_ioctl_ops = {
>  	.vidioc_querycap = venc_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = venc_enum_fmt,
> -	.vidioc_enum_fmt_vid_out_mplane = venc_enum_fmt,
> +	.vidioc_enum_fmt_vid_cap = venc_enum_fmt,
> +	.vidioc_enum_fmt_vid_out = venc_enum_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane = venc_s_fmt,
>  	.vidioc_s_fmt_vid_out_mplane = venc_s_fmt,
>  	.vidioc_g_fmt_vid_cap_mplane = venc_g_fmt,
> diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
> index 6bda1eee9170..6e6471c37984 100644
> --- a/drivers/media/platform/rcar_fdp1.c
> +++ b/drivers/media/platform/rcar_fdp1.c
> @@ -1730,8 +1730,8 @@ static const char * const fdp1_ctrl_deint_menu[] = {
>  static const struct v4l2_ioctl_ops fdp1_ioctl_ops = {
>  	.vidioc_querycap	= fdp1_vidioc_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane = fdp1_enum_fmt_vid_cap,
> -	.vidioc_enum_fmt_vid_out_mplane = fdp1_enum_fmt_vid_out,
> +	.vidioc_enum_fmt_vid_cap	= fdp1_enum_fmt_vid_cap,
> +	.vidioc_enum_fmt_vid_out	= fdp1_enum_fmt_vid_out,
>  	.vidioc_g_fmt_vid_cap_mplane	= fdp1_g_fmt,
>  	.vidioc_g_fmt_vid_out_mplane	= fdp1_g_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane	= fdp1_try_fmt,
> diff --git a/drivers/media/platform/rcar_jpu.c b/drivers/media/platform/rcar_jpu.c
> index 1dfd2eb65920..a34f4e6b2f98 100644
> --- a/drivers/media/platform/rcar_jpu.c
> +++ b/drivers/media/platform/rcar_jpu.c
> @@ -948,8 +948,8 @@ static int jpu_streamon(struct file *file, void *priv, enum v4l2_buf_type type)
>  static const struct v4l2_ioctl_ops jpu_ioctl_ops = {
>  	.vidioc_querycap		= jpu_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane = jpu_enum_fmt_cap,
> -	.vidioc_enum_fmt_vid_out_mplane = jpu_enum_fmt_out,
> +	.vidioc_enum_fmt_vid_cap	= jpu_enum_fmt_cap,
> +	.vidioc_enum_fmt_vid_out	= jpu_enum_fmt_out,
>  	.vidioc_g_fmt_vid_cap_mplane	= jpu_g_fmt,
>  	.vidioc_g_fmt_vid_out_mplane	= jpu_g_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane	= jpu_try_fmt,
> diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
> index 150196f7cf96..57d0c0f9fa4b 100644
> --- a/drivers/media/platform/renesas-ceu.c
> +++ b/drivers/media/platform/renesas-ceu.c
> @@ -1339,7 +1339,7 @@ static int ceu_enum_frameintervals(struct file *file, void *fh,
>  static const struct v4l2_ioctl_ops ceu_ioctl_ops = {
>  	.vidioc_querycap		= ceu_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane	= ceu_enum_fmt_vid_cap,
> +	.vidioc_enum_fmt_vid_cap	= ceu_enum_fmt_vid_cap,
>  	.vidioc_try_fmt_vid_cap_mplane	= ceu_try_fmt_vid_cap,
>  	.vidioc_s_fmt_vid_cap_mplane	= ceu_s_fmt_vid_cap,
>  	.vidioc_g_fmt_vid_cap_mplane	= ceu_g_fmt_vid_cap,
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> index e111f9c47179..b270ff59c5e3 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
> @@ -887,8 +887,8 @@ static int vidioc_subscribe_event(struct v4l2_fh *fh,
>  /* v4l2_ioctl_ops */
>  static const struct v4l2_ioctl_ops s5p_mfc_dec_ioctl_ops = {
>  	.vidioc_querycap = vidioc_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out_mplane,
> +	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane = vidioc_g_fmt,
>  	.vidioc_g_fmt_vid_out_mplane = vidioc_g_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane = vidioc_try_fmt,
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> index 8fcf627dedfb..2fa16ee9c7b0 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
> @@ -2343,8 +2343,8 @@ static int vidioc_subscribe_event(struct v4l2_fh *fh,
>  
>  static const struct v4l2_ioctl_ops s5p_mfc_enc_ioctl_ops = {
>  	.vidioc_querycap = vidioc_querycap,
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out_mplane,
> +	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane = vidioc_g_fmt,
>  	.vidioc_g_fmt_vid_out_mplane = vidioc_g_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane = vidioc_try_fmt,
> diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> index 207e7e76c048..ddfae9f4fbfa 100644
> --- a/drivers/media/platform/ti-vpe/vpe.c
> +++ b/drivers/media/platform/ti-vpe/vpe.c
> @@ -1973,12 +1973,12 @@ static const struct v4l2_ctrl_ops vpe_ctrl_ops = {
>  static const struct v4l2_ioctl_ops vpe_ioctl_ops = {
>  	.vidioc_querycap		= vpe_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane	= vpe_enum_fmt,
> +	.vidioc_enum_fmt_vid_cap	= vpe_enum_fmt,
>  	.vidioc_g_fmt_vid_cap_mplane	= vpe_g_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane	= vpe_try_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane	= vpe_s_fmt,
>  
> -	.vidioc_enum_fmt_vid_out_mplane	= vpe_enum_fmt,
> +	.vidioc_enum_fmt_vid_out	= vpe_enum_fmt,
>  	.vidioc_g_fmt_vid_out_mplane	= vpe_g_fmt,
>  	.vidioc_try_fmt_vid_out_mplane	= vpe_try_fmt,
>  	.vidioc_s_fmt_vid_out_mplane	= vpe_s_fmt,
> diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
> index d7636fe9e174..fda726e43d60 100644
> --- a/drivers/media/platform/vicodec/vicodec-core.c
> +++ b/drivers/media/platform/vicodec/vicodec-core.c
> @@ -1140,7 +1140,6 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
>  	.vidioc_try_fmt_vid_cap	= vidioc_try_fmt_vid_cap,
>  	.vidioc_s_fmt_vid_cap	= vidioc_s_fmt_vid_cap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap,
>  	.vidioc_g_fmt_vid_cap_mplane	= vidioc_g_fmt_vid_cap,
>  	.vidioc_try_fmt_vid_cap_mplane	= vidioc_try_fmt_vid_cap,
>  	.vidioc_s_fmt_vid_cap_mplane	= vidioc_s_fmt_vid_cap,
> @@ -1150,7 +1149,6 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
>  	.vidioc_try_fmt_vid_out	= vidioc_try_fmt_vid_out,
>  	.vidioc_s_fmt_vid_out	= vidioc_s_fmt_vid_out,
>  
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out,
>  	.vidioc_g_fmt_vid_out_mplane	= vidioc_g_fmt_vid_out,
>  	.vidioc_try_fmt_vid_out_mplane	= vidioc_try_fmt_vid_out,
>  	.vidioc_s_fmt_vid_out_mplane	= vidioc_s_fmt_vid_out,
> diff --git a/drivers/media/platform/vivid/vivid-core.c b/drivers/media/platform/vivid/vivid-core.c
> index 342e0e6c103b..345adde47789 100644
> --- a/drivers/media/platform/vivid/vivid-core.c
> +++ b/drivers/media/platform/vivid/vivid-core.c
> @@ -500,20 +500,18 @@ static const struct v4l2_file_operations vivid_radio_fops = {
>  static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
>  	.vidioc_querycap		= vidioc_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap	= vidioc_enum_fmt_vid,
> +	.vidioc_enum_fmt_vid_cap	= vivid_enum_fmt_vid,
>  	.vidioc_g_fmt_vid_cap		= vidioc_g_fmt_vid_cap,
>  	.vidioc_try_fmt_vid_cap		= vidioc_try_fmt_vid_cap,
>  	.vidioc_s_fmt_vid_cap		= vidioc_s_fmt_vid_cap,
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane	= vidioc_g_fmt_vid_cap_mplane,
>  	.vidioc_try_fmt_vid_cap_mplane	= vidioc_try_fmt_vid_cap_mplane,
>  	.vidioc_s_fmt_vid_cap_mplane	= vidioc_s_fmt_vid_cap_mplane,
>  
> -	.vidioc_enum_fmt_vid_out	= vidioc_enum_fmt_vid,
> +	.vidioc_enum_fmt_vid_out	= vivid_enum_fmt_vid,
>  	.vidioc_g_fmt_vid_out		= vidioc_g_fmt_vid_out,
>  	.vidioc_try_fmt_vid_out		= vidioc_try_fmt_vid_out,
>  	.vidioc_s_fmt_vid_out		= vidioc_s_fmt_vid_out,
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_mplane,
>  	.vidioc_g_fmt_vid_out_mplane	= vidioc_g_fmt_vid_out_mplane,
>  	.vidioc_try_fmt_vid_out_mplane	= vidioc_try_fmt_vid_out_mplane,
>  	.vidioc_s_fmt_vid_out_mplane	= vidioc_s_fmt_vid_out_mplane,
> diff --git a/drivers/media/platform/vivid/vivid-vid-common.c b/drivers/media/platform/vivid/vivid-vid-common.c
> index 74b83bcc6119..9307ce1cdd16 100644
> --- a/drivers/media/platform/vivid/vivid-vid-common.c
> +++ b/drivers/media/platform/vivid/vivid-vid-common.c
> @@ -797,26 +797,6 @@ int vivid_enum_fmt_vid(struct file *file, void  *priv,
>  	return 0;
>  }
>  
> -int vidioc_enum_fmt_vid_mplane(struct file *file, void  *priv,
> -					struct v4l2_fmtdesc *f)
> -{
> -	struct vivid_dev *dev = video_drvdata(file);
> -
> -	if (!dev->multiplanar)
> -		return -ENOTTY;
> -	return vivid_enum_fmt_vid(file, priv, f);
> -}
> -
> -int vidioc_enum_fmt_vid(struct file *file, void  *priv,
> -					struct v4l2_fmtdesc *f)
> -{
> -	struct vivid_dev *dev = video_drvdata(file);
> -
> -	if (dev->multiplanar)
> -		return -ENOTTY;
> -	return vivid_enum_fmt_vid(file, priv, f);
> -}
> -
>  int vidioc_g_std(struct file *file, void *priv, v4l2_std_id *id)
>  {
>  	struct vivid_dev *dev = video_drvdata(file);
> diff --git a/drivers/media/platform/vivid/vivid-vid-common.h b/drivers/media/platform/vivid/vivid-vid-common.h
> index 29b6c0b40a1b..d908d9725283 100644
> --- a/drivers/media/platform/vivid/vivid-vid-common.h
> +++ b/drivers/media/platform/vivid/vivid-vid-common.h
> @@ -28,8 +28,6 @@ void vivid_send_source_change(struct vivid_dev *dev, unsigned type);
>  int vivid_vid_adjust_sel(unsigned flags, struct v4l2_rect *r);
>  
>  int vivid_enum_fmt_vid(struct file *file, void  *priv, struct v4l2_fmtdesc *f);
> -int vidioc_enum_fmt_vid_mplane(struct file *file, void  *priv, struct v4l2_fmtdesc *f);
> -int vidioc_enum_fmt_vid(struct file *file, void  *priv, struct v4l2_fmtdesc *f);
>  int vidioc_g_std(struct file *file, void *priv, v4l2_std_id *id);
>  int vidioc_g_dv_timings(struct file *file, void *_fh, struct v4l2_dv_timings *timings);
>  int vidioc_enum_dv_timings(struct file *file, void *_fh, struct v4l2_enum_dv_timings *timings);
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index d7528f82a66a..29946a2b2752 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -593,11 +593,9 @@ static void determine_valid_ioctls(struct video_device *vdev)
>  	if (is_vid || is_tch) {
>  		/* video and metadata specific ioctls */
>  		if ((is_rx && (ops->vidioc_enum_fmt_vid_cap ||
> -			       ops->vidioc_enum_fmt_vid_cap_mplane ||
>  			       ops->vidioc_enum_fmt_vid_overlay ||
>  			       ops->vidioc_enum_fmt_meta_cap)) ||
>  		    (is_tx && (ops->vidioc_enum_fmt_vid_out ||
> -			       ops->vidioc_enum_fmt_vid_out_mplane ||
>  			       ops->vidioc_enum_fmt_meta_out)))
>  			set_bit(_IOC_NR(VIDIOC_ENUM_FMT), valid_ioctls);
>  		if ((is_rx && (ops->vidioc_g_fmt_vid_cap ||
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index f6d663934648..97ba365218fb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1380,6 +1380,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>  				struct file *file, void *fh, void *arg)
>  {
> +	struct video_device *vdev = video_devdata(file);
>  	struct v4l2_fmtdesc *p = arg;
>  	int ret = check_fmt(file, p->type);
>  
> @@ -1389,30 +1390,30 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
>  
>  	switch (p->type) {
>  	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> +		if (!!(vdev->device_caps & V4L2_CAP_VIDEO_CAPTURE_MPLANE) !=

Hmm. I am not sure if all drivers that set V4L2_CAP_VIDEO_CAPTURE_MPLANE also
fill in vdev->device_caps. While filling in vdev->device_caps is required for
new drivers, older drivers often don't do this.

You would have to check all drivers that set V4L2_CAP_VIDEO_CAPTURE/OUTPUT_MPLANE
to verify that they also set vdev->device_caps. I'm fairly certain the Samsung
drivers don't fill this in.

> +		    (p->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
> +			break;
> +
>  		if (unlikely(!ops->vidioc_enum_fmt_vid_cap))
>  			break;
>  		ret = ops->vidioc_enum_fmt_vid_cap(file, fh, arg);
>  		break;
> -	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> -		if (unlikely(!ops->vidioc_enum_fmt_vid_cap_mplane))
> -			break;
> -		ret = ops->vidioc_enum_fmt_vid_cap_mplane(file, fh, arg);
> -		break;
>  	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>  		if (unlikely(!ops->vidioc_enum_fmt_vid_overlay))
>  			break;
>  		ret = ops->vidioc_enum_fmt_vid_overlay(file, fh, arg);
>  		break;
>  	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> +		if (!!(vdev->device_caps & V4L2_CAP_VIDEO_OUTPUT_MPLANE) !=
> +		    (p->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE))
> +			break;

See comment above.

> +
>  		if (unlikely(!ops->vidioc_enum_fmt_vid_out))
>  			break;
>  		ret = ops->vidioc_enum_fmt_vid_out(file, fh, arg);
>  		break;
> -	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
> -		if (unlikely(!ops->vidioc_enum_fmt_vid_out_mplane))
> -			break;
> -		ret = ops->vidioc_enum_fmt_vid_out_mplane(file, fh, arg);
> -		break;
>  	case V4L2_BUF_TYPE_SDR_CAPTURE:
>  		if (unlikely(!ops->vidioc_enum_fmt_sdr_cap))
>  			break;
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index 9c0352b193a7..92240baddca4 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -959,12 +959,12 @@ static const struct v4l2_file_operations imgu_v4l2_fops = {
>  static const struct v4l2_ioctl_ops imgu_v4l2_ioctl_ops = {
>  	.vidioc_querycap = imgu_vidioc_querycap,
>  
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap,
> +	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap,
>  	.vidioc_g_fmt_vid_cap_mplane = imgu_vidioc_g_fmt,
>  	.vidioc_s_fmt_vid_cap_mplane = imgu_vidioc_s_fmt,
>  	.vidioc_try_fmt_vid_cap_mplane = imgu_vidioc_try_fmt,
>  
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out,
> +	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out,
>  	.vidioc_g_fmt_vid_out_mplane = imgu_vidioc_g_fmt,
>  	.vidioc_s_fmt_vid_out_mplane = imgu_vidioc_s_fmt,
>  	.vidioc_try_fmt_vid_out_mplane = imgu_vidioc_try_fmt,
> diff --git a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> index ab0fb2053620..f42d8325fd33 100644
> --- a/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> +++ b/drivers/staging/media/rockchip/vpu/rockchip_vpu_enc.c
> @@ -493,8 +493,8 @@ const struct v4l2_ioctl_ops rockchip_vpu_enc_ioctl_ops = {
>  	.vidioc_s_fmt_vid_cap_mplane = vidioc_s_fmt_cap_mplane,
>  	.vidioc_g_fmt_vid_out_mplane = vidioc_g_fmt_out_mplane,
>  	.vidioc_g_fmt_vid_cap_mplane = vidioc_g_fmt_cap_mplane,
> -	.vidioc_enum_fmt_vid_out_mplane = vidioc_enum_fmt_vid_out_mplane,
> -	.vidioc_enum_fmt_vid_cap_mplane = vidioc_enum_fmt_vid_cap_mplane,
> +	.vidioc_enum_fmt_vid_out = vidioc_enum_fmt_vid_out_mplane,
> +	.vidioc_enum_fmt_vid_cap = vidioc_enum_fmt_vid_cap_mplane,
>  
>  	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
>  	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
> index 8533ece5026e..400f2e46c108 100644
> --- a/include/media/v4l2-ioctl.h
> +++ b/include/media/v4l2-ioctl.h
> @@ -26,19 +26,13 @@ struct v4l2_fh;
>   *	:ref:`VIDIOC_QUERYCAP <vidioc_querycap>` ioctl
>   * @vidioc_enum_fmt_vid_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> - *	for video capture in single plane mode
> + *	for video capture in single and multi plane mode
>   * @vidioc_enum_fmt_vid_overlay: pointer to the function that implements
>   *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
>   *	for video overlay
>   * @vidioc_enum_fmt_vid_out: pointer to the function that implements
>   *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> - *	for video output in single plane mode
> - * @vidioc_enum_fmt_vid_cap_mplane: pointer to the function that implements
> - *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> - *	for video capture in multiplane mode
> - * @vidioc_enum_fmt_vid_out_mplane: pointer to the function that implements
> - *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
> - *	for video output in multiplane mode
> + *	for video output in single and multi plane mode
>   * @vidioc_enum_fmt_sdr_cap: pointer to the function that implements
>   *	:ref:`VIDIOC_ENUM_FMT <vidioc_enum_fmt>` ioctl logic
>   *	for Software Defined Radio capture
> @@ -313,10 +307,6 @@ struct v4l2_ioctl_ops {
>  					   struct v4l2_fmtdesc *f);
>  	int (*vidioc_enum_fmt_vid_out)(struct file *file, void *fh,
>  				       struct v4l2_fmtdesc *f);
> -	int (*vidioc_enum_fmt_vid_cap_mplane)(struct file *file, void *fh,
> -					      struct v4l2_fmtdesc *f);
> -	int (*vidioc_enum_fmt_vid_out_mplane)(struct file *file, void *fh,
> -					      struct v4l2_fmtdesc *f);
>  	int (*vidioc_enum_fmt_sdr_cap)(struct file *file, void *fh,
>  				       struct v4l2_fmtdesc *f);
>  	int (*vidioc_enum_fmt_sdr_out)(struct file *file, void *fh,
> 

Regards,

	Hans
