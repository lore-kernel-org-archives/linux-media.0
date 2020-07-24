Return-Path: <SRS0=bEPg=BD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C6C433E3
	for <linux-media@archiver.kernel.org>; Fri, 24 Jul 2020 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F1206D8
	for <linux-media@archiver.kernel.org>; Fri, 24 Jul 2020 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgGXPrP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:47:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXPrO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Jul 2020 11:47:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 401F8297508
Subject: Re: [PATCH 3/4] media: staging: rkisp1: replace two identical macros
 with one
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
References: <20200625185017.16493-1-dafna.hirschfeld@collabora.com>
 <20200625185017.16493-4-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <4fd3261d-2d3a-21ec-7943-85c399ad1eee@collabora.com>
Date:   Fri, 24 Jul 2020 12:47:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200625185017.16493-4-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 6/25/20 3:50 PM, Dafna Hirschfeld wrote:
> The two macros RKISP1_CIF_ISP_LSC_{GRAD/SIZE}_TBL_SIZE have
> the same value which is the number of sectors in the grads
> and size parameters. Therefore there is no need for two
> different macros. Replace them with one macro
> RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE. Also use the macro
> when iterating the arries instead of hardcoded '4'.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
>  drivers/staging/media/rkisp1/rkisp1-params.c      |  2 +-
>  drivers/staging/media/rkisp1/uapi/rkisp1-config.h | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-params.c b/drivers/staging/media/rkisp1/rkisp1-params.c
> index 5be57426d940..ea55532ab797 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-params.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-params.c
> @@ -267,7 +267,7 @@ static void rkisp1_lsc_config(struct rkisp1_params *params,
>  				RKISP1_CIF_ISP_LSC_CTRL_ENA);
>  	rkisp1_lsc_correct_matrix_config(params, arg);
>  
> -	for (i = 0; i < 4; i++) {
> +	for (i = 0; i < RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE / 2; i++) {
>  		/* program x size tables */
>  		data = RKISP1_CIF_ISP_LSC_SECT_SIZE(arg->x_size_tbl[i * 2],
>  						    arg->x_size_tbl[i * 2 + 1]);
> diff --git a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> index d8a8e4457aa4..bca2e805c0f5 100644
> --- a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> +++ b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> @@ -82,8 +82,8 @@
>  /*
>   * Lens shade correction
>   */
> -#define RKISP1_CIF_ISP_LSC_GRAD_TBL_SIZE           8
> -#define RKISP1_CIF_ISP_LSC_SIZE_TBL_SIZE           8
> +#define RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE        8
> +
>  /*
>   * The following matches the tuning process,
>   * not the max capabilities of the chip.
> @@ -279,11 +279,11 @@ struct rkisp1_cif_isp_lsc_config {
>  	__u32 gb_data_tbl[RKISP1_CIF_ISP_LSC_SAMPLES_MAX][RKISP1_CIF_ISP_LSC_SAMPLES_MAX];
>  	__u32 b_data_tbl[RKISP1_CIF_ISP_LSC_SAMPLES_MAX][RKISP1_CIF_ISP_LSC_SAMPLES_MAX];
>  
> -	__u32 x_grad_tbl[RKISP1_CIF_ISP_LSC_GRAD_TBL_SIZE];
> -	__u32 y_grad_tbl[RKISP1_CIF_ISP_LSC_GRAD_TBL_SIZE];
> +	__u32 x_grad_tbl[RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE];
> +	__u32 y_grad_tbl[RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE];
>  
> -	__u32 x_size_tbl[RKISP1_CIF_ISP_LSC_SIZE_TBL_SIZE];
> -	__u32 y_size_tbl[RKISP1_CIF_ISP_LSC_SIZE_TBL_SIZE];
> +	__u32 x_size_tbl[RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE];
> +	__u32 y_size_tbl[RKISP1_CIF_ISP_LSC_SECTORS_TBL_SIZE];
>  } __packed;
>  
>  /**
> 
