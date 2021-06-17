Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC29C48BE5
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 07:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E561161241
	for <linux-media@archiver.kernel.org>; Thu, 17 Jun 2021 07:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFQHUG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:20:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFQHUF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Jun 2021 03:20:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 81A1D1F43AB4
Subject: Re: [PATCH v4 03/10] dt-bindings: media: rkisp1: document different
 irq possibilities
To:     Heiko Stuebner <heiko@sntech.de>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     ezequiel@collabora.com, helen.koike@collabora.com,
        Laurent.pinchart@ideasonboard.com,
        linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20210616215211.4002992-1-heiko@sntech.de>
 <20210616215211.4002992-4-heiko@sntech.de>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <0d819205-6193-1952-e3ee-4fe5c0e53622@collabora.com>
Date:   Thu, 17 Jun 2021 10:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616215211.4002992-4-heiko@sntech.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

On 17.06.21 00:52, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Some variants have one irq signaling all of MI, MIPI and ISP events
> while some rkisp1 variants use separate irqs for each.
> 
> Adapt the binding to handle both cases.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>   .../devicetree/bindings/media/rockchip-isp1.yaml         | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> index 2f8f0625d22e..80709a01c6fd 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> @@ -21,7 +21,14 @@ properties:
>       maxItems: 1
>   
>     interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      - const: isp
> +      - const: mi
> +      - const: mipi

Since you use those names in the driver they should probably be 'required' you should do something like:

if:
   properties:
     compatible:
       contains:
         const: the-new-px30-compat..
then:
   required:
     - interrupt-names

would also be nice to add your new bindings in the example in the yaml

Thanks,
Dafna

>   
>     clocks:
>       minItems: 3
> 
