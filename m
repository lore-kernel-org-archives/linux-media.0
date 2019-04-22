Return-Path: <SRS0=+FiN=SY=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D79C10F11
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEB9214AF
	for <linux-media@archiver.kernel.org>; Mon, 22 Apr 2019 17:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555954438;
	bh=p91EbMtfuRn07xHlvnnEAJjEFLUen/WK38oMPVsYmIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OQs7dCxb5OO9M1xAwArhw+jIy002JjPoHvek20uHVztDQzVOsiAriDEm87g7/mymU
	 Q9P/pZaflIV/l9wcQ09jwIOi4aHRQ4G5ZUHHC1mrRrsiDy1b6vFXn+soa5Huivn+Fd
	 34/ElHoFGw8CJWcW7Wguy3rpTTq0JmaRSX2XX2cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDVRd5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:33:57 -0400
Received: from casper.infradead.org ([85.118.1.10]:41526 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRd4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Apr 2019 13:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/KaNyzfV6LTyLVoAMzqFv4nQhsueYT0lEy/VknSVvYg=; b=VsD4qWYrrrgTG7Q1o0k6SCdzrZ
        nwZuhFu7KSWRZl4QiAR1EHhEjPT7G14A43IkR5lvkcWL2D4ElYvZiVvMvcnSqxsI4W07BVmWsbnFl
        FbTj5My40SYdH83FRIHzSBoMz2iSLLhfDHeRA6w/9Hu7bFRyf3RPPUtxfHe2dgNJIrffeGQaMT/0u
        G/g9COTQJox9cqKdvJfgA0jwb7C4NY6ZDZ+1tNeBBVCmLzJs8hlu2RJHwChcmmlAAUM2EhAwhh3t6
        yMlwojfz0Ou0dskw7786dzXBwGMoxJHpZKg5QqU2/UUAc1qavi59yGlkoUCP+2Fpup+38yxyONnOS
        fRsgrLsQ==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIcpF-000297-T9; Mon, 22 Apr 2019 17:33:54 +0000
Date:   Mon, 22 Apr 2019 14:33:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [GIT PULL FOR v5.2] cedrus: add H.264 support
Message-ID: <20190422143349.53e8da3f@coco.lan>
In-Reply-To: <5356eed6-6bf0-49ab-32e1-7e632c3e4328@xs4all.nl>
References: <5356eed6-6bf0-49ab-32e1-7e632c3e4328@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Hans,

Em Fri, 12 Apr 2019 14:07:45 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:
> 
>   media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)
> 
> are available in the Git repository at:
> 
>   git://linuxtv.org/hverkuil/media_tree.git tags/br-cedrus-h264
> 
> for you to fetch changes up to 496ab402ea2cb3b0ebba3d0e699e0454b611c820:
> 
>   media: cedrus: Add H264 decoding support (2019-04-12 13:32:21 +0200)

Could you please rebase this one on the top of the media tree?

It came with some conflicts. Perhaps some of the patches here were
(partially?) applied already, as when I tried to fix the conflict,
it complained that some switch would have a duplicated case.

Regards,
Mauro

Thanks,
Mauro
