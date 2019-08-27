Return-Path: <SRS0=pW3C=WX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB168C3A5A3
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 16:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FB120679
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566924530;
	bh=w9Iyt0uDJB8SCbKjdT8p35IYrioC+E5kShi7p63tayA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CDUz0d1FOUdyxTDi4MS1vvyznxYOtWv3Xt3iWHQvWVHdpfFwadwDwdbnWunl7rmBb
	 ywATMSSMWHF+GW8XDFHOt9yzOakT1AJfuQ9jpgyvu4NDq2LNcCpsUZ0yhL8baRmUn8
	 D39ZxQXOiAkTRaGeUUXQ36XNs7xAVknUa/eH56CY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0Qst (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:48:49 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41047 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfH0Qst (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Aug 2019 12:48:49 -0400
Received: by mail-oi1-f181.google.com with SMTP id p127so6882874oic.8;
        Tue, 27 Aug 2019 09:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wEdejl/3E6RvnYGJ/kyyb0K7QYCM4jHZSEvI4UNoUac=;
        b=UqvNKXEsdBel3rQlzN+Dq+YDL6PHDkPh5RT8JB81DT/l19nAHKM3t4SIuRzfHxefLC
         AURU9ReQdbjtohWOaKy2uHnFjCz0Il0Sk4XyH8/hnjjIuCByjfVIKAU1c2plZmJ2pR6k
         WnOK9imYU3mMr/UlpeOhsFGxK2Jkq/f1PAwEr9BilbNTryFh8ydW4Me1WZk2sYyxpzRJ
         ynqI4hjYU8K3MVzhRVi09edDA7N1UzeihiNWjNxcUBferuVGQHzBgRK3n3A2kfIZHEg/
         4sMGZnuUPyS5K/XfXyHesxqtXNCkryTLBN/SP+ztdB0BGMc4pVp1CduheIhUC6frO07d
         BpSw==
X-Gm-Message-State: APjAAAV6/UOcPW/6yJYz7/bcxbbiD3oVMWlAuvocangm5W8mHMIYko+Q
        /UR20DSN9O82ccU3Fl01Cw==
X-Google-Smtp-Source: APXvYqzDA2MsllrIzZyZtTCdbxjTgfn8lArwxLtk/7tMd9XzM3rUeQZ5LI+JOL8LFk7i+hNoJ0Tnow==
X-Received: by 2002:a54:4788:: with SMTP id o8mr16933180oic.100.1566924528431;
        Tue, 27 Aug 2019 09:48:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm4253147oic.6.2019.08.27.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:48:47 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:48:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     dongchun.zhu@mediatek.com
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        sakari.ailus@linux.intel.com, drinkcat@chromium.org,
        tfiga@chromium.org, matthias.bgg@gmail.com, bingbu.cao@intel.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sj.huang@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        louis.kuo@mediatek.com, shengnan.wang@mediatek.com,
        dongchun.zhu@mediatek.com
Subject: Re: [V3, 1/2] media: dt-bindings: media: i2c: Add bindings for
 OV02A10
Message-ID: <20190827164847.GA22619@bogus>
References: <20190819034331.13098-1-dongchun.zhu@mediatek.com>
 <20190819034331.13098-2-dongchun.zhu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819034331.13098-2-dongchun.zhu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 19 Aug 2019 11:43:30 +0800, <dongchun.zhu@mediatek.com> wrote:
> From: Dongchun Zhu <dongchun.zhu@mediatek.com>
> 
> Add device tree binding documentation for the OV02A10 camera sensor.
> 
> Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
> ---
>  .../devicetree/bindings/media/i2c/ov02a10.txt      | 54 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ov02a10.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
