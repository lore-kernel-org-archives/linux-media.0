Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C6C64E7B
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 14:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35992085B
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 14:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgK3OU4 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:20:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgK3OU4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Nov 2020 09:20:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id D7FDC1F45036
Subject: Re: [PATCH] media: rockchip: rkisp1: remove some dead code
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <X8TrSj3PbqVtN5XQ@mwanda>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <a6d9660f-84ec-317d-c3aa-9b3bda595d49@collabora.com>
Date:   Mon, 30 Nov 2020 11:20:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8TrSj3PbqVtN5XQ@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dan,

Thank you for your patch.

On 11/30/20 9:53 AM, Dan Carpenter wrote:
> The debugfs_create_dir() function never returns NULLs.  It's not supposed
> to checked for errors in the normal case and there is no need to check
> in this function so let's just delete this dead code.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index 9af137e4967f..68da1eed753d 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -430,10 +430,6 @@ static void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>  	struct rkisp1_debug *debug = &rkisp1->debug;
>  
>  	debug->debugfs_dir = debugfs_create_dir(RKISP1_DRIVER_NAME, NULL);
> -	if (!debug->debugfs_dir) {
> -		dev_dbg(rkisp1->dev, "failed to create debugfs directory\n");
> -		return;
> -	}

I was taking a look at the debugfs_create_dir() code, and I saw it can
return ERR_PTR(), so ideally we should check for errors with IS_ERR() / PTR_ERR().

Also from the docs:

 * <snip>  If an error occurs, ERR_PTR(-ERROR) will be
 * returned.
 *
 * If debugfs is not enabled in the kernel, the value -%ENODEV will be
 * returned.



>  	debugfs_create_ulong("data_loss", 0444, debug->debugfs_dir,
>  			     &debug->data_loss);
>  	debugfs_create_ulong("outform_size_err", 0444,  debug->debugfs_dir,
> 


nit: I would change the name of the commit just to make it clear what it
does.
Example: Remove useless error check from debugfs_create_dir()

Thanks,
Helen
