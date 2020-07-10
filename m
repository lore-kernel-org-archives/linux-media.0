Return-Path: <SRS0=jMCU=AV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACAC433F8
	for <linux-media@archiver.kernel.org>; Fri, 10 Jul 2020 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595FA20748
	for <linux-media@archiver.kernel.org>; Fri, 10 Jul 2020 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0mgxztF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGJOgX (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJOgW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 10 Jul 2020 10:36:22 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC564C08C5CE
        for <linux-media@vger.kernel.org>; Fri, 10 Jul 2020 07:36:22 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b25so4572467qto.2
        for <linux-media@vger.kernel.org>; Fri, 10 Jul 2020 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GLA8hy0Mxnr5ois+m7iqZSoz9HaAK6soXtHyMxCCCIM=;
        b=F0mgxztFMPAYojlKB4OMbB4lHcuYJ1sXVegMYwRZHvSlnIagiT0HnXJkaSOApLNg0M
         x4DVbuy1yY+96TmPz++PL/w5gBJJD0cVmW5tBhOSRVZTEZPDGIn+hXNprAHu3iT27HUa
         8JP4nB2dAPd+7gvyWJGeFdnhlpVi816JbeUmnvZepl4pDioiYxD90bIrsDHqjG0SSqEs
         jL1PT5iuBLpiMAwdAaUH5TPO7ZwW9d5I1yBFGKQVoVgII3C3EeMNnehU5flHoDlo/seC
         rrfw8q67D+bd9RyxvNId1jVYZpZCmZsC0SbsBwPSQq2ATPjmpeF6XTfH7tVIfOShlX+x
         BkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GLA8hy0Mxnr5ois+m7iqZSoz9HaAK6soXtHyMxCCCIM=;
        b=Bv5AGz0l4hisbu1gtjuQAI9+mXhbFAbfzMf5ALRAwx9QRaRJc3vYnaCE9ViHOdRf1d
         XMf5FgMQXPHkPniF4K7isslZPbPBQWMdgtiYSXWltPg/4VZpesuONgw0ITk8ZPN46Cg2
         xK11n6xpOUN403C62A76TwSG4KHKuHOEID2GJt68sDtFoIDjjQRDCn8WFEU6NX8DHqRn
         txhRQjunwFh8PL2ZeCre/9/VOFzBucmiAI7Zo/TRLm9pOy1uBuqrPcMVAFBdS4b5/beQ
         2E5M8ToAsb30bPGnlxiTXYYO00NsrV+ehBl+bLNXmBsTLypYQttAKU5mO43rKnJJRfk4
         hr3w==
X-Gm-Message-State: AOAM533e8AFbGcvDbPBedZSgPVxC91PhRIY/4XUnU8ill1IkvGkQdxrC
        Sm1Iegn+WyX5up8Omi7lt3HixayfM6U=
X-Google-Smtp-Source: ABdhPJzOGjJQ0eyd3Lk4S6BDr7fBQsMVhFh9tXWxtVkFqfpGJy+/TVQAC0A4QURDQhdFRAK2qR3eHA==
X-Received: by 2002:aed:2f46:: with SMTP id l64mr37798487qtd.1.1594391781768;
        Fri, 10 Jul 2020 07:36:21 -0700 (PDT)
Received: from [10.0.0.101] ([177.86.199.79])
        by smtp.gmail.com with ESMTPSA id f203sm8096412qke.135.2020.07.10.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:36:21 -0700 (PDT)
Subject: Re: Range values for V4L2_CID_* commands
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
References: <ab88a3cf-bc05-d43b-dfe2-5f9e78422132@gmail.com>
 <01fd7935-2793-c1a5-5aa3-4f453019394c@xs4all.nl>
From:   Lucas <lucasavdantas1992@gmail.com>
Message-ID: <fa6af3b2-0c18-0766-7aeb-19f703a619a9@gmail.com>
Date:   Fri, 10 Jul 2020 11:36:17 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <01fd7935-2793-c1a5-5aa3-4f453019394c@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Thank you kind sir.

On 10/07/2020 11:28, Hans Verkuil wrote:
> On 10/07/2020 16:18, Lucas wrote:
>> Hello, how do I obtain the accepted range of values for each V4L2_CID
>> command? Take V4L2_CID_BRIGHTNESS as an example, how do I know what is
>> the maximum and minimum values accepted for it? I have tried to use
>> 'v4l2_ioctl(fd, VIDIOC_G_CTRL, &query);' thinking that would be stored
>> in the maximum and minimum members for the struct v4l2_queryctrl but
>> that does not appear to be the case as the values for those members are
>> always zero.
> Use VIDIOC_QUERYCTRL for that. See:
>
> https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/vidioc-queryctrl.html
>
> Regards,
>
> 	Hans
