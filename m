Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FFBC4332F
	for <linux-media@archiver.kernel.org>; Tue, 31 Oct 2023 09:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJaJMp (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 31 Oct 2023 05:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbjJaJMn (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 31 Oct 2023 05:12:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DB3B3
        for <linux-media@vger.kernel.org>; Tue, 31 Oct 2023 02:12:41 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-779fb118fe4so358994685a.2
        for <linux-media@vger.kernel.org>; Tue, 31 Oct 2023 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698743560; x=1699348360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0BRx8gZoE9fOWKsHw60pqFlz6sDQAcL5kgFNRqM8gpY=;
        b=EE8/N5AcZs5D6R5XBDm7Gwh3piwUMoP3wZyctDyP0+AMSgL8WBMtLqrbQwRa1rkx+n
         vsAI/u0U8t20NJgq33LeAXTNiqlc874ziZ//StMo9RfwpJD2zqxkW+shk6Mn0PD8Kdr7
         xQSmxOf1AAXQPpkNWKyJFrnq95xyQlhJNfYns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743560; x=1699348360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BRx8gZoE9fOWKsHw60pqFlz6sDQAcL5kgFNRqM8gpY=;
        b=MWe3p6HwP4bwY3PawR5gNQso508sZL+ZWE++7aK0z/acYLu4WG0BjAtXBOf4IDYFWa
         qvWM8PEQnNoVk9i0WZJErHW2FC3s/MyVpZlKq1kvm9Vg75TPoYzP1TewvcgEZ1EN6nmA
         5O5FsZidjJBpCJsNecMV28YmDbU9qKnEBSDkqUfnILW1xjQoydqGlanWpxx2MpbOgUvN
         0V83qxWj6ygper/P8MJDgkjHhRafn0hH5KB44xDx5Fvwj1i32JFUTeURY/ewZbjsYwtI
         RSy0OtDjhZRCMnYd1GlJRa+Yzybz8WmPnu5xXF25hxgYi7Y7uQS2RfLsO+2H22txXEnt
         pXig==
X-Gm-Message-State: AOJu0Yz+w82YXnz8xVf8+jfiRPX9+1xbq/2Sbh1V8t5s5uFwnkR0e3Vi
        bI+M/2XORP4+56ZaZw/hY6rUrlfiCZ+ZDWIdzf0=
X-Google-Smtp-Source: AGHT+IFZ9jW9xu801wMJK23sxE51xoeYqqVHi8amhzJh1tgtVZULV8Zh+JIpfdjwU+EOGwfwIvwayw==
X-Received: by 2002:a0c:b343:0:b0:66d:43fd:f4e4 with SMTP id a3-20020a0cb343000000b0066d43fdf4e4mr11876551qvf.45.1698743560162;
        Tue, 31 Oct 2023 02:12:40 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id i12-20020a0cd84c000000b0065afedf3aabsm361181qvj.48.2023.10.31.02.12.39
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 02:12:39 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-779fb118fe4so358992985a.2
        for <linux-media@vger.kernel.org>; Tue, 31 Oct 2023 02:12:39 -0700 (PDT)
X-Received: by 2002:a05:6214:627:b0:66d:63d6:3600 with SMTP id
 a7-20020a056214062700b0066d63d63600mr15176670qvx.55.1698743558964; Tue, 31
 Oct 2023 02:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231028-uvc-power-v1-1-fa5c376abe78@chromium.org> <20231031002545.GF12764@pendragon.ideasonboard.com>
In-Reply-To: <20231031002545.GF12764@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 31 Oct 2023 10:12:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCuiUWEQ292Lt2RnZ2OjXA4pATxdEufkLDBzpYLk74yY+g@mail.gmail.com>
Message-ID: <CANiDSCuiUWEQ292Lt2RnZ2OjXA4pATxdEufkLDBzpYLk74yY+g@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix power line control for SunplusIT camera
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Laurent

>
> No need to resend for the typo, I'll fix it locally.

Thanks!
>
