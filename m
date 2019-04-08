Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF9FC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F4B20880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ao76Gj+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfDHMBN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:01:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34131 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHMBN (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 08:01:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so15087524wmf.1
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 05:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q8nscxzRtrbZqJjFlLUP3M4t2N+UMGm4qNcj3l8DCPU=;
        b=Ao76Gj+ugZfDacjQkhnxw5OXYr3bOkaUlhv9fDzrd8V34DGigKgCo08SEFBVTIdaT3
         Vn7/kpi+5MjwtsIGgHSXlgM9kyep2SNW9X3xXUHoBoKPAG8ZW+y7dq1o20DWuN1VZFtf
         uloQ1KtxzGRUrWXcr91jr9Pc6JyHZ6jB+i6xYyGsK8TR4SICw4PcU1fzXcDD7RkX6r6+
         /3HX/V4h33lfVpQNW+L4sQJxiokQsjSBzp6cDnRsiUY8dTY7/NCy8zCFSrj+OhIFy+Bj
         +H84Gy+TMCGOzB+z+w3qTh70vn4Gv4s2cHUNWQmy8fQHYkKt147lafnIZbDQokoPE/4o
         R8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q8nscxzRtrbZqJjFlLUP3M4t2N+UMGm4qNcj3l8DCPU=;
        b=FVphu2omNViiCqj1Wc/oZNmubZNn1pHVNtu60Um9vI27cJHeE92ALwrNM78P1jBGjZ
         MCVnWc2Jz29n20W0n8mO1r/PhYmEf2x80Pb9GBQXg0t+yGOHwuK/FKuAqC7fWetPpo1p
         +3pP8tZLqdx/UWo2L81fejsrd8Wui7tBKDNarBfEEa2H6Eyj+K+kVoARGVfHfhxsd1/O
         hWPKBc1w4ysqpVXikuuWZL3ialZ8p2maCEJkr0HXECfJtT5JDHwxfOVd3nq18K5TByJ6
         rTlMn6CU9sAj5Z3imHn4EAYHuDJBvX//oXXXObUTJXk8BXcJHEumf4Ua9yAwuOuo9J1h
         8www==
X-Gm-Message-State: APjAAAV64dTEUd7yZ3e/5JJ27qOdajUDYL3ZAP1djZ6ZUDdMx8DBUIE0
        gHzAaKuzrf1GrMlbm9LGV+AmKg==
X-Google-Smtp-Source: APXvYqxO5wqEZYZnXkrIRYVO5JgkUvOcvGEUM6YKs9GcI2rJNa0n5tEkOowsKkIm5B2bbpLPBdN7ow==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr16609187wmj.62.1554724871074;
        Mon, 08 Apr 2019 05:01:11 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d6sm39707917wrx.62.2019.04.08.05.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:01:10 -0700 (PDT)
Subject: Re: [PATCH 2/7] meson: ao-cec: use new cec_notifier_find_hdmi_dev
 helper
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
 <20190408110401.3345-3-hverkuil-cisco@xs4all.nl>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8eae3329-4fde-9a24-8b15-b623e5de5cb0@baylibre.com>
Date:   Mon, 8 Apr 2019 14:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408110401.3345-3-hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 08/04/2019 13:03, Hans Verkuil wrote:
> The meson CEC driver increased the HDMI device refcount when
> it shouldn't. Use the new helper function to ensure that that
> doesn't happen and to simplify the driver code.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  drivers/media/platform/meson/ao-cec.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
> index cd4be38ab5ac..c8b374741a7c 100644
> --- a/drivers/media/platform/meson/ao-cec.c
> +++ b/drivers/media/platform/meson/ao-cec.c
> @@ -601,20 +601,14 @@ static const struct cec_adap_ops meson_ao_cec_ops = {
>  static int meson_ao_cec_probe(struct platform_device *pdev)
>  {
>  	struct meson_ao_cec_device *ao_cec;
> -	struct platform_device *hdmi_dev;
> -	struct device_node *np;
> +	struct device *hdmi_dev;
>  	struct resource *res;
>  	int ret, irq;
>  
> -	np = of_parse_phandle(pdev->dev.of_node, "hdmi-phandle", 0);
> -	if (!np) {
> -		dev_err(&pdev->dev, "Failed to find hdmi node\n");
> -		return -ENODEV;
> -	}
> +	hdmi_dev = cec_notifier_find_hdmi_dev(&pdev->dev);
>  
> -	hdmi_dev = of_find_device_by_node(np);
> -	if (hdmi_dev == NULL)
> -		return -EPROBE_DEFER;
> +	if (IS_ERR(hdmi_dev))
> +		return PTR_ERR(hdmi_dev);
>  
>  	ao_cec = devm_kzalloc(&pdev->dev, sizeof(*ao_cec), GFP_KERNEL);
>  	if (!ao_cec)
> @@ -622,7 +616,7 @@ static int meson_ao_cec_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&ao_cec->cec_reg_lock);
>  
> -	ao_cec->notify = cec_notifier_get(&hdmi_dev->dev);
> +	ao_cec->notify = cec_notifier_get(hdmi_dev);
>  	if (!ao_cec->notify)
>  		return -ENOMEM;
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
