Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B1C10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5DB2084B
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556193913;
	bh=tihB706G7fEOfjOzClATiswR4e3PanmdrkR+Y5BKJbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0dtofQDEaQ6tisaPviHXDnLhY0T454EKnwjy+AgqEltYJmqnxFcrxsFaehUqHsQRQ
	 z6TL6P4kLO4ifaGKdA063f2mE0l/gP05//jdpqRKnr96+Z8Af1XkWFPK9QwKaX4sag
	 uRC1/Wfj6uXH6hliUfTByc6lOXXDJOKIoq8gUuhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfDYMFM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:05:12 -0400
Received: from casper.infradead.org ([85.118.1.10]:51708 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfDYMFM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 08:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l5zubg47LGtkQnlzT44RKkICtvuzMTeVkntFV9l5K50=; b=CYIUU8gCg7DsGNVP+pJAKJZjHW
        Z60RIIAiXRtJIIc1sBgttDwLU4XM7OKP22KPk64jN+UXCUlyyN6JelX9Wv4dyXhxITQjOMXxbsdeu
        Ity6zMIhJcTxVTph3Te//+4cB5y3x668BXScsnbYYA7I5zdqe0Hu18i3OL0RF3iFh9/A5nt3LqbaU
        npzdXBcPE4d+WuJFcKqdUQ4qCXYXCjGOYtTRxd+BQzaH7+ybrudAYRtl+7ToF96OKIy0KfAkuhXrC
        S2CJf1hm0E78CzxkUC1dyA9iqq2Mi6VHxscc+mEHq8XL/ERmbW0xnoDgpzaiOzfOtBNEd6oO0m0Js
        VwQQf4cQ==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJd7l-0007NC-9J; Thu, 25 Apr 2019 12:05:09 +0000
Date:   Thu, 25 Apr 2019 09:05:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     =?UTF-8?B?0KDRg9GB0LvQsNC9INCY0LbQsdGD0LvQsNGC0L7Qsg==?= 
        <lrn1986@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [PATCH 0/8] [PATCH for ZBar] MinGW compatibility patches
Message-ID: <20190425090505.69d7685b@coco.lan>
In-Reply-To: <20190409123842.19600-1-lrn1986@gmail.com>
References: <20190409123842.19600-1-lrn1986@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue,  9 Apr 2019 12:38:34 +0000
=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD =D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=
=D1=82=D0=BE=D0=B2         <lrn1986@gmail.com> escreveu:

> Here's a few patches that might be useful.
>=20
> =D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD =D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=
=D1=82=D0=BE=D0=B2 (8):
>   Include windows.h for vfw
>   Specify correct path to barcode.png
>   Check for clock_gettime on pthread library as well
>   Disable zbarcam-gtk on Windows
>   Use -no-undefined for libzbargtk
>   Make zbargtk build on Windows
>   Make use of glib thread names
>   Correctly generate version.xml and reldate.xml

Thank you for the patches. Applied today, and launched a new
ZBar version (0.22.1) with the build corrections.

>=20
>  Makefile.am             |  2 +-
>  configure.ac            |  8 ++++----
>  gtk/Makefile.am.inc     |  2 +-
>  gtk/zbargtk.c           | 12 +++++++++++-
>  zbarcam/Makefile.am.inc |  2 ++
>  5 files changed, 19 insertions(+), 7 deletions(-)
>=20

Thanks,
Mauro
