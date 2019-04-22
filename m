Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF635C10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD8214AE
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555954563;
	bh=fhSkKC+KAjKNe94Jy7RHG5BaywaMOuDKYh7b1WqAQ90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LluWV/Cqv4524dB4Sq9J6Yn/wIlRbU4+b3Xqe+S0wZKE+BB+SemmHfvg/rllv9erk
	 81UHzZ7kCOe5idFCN701OmJUxyc4aOaJx+7BS/FKbaLZ5Bi+Sezvpqr36lTU/vahRC
	 jUQqpjDE8/OAUxdqPVBDgLBZrbZiLK4gGT7qzeVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfDVRgD (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:36:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:41694 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVRgC (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 13:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ixrkklA9r5NdzUfCbwZ4K96ZOE60p2Z9zUOACvXrMeY=; b=foamT6Mzq+DZ7JV5Z4SjC19vTf
        pbZSr/usJX1bdAoB3lnMS9VGzQ0O61kAl+EwLUEw4bd4QUNEcVQj1gVx3rRJrgub16qgmfvRloVM2
        ar2fxzAQqHufotw3Zn1Ma+HEo3+Nv904kdYGhMHugLLtb9sdAT7lU7qJnGvY8tSyZCsq6DuKG53Mq
        MHb0OF6wkbHuBUkKRmrrCOx/R+5nBOl6TqjATtSG2nCW6lpdesxhLU37B/tgRjNMoOTJ3ByKTTCrg
        MS7jiN67tEDKDpAdJ36mk/djRNYJbBW3m2+uz+DTRgTTiS0Z3LI0vedpZMRcE7sZnQB+c+y/fjxwa
        k9asZfXA==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIcrI-0002DR-5T; Mon, 22 Apr 2019 17:36:00 +0000
Date:   Mon, 22 Apr 2019 14:35:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org
Subject: Re: [GIT PULL for v5.2] Venus updates
Message-ID: <20190422143551.6d29231e@coco.lan>
In-Reply-To: <20190401081817.14386-1-stanimir.varbanov@linaro.org>
References: <20190401081817.14386-1-stanimir.varbanov@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Stanimir,


Em Mon,  1 Apr 2019 11:18:17 +0300
Stanimir Varbanov <stanimir.varbanov@linaro.org> escreveu:

> Hi Mauro,
> 
> Here are two patches, one fix and one which makes gstreamer happy with h265.
> 
> Please pull.
> 
> 
> The following changes since commit 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:
> 
>   media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2
> 
> for you to fetch changes up to 3e11851d16ea7eff1cfa66b1cb7b35967876dd1e:
> 
>   media: venus: Add support for H265 controls required by gstreamer V4L2 H265 module. (2019-04-01 10:44:05 +0300)
> 
> ----------------------------------------------------------------
> venus for 5.2
> 
> ----------------------------------------------------------------

Not sure why, but I'm not able to pull from it. It complains about some
issues with your gpg key, and the diffstat is not there...

I suspect that the e-mail was only partially sent.

Thanks,
Mauro
