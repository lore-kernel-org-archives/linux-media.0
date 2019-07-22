Return-Path: <SRS0=6VSJ=VT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A2C7618F
	for <linux-media@archiver.kernel.org>; Mon, 22 Jul 2019 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E275218EA
	for <linux-media@archiver.kernel.org>; Mon, 22 Jul 2019 15:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563810980;
	bh=UdMPFHx/A3XPXsDRoeTAPumlZUv7oH68IF+K1UBNGLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=j/lp2UlNqrhKQWAkfbh3rcEfv+ODPg+bh+zoI/JaaTS2+hFl5CUi1F68olqleHQWE
	 ytWpQ5/SwKF9eHzSJGKb2FfGU4UihTeO46E5yL5MZxvwoG6aPBPCadPs/+CfgzcXmd
	 2g4jqRcqPTSwpdjZ+V1JDWevPLSUfGrQnQmNp2xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfGVP4U (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:56:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfGVP4U (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 22 Jul 2019 11:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CAzJDkQEF+zZ3EPLNqWPzICxo/kTEg65fS0d8UgYJ+s=; b=DLqFEh6XdjwyhiyLdrCUXChd2
        sf8s5YQyiGHPfIG3e7nbt0eUm/mJtwGtb5csrt0IpxQbK3IFinq950YhJHeOcop/JRVBxZ1eCpAQs
        YN78nh+hRWZ/7KC90ZVBPACyOmfUJu5wNW3lLbg2vCW7h3ZtgQGcShwHKIGPjtjecR37EYYv5vR02
        9fC729x6dDr5908hgSoTT0EwAaC8d90E2AkQ/l5Jc8vNix0cbqEZnnqDmzPJM0LpkzJ1XKf+VzxNt
        +xCFAZ+FGOVKLs3f940YASVM7jGRMxojwa25G01f+5KjrmxN9SgPsfC7sQD51bPmPFL9ULkPPO+88
        zqYGwxzJQ==;
Received: from 177.157.124.3.dynamic.adsl.gvt.net.br ([177.157.124.3] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpafh-0004dD-Sv; Mon, 22 Jul 2019 15:56:18 +0000
Date:   Mon, 22 Jul 2019 12:56:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [GIT PULL FOR v5.4] Fix device_caps, don't set fmt description
Message-ID: <20190722125614.53815ac0@coco.lan>
In-Reply-To: <9064bb69-03f1-02a3-fcc8-5010a506e0e5@xs4all.nl>
References: <9064bb69-03f1-02a3-fcc8-5010a506e0e5@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 22 Jul 2019 16:06:01 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> Contains these two patch series, rebased on top of v5.3-rc1

>       media/usb: don't set description in ENUM_FMT

Hmm...

trying to apply this on the top of upstream caused a lot of issues:

Applying patch patches/0002-0021-media-usb-don-t-set-description-in-ENUM_FMT.patch
patching file drivers/media/dvb-frontends/rtl2832_sdr.c
Hunk #1 FAILED at 998.
1 out of 1 hunk FAILED -- rejects in file drivers/media/usb/gspca/gspca.c
patching file drivers/media/usb/hdpvr/hdpvr-video.c
Hunk #1 succeeded at 984 with fuzz 2.
patching file drivers/media/usb/msi2500/msi2500.c
Hunk #2 FAILED at 890.
1 out of 2 hunks FAILED -- rejects in file drivers/media/usb/msi2500/msi2500.c
patching file drivers/media/usb/pwc/pwc-v4l.c
Hunk #1 FAILED at 867.
1 out of 1 hunk FAILED -- rejects in file drivers/media/usb/pwc/pwc-v4l.c
patching file drivers/media/usb/s2255/s2255drv.c
Hunk #3 FAILED at 723.
1 out of 3 hunks FAILED -- rejects in file drivers/media/usb/s2255/s2255drv.c
patching file drivers/media/usb/stk1160/stk1160-v4l.c
Hunk #2 FAILED at 342.
1 out of 2 hunks FAILED -- rejects in file drivers/media/usb/stk1160/stk1160-v4l.c
patching file drivers/media/usb/stk1160/stk1160.h
patching file drivers/media/usb/stkwebcam/stk-webcam.c
patching file drivers/media/usb/tm6000/tm6000-video.c
Hunk #2 FAILED at 869.
1 out of 2 hunks FAILED -- rejects in file drivers/media/usb/tm6000/tm6000-video.c
patching file drivers/media/usb/tm6000/tm6000.h
patching file drivers/media/usb/usbtv/usbtv-video.c
Hunk #1 FAILED at 630.
1 out of 1 hunk FAILED -- rejects in file drivers/media/usb/usbtv/usbtv-video.c

It doesn't seem you did a rebase on this branch
	git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.4a2

Thanks,
Mauro
