Return-Path: <SRS0=DymM=CG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8718C433E2
	for <linux-media@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC71208A9
	for <linux-media@archiver.kernel.org>; Fri, 28 Aug 2020 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8FA52NA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgH1S4G (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1S4E (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 28 Aug 2020 14:56:04 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909EDC061264
        for <linux-media@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i10so149677ybt.11
        for <linux-media@vger.kernel.org>; Fri, 28 Aug 2020 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnNw5CWzP8lUiH2nZYQGN5jpBc++mmmv4sVoEABnC4g=;
        b=f8FA52NAkvfzgqADf0WbDOllQdDHETwhwuBzyyZlBAxXm1kSdwykbXKcXETq/UZQh1
         yl6Qz91C9trg3GmpuSvN/maT+lIQpo+dpWsNeTdjJK4D/Ejk+z5fZxbFl/MuSmoXFvC8
         DjjNnDcQfBrXsmSe+NoV+uplsoNYOJFvHzTkeUawf0qQRzQeBtwQSXhGUMecAjtN3uXf
         hNHbUBKd9etS6goe/ZRIfOm4IW9y4/cn/+ZDP5598zY0rJrRXweXrk7+/2cswpx+8jwm
         WEZzjH6EX8taGoOQ9GmEbdaGKknSHjC0sjvm73zPx/B1nERvh2JV8/svQeRu4EzZsgCD
         KkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnNw5CWzP8lUiH2nZYQGN5jpBc++mmmv4sVoEABnC4g=;
        b=mkCIwLtqi768tjhBD5pK6yCxi+3SuFj5Tw1JX+E3g22h5NFG1sE4+7DbPhlBxXxY3x
         baeaBXEKFtARNs0uY4dVqH9FzpMV8Fuc9b7/sZVVs8SXBmTIXY9drM3ROU3pm2hYBe6R
         5Pu+5FSL+JHkMeSiyCg+M0BrexzHbbFZ44y+F8sL/c6G4t6jIcIdm7Y1eybHNdlx9wZy
         DV6ih/jSI74+EXykIyK3VjIW/m9QvHKv4nPq5jLN0f1sPomT/mzZOVCJbzk8s3EZXooP
         hewvQbkrxOB6UDYCONxWeX7kcOGeCHj/wIsMcHte2DdPDBfNddy37UyZoaYb5L0Q1fjd
         CnRg==
X-Gm-Message-State: AOAM530e2SSYZ1RhGRHFRwmm0Cnlm0Ftejz7boKcC1hat8OcnEe3haQb
        eJljQPkcGzAWoViuHpsyefeMXxFZCAMzbm3F/0wR2Q==
X-Google-Smtp-Source: ABdhPJxPjCSCMQ7LhbKWQ7XUp5huhPtc67UGElcc3VCbR43Fg78gP/RFIm6MqpkF90shYA+0NmVp2l5Q4+Tt5ZQQU/0=
X-Received: by 2002:a25:ad4e:: with SMTP id l14mr4478460ybe.322.1598640960119;
 Fri, 28 Aug 2020 11:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200823012134.3813457-1-agoode@google.com> <20200823012134.3813457-2-agoode@google.com>
 <20200823145417.GC6002@pendragon.ideasonboard.com> <20200823150822.GD6002@pendragon.ideasonboard.com>
 <5a2882e5-c029-dde7-c6ff-bd6f57aa7850@xs4all.nl> <CAOf41NnrfW6h++nR42R1OxR0B3DVrKg9RVLTQVJ=nEkn3GW4aw@mail.gmail.com>
 <6538b14c-e386-2fab-d178-7bb3e98b3525@xs4all.nl> <CAOf41NmOdb1Y3ZSO7YLxyStbSfUCo8p204TdvkwH91cXdmNq5A@mail.gmail.com>
In-Reply-To: <CAOf41NmOdb1Y3ZSO7YLxyStbSfUCo8p204TdvkwH91cXdmNq5A@mail.gmail.com>
From:   Adam Goode <agoode@google.com>
Date:   Fri, 28 Aug 2020 14:55:24 -0400
Message-ID: <CAOf41Nk4Fn=-mtZLr_TRp2PRNS+cAc1o9=Y8zw2newCmcHobQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: uvcvideo: Convey full ycbcr colorspace
 information to v4l2
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

I sent a v2 patch last night, thanks for all the comments here!


Adam
