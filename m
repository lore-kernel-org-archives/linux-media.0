Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D16C47098
	for <linux-media@archiver.kernel.org>; Fri,  4 Jun 2021 03:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23DB611ED
	for <linux-media@archiver.kernel.org>; Fri,  4 Jun 2021 03:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhFDDRj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:17:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7101 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDRj (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Jun 2021 23:17:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fx7B93Hs0zYpkg;
        Fri,  4 Jun 2021 11:13:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 11:15:51 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 11:15:50 +0800
Subject: Re: [PATCH 1/1] media: dt-bindings: media: renesas,drif: Fix a
 dt_binding_check warning
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Ramesh Shanmugasundaram" <rashanmu@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-renesas-soc <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210520114953.8206-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a9522c05-a0d7-4017-f42b-a8e4b2a8c0e2@huawei.com>
Date:   Fri, 4 Jun 2021 11:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210520114953.8206-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all:
  Can someone review this patch?


On 2021/5/20 19:49, Zhen Lei wrote:
> The value of the property 'clock-names' is a constant string, so the
> 'maxItems: 1' is not needed, should be removed. Otherwise, the following
> warning is reported:
> properties:clock-names:maxItems: False schema does not allow 1
> ignoring, error in schema: properties: clock-names: maxItems
> warning: no schema found in file: xxx/bindings/media/renesas,drif.yaml
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/media/renesas,drif.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,drif.yaml b/Documentation/devicetree/bindings/media/renesas,drif.yaml
> index f1bdaeab4053..b7f07062922f 100644
> --- a/Documentation/devicetree/bindings/media/renesas,drif.yaml
> +++ b/Documentation/devicetree/bindings/media/renesas,drif.yaml
> @@ -67,7 +67,6 @@ properties:
>      maxItems: 1
>  
>    clock-names:
> -    maxItems: 1
>      items:
>        - const: fck
>  
> 

