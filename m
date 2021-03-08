Return-Path: <SRS0=qtPK=IG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0DC433DB
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 02:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905B7650E0
	for <linux-media@archiver.kernel.org>; Mon,  8 Mar 2021 02:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhCHCy0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 7 Mar 2021 21:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhCHCyJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sun, 7 Mar 2021 21:54:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A271C06174A;
        Sun,  7 Mar 2021 18:54:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t29so6113513pfg.11;
        Sun, 07 Mar 2021 18:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mFSkViZXOvwmWAhS7tYtXVJXwXatkvhNxjoAxYZhg/s=;
        b=kVXg1qiK64BM/wA9A7kLXmNiANwfY4X+x1YJKBrZhjJCIA/ykx1/eo7t4eYZ5+zdSG
         HOOvd2b4YUXuJPZoE9FtYYkHGQEDFsgf+C6mvh9O8GkJ8PhnS2tyM997uvonql1MdAYk
         Jawd4oAPGfvip0k4Aivcrb2c2ZmfAYkI0BbsEdb9v6mqdTlVylV6wbAfvqmdE727vtMp
         Rk+AW4RtICpdAaIdclEBFJhS99W+e05lXKXjztvA/iYDI2Enoo+nYPu5iEABs0h+VCnc
         QNwfIdu3SDhTon8GS8J/feJu/QERJ7cCBRWcpqAfml1tZwJh2G2fTx3bxkMtfY7XeUdz
         Al8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mFSkViZXOvwmWAhS7tYtXVJXwXatkvhNxjoAxYZhg/s=;
        b=B1sgddbtbuUb0ZbOikCrkAQ6x9if6+yVkoaXXA0PoC450Y8XHjit8zU5mdi84673GQ
         4u/ab0SEBpBQQD6pK8FUmWXTc7iRCN0/93fbatzT9cB9c7x3q+hON+E8XJUZzIZnWXel
         mC8DkbadJbWReQRR6wRVdr3nGamZICm+tlhQIWHqMYenEMzHTbokLTtdi6QmW9fFWTm5
         eFsvCnZlauhxy2KrcgakdS6nO2oL0jprpDjG9iv37GNqLvbblPHvGwqOcxBce1qUfumR
         rWcUnP9IK1WgfO394Nzo+6mGPbe1xkJrTsc98vZpCfHkbLhofi5wzEmnv7QBYWfLbQLk
         xjUA==
X-Gm-Message-State: AOAM532EKyYFUy3lXBByhZTspPgNidOPk3wjyfaoBdt+7C8ECbnsRkdR
        C+yzPB+bGaYH2/vUqwBoYF70XmrSeHdWb4cS
X-Google-Smtp-Source: ABdhPJy9xhOPu5/0+XQIwwNkR0Bjtnppnsbuz9fr0degL00AQ1ak0eHSEVkDa9SRlaehrCCCxwFs2g==
X-Received: by 2002:a62:2786:0:b029:1ee:afe7:6bfb with SMTP id n128-20020a6227860000b02901eeafe76bfbmr18715044pfn.14.1615172048618;
        Sun, 07 Mar 2021 18:54:08 -0800 (PST)
Received: from [10.187.1.26] ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id g22sm2447811pju.30.2021.03.07.18.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 18:54:08 -0800 (PST)
Subject: Re: [PATCH] media: platform: sunxi: sun6i-csi: fix error return code
 of sun6i_video_start_streaming()
To:     wens@csie.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210306141528.18925-1-baijiaju1990@gmail.com>
 <CAGb2v660_jsK565dN4D2wSTmGjt1WUnHRkMOG7vzaqgZwY-Zeg@mail.gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <ad3e4bd5-9db9-da04-37fa-b7fe5d9d431e@gmail.com>
Date:   Mon, 8 Mar 2021 10:54:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v660_jsK565dN4D2wSTmGjt1WUnHRkMOG7vzaqgZwY-Zeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 2021/3/7 20:47, Chen-Yu Tsai wrote:
> On Sat, Mar 6, 2021 at 10:15 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> When sun6i_video_remote_subdev() returns NULL to subdev, no error return
>> code of sun6i_video_start_streaming() is assigned.
>> To fix this bug, ret is assigned with -EINVAL in this case.
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> This should have the tag:
>
> Fixes: 5cc7522d8965 ("media: sun6i: Add support for Allwinner CSI V3s")
>
> Please try to add them when fixing bugs. And this should also be tagged
> for stable, so
>
> Cc: <stable@kernel.org>
>
> Otherwise,
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks for the advice :)
I will add the fixes and stable tags in my future patches.


Best wishes,
Jia-Ju Bai
