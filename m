Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF2C433F5
	for <linux-media@archiver.kernel.org>; Fri, 24 Sep 2021 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3106124B
	for <linux-media@archiver.kernel.org>; Fri, 24 Sep 2021 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbhIXLcu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:32:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39666 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbhIXLct (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 24 Sep 2021 07:32:49 -0400
Received: from [192.168.1.87] (unknown [223.184.74.135])
        by linux.microsoft.com (Postfix) with ESMTPSA id 895E620A1FB8;
        Fri, 24 Sep 2021 04:31:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 895E620A1FB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632483076;
        bh=BAgdUqonqhp/HCQpRDWS5729o1E0Cy8wiBVmSwI6sv8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDjdgFjPaDnVkAHYT53cBPCkggfY1x6fZFWAlnJMbHEEYwjg090ghvDgROlMK3QcG
         khAq3uo+KnoXdsj9kKm++WNvechbKExEoLjkZEtxoGW+I3LpWTy9V9vUmGacmcP8Dx
         tEsPvLdnJjVYv1fTfTk/fM38Al6PMUaPi2NB3M5o=
Subject: Re: [PATCH] media: atomisp: restore missing 'return' statement
To:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210802143820.1150099-1-arnd@kernel.org>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <a472d0f0-2be4-5f95-7106-5d580b28cac6@linux.microsoft.com>
Date:   Fri, 24 Sep 2021 17:01:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210802143820.1150099-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 02-08-2021 20:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The input_system_configure_channel_sensor() function lost its final
> return code in a previous patch:
> 
> drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c: In function 'input_system_configure_channel_sensor':
> drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c:1649:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> Restore what was there originally.
> 
> Fixes: 728a5c64ae5f ("media: atomisp: remove dublicate code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../media/atomisp/pci/hive_isp_css_common/host/input_system.c   | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
> index 8e085dda0c18..712e01c37870 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/input_system.c
> @@ -1646,6 +1646,8 @@ static input_system_err_t input_system_configure_channel_sensor(
>  	default:
>  		return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
>  	}
> +
> +	return INPUT_SYSTEM_ERR_NO_ERROR;

I would recommend to return "status" instead of INPUT_SYSTEM_ERR_NO_ERROR,
this will take care of sending correct return code, we encounter in different case statements.
Something like below would be better. Thanks.

-               return INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
+               status = INPUT_SYSTEM_ERR_PARAMETER_NOT_SUPPORTED;
        }
+       return status;

Regards,

~Praveen.
