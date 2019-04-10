Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D0C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BD520830
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 09:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfDJJKc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:10:32 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:44445 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729143AbfDJJKc (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 05:10:32 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud8.xs4all.net with ESMTPA
        id E9FQhpBpoUjKfE9FRhgq2i; Wed, 10 Apr 2019 11:10:30 +0200
Subject: Re: [PATCH 3/7] s5p_cec: use new cec_notifier_find_hdmi_dev helper
To:     wen.yang99@zte.com.cn
Cc:     linux-media@vger.kernel.org, narmstrong@baylibre.com,
        snawrocki@kernel.org, benjamin.gaignard@linaro.org,
        treding@nvidia.com, ek5.chimenti@gmail.com
References: <201904091005306593106@zte.com.cn>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <00bdfe1a-bf48-ebdd-c86a-2b33b7752206@xs4all.nl>
Date:   Wed, 10 Apr 2019 11:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201904091005306593106@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHYHiis19TbG6rF39sm8UPj9pPkoJIjFxrBU9Yu0Wn3q5XjODehVgqzF9gFuUQ4bdgxcpbg8KKYmNYe0/NI2j3BfErFp7QgE2Kn/ZH5RQcv+Dcnvr3ZR
 N2T85hFUhe91x840x/o33pjvZ2uycw718CFwPBl/2Lg39VQwfY2C47wz1T3N0UBabPIONSrcQH5NaaK4VMRCX9I1ZFI1VvdIYh4RyuHZbYROO4HmHAHqlzW7
 b7FaXlDMco9r5I5QMTE231KswtDOEBFubr5JRB+b+6y8znWibGUo7yrGJbjv+ANTRpB+pzmaUWxtVPI2btpM3z2Rz76sQEWJ2OXHBR+GZquP1eM3uH9vGzf+
 dHTnVeHM9PbAcT8rMZN6YeecULGBugN/TGAPlwHgfd4VG3qxMD1wAb5udHEt2BAx/ZSq0xd9BG5vj7tmozpt9CIYbM89gxS5qP93zYFH9awUpc8ic6zgKQEJ
 85dwKOrP2r3pdJ4w
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/9/19 4:05 AM, wen.yang99@zte.com.cn wrote:
> Hi Hans, 
> 
>> Subject: [PATCH 3/7] s5p_cec: use new cec_notifier_find_hdmi_dev helper
>> The S5P CEC driver increased the HDMI device refcount when
>> it shouldn't. Use the new helper function to ensure that that
>> doesn't happen and to simplify the driver code.
>>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> ---
>> drivers/media/platform/s5p-cec/s5p_cec.c | 16 +++++-----------
>> 1 file changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/media/platform/s5p-cec/s5p_cec.c b/drivers/media/platform/s5p-cec/s5p_cec.c
>> index 8837e2678bde..7e2c94816c55 100644
>> --- a/drivers/media/platform/s5p-cec/s5p_cec.c
>> +++ b/drivers/media/platform/s5p-cec/s5p_cec.c
>> @@ -178,22 +178,16 @@ static const struct cec_adap_ops s5p_cec_adap_ops = {
>> static int s5p_cec_probe(struct platform_device *pdev)
>> {
>> struct device *dev = &pdev->dev;
>> -    struct device_node *np;
>> -    struct platform_device *hdmi_dev;
>> +    struct device *hdmi_dev;
>> struct resource *res;
>> struct s5p_cec_dev *cec;
>> bool needs_hpd = of_property_read_bool(pdev->dev.of_node, "needs-hpd");
>> int ret;
>>
>> -    np = of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
>> +    hdmi_dev = cec_notifier_find_hdmi_dev(dev);
>>
> 
> The hdmi_dev returned by the cec_notifier_find_hdmi_dev function is just a key value
> and cannot be used as a struct device *, so the name cec_notifier_find_hdmi_dev
> is a bit inappropriate.
> 
>> -    if (!np) {
>> -        dev_err(&pdev->dev, "Failed to find hdmi node in device tree\n");
>> -        return -ENODEV;
>> -    }
>> -    hdmi_dev = of_find_device_by_node(np);
>> -    if (hdmi_dev == NULL)
>> -        return -EPROBE_DEFER;
>> +    if (IS_ERR(hdmi_dev))
>> +        return PTR_ERR(hdmi_dev);
>>
>> cec = devm_kzalloc(&pdev->dev, sizeof(*cec), GFP_KERNEL);
>> if (!cec)
>> @@ -224,7 +218,7 @@ static int s5p_cec_probe(struct platform_device *pdev)
>> if (IS_ERR(cec->reg))
>> return PTR_ERR(cec->reg);
>>
>> -    cec->notifier = cec_notifier_get(&hdmi_dev->dev);
>> +    cec->notifier = cec_notifier_get(hdmi_dev);
> 
> The hdmi_dev variable is only used as  a key for the input of the cec_notifier_get function.
> So here is a little advice:
> The current code mode is like this:
> struct device *dev = &pdev->dev;
> ...
> +    struct device *hdmi_dev;
> ...
> +    hdmi_dev = cec_notifier_find_hdmi_dev(dev);
> ...
> +    cec->notifier = cec_notifier_get(hdmi_dev);
> 
> Can we replace it like this:
> struct device *dev = &pdev->dev;
> ...
> +    cec->notifier = cec_notifier_get(dev);
> 
> This way we can remove the hdmi_dev temporary variable, 
> and we can also remove the cec_notifier_find_hdmi_dev function.
> It is enough to provide an API similar to cec_notifier_get.

Some drivers get the HDMI device through other means (e.g. cros-ec-cec)
so combining this in one function is not a good idea.

I did decide to rename cec_notifier_find_hdmi_dev to
cec_notifier_parse_hdmi_phandle. I think that is a better description of
what the helper does.

Regards,

	Hans

> 
> --
> Regards,
> Wen
> 
>> if (cec->notifier == NULL)
>> return -ENOMEM;

