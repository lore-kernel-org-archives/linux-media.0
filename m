Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19846C2D0E4
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 06:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A256F221FF
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 06:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlEreNb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgK0GaL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 27 Nov 2020 01:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgK0GaK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 27 Nov 2020 01:30:10 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED8C0613D1
        for <linux-media@vger.kernel.org>; Thu, 26 Nov 2020 22:30:10 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so3536657pgl.3
        for <linux-media@vger.kernel.org>; Thu, 26 Nov 2020 22:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fo/FUig7ulWqnAOd2l4Xs85CqNg+T8GFZyQSX2dOsHM=;
        b=hlEreNb08EhKTkG+AL4kw6j+t3uHJICQs1Aa4lzWC8WbF+1pLASY1Q7MzcS35Xy479
         YsxikDtU6Sd48bMPlzrQDsAq8D5AmeqdkJAr+fXbEan+X3uWmdAkXlHxIqUd6qjamOMI
         BlO5Twh2mwyQA8ukXunHEICx5fWfeMfmWbby2St0BXY9w+q2VlpJWtSNKqxVwWS+qAez
         6i8ElL6cvKxwKIjg8wTfBndxHQY/LGAMLeBqoDYpU2Uh8riQcHLbv+a1EfcCit+3DyGg
         QCHOoCimjlpIpDEo8grt5sjuHgl1aS4ukYtpfADvFB8HK6YGxqyDPDj1uwe0MMf1jqZI
         rnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fo/FUig7ulWqnAOd2l4Xs85CqNg+T8GFZyQSX2dOsHM=;
        b=tsivl1ELqahfwCEinkKxPkleVaEyT4i6DFAe6gsej5jOcumLTDFkm08nksEv6Gal7m
         YpNlxXIAA5WUwkTKmn3rS/BNhFcJGfVGdheMC9XfkwLKTZnqFxwapVElsIJp0TBniDhH
         /sc51Gdb6LkA/PElxV+IHJdjKNgUahHAsEREwLPkQgT66e6fXGjZUlt94+Q8bkNpfC8o
         7stBFTnoKADdmln1yPm1zvbEqLJs21mSTOaKLhcsEA+SqtPQmQo2Z73Jffxc4/XD1YIl
         x8KhpOXfuJEymzol/SDCyZfHm+uWGPLm+YoilTGbi7nnfPLsIJCjCsVrJIB/v8ElUeSV
         xDqw==
X-Gm-Message-State: AOAM530AP+wrerJcflU3cpQlYYouXGRUI527iGCKmY47fOBsvpmNvcgb
        LnyRr0G3g9KKiC7wcB+g9J8=
X-Google-Smtp-Source: ABdhPJwcaHnBWyvZAEDEajRRSVQEIfQVw/lIvHOSmc+fO0U88zklhi5ml+iQ2pBlNyZFtnIZoyFtXg==
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr8093539pja.6.1606458610480;
        Thu, 26 Nov 2020 22:30:10 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id mv16sm10088905pjb.36.2020.11.26.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 22:30:09 -0800 (PST)
Date:   Fri, 27 Nov 2020 15:30:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        senozhatsky@chromium.org, tfiga@chromium.org,
        bingbu.cao@linux.intel.com
Subject: Re: [PATCH] media: ov9734: hold lock to check streaming state
Message-ID: <20201127063008.GC3723071@google.com>
References: <1606448892-19167-1-git-send-email-bingbu.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606448892-19167-1-git-send-email-bingbu.cao@intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On (20/11/27 11:48), Bingbu Cao wrote:
> The lock in ov9734 is used to protect the streaming state and
> serialize the stream on and off callbacks, it should be hold before
> checking the streaming state in ov9734_set_stream().
> 
> Reported-by: Tomasz Figa <tfiga@chromium.org>
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
