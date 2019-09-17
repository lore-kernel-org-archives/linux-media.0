Return-Path: <SRS0=qP1p=XM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D72DC4CEC9
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD5A214AF
	for <linux-media@archiver.kernel.org>; Tue, 17 Sep 2019 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568731456;
	bh=HTMBC4SZy4JO2Wyzi9EEQ1Kd66w4SXVS78NM2zLwhGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7JqVtZTZ5LrX2L3fjXgKY3KGBZ7wOzkXVllPkI/49eKgQzs67tWbRGHOjHZVlejv
	 HANLa4CwGBVuTHN+0hAH3TQ7FqqaWC0M2Y6wKzBs5flseX+Q5nUnbrZBh3I00OFaRQ
	 TXQj1u/0dKPzIk0MJykmp2rFIpBQdOg4/hTXSW7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfIQOoP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:44:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43474 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQOoP (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Sep 2019 10:44:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id b2so3242805otq.10;
        Tue, 17 Sep 2019 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwnK4pIMscJKpUNIH9WS0x8BYMP10RHEPdGsIe2GTK8=;
        b=PYNKuQAaOWrdwOfBpnoBY9uaYEUyHQWlfw2WVGAjqYHuBCcspR73OeIuRySWu+aor1
         RxCEcP9XM4lkgxhQb8FMxlyCZ9H21ueUd0uzrOBKqRPRW8RrKNpLIaaohOs/kjeorGwr
         I0ZbOHqOFW5lnZ/uY1tFZ/RVJP0o6l9swcBIrNxH+yk7WrRWGS57j+RLwSI1bCYFQzxC
         3n5pTW9Fo03I1bLb269OgTzazdnsRf0GiMWnSunZY0KpGaUJSSVWfNaPtN0uCHqrdiDM
         nD77yydSJa/ietvkzg6LP5NiHopXWRLNYhf4v/k0UZRwwPGt3Svika64Z3/nPowlqRiw
         Se8w==
X-Gm-Message-State: APjAAAXo2Qmq+ZPJHUrVX6f/Ci51yGn80sRBRVYjoOo7aERTg2UADKcK
        L3VOJiVIqOsBDZXRptXf+w==
X-Google-Smtp-Source: APXvYqx1FbLhv1a9jKgf5RMOiCVzoHqYD3Q5Wg9G+dwariWWOABAA7afzAC9ZFvbbyf6luvEOJZhug==
X-Received: by 2002:a05:6830:182:: with SMTP id q2mr2843274ota.175.1568731454272;
        Tue, 17 Sep 2019 07:44:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm721322otl.8.2019.09.17.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:44:13 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:44:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dongchun.zhu@mediatek.com, mchehab@kernel.org,
        mark.rutland@arm.com, drinkcat@chromium.org, tfiga@chromium.org,
        matthias.bgg@gmail.com, bingbu.cao@intel.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sj.huang@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        louis.kuo@mediatek.com, shengnan.wang@mediatek.com
Subject: Re: [V2, 1/2] media: dt-bindings: media: i2c: Add bindings for ov8856
Message-ID: <20190917144412.GA23952@bogus>
References: <20190910130446.26413-1-dongchun.zhu@mediatek.com>
 <20190910130446.26413-2-dongchun.zhu@mediatek.com>
 <20190910173743.GI2680@smile.fi.intel.com>
 <20190917120205.GO5781@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917120205.GO5781@paasikivi.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Sep 17, 2019 at 03:02:06PM +0300, Sakari Ailus wrote:
> On Tue, Sep 10, 2019 at 08:37:43PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 10, 2019 at 09:04:45PM +0800, dongchun.zhu@mediatek.com wrote:
> > > From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> > > 
> > > This patch adds device tree bindings documentation for the ov8856 CMOS
> > > image sensor.
> > 
> > New bindings in YAML, please.
> 
> My understanding is text documents are still fine.

Schema are preferred, but still up to the subsystem for now.
 
> We don't have things like graph.txt or video-interfaces.txt in YAML yet
> either.

That doesn't really matter too much. You can assume common properties 
will have a common schema and just define what's device specific. The 
device specific bindings have to define 'port' or 'port@N' nodes.

Rob
