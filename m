Return-Path: <SRS0=a2si=SP=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A6C10F11
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6321920850
	for <linux-media@archiver.kernel.org>; Sat, 13 Apr 2019 09:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OH190D+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDMJGx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:06:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36718 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMJGx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 13 Apr 2019 05:06:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so9345368lfi.3
        for <linux-media@vger.kernel.org>; Sat, 13 Apr 2019 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVCa4HVjvMwpUUEJR4piTzLAxcmEYcOp/9IPI7twUUs=;
        b=OH190D+xP+LlTxZDq4fPXx7e8HC3flcr0fn7WwCtFdpHxsF0OyLNa1+WDwM79462Cz
         1J5WsRzl1N0y+zVEUZw4bO6w8nrFb64wi5ZG8zujNpncvTP8Htm13WWh2OC9O4gcg7CV
         qvia9ke9WZ71Ouh0EKX7Qq+rkly4Cb/jTWBid5xvMn+xd5AK6LSEZrkuIJq2ZhhfwHYk
         H9PZpE4Kf3ZqaYnxQnQGqIssy7Uzl2JEwEd2SZpVEPJVLRCrcpvOXcn3aC9mG+mQm3qk
         0oV50GqXjRP73c5z3bsYw3yNC0ynJhq4j+/TFkObGIDvoQtxxqLnqIQs7m5a8YqFeaaL
         8QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVCa4HVjvMwpUUEJR4piTzLAxcmEYcOp/9IPI7twUUs=;
        b=uPuGbHOUTzaXrmLPz7C7xSTK7oDgatwBR/lOSnQ0bjr29MUEDuTA5M6ldba2dU2Sfz
         djDUQDtsvxUgZxBMil5K7TqlhR2ygJ7O8hNBMS6xvIuodrNmgDveWriOTJ31QGYziWQi
         LYbiPJCT2AJRdCiEa4DGQ5lerMqpdtOJbq1BTktmXwA1vt4e57geNkx+tTqDJElz/l3A
         pbA/RuhVKMzBDYUtGBsSCnRjEsu6WGF9S8xW5QHdx+pMABZuZVYyIcnITSH79+xCQPOI
         JqFlpwOmL3UhvJm59SisMoOr5v7SpHPlMSqo6hdzGavt9Hnq0+NO2nzyhCBeRTQbl8/C
         1cCg==
X-Gm-Message-State: APjAAAWwaGdhoiBxnHYEMpc3USF97mtrgoUFr3wSx4i40cxAVKFXEbCz
        8VRI3PiJxN/wbajLeFRsBrqRmg==
X-Google-Smtp-Source: APXvYqxQm7wIzvXe7u7IkgQtFEQZ/8E3KHFsyikAlSIpMPIC3xO00eNCPP8DnNwdMOPAXy9Q0RGFJw==
X-Received: by 2002:ac2:43a9:: with SMTP id t9mr11777480lfl.6.1555146411668;
        Sat, 13 Apr 2019 02:06:51 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.47])
        by smtp.gmail.com with ESMTPSA id e17sm8635462ljj.20.2019.04.13.02.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:06:51 -0700 (PDT)
Subject: Re: [PATCH 2/8] rcar-vin: Remove unneeded calls to
 pm_runtime_{enable,disable}
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190412234359.5079-1-niklas.soderlund+renesas@ragnatech.se>
 <20190412234359.5079-3-niklas.soderlund+renesas@ragnatech.se>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b94fe6e1-5767-74e2-4ee0-c230d00ca1cf@cogentembedded.com>
Date:   Sat, 13 Apr 2019 12:06:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412234359.5079-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 13.04.2019 2:43, Niklas Söderlund wrote:

> Runtime PM is already enable unconditionally when the driver is probed

    Enabled?

> and disabled when it's removed. There is no point in doing it again for
> Gen2 when opening and closing the video device.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
