Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22AC43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8894320679
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="IK6fU3V3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfD1UVj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 16:21:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39824 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfD1UVi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 16:21:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id q10so7464139ljc.6
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WivmGQO4RuW8PQL7FqfGRxyyPDqgN6IRsNst2/0ie+M=;
        b=IK6fU3V33/STF4ZfwSdX+5qiq4VJNlidyTzsCu/Z1nfYt2W7x0aDxy86bmbM1Tx3nz
         NxPQADhP7o40LazOf+hZjNUCIK59UprBGQ34wVbQwLfzJdHt0Sx7A/CC/kal0gqV1C0I
         iTy6vAzYXj7xrTi72tGHWXa46iu9zdmGYhaiKW9kn0Dlqtxg+QeoxxMXuFbbOrNyojlX
         umwJ8WDA6kvQMqrlIgV3r2KAIJbv4o+2DKGDQ8re8rdmTaON0g9Ra7MlivlRAawgAYnO
         CKVw95nSyWQ9nbpzzv/f6742peDCzJ5oZj3F9DpS1qsjJRv4tv2ITg/clcnhVm7wWvDd
         JTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WivmGQO4RuW8PQL7FqfGRxyyPDqgN6IRsNst2/0ie+M=;
        b=K1mt30szKuuIx3MWcXN3q86IccZenM32vH5yQsIfISYSpk8NRdnX+pTGtvoccxeiD1
         Ndg9QiMwjIloauuSe0FaN/8G+e/1VU6fVCHcLCNzto2kBV4UHPt/J9oS2Nb2jecdjMUG
         4lTMLm4PESNlTm2b4CeHf2H+tlxdbIZxEQux+aQAdVQZl9IZ0NN8A54CDVbILv1orOKP
         MaLXCLxVhZgnOWz9kMTT1tfufYLN94mmG7E8fv4ohI6yQLVD3fMBqbHUv7sn4vhTCkp4
         fQL8n7VQprVFvpcgO/8p1sOcNCbo+hB1DJXs7cM/Y4/Rl/juF/OAvZeNjedeQ7sUERIL
         ETlQ==
X-Gm-Message-State: APjAAAVQR1ofKEM5u1agCWuiDtpX6jP7PtPoZGJnaPbfYeN6/PjZSO/+
        RDE+GjmZ3rpoSUbmPZTzE2UIpA==
X-Google-Smtp-Source: APXvYqw/TNu1ZIHoFhah/0o8Yp9WqCWp3Q8bHghHrJKR586sMIvvkouMffjFXSNmffKQqsrav5Hk+g==
X-Received: by 2002:a2e:8905:: with SMTP id d5mr27807997lji.59.1556482896690;
        Sun, 28 Apr 2019 13:21:36 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e18sm6508281ljb.12.2019.04.28.13.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 13:21:35 -0700 (PDT)
Date:   Sun, 28 Apr 2019 12:57:40 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     arm-soc <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: Re: [GIT PULL] dts64 updates for v5.2
Message-ID: <20190428195740.37housyryoxv4p47@localhost>
References: <5ea296e5-92bd-5790-c075-cf4bcb74d88c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea296e5-92bd-5790-c075-cf4bcb74d88c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Apr 23, 2019 at 06:12:24PM +0200, Matthias Brugger wrote:
> Hi Anrd and Olof,
> 
> you can find below the pull request for mediatek related dts64.
> 
> Please have a look :)
> 
> Regards,
> Matthias
> 
> ---
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
> tags/v5.1-next-dts64
> 
> for you to fetch changes up to a4599f6ec8e844f53dac15f719084d3b5ffe68c3:
> 
>   arm64: dts: mt8173: add pmu nodes for mt8173 (2019-04-16 10:55:30 +0200)

Merged, thanks!


-Olof
