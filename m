Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3964DC43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDFC206E0
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556291631;
	bh=uQOqjOF9ezd29pSnh2vTWWhTDe8HHK2/JyWFAOes8L0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ANDFjfbQfaHDAysjNqActj4LLm/LI7i9WfByjcvR+Kx7LMvXYK82ZdRSJpAN/U+hX
	 KVGcvdRZzvxO3WFDZxvdbiNB73GvOQLls+VKfe3jwZVit2hX3x0whQqe7iebe1o/TI
	 gl9q8/eSeyv95cSSA1Cgro58bJ/7Bfaa6V0T3QcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDZPNu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:13:50 -0400
Received: from casper.infradead.org ([85.118.1.10]:46420 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfDZPNt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 11:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RV1vtieW+Y/A/E6MnvjqEeDvTs1q8U+nVjxcgXA8XnE=; b=UH0wbkV+TN3P2VSyyq3QJhjvtj
        4W12fyCBeQHA3+/29eoCm4QKNb2oUSCuR9RcgiD3avWMRnOgw0348cIhUM8ELATHn8nDGwNry3v2m
        L66dG+s5AH3E+CD57ml40V/GzzhpRVgVy3EsQKp6u+YoGlv+HteGqYZA9yLn1aCeqrz1UAyG2qUa/
        0yXt/uZ4RRJDXTaVzvg5KwOLTbKBP2E4PoxK9OPOTLG+0QKrr7/TKKKM1EZfbjfd3SVNazaxKRO/O
        DKOSZ5bXSC4uqWa7rPRLGgVS7PQgI8700W1sFTgaT8VNWsTGA2UeogWwzRyCqoyByq+Ygy3pDC5Da
        LyuKLasg==;
Received: from [179.95.39.209] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK2Xr-0006pr-T5; Fri, 26 Apr 2019 15:13:48 +0000
Date:   Fri, 26 Apr 2019 12:13:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org, Gregor Jasny <gjasny@googlemail.com>
Subject: Re: [PATCH v4l-utils] libdvbv5: leaks and double free in
 dvb_fe_open_fname()
Message-ID: <20190426121344.510ef576@coco.lan>
In-Reply-To: <20190317163220.1881-1-sean@mess.org>
References: <20190317163220.1881-1-sean@mess.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Sun, 17 Mar 2019 16:32:20 +0000
Sean Young <sean@mess.org> escreveu:

> dvb_fe_open_fname() takes ownership of fname if the function succeeds, but
> also in two of the error paths (e.g. if the ioctl FE_GET_PROPERTY fails).
> 
> Adjust dvb_fe_open_fname() so it copies fname rather than taking ownership
> (and passing that to params). This makes the code cleaner.

Just reverted this patch from stable-1.16, as it breaks Kaffeine.

There are two reports about the issue:

	https://bugs.kde.org/show_bug.cgi?id=406145
        https://bugzilla.redhat.com/show_bug.cgi?id=1695023

I was able to reproduce it locally.

So, better to keep a possible memory leak than to cause apps
to not function anymore.

> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  lib/libdvbv5/dvb-dev-local.c |  2 +-
>  lib/libdvbv5/dvb-fe.c        | 18 ++++++++----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/libdvbv5/dvb-dev-local.c b/lib/libdvbv5/dvb-dev-local.c
> index e98b967a..2de9a614 100644
> --- a/lib/libdvbv5/dvb-dev-local.c
> +++ b/lib/libdvbv5/dvb-dev-local.c
> @@ -467,7 +467,7 @@ static struct dvb_open_descriptor
>  			flags &= ~O_NONBLOCK;
>  		}
>  
> -		ret = dvb_fe_open_fname(parms, strdup(dev->path), flags);
> +		ret = dvb_fe_open_fname(parms, dev->path, flags);
>  		if (ret) {
>  			free(open_dev);
>  			return NULL;
> diff --git a/lib/libdvbv5/dvb-fe.c b/lib/libdvbv5/dvb-fe.c
> index 5dcf492e..7f634766 100644
> --- a/lib/libdvbv5/dvb-fe.c
> +++ b/lib/libdvbv5/dvb-fe.c
> @@ -133,7 +133,6 @@ struct dvb_v5_fe_parms *dvb_fe_open_flags(int adapter, int frontend,
>  					  int flags)
>  {
>  	int ret;
> -	char *fname;
>  	struct dvb_device *dvb;
>  	struct dvb_dev_list *dvb_dev;
>  	struct dvb_v5_fe_parms_priv *parms = NULL;
> @@ -153,7 +152,6 @@ struct dvb_v5_fe_parms *dvb_fe_open_flags(int adapter, int frontend,
>  		dvb_dev_free(dvb);
>  		return NULL;
>  	}
> -	fname = strdup(dvb_dev->path);
>  
>  	if (!strcmp(dvb_dev->bus_addr, "platform:dvbloopback")) {
>  		logfunc(LOG_WARNING, _("Detected dvbloopback"));
> @@ -161,14 +159,10 @@ struct dvb_v5_fe_parms *dvb_fe_open_flags(int adapter, int frontend,
>  	}
>  
>  	dvb_dev_free(dvb);
> -	if (!fname) {
> -		logfunc(LOG_ERR, _("fname calloc: %s"), strerror(errno));
> -		return NULL;
> -	}
> +
>  	parms = calloc(sizeof(*parms), 1);
>  	if (!parms) {
>  		logfunc(LOG_ERR, _("parms calloc: %s"), strerror(errno));
> -		free(fname);
>  		return NULL;
>  	}
>  	parms->p.verbose = verbose;
> @@ -183,7 +177,7 @@ struct dvb_v5_fe_parms *dvb_fe_open_flags(int adapter, int frontend,
>  	if (use_legacy_call)
>  		parms->p.legacy_fe = 1;
>  
> -	ret = dvb_fe_open_fname(parms, fname, flags);
> +	ret = dvb_fe_open_fname(parms, dvb_dev->path, flags);
>  	if (ret < 0) {
>  		dvb_v5_free(parms);
>  		return NULL;
> @@ -203,7 +197,6 @@ int dvb_fe_open_fname(struct dvb_v5_fe_parms_priv *parms, char *fname,
>  	fd = open(fname, flags, 0);
>  	if (fd == -1) {
>  		dvb_logerr(_("%s while opening %s"), strerror(errno), fname);
> -		free(fname);
>  		return -errno;
>  	}
>  
> @@ -224,7 +217,12 @@ int dvb_fe_open_fname(struct dvb_v5_fe_parms_priv *parms, char *fname,
>  		}
>  	}
>  
> -	parms->fname = fname;
> +	parms->fname = strdup(fname);
> +	if (!parms->fname) {
> +		dvb_logerr(_("fname calloc: %s"), strerror(errno));
> +		return -errno;
> +	}
> +
>  	parms->fd = fd;
>  	parms->fe_flags = flags;
>  	parms->dvb_prop[0].cmd = DTV_API_VERSION;



Thanks,
Mauro
