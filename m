Return-Path: <SRS0=WSgU=BN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CEC433DF
	for <linux-media@archiver.kernel.org>; Mon,  3 Aug 2020 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C551620672
	for <linux-media@archiver.kernel.org>; Mon,  3 Aug 2020 19:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgHCTtl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:49:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49624 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgHCTtk (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 3 Aug 2020 15:49:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id BFFE8295896
Subject: Re: [PATCH] media: staging: rkisp1: rename
 RKISP1_CIF_ISP_STAT_AFM_FIN to RKISP1_CIF_ISP_STAT_AFM
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
References: <20200707171549.29601-1-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <4d485ed1-4e8a-d635-5385-0f51a1297b13@collabora.com>
Date:   Mon, 3 Aug 2020 16:49:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707171549.29601-1-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dafna,

On 7/7/20 2:15 PM, Dafna Hirschfeld wrote:
> The flag RKISP1_CIF_ISP_STAT_AFM_FIN indicates userspace
> that auto-focus measurements were collected. Therefore
> the suffix _FIN in the flag's name does not fit.

I would just clarify that _FIN is used in RKISP1_CIF_ISP_AFM_FIN,
which is an interruption indicating that that the hardware finished
collecting auto-focus measurement, and RKISP1_CIF_ISP_STAT_AFM is
a flag sent to userspace to indicate data contained in the buffer.

With this:

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/staging/media/rkisp1/rkisp1-stats.c       | 2 +-
>  drivers/staging/media/rkisp1/uapi/rkisp1-config.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-stats.c b/drivers/staging/media/rkisp1/rkisp1-stats.c
> index 0616793ae395..b2a77ec21989 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-stats.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-stats.c
> @@ -253,7 +253,7 @@ static void rkisp1_stats_get_afc_meas(struct rkisp1_stats *stats,
>  	struct rkisp1_device *rkisp1 = stats->rkisp1;
>  	struct rkisp1_cif_isp_af_stat *af;
>  
> -	pbuf->meas_type |= RKISP1_CIF_ISP_STAT_AFM_FIN;
> +	pbuf->meas_type |= RKISP1_CIF_ISP_STAT_AFM;
>  
>  	af = &pbuf->params.af;
>  	af->window[0].sum = rkisp1_read(rkisp1, RKISP1_CIF_ISP_AFM_SUM_A);
> diff --git a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> index ec624f2579cd..57f5035d62a4 100644
> --- a/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> +++ b/drivers/staging/media/rkisp1/uapi/rkisp1-config.h
> @@ -113,7 +113,7 @@
>   */
>  #define RKISP1_CIF_ISP_STAT_AWB           BIT(0)
>  #define RKISP1_CIF_ISP_STAT_AUTOEXP       BIT(1)
> -#define RKISP1_CIF_ISP_STAT_AFM_FIN       BIT(2)
> +#define RKISP1_CIF_ISP_STAT_AFM           BIT(2)
>  #define RKISP1_CIF_ISP_STAT_HIST          BIT(3)
>  
>  enum rkisp1_cif_isp_histogram_mode {
> 
