Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF9C56202
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21CD20719
	for <linux-media@archiver.kernel.org>; Mon, 23 Nov 2020 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn88Isi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKWIJW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Nov 2020 03:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKWIJV (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Nov 2020 03:09:21 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22155C0613CF;
        Mon, 23 Nov 2020 00:09:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so16947610ljo.11;
        Mon, 23 Nov 2020 00:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vCZbRS+tLBVuXjiejgQM5wm4jHH8Hqj/yTs9/xuHE2w=;
        b=Qn88Isi0so1Wm+NdEL3YWXQSMQsISgmRDDpRvrotV4rnYm7v7Ok4TMfIBgaIXH6kN3
         Dgx70tauqIs+d4lwG6TMiRnbYcpclNK7dZbOWu45GwfhC6P0bmkfynOmeDPoCp7qm44A
         fvXzUwbd1iyrs8ADE9xuZucQzMscBvZpZPg0TqjxqPWMb73+5p5A6xK2rPm7VRhvkXO3
         iesEQy3YVxAnu717oBFS/qh65jfN2hpPf/l8wpb6T1RsQOymrN9yRQBV5+ls6swvRblF
         j0L6RAyZmEOIMJatiS6RWwxbkT8658zPX6pEUaYhSIKhvKLQITGBlcQRBslE+Lg3pU/3
         fQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vCZbRS+tLBVuXjiejgQM5wm4jHH8Hqj/yTs9/xuHE2w=;
        b=i4JRqWXNbmzFcNWkRNTq/0369ATk08lZGta9gMsx/8KNhIzLY0yEYOfpNTHI5sSu35
         DfJ8m8mbPyvsoq7oPGh/rMeE9eby8GKlZvvuJZ1xjZcX4ry/IiOpQqEH03lfN8tYURrq
         BJJEwHzDe6S+zt6dFOKhJEe7qHkJvRcAryAJtxv4q8dE968ipC9H/OsfZWEK0ZNCOGVN
         5breR1Z1r5lIp+g6J8VcSWWORRP9DUMlcVklvI7GjWMbqi9MEbjs775A5iKh3hAsWtod
         IQoI3lMmqJdetBLD3H0GCm0vZq6FgR576VJFIqtOezG0tH5t2XKxMP5SQ+ZP8CxM8lhm
         ooxA==
X-Gm-Message-State: AOAM531A7Q3cXr8idNx1r0WU6ROrP5EW4NBeGbAGHMd5JBp0YKb0McN8
        sNibRTkXyTGwLMMhOJ06tp+ekh9bkkQ=
X-Google-Smtp-Source: ABdhPJxbpwvP/HmccuQmsq3OFExMYzRYBakjKWI2fpjge24fAuxnoMPxZ42VKkr09tevxpGO9eVugA==
X-Received: by 2002:a2e:994:: with SMTP id 142mr12585153ljj.97.1606118959432;
        Mon, 23 Nov 2020 00:09:19 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:462f:9843:a5e7:af08:6dde:94bd? ([2a00:1fa0:462f:9843:a5e7:af08:6dde:94bd])
        by smtp.gmail.com with ESMTPSA id q21sm1218526ljm.52.2020.11.23.00.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 00:09:18 -0800 (PST)
Subject: Re: [PATCH 3/3] adv748x: Configure device when resuming from sleep
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20201122163637.3590465-1-niklas.soderlund+renesas@ragnatech.se>
 <20201122163637.3590465-4-niklas.soderlund+renesas@ragnatech.se>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <e8f57c5c-f832-59b7-4f36-3fbcc92a3243@gmail.com>
Date:   Mon, 23 Nov 2020 11:09:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201122163637.3590465-4-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 22.11.2020 19:36, Niklas Söderlund wrote:

> If the device is powered off for example during system suspend to ram
> the devices loses its configuration, specially the slave i2c mappings

    Especially?

> and other configuration set at probe time. This renders the device
> unusable and only way to recover is to unbind and rebind the device to
> the driver to run the probe setup again.
> 
> Add an early resume callback that reinitializes the device and setup the
> slave i2c address mappings and other probe time configuration.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[...]

MBR, Sergei
