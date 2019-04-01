Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20630C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15D7206B8
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="bbK0WNNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfDAHju (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:39:50 -0400
Received: from mail2.skidata.com ([91.230.2.91]:45842 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfDAHju (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 1 Apr 2019 03:39:50 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 03:39:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1554104389; x=1585640389;
  h=to:cc:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=vSoEsYeNLRVj8KIPbCLDGSCGis3n1UtRvWgLmaRlRg0=;
  b=bbK0WNNxPiOH4yEisqwKfMUJk4azzUEGvodIkcdUXrglIbsjczeWbYE3
   IImPvE3NAdWnCF3QUm9rn5rOu5ouvU/CVPfgSDgwLxA2BsrzvhW4W4FUS
   4ZKNbMdiM6qkFEKiOfv87Vh2uH6AAoqe8BhIfytQ/KAxNILCtG0f8jI+Z
   bXBR4AXGEtZtW680kzYmXrxfciRCyH6EFOfzXTN2b1emp3u62wqHcaK/m
   2DyLtNJCBFu0kxAO63ZmsQ+fvlaWP2UBz9marpf9PgpRFY1I4cZfqPIg1
   S7jXStjUMWU4spt2nbiJ7fFFxoNv7Ce8FkxAAcEjpSgz/kUhyb4NO8PXr
   Q==;
IronPort-SDR: yQXxdov0TJmP87gNIHdAFVCUe0ynE+vjDGGRgFARfygXy8TS0+X/dThv4tXRK4V6TRs8buRWi9
 Kz87c2hBOWLOjm2euaqP7XsXb2OsqFOXy5S+R7vFgPUtrYQl4NDJfnWELABbJ7mTCHbCZwf5ie
 zPf4q3n0g8ajXFBHTj7WXxx/2QdjYapW3kN11D1CcgI3QK9TJq4mXhi9XdqQFGcw9TsV5dCITb
 J44ggv/vsQIYHGJhfXJ3LeYmgzbnjr+1EBMgoIfNnl3QWG4CQy7Jee02MV+HutHCcXT0V2Szv8
 JD0=
X-IronPort-AV: E=Sophos;i="5.60,295,1549926000"; 
   d="scan'208";a="2065211"
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
CC:     <linux-media@vger.kernel.org>
From:   Richard Leitner <richard.leitner@skidata.com>
Subject: Baseline for a new i2c sensor driver
Message-ID: <28fbaf9b-474b-5ad2-4bbe-0fcf138e4f78@skidata.com>
Date:   Mon, 1 Apr 2019 09:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.22]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello linux-media world,
I'm currently working on forward-porting and mainlining a i2c sensor 
driver and would like to know what would be the best reference to base 
this driver on?

Any hints would be greatly appreciated, thanks!

regards;Richard.L
