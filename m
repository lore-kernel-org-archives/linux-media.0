Return-Path: <SRS0=LydW=AH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47DC433DF
	for <linux-media@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A153207E8
	for <linux-media@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFZQwh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:52:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFZQwh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Jun 2020 12:52:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 101C02A5DF9
Subject: Re: [PATCH v2 2/4] media: staging: rkisp1: stats: replace
 spin_lock_irqsave with spin_lock_irq
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Cc:     ezequiel@collabora.com, hverkuil@xs4all.nl, kernel@collabora.com,
        dafna3@gmail.com, sakari.ailus@linux.intel.com,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        tfiga@chromium.org
References: <20200626085141.7646-1-dafna.hirschfeld@collabora.com>
 <20200626085141.7646-3-dafna.hirschfeld@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <9853e2f3-8fd9-c291-af4a-e70c1ad941b0@collabora.com>
Date:   Fri, 26 Jun 2020 13:52:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200626085141.7646-3-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dafna,

On 6/26/20 5:51 AM, Dafna Hirschfeld wrote:
> The function 'rkisp1_stats_vb2_stop_streaming' runs in user context
> therefore it is enough to use spin_lock_irq
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks,
Helen

> ---
>  drivers/staging/media/rkisp1/rkisp1-stats.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/media/rkisp1/rkisp1-stats.c b/drivers/staging/media/rkisp1/rkisp1-stats.c
> index b19a6d9cdd4d..d4f0df4342e0 100644
> --- a/drivers/staging/media/rkisp1/rkisp1-stats.c
> +++ b/drivers/staging/media/rkisp1/rkisp1-stats.c
> @@ -152,13 +152,12 @@ static void rkisp1_stats_vb2_stop_streaming(struct vb2_queue *vq)
>  {
>  	struct rkisp1_stats *stats = vq->drv_priv;
>  	struct rkisp1_buffer *buf;
> -	unsigned long flags;
>  	unsigned int i;
>  
>  	/* Make sure no new work queued in isr before draining wq */
> -	spin_lock_irqsave(&stats->irq_lock, flags);
> +	spin_lock_irq(&stats->irq_lock);
>  	stats->is_streaming = false;
> -	spin_unlock_irqrestore(&stats->irq_lock, flags);
> +	spin_unlock_irq(&stats->irq_lock);
>  
>  	drain_workqueue(stats->readout_wq);
>  
> 
