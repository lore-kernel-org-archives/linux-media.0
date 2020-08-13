Return-Path: <SRS0=DBWO=BX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9BC433E1
	for <linux-media@archiver.kernel.org>; Thu, 13 Aug 2020 21:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC9D204EC
	for <linux-media@archiver.kernel.org>; Thu, 13 Aug 2020 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597355754;
	bh=g6VnjkHiul5rnqrdKnHcDrPO13g7jXUP3KOqbUzGI4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m1ZAz8IKHsChP2Ywfd7Td7ry9YzPVuQNdoSMdl5y2RliVAgSk0bLiVuo372WovoLP
	 vN7djK+wsFA9PP2ePdlCccqt3AKAD/qqoGBCM58OHSAHRv7m1VH6ls7fLPsREvWX6W
	 ALYuPTpb8sG56joD06vJxz2TYK29UCmkBpzEB1sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMVzy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:55:54 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37798 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMVzy (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Aug 2020 17:55:54 -0400
Received: by mail-il1-f195.google.com with SMTP id p13so6851553ilh.4
        for <linux-media@vger.kernel.org>; Thu, 13 Aug 2020 14:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gCC5drV34nnZQ2cGRcrqK8G/cSWqXf7L4O/Ca2yLTDQ=;
        b=IDig0VLun+jRAcvMr3hejrtENPkB0AlgvWi1K/03X+j4fgoWCeoG6QQE9wgvwwdOg1
         mHVCHKS/LzvBvOal+x88LKNroBXgnssDtwn37b5WKaDwDdVjEaM+2uaYn/y3dYC+OhhU
         Y8+KGgK+qauk7SXQ8fl4oVeUXfTvqUy6+gG2FfoAjOgVdK9MtcWooDO7f6TgYY0I5PZr
         jw9i72AhUSIU3BgHrOV5ePG2g/ezWtPNhA8SH1RlF6WLA5bJpvGOLZgOSzFQCdLFvY/g
         AM9lDaqT2JbDkngwCbb+4snxAyyhc19+S3Fz9VNqpqlvX57+FmsbzuMYWw+m53EvoFRi
         52kg==
X-Gm-Message-State: AOAM530HKwAvuKD4tO+xHqaYnrwM2UfJH3BayHmhDFXJShmQ+4o+kdH5
        GS7StXOfIt2dEuw/zuHeMAC0ykT7X2U=
X-Google-Smtp-Source: ABdhPJznIeAwU1D/S7PcaaVLq6j2S69Hkq1tiZNi9R1MvO8Moo0PltRd65kZUMsMOdc22WkhT0vBzA==
X-Received: by 2002:a92:5f87:: with SMTP id i7mr6112439ill.67.1597355753326;
        Thu, 13 Aug 2020 14:55:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z9sm3561259ioq.52.2020.08.13.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:55:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 07BF5403DC; Thu, 13 Aug 2020 21:55:51 +0000 (UTC)
Date:   Thu, 13 Aug 2020 21:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     linux-media@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 2/2] media: si2168: also cache Si2168 B40 fallback
 firmware
Message-ID: <20200813215551.GA4332@42.do-not-panic.com>
References: <20200813214538.8474-1-kernel@tuxforce.de>
 <20200813214538.8474-2-kernel@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813214538.8474-2-kernel@tuxforce.de>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Aug 13, 2020 at 11:45:38PM +0200, Lukas Middendorf wrote:
> we can not know beforehand whether we have to access that firmware
> file during resume. We just request the caching so we don't run
> into any problems later
> 
> Signed-off-by: Lukas Middendorf <kernel@tuxforce.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
