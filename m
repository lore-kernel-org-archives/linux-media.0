Return-Path: <SRS0=8AJ+=V7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72800C433FF
	for <linux-media@archiver.kernel.org>; Sat,  3 Aug 2019 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452842075C
	for <linux-media@archiver.kernel.org>; Sat,  3 Aug 2019 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564836579;
	bh=NDVOJaknX1qztcBJGFnZcF6TJkWE7k/t6XgKJeTkciY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a1974bzgJLXJEHLqeATHVPUVDk2hKabFv9TIQnm0zf2TfiDFADbQWWw8mOH5FUlsc
	 lDHQmBXfbVK7J6Gw0+WuKiVub9+sJUb8Ffs4yv412cQYE74mUidRsDyGx+8hMvSrjX
	 sZR0Oa+iamvdZqkWcKxEmSfTLWrM5FHBIVVIkqSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390761AbfHCMti (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 3 Aug 2019 08:49:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbfHCMti (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Sat, 3 Aug 2019 08:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=clsLOA6WMhirNbK5w+Om4GaDi7e45HhAECiH5gv+EHA=; b=dXADn0+WjoimxGFg2+068+N+u
        EJgzb/zxBQONAoeAoSSaC7qsLrkuv4GzLcedV/gqAlUqI1ZaEqOBNo8N2M4Lh5/a1e4yJaW2asvw0
        sBwNVy0VeprM7fv9Yry5VMxZ5x+yl1Pu3fu+c6sQSS6BljKzcyiqfMwYMU7JHrQ8yxzq3mUjzpz59
        uUF3B0LOcMYtwGqnHG5BI4B3i/Y8u33HwHO6w/ikpj6pxtxo4fUnxdF/e8ZPg1gkidmQqFAKBWzwq
        ALV77digzVvmEN23xhV6KXv4zPNDaDRKexchO+22tah7hygxNIu8VuWQzoNQkNz92aixPSCYTh4JR
        +h8X/oK/w==;
Received: from [191.33.150.100] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1httTd-0004tu-1T; Sat, 03 Aug 2019 12:49:37 +0000
Date:   Sat, 3 Aug 2019 09:49:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org
Subject: Re: [GIT PULL for v5.4] Venus updates - stateful decoder
Message-ID: <20190803094933.46f30732@coco.lan>
In-Reply-To: <20190803115807.27655-1-jenkins@linuxtv.org>
References: <20190802145430.843-1-stanimir.varbanov@linaro.org>
        <20190803115807.27655-1-jenkins@linuxtv.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Stanimir,

Em Sat,  3 Aug 2019 11:58:07 +0000
Jenkins <jenkins@linuxtv.org> escreveu:

> From: builder@linuxtv.org
> 
> Pull request: https://patchwork.linuxtv.org/patch/57868/mbox/
> Build log: https://builder.linuxtv.org/job/patchwork/866/
> Build time: 00:04:24
> 
> Summary: 1 issues, being 0 build regressions
> 
> Error/warnings:
> 
> patches/0009-venus-make-decoder-compliant-with-stateful-codec-API.patch:31: WARNING: please, no space before tabs
> patches/0009-venus-make-decoder-compliant-with-stateful-codec-API.patch:41: CHECK: Please don't use multiple blank lines
> patches/0009-venus-make-decoder-compliant-with-stateful-codec-API.patch:139: CHECK: Please don't use multiple blank lines
> 
> Error #256 when running ./scripts/checkpatch.pl --terse --mailback --no-summary --strict patches/0009-venus-make-decoder-compliant-with-stateful-codec-API.patch

Please fix the above warnings on your pull request.

Thanks,
Mauro
