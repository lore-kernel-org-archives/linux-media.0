Return-Path: <SRS0=Gh4I=23=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14D4C33C9B
	for <linux-media@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F312080A
	for <linux-media@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348448;
	bh=52I/ytr8y9cirx8LrY22EFRDoW9M0a1IhsQ6eg6oJeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HMEE1TpU2aee70Wax4ponZsF217j+YqfcwaxLpLV6lSmde+/uGhaS9fhBgWyv0Fy7
	 71IIkUPFMGzgmE2BJtWO/gxLOcmo+hM8zY7hJARgy+xOeQvVQ0efddUB+cHv/3To/I
	 3dnfrqp1EpTiCgFK0ekdmGB6rzTYJA3/WHv7td3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAFWH2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:07:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44958 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFWH1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jan 2020 17:07:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so16941457oia.11
        for <linux-media@vger.kernel.org>; Mon, 06 Jan 2020 14:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mX8Apg3ZN6eJo68XMUgHBKoUIUkBElk8pz2rAOhoL5k=;
        b=rLrZ3VtoDqgcT1FEStoi2Tichwc0MquoaML49SWIgFDijSy1BXAaByzqzKpz8aAuy5
         yk46/A2HmM0CVClrv/1Uk10PhXq+NPOmJ+BHLN2Fu3ympfzspoHpnbjH7HHwOCkPOh3x
         x5gUHXq0duHrDfVUpTBUDL0GxhtC/aRsnlMUtSclueIXgxDXErok9z6F/c1+xhCLf1/7
         gKrpuZ2ZH1Uza1t9ix7/3JGuMtRQwOthYQfAyFgsoVWE4wSv6dh5JmXIUVzZ0EcI/Ud8
         6yhpofDCPgtXS/AxMhDHT4Ub+S4D9xB+/KRQ4dyIFvYNOORkCditxgroQB7+pNAlOYUJ
         joTQ==
X-Gm-Message-State: APjAAAVEhe41isJs5JDeBhlMQmXT43UiSQTypqKoeeJdQBgyUgc14qXK
        hpa1cZojjWlYM4RtCeHwsL1w29s=
X-Google-Smtp-Source: APXvYqwCgVeDfqxyfG66lypJEraP21TaRCk2yLwSG9SvKRB5fdDrLS5Neq9Yk3/+kYlNJba3EcIhGg==
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr6732498oif.89.1578348446490;
        Mon, 06 Jan 2020 14:07:26 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id 6sm16608380oil.43.2020.01.06.14.07.25
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:07:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2207cd
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:07:25 -0600
Date:   Mon, 6 Jan 2020 16:07:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 09/12] dt-bindings: media: venus: Add sdm845v2 DT
 schema
Message-ID: <20200106220724.GA15963@bogus>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-10-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154929.4331-10-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon,  6 Jan 2020 17:49:26 +0200, Stanimir Varbanov wrote:
> Add new qcom,sdm845-venus-v2 DT binding schema.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,sdm845-venus-v2.yaml  | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
