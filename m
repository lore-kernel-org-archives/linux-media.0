Return-Path: <SRS0=wOjJ=UD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DBC282CE
	for <linux-media@archiver.kernel.org>; Tue,  4 Jun 2019 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4FA2070D
	for <linux-media@archiver.kernel.org>; Tue,  4 Jun 2019 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559669225;
	bh=NB/vh4xNQ38JqMpVh8oE4G/XSNXK/VjUU1qXijmswEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YN2oUmgaAY2wGa7eocd4Cjl4VREI+IWpu1dMFtsSRUZtDHqjAsQMvp0UxTUHV39nj
	 FAVPhpHg6txSCM64X+nEkRAMabo2s63XsKntye90hOCz6z1ifkQymI2KAO0dzFPR/1
	 bnOHFHo1snNt99Rxx4n5NJVQaImkv0Fo4BCa4y8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFDR1F (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:27:05 -0400
Received: from casper.infradead.org ([85.118.1.10]:52180 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfFDR1F (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 4 Jun 2019 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XMcuRt8xk+V5i8CBO7LPCXgXeLYsVgUlbtBr2jA08Js=; b=Jor5WbmtFlTls4yC9v19+pr9Ka
        x0EzNQwdou/6sX9YZB2nZiDXNbOPLYUUIXq/qieFDxzUZMRuvz2aVoDePklavYDvhyPbqcll2sh19
        ze92kyLuNTk4xL2g7t8oqnUOvkQiVUBs2mpl4akv62VL92JveK2UgAgYIFMXajcFa4Hu6MapvEKSx
        UWWnPtZkhqWNO09qJ/YgJBiukiqbx7UYZ3g9voQJYJy6MdDv6xlFTQZrs+OmIK1iuSnb6PioPsP5q
        +xxAB2+j9k2m7ppp/mZzBgpMRZ+rBS8Qv4Lra6pMi+1KLLPwl5EOMHxasde9wEpq9fXhpnmCJZ+TL
        uHdijBzQ==;
Received: from [179.182.172.34] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYDDD-0006zE-5X; Tue, 04 Jun 2019 17:27:03 +0000
Date:   Tue, 4 Jun 2019 14:26:58 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     linux-media@vger.kernel.org
Subject: Re: [RFC] Documentation clarifications
Message-ID: <20190604142658.0ea99881@coco.lan>
In-Reply-To: <e9d01085-168f-2cd8-9aef-e8b632489b8e@free.fr>
References: <e9d01085-168f-2cd8-9aef-e8b632489b8e@free.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Tue, 4 Jun 2019 18:41:44 +0200
Marc Gonzalez <marc.w.gonzalez@free.fr> escreveu:

> Not sure about these changes, hence the RFC (some are quite trivial)

Looks ok to me. You should submit it as a patch, though, with your SOB.

See https://linuxtv.org/wiki/index.php/Development:_How_to_submit_patches.

> 
> diff --git a/Documentation/media/kapi/dtv-core.rst b/Documentation/media/kapi/dtv-core.rst
> index ac005b46f23e..9a74b8ba64b7 100644
> --- a/Documentation/media/kapi/dtv-core.rst
> +++ b/Documentation/media/kapi/dtv-core.rst
> @@ -11,8 +11,8 @@ Digital TV devices are implemented by several different drivers:
>  
>  - Frontend drivers that are usually implemented as two separate drivers:
>  
> -  - A tuner driver that implements the logic with commands the part of the
> -    hardware with is responsible to tune into a digital TV transponder or
> +  - A tuner driver that implements the logic which commands the part of
> +    the hardware responsible for tuning into a digital TV transponder or
>      physical channel. The output of a tuner is usually a baseband or
>      Intermediate Frequency (IF) signal;
>  
> diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
> index 881ca461b7bb..8e47411cf1d9 100644
> --- a/include/media/dvbdev.h
> +++ b/include/media/dvbdev.h
> @@ -86,8 +86,8 @@ struct dvb_frontend;
>   * @priv:		private data
>   * @device:		pointer to struct device
>   * @module:		pointer to struct module
> - * @mfe_shared:		mfe shared: indicates mutually exclusive frontends
> - *			Thie usage of this flag is currently deprecated
> + * @mfe_shared:		indicates mutually exclusive frontends.
> + *			Use of this flag is currently deprecated.
>   * @mfe_dvbdev:		Frontend device in use, in the case of MFE
>   * @mfe_lock:		Lock to prevent using the other frontends when MFE is
>   *			used.



Thanks,
Mauro
