Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48251C433E2
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C82B206A1
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JvNYembF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIQIse (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:48:34 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:40765 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgIQIsa (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 04:48:30 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id IpaZkLCWrPTBMIpaaklCZD; Thu, 17 Sep 2020 10:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1600332504; bh=FGGfh7jhrNlQmwwZoXn5URUJwAP31ZNmRR24iAOJumo=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=JvNYembFkkAhGAZ8dN+vXmDFZsHMHNmic8W0rbLg6fJNrTrsSd+ot7Jjz6P0mhT5o
         IAZWe/FEbfl9JvTwgcXv/ENPPcZ1rYtqm820WfYZDuoaMGx+HALyiwXDXfr2Wbqi5U
         M00javSYvNRyeuAJWWRiJ8W2zRs/lXIUs1yTIvuAgTAWK+cT+YFWg7E9BR1il0g988
         Met91hPCmxFEcuAt4+aic+Tc15qZdfI4hR/O3amqgvidJWV+3qeSBRqSHyoTskCJId
         MsKLayrGEJzq3OwKRXZKdyqyjUQYpCZ3N61OOrbf9BnRFVOwV1E9xO0MY1Rj1tB4hP
         YTDtZGR0CkouA==
Subject: Re: [PATCH] media: s5p-mfc: set V4L2_BUF_FLAG_LAST flag on final
 buffer
To:     Andriy Gelman <andriy.gelman@gmail.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20200502194052.485-1-andriy.gelman@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0210ef98-b075-322d-dc3a-adf3dccd3a92@xs4all.nl>
Date:   Thu, 17 Sep 2020 10:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200502194052.485-1-andriy.gelman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEUIpir7Ikuif51JPR0IdmdnmoQrwFeVAxZVhJd5QweV3UW944PQu8Mh5b9o6+gH+RkTZyICGmRrFMScfWc4FUFklaDZosxGds04g0NiPTdlwRlXu/rj
 k/lTU4TPJkR1r/3srOG2CsdU/zJvlHQ0SXylvNpc5Grvbbl5UQFpEsmoihDju9Wuvy4O72v18pKVRXHHoxWmUZTrIZA34zh70AhRiQmGU83dyTxXu9c2MqKa
 cTcnCiL7S0QDgE9u9sEbnYNsbpy3TQ2wvys7RbGlzmLg1SlZ1yXUKYuUALFkDup43MA/6BfSZZ/ndTB5cLs5MfyvMUkef4sLQG8MraK76Acjhr3J89mXvngf
 TdwkRs/RuxINL8GRDSViHLCiLq5utINYMow1METgqj88eubOC3dpwfrAwGqRTCP2zi4EGItg5BExVqicpcRaooTeAjZ5lfr7ZB8Q4BihfpmQFe6jUkOVZsgk
 uNhKrMiYixObA6SEH1wQ9mVVupJgzV7+Jn89+iuNcmqbGvA3ugLCQdEjkaXokyQQpbhIJ+DEXBWzQMEAIXcOG2z7iPB+9agCgepgnRdgbesnLCZwK/kKKaC5
 GfgAmMQw/nyvexYwQS4RGB6GBVQgDziM5uTubrdzOH+sSVrdObvu3A4pk9MkVE7wkU0=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Added Sylwester and Tomasz.

I'd like to have an Ack of a driver maintainer before merging.

Regards,

	Hans

On 02/05/2020 21:40, Andriy Gelman wrote:
> From: Andriy Gelman <andriy.gelman@gmail.com>
> 
> As per V4L2 api, the final buffer should set V4L2_BUF_FLAG_LAST flag.
> 
> Signed-off-by: Andriy Gelman <andriy.gelman@gmail.com>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> index 5c2a23b953a4..b3d9b3a523fe 100644
> --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> @@ -614,6 +614,7 @@ static void s5p_mfc_handle_stream_complete(struct s5p_mfc_ctx *ctx)
>  		list_del(&mb_entry->list);
>  		ctx->dst_queue_cnt--;
>  		vb2_set_plane_payload(&mb_entry->b->vb2_buf, 0, 0);
> +		mb_entry->b->flags |= V4L2_BUF_FLAG_LAST;
>  		vb2_buffer_done(&mb_entry->b->vb2_buf, VB2_BUF_STATE_DONE);
>  	}
>  
> 

