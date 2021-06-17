Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E2C2B9F4
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C34613ED
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFQOI1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:08:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7358 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhFQOI1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Jun 2021 10:08:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5NzD2hWxz6yVH;
        Thu, 17 Jun 2021 22:02:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 22:06:16 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 22:06:16 +0800
Subject: Re: [PATCH -next resend] media: staging: media: atomisp: pci: fix
 error return code in atomisp_pci_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-media@vger.kernel.org>, <mchehab@kernel.org>,
        <sakari.ailus@linux.intel.com>
References: <20210617135500.2158302-1-yangyingliang@huawei.com>
 <20210617135824.GO1901@kadam>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <f6340eca-dcf6-770a-1296-8143df42d506@huawei.com>
Date:   Thu, 17 Jun 2021 22:06:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210617135824.GO1901@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 2021/6/17 21:58, Dan Carpenter wrote:
> Looks good.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> But next time please use v2 in the subject instead of "resend".  "resend"
> means that the process broke down somehow and we ignored your first
> patch.
>
> On Thu, Jun 17, 2021 at 09:55:00PM +0800, Yang Yingliang wrote:
>> If init_atomisp_wdts() fails, atomisp_pci_probe() need return
>> error code.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
> Put a note here under the --- cut off line to say what happened since
> the last version.
>
> v2: style change
OK

Thanks,
Yang
>
>
>>   drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
> regards,
> dan carpenter
>
> .
