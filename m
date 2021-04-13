Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B933BC43462
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 06:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA0613AE
	for <linux-media@archiver.kernel.org>; Tue, 13 Apr 2021 06:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbhDMG7r (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 13 Apr 2021 02:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243059AbhDMG66 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 13 Apr 2021 02:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D644460FDB;
        Tue, 13 Apr 2021 06:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618297119;
        bh=At7tv/t6+u+Xed4C9ESv3PLB9A4rw88+He4xQJrhC8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uF0mHX87ApqlGgu9151snbVoO5F+wIjbsZdjqFB9dP9GZ73EsdAzJT8LUtHy9rZGC
         mdP+VB6xzHjCu9fB8SnJxOKn3Ey9Kp51nH4h/3wgBcZEFU2Anizjcg7a7etG7FkOM+
         IEdEN9aXBt4mdjF3YIzY2C1Kchu3H2E6+SfitlK4=
Date:   Tue, 13 Apr 2021 08:58:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     narmstrong@baylibre.com, mchehab@kernel.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        linux-amlogic@lists.infradead.org, mitali_s@me.iitr.ac.in
Subject: Re: Subject: [PATCH v2] staging: media: meson: vdec: declare u32 as
 static const appropriately
Message-ID: <YHVBGhoZXnVYfeKE@kroah.com>
References: <YHU56OM+C2zY34VP@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHU56OM+C2zY34VP@kali>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 13, 2021 at 11:57:52AM +0530, Mitali Borkar wrote:
> Declared 32 bit unsigned int as static constant inside a function
> appropriately.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>

Why does your Subject: line have "Subject:" twice?
