Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B91C433B4
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F60860C3E
	for <linux-media@archiver.kernel.org>; Sat,  1 May 2021 08:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhEAIWe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 1 May 2021 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhEAIWd (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 1 May 2021 04:22:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56FC06138B
        for <linux-media@vger.kernel.org>; Sat,  1 May 2021 01:21:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v191so699759pfc.8
        for <linux-media@vger.kernel.org>; Sat, 01 May 2021 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+MuJt4JpNhaeCfTs6whxsfc3L27JznuEHDV6B3gjoM=;
        b=DITj8gyCFnbSw3FzSMIWVDBOLylocxGHOmp4XKAaOTVGbUQuQBSArSR/oSxRwaEjR7
         jQUqo/WH7YTkAr6wVjkYBUt7r4bfEDWoxCOeBZTpyO/NGtM9x2M2Gwd7+5/ZBBhVikzX
         j3J7UXI5PB0myEj1TfS+TYEAN30kImrb91csE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+MuJt4JpNhaeCfTs6whxsfc3L27JznuEHDV6B3gjoM=;
        b=HmSRr2OsjcqNb7TR4vfYRQ5OyBh0tVWILCJiBzuwCrQGASDfewDktYMWcwXNIB1FRn
         6QEPW0oy/KsOuw4uAnyFsxxOngi+pqEJdyFN7Ev4u3EDjaJBUT2nudBgC5M1Kvt/Pzei
         ufl+kaa/4cgPTaMlxe/CPjt6Xsgcod6mxhk5GxhjjcDlJtZMqmOLM/qBJXlO7IdYXCc8
         k+xBcoo1F74V0US8lU9OPi7WckXC28tTSGs46kNt8GxA/PTibVWjaPETw7yCnECCG2Hx
         iWASLo8eA7jUR1P2kqKtYcHKMeIKRg+fAAailmrkc3vfMwkAWkmVpCsnEKST+15Eo6wd
         otZQ==
X-Gm-Message-State: AOAM531hEdtjYSIGMTddfknanYlXi/084+MvQCowHkTTC0OGPxk0Kpvj
        1PMO0TRvq0r4vcHZ/ro9YUN8qQ==
X-Google-Smtp-Source: ABdhPJxfSzqx7W9tWpLxTtm51XBBb35T0kXip5gom7sToV+vGXBNy3opr+TzKxSH2NkHrlp1ibYDrQ==
X-Received: by 2002:a65:4082:: with SMTP id t2mr8593837pgp.396.1619857303754;
        Sat, 01 May 2021 01:21:43 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id d9sm7737742pjx.41.2021.05.01.01.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:21:43 -0700 (PDT)
Date:   Sat, 1 May 2021 17:21:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 0/5] media: uvcvideo: implement UVC 1.5 ROI
Message-ID: <YI0PkqSCBMjj4P4a@google.com>
References: <20210430112611.475039-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430112611.475039-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On (21/04/30 20:26), Sergey Senozhatsky wrote:
> v4:
> -- split ROI rect selection API and auto-controls
> -- handle very large ROI rectangles: limit to frame dimensions

Please ignore this series. I just sent out v5 with UAPI fixes.
