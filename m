Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1758C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85B4217F5
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UWzcmLIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfC1Tsh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:48:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36163 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1Tsh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 15:48:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so123559wml.1
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k4fWnI+GSJr/5X4jqfSrHgAw86SndYZq8v0HTRnnX+Q=;
        b=UWzcmLIaA/qeb2xU9jy6UnWroxkeDrvmTZxagMxqmYHhEUsF8J0HVz0YyNc6f/UiOt
         4bV2KZM4Zgkj939SuIJRsrm78prGjaQU08Inw4tXoyW7i4brm5+0YDdd+43aQyT3O1B7
         +QKWjoeg6fiAPbJ9k9idVclcwv93IXlxa/J3DEUII95kCHMixlco8hEyqwU9tXkqxmQi
         pULjxdv1jWNj/2MPFLzY1i8PituJeHBRXXMycYkV1ENd+w8sveN4LTGZ44F9TIWAkGQ3
         3J81xKLEuL3Xpv2A9JFioW3CKdnlilMGtYZnEh605ecsCaJfPwcdtU9iTZqzJ+oVyenW
         J8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4fWnI+GSJr/5X4jqfSrHgAw86SndYZq8v0HTRnnX+Q=;
        b=peybTjCIUKs/8Q8nrlXpGDCVjtzGRyRSbJhbXZsMdyhaEk2b3rsq45PmAd7OQuB+UU
         BQY/N6dxXkIZsKMTCSKOIEs9nchjN89KqJeuFfjul7UHi62ciJ20e/0Snm0F685rFNkZ
         pDiWY3mGeQqHGcI4KRZnX3W5Mwiprk9xWhXYHL+JHfSvSudjA8ZBh6Z3BpkPuO5go8L0
         CRnGKHcimR6ig/409NodJ0fkxi1j8pOFToLI0CoEjhWD6rw/IpNJbQ94x6L8Q9I5lGsp
         nlRUiNrljcHdevaX9ct9Et0iXq3AcKXCWla+Wot3IpP8niV/7GckMtmRr2w+8aK4Rnx8
         cymw==
X-Gm-Message-State: APjAAAW0fJvFVvBqO1jHzXdtH48k3tcKNu8H8AX0lCvhZj5CpqF/9ZZg
        zEdj6xAnLJi0VosT8S+zZU8MNTvu
X-Google-Smtp-Source: APXvYqzJnRFTDAVG7TpUS/vI7EhyFsnng500hE06l9bNsYT72vXSg4d4R0Gni2JDmYBotzyRVQ3UrA==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr1149480wma.75.1553802515723;
        Thu, 28 Mar 2019 12:48:35 -0700 (PDT)
Received: from ?IPv6:2a02:810a:8340:5f04:e45e:bcec:ae29:52fd? ([2a02:810a:8340:5f04:e45e:bcec:ae29:52fd])
        by smtp.gmail.com with ESMTPSA id x14sm87546wmj.3.2019.03.28.12.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:48:35 -0700 (PDT)
Subject: Re: [Bug report] dvbv5-zap crash dvb-tool ARMHF builds
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Samuel CHEMLA <chemla.samuel@gmail.com>
Cc:     Sean Young <sean@mess.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
 <20190317065242.137cb095@coco.lan> <20190319164507.7f95af89@coco.lan>
 <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com>
 <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
 <20190321083044.621f1922@coco.lan>
 <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
 <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
 <20190325140838.71f88eac@coco.lan>
 <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
 <20190326132643.r3svehoa764xagje@gofer.mess.org>
 <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
 <20190326123115.5d83f450@coco.lan>
 <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
 <20190328161758.2da2bf4e@coco.lan>
From:   Gregor Jasny <gjasny@googlemail.com>
Message-ID: <62429f4e-eabb-8ee9-4137-47540e8131ef@googlemail.com>
Date:   Thu, 28 Mar 2019 20:48:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328161758.2da2bf4e@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

On 28.03.19 20:17, Mauro Carvalho Chehab wrote:
> Em Thu, 28 Mar 2019 19:48:35 +0100
> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>> 1) I did reproduce the bug with a serial console, but the serial
>> console was also frozen, and there was no message before freeze.
> 
> The only way for a machine to freeze even on serial console is due to
> a very serious Kernel or hardware bug, like a bad lock/semaphore.

Does anything speak against upgrading Debian to latest 1.16.5 release?

Thanks,
Gregor
