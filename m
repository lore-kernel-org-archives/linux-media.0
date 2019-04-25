Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28FC43218
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318DB2084F
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556203585;
	bh=d0u2IertS1XZjlbmqB+WsXI+gm69/4sLylG5NEX/JfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VTFbchd4PIh1hm5LSHNrUMlOYjGW2IUc5fPAmGylQUPcYfeAki9qIQ+tUmY+hAj2p
	 H6fmR5BJwU/Db8dxzC50GgaRyrbFAOORkOtAm3rB2kXGd1pfnmwGkniL316UyVpAYH
	 2K84dp8GMdDepC1/g+J1vPUosM2Pz/HGgv9G/baw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfDYOqY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:46:24 -0400
Received: from casper.infradead.org ([85.118.1.10]:37354 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDYOqY (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KAZitFzQYekUcpEQytKtF4AF4mIIKjbLf23L6FYRTxo=; b=VwQKZL8jr0kJjXEryf4VquXnv/
        4GLmu7nO+DpbXEtmsImxRvVMiWPLPYo1BRK8KEMQPHm6+wLpsnNGBV7caHyZ6dqBAJHT+c/J6GEZU
        NtRIgbqH0d9MpHVwhsswfUSRnZ/AjfIvpDapT/Ac8D4c20AeQO3CQcU7i6VhGQPFmaJAD85Pf1x64
        F/Ujw70sNyKTMSHz/xakxLC33tc2hiNGJIvvcsdxX7KXIWlje6WWO1PNJ225AI6rsrm6tZHFopBWN
        Z5CFk32NDQh/nhVQDcHt0eZpAzAi/AvUjbES/Ow6jt1sIowAZq8e/O8m8dRaxwzc0WGob+sStK0P2
        yYPxgrtw==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJfdm-00059l-2O; Thu, 25 Apr 2019 14:46:22 +0000
Date:   Thu, 25 Apr 2019 11:46:18 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org
Subject: Re: [GIT PULL for v5.2] Venus updates - take2
Message-ID: <20190425114618.1fefb0e8@coco.lan>
In-Reply-To: <20190423140702.26044-1-stanimir.varbanov@linaro.org>
References: <20190423140702.26044-1-stanimir.varbanov@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 23 Apr 2019 17:07:02 +0300
Stanimir Varbanov <stanimir.varbanov@linaro.org> escreveu:

> Hi Mauro,
> 
> Here is the second attempt.
> 
> Added two more fixes for Venus v4 properties and dynamic buffer mode.
> 
> Please pull.
> 
> The following changes since commit 26d5d1fe53e966efe567e9773d1158baef303e3b:
> 
>   venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/svarbanov/media_tree.git tags/venus-for-5.2-take2
> 
> for you to fetch changes up to 26d5d1fe53e966efe567e9773d1158baef303e3b:
> 
>   venus: helpers: fix dynamic buffer mode for v4 (2019-04-23 15:57:17 +0300)
> 
> ----------------------------------------------------------------
> Venus updates for v5.2
> 
> ----------------------------------------------------------------

There's something really weird here... It should be showing above the
patches applied to your tree, but, instead, it doesn't show any
patch on the above summary. It is like your tree doesn't contain
any new patch, just the stuff that were already merged on my
tree.

I suspect that you're passing some weird argument to 
git pull-request, as it is saying:

> The following changes since commit 26d5d1fe53e966efe567e9773d1158baef303e3b:
				     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> for you to fetch changes up to 26d5d1fe53e966efe567e9773d1158baef303e3b:
				 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

See?

It is requesting me to pull an empty set of patches, as the git
reference is identical! There's not between 26d5d1fe5..26d5d1fe5!!!

As my import script uses those references, it gets an empty number of
patches to merge.


Thanks,
Mauro
