Return-Path: <SRS0=JK+F=V3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2148C433FF
	for <linux-media@archiver.kernel.org>; Tue, 30 Jul 2019 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E99206A2
	for <linux-media@archiver.kernel.org>; Tue, 30 Jul 2019 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564503357;
	bh=BfBzWlo3UNykmQF2mkx9T4Qu+R/YsHpAkw02FK/ARAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Lv1fa7x8TULrOXXh4j0VI1CQiHFyuokUePBtk+Tm6GQJKcdTGkx9F3ZM0zP5wPQJT
	 VcLLtNCbvFY3HQvUA+Lac0WGdesfjnCXRPYdeDMqSgZwzujq25DUPm0Q+mgpGAr1H8
	 +h347VkCC5ahSdwpHSKwVuSD082BqE3ErLFT5LTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfG3QPx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:15:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbfG3QPx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 30 Jul 2019 12:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BfBzWlo3UNykmQF2mkx9T4Qu+R/YsHpAkw02FK/ARAw=; b=g7MEv5CvZSMTvgVln//QY5S9V
        qGGr4i/FPIFNEOzfWJ/XnXL1awvbG7bUy0fiebgzLYNSaZfyCXMdVFIsmKQU43/KZEsObQwL8YVjt
        Pe/LSSe2sJQkuPT7fkZRdF38y4NUnS33yriWDQ9pTVDfDb64LF6xLUSw0SP8ZxcH7PhWIrQTU1v3B
        wkPvIpgnPXqcLtKk74dcXD92zD9SbWbDi5EqsOEw4GxCAky6ff8+6ojGZ7WmZpKmQxCdRHiqZtgkT
        RBCoBCaKL/07qy7SgRtdPVNgUkWwvSjqUJlkETXvO5Wc0N0SQCcc4AgavheK4LmZMK6gvqb4PiACg
        2lcUsstBw==;
Received: from [177.157.101.143] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsUmx-0003iU-Ae; Tue, 30 Jul 2019 16:15:47 +0000
Date:   Tue, 30 Jul 2019 13:15:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     <gtk_ruiwang@mediatek.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: media: mtk-vcodec: Handle H264 error bitstreams
Message-ID: <20190730131541.40ce5ead@coco.lan>
In-Reply-To: <20190726085433.15612-1-gtk_ruiwang@mediatek.com>
References: <20190726085433.15612-1-gtk_ruiwang@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Fri, 26 Jul 2019 16:54:33 +0800
<gtk_ruiwang@mediatek.com> escreveu:

> From: gtk_ruiwang <gtk_ruiwang@mediatek.com>

...

> Signed-off-by: gtk_ruiwang <gtk_ruiwang@mediatek.com>

Please use your real name on your SOB and at the From: line.

Thanks,
Mauro
