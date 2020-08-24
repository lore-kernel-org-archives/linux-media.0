Return-Path: <SRS0=Edv6=CC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B4C433E3
	for <linux-media@archiver.kernel.org>; Mon, 24 Aug 2020 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC22207DF
	for <linux-media@archiver.kernel.org>; Mon, 24 Aug 2020 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="EDrrfMRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgHXIvc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:51:32 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:56931 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgHXIva (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 24 Aug 2020 04:51:30 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id A8CNkNXrmuuXOA8COk1adn; Mon, 24 Aug 2020 10:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1598259088; bh=ceRb7TivxlafITlVuyAamsIq3ParWm9YhbH2GeRwJB4=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=EDrrfMRwy3IsrIS/z6wfrW7juZ+kQztDBfJRE/Qbbt3IrAFmuOKxydbk0vm1FRG+g
         sX/D8HJCHKthrhve6F38Jc2486WzN+QcpBK9v8zwpLkyPBksA/MVUmhYuWWVymXjQn
         Rhdwnm6TTsqMfMN6y7rpMVGp/SXeN8qqFjRfpCKGiS8BQiuXArVhPjIVcCHeHOD9De
         y1yfY4QurDZm//PPNlXDFPo++9KanB+AiBtwpw6oAOnh4Wr+y3TNXr9xAXTgk1UR5F
         z4xIYuF2RfIqZWFGKdpitORifXbcHQhsh67MF0bcKjIHs5TqrCSubK6xQu0/ZtLX2y
         yS44hfHyQFXyA==
Subject: Re: [PATCH] configure.ac: Add --without-libudev option to avoid
 automagic dep
To:     James Le Cuirot <chewi@gentoo.org>, linux-media@vger.kernel.org
References: <20200823164744.6191-1-chewi@gentoo.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <79c5bdb0-4082-7a3b-d614-4f87bf61f01c@xs4all.nl>
Date:   Mon, 24 Aug 2020 10:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823164744.6191-1-chewi@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOTOIBj9j3ai3/FvUvts9OJPIYLoeA0RriZlqRhonKukqgZRk4bCIjLdXc7C0NPUMSB2cIn/8AWSawyJUFWb8w6vZbFjgRR3XEo6cTxX2i1L897Bzn6l
 coZgiIFv6XlkX95tM3UuZPXxDj46Dkr/Mp6c32qabuKkz4EYER3D1TyJ4U+tw2US8CkBmUX9rSl4R71AF6yAO5qhQF1BSS/vPA2uKMO+uZu5uOm9TIisrufZ
 xeDquFD5q5fM3kNBWTRn8bRf4F7QFqskEpOt0tZNINDxOOHLkZfLJrp/raJJIP6AYIWjltvvpJegOmlQUiy/gw==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi James,

Can you elaborate a bit more in the commit log text? It's not clear to
me what you mean with 'avoid automagic dep' or why you want to avoid it.

Regards,

	Hans

On 23/08/2020 18:47, James Le Cuirot wrote:
> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> ---
>  configure.ac | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d9f43ab5..e6134d08 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -291,16 +291,23 @@ else
>     AC_MSG_WARN(ALSA library not available)
>  fi
>  
> -PKG_CHECK_MODULES(libudev, libudev, have_libudev=yes, have_libudev=no)
> -if test "x$have_libudev" = "xyes"; then
> -	AC_DEFINE([HAVE_LIBUDEV], [], [Use libudev])
> -	LIBUDEV_CFLAGS="$libudev_CFLAGS"
> -	LIBUDEV_LIBS="$libudev_LIBS"
> -	AC_SUBST(LIBUDEV_CFLAGS)
> -	AC_SUBST(LIBUDEV_LIBS)
> -else
> -   AC_MSG_WARN(udev library not available)
> -fi
> +AC_ARG_WITH([libudev],
> +            AS_HELP_STRING([--without-libudev], [Do not use udev library]),
> +            [],
> +            [with_libudev=yes])
> +
> +have_libudev=no
> +
> +AS_IF([test "x$with_libudev" != xno -o "x$enable_libdvbv5" != xno],
> +      [PKG_CHECK_MODULES(libudev, libudev, have_libudev=yes, [])
> +       AS_IF([test "x$have_libudev" = xyes],
> +             [AC_DEFINE([HAVE_LIBUDEV], [], [Use libudev])
> +              LIBUDEV_CFLAGS="$libudev_CFLAGS"
> +              LIBUDEV_LIBS="$libudev_LIBS"
> +              AC_SUBST(LIBUDEV_CFLAGS)
> +              AC_SUBST(LIBUDEV_LIBS)],
> +             AC_MSG_WARN(udev library not available)
> +            )])
>  
>  AC_SUBST([JPEG_LIBS])
>  
> 

