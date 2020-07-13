Return-Path: <SRS0=Gq82=AY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F5C433E1
	for <linux-media@archiver.kernel.org>; Mon, 13 Jul 2020 11:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4903206F0
	for <linux-media@archiver.kernel.org>; Mon, 13 Jul 2020 11:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMLHQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:07:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgGMLHQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Jul 2020 07:07:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 49DE32A0D5F
Subject: Re: [PATCH 1/4] media: staging: rkisp1: remove unused field
 ctrl_handler from struct rkisp1_device
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
References: <20200629065754.26621-1-dafna.hirschfeld@collabora.com>
 <20200629065754.26621-2-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <b2651b90-a514-1b9c-7d07-944e3b24dbdb@collabora.com>
Date:   Mon, 13 Jul 2020 08:07:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200629065754.26621-2-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 6/29/20 3:57 AM, Dafna Hirschfeld wrote:
> The field ctrl_handler in struct rkisp1_device is not used.
> This patch removes it.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks

> ---
>  drivers/staging/media/rkisp1/rkisp1-common.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-common.h b/drivers/staging/media/rkisp1/rkisp1-common.h
> index 45e554169224..eb0dbc42d09c 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-common.h
> +++ b/drivers/staging/media/rkisp1/rkisp1-common.h
> @@ -250,7 +250,6 @@ struct rkisp1_device {
>  	unsigned int clk_size;
>  	struct clk_bulk_data clks[RKISP1_MAX_BUS_CLK];
>  	struct v4l2_device v4l2_dev;
> -	struct v4l2_ctrl_handler ctrl_handler;
>  	struct media_device media_dev;
>  	struct v4l2_async_notifier notifier;
>  	struct rkisp1_sensor_async *active_sensor;
> 
