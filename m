Return-Path: <SRS0=XatT=DC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2EC4727F
	for <linux-media@archiver.kernel.org>; Fri, 25 Sep 2020 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABCD22211
	for <linux-media@archiver.kernel.org>; Fri, 25 Sep 2020 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgIYSgI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:36:08 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:33710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729920AbgIYSgI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 25 Sep 2020 14:36:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0386C5010;
        Fri, 25 Sep 2020 18:36:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: story36_0500f6027169
X-Filterd-Recvd-Size: 1695
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Sep 2020 18:36:05 +0000 (UTC)
Message-ID: <4d9210df1c70dfa9a2de4372252d90f039cfe480.camel@perches.com>
Subject: Re: [PATCH RFT/RFC v2 11/47] staging: media: zoran: zoran_device.c:
 convert pr_x to pci_x
From:   Joe Perches <joe@perches.com>
To:     Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Fri, 25 Sep 2020 11:36:03 -0700
In-Reply-To: <1601058657-14042-12-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
         <1601058657-14042-12-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, 2020-09-25 at 18:30 +0000, Corentin Labbe wrote:
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[]
> diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
[]
> @@ -198,15 +198,14 @@ void detect_guest_activity(struct zoran *zr)
[]
>  	for (i = 0; i < j; i++)
> -		pr_info("%s: %6d: %d => 0x%02x\n", ZR_DEVNAME(zr),
> -			change[i][0], change[i][1], change[i][2]);


> +		pci_info(zr->pci_dev, "%6d: %d => 0x%02x\n", change[i][0], change[i][1], change[i][2]);

IMO: this change does little for readability or makes it worse.
Can you please keep to 80 columns where it's already 80 columns?


