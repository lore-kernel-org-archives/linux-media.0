Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18E9C2D0E4
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 04:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD042223D
	for <linux-media@archiver.kernel.org>; Fri, 27 Nov 2020 04:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="H3BA403s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404832AbgK0E7m (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 26 Nov 2020 23:59:42 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731606AbgK0E7m (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 26 Nov 2020 23:59:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cj2VC6ZHrz9sRR;
        Fri, 27 Nov 2020 15:59:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606453180;
        bh=CFK7tphudoAmtSuHpZKpARuajXEY0837Mt2QbcT9v1s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H3BA403sisj6HLxCRmR4/cxsl6fAop/BsWLYq/VqMviKQkUF+hFL9VwmzddYkokFE
         0kRayOIKCYrCe+u7sTZQ0nUd+wdk7+Nw7YHOgmnnRK5/ZP7lhkP6HfCpA6+J0YvAgf
         n2TeuwKiTN7kOraXuukTfAaX0llqAbj1WRA00Eipyn09z2vhCCEzAbLOMt61TgjRoH
         D6kZFP9uAR0hRJme9jz6YzyInKNwPOa7kYFBenJjdaIkmFci5poZ095ohZkTHHHvOB
         9n24Igdi8wYxjFpq9LucO9lHlFuFGs4YfHA3yzQ3uyB9Y3RPXy15CEBJdY6xEXdpO7
         eBjcraDl7dDvg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Fabio Estevam <festevam@gmail.com>, mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        geert@linux-m68k.org, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] media: fsl-viu: Use the ioread/write32be() accessors
In-Reply-To: <20201125120447.12437-1-festevam@gmail.com>
References: <20201125120447.12437-1-festevam@gmail.com>
Date:   Fri, 27 Nov 2020 15:59:28 +1100
Message-ID: <87czzzxumn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fabio Estevam <festevam@gmail.com> writes:
> Since commit 29d750686331 ("media: fsl-viu: allow building it with
> COMPILE_TEST") there were several attempts to fix build failures on
> PPC, MICROBLAZE and M68K.
>
> However, such errors are still present as reported by kbuild robot.
>
> Fix the problem by using the ioread/write32be() accessors, which build
> fine on all platforms.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Fix wrong conversion - Michael
>
>  drivers/media/platform/fsl-viu.c | 119 ++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 64 deletions(-)

LGTM.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
