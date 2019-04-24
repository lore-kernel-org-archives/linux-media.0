Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F77FC282CE
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC2C20811
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTntqaoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfDXMjh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:39:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40067 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfDXMjg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 08:39:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so15956844otp.7
        for <linux-media@vger.kernel.org>; Wed, 24 Apr 2019 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyXfa149xflFPUebzbBDNz6s0lUGYHuiRaKn3DL9Cs4=;
        b=VTntqaoByvKi4O60oIfPkpb91X5rmSYz9Q3BhXE8h28107pN+W8kpnWHQzAQvNjGGA
         dOaI53lntSNvaer6TNQoqeJ2F4Ndqc8MFoPtG2wlSgCudqwqV3IlAvpKqQX51IessjEv
         RUr9Sqsb6/x8EhdRucXIiWJkBWPL0NRKRkUn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyXfa149xflFPUebzbBDNz6s0lUGYHuiRaKn3DL9Cs4=;
        b=R0vMOfNrc/v7xBb15a1gOCwSb6JvhI3NjVs73X/F7hvClC/u4E28QQXmKwn3kc7Ibi
         uuI6LC8tBBItGQl3JZ0CjOMfLv8uNScPhg/yl9/DvmvW7zOgnMaWZVi8A1v7ShxpL8WZ
         ysOh7fxCawJAKsXdd2S0/ED4Tu8dN+1KE8idE5ow2LVeYD7mM71Jq2WB+oNmIYqiL94V
         XAJUNbjfCgVtAMiEHXiWsJM7+5H9Pcxs1tVJ3z4u5uWlbMtZ/M1rhFeycVIRWJ30VF5r
         U4CcpvYlMVokSfdbcc8MbsO0ePzv3nkgKzWv9e3e6DrLxhbRCyYFEFZnoCs3QjHybFU3
         4UqA==
X-Gm-Message-State: APjAAAWAy0W2hMOcvXSNW8P2ADTdxG4t92vFYL5ST2DU+P3k7dlxMrCu
        147n23+hX4Yx4rCxjE321MQXGk20ZZM=
X-Google-Smtp-Source: APXvYqyCHtS3gIk0QS+o1AqnI+o5utZuXytLHsLtJ9Z/LHBgwgFIv7ae00JrFyfaHJiAAVyhu6zNpg==
X-Received: by 2002:a05:6830:1418:: with SMTP id v24mr19907967otp.273.1556109574772;
        Wed, 24 Apr 2019 05:39:34 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id h13sm31042otj.25.2019.04.24.05.39.33
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:39:33 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id s24so15933405otk.13
        for <linux-media@vger.kernel.org>; Wed, 24 Apr 2019 05:39:33 -0700 (PDT)
X-Received: by 2002:a9d:6f90:: with SMTP id h16mr7097977otq.152.1556109572667;
 Wed, 24 Apr 2019 05:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-11-stanimir.varbanov@linaro.org> <60b3efff-31c1-bc04-8af9-deebb8bc013a@xs4all.nl>
 <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
In-Reply-To: <fe51ae1e-6d2e-36bd-485a-d85520ad2386@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 24 Apr 2019 21:39:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Message-ID: <CAAFQd5Co3G1J4+HOcjtCb7p3rhLcm+1E=mPr2d=AtdOSuF_eKg@mail.gmail.com>
Subject: Re: [PATCH 10/10] venus: dec: make decoder compliant with stateful
 codec API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 24, 2019 at 9:15 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Hans,
>
> On 2/15/19 3:44 PM, Hans Verkuil wrote:
> > Hi Stanimir,
> >
> > I never paid much attention to this patch series since others were busy
> > discussing it and I had a lot of other things on my plate, but then I heard
> > that this patch made G_FMT blocking.
>
> OK, another option could be to block REQBUF(CAPTURE) until event from hw
> is received that the stream is parsed and the resolution is correctly
> set by application. Just to note that I'd think to this like a temporal
> solution until gstreamer implements v4l events.
>
> Is that looks good to you?

Hmm, I thought we concluded that gstreamer sets the width and height
in OUTPUT queue before querying the CAPTURE queue and so making the
driver calculate the CAPTURE format based on what's set on OUTPUT
would work fine. Did I miss something?

Best regards,
Tomasz
