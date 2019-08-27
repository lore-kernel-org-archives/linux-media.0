Return-Path: <SRS0=pW3C=WX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7ABC3A5A3
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E552189D
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566921498;
	bh=WWpJ6i3XCHk+oU4FMOa03WyLCQS28RFJu0a+4zbMegU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTebH3q6Fw65eEc6MQI+kVjtsSOjs1K0UB9VgZlbYK3NkLFnDpKM8Wrfzw/mTSBe5
	 Q4puxnKlBOOKv2lGJFYTmyQ28sYrO1XDaKnrFNfzcZZymxNCw6rMzxoao821XDwnCb
	 bK4ZbwYUTwQoDbr6cpmWx6bN/egbbwQ406TmrtrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH0P6R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:58:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34490 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfH0P6R (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Aug 2019 11:58:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so19186018otp.1;
        Tue, 27 Aug 2019 08:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=acj7UIjHVuWuWn2QLV1FnPRCd5iCzDyxTRm5JLj04QI=;
        b=TrDv4EP12grRKSbzhTrNk6wFoC8bq/CNvDAXikutL3u1CCenonoutiyFUmtoCg/Zgq
         uW0fw19YALbWygXyOGbppTUtGTZ1G17E3G44h8m/9BITEEJYvMClNojuYdyjwrnHEGzo
         D2PPUw91lTj01qLcX0f2lubtFj9Iraffqn9gScuwQK7f2anoixfU9qNgdaoXK0WIgv4S
         yzO2C6+7uh2Yk0uEjsh5UYu09ZuQ5wmF9kr90F6JlkVNTnUbnwdjDX19vnO0wIDgfpxJ
         6VuuYm20dYcnwxTl9oKvmbw0Gg5ha7dAi7JUpMfkESkG7ngLZBIfTS/0HQzUzRKauFNm
         sTTQ==
X-Gm-Message-State: APjAAAV32GXyBt9qVDbB1Jkl4JbU8KMzDvAiTJPv8Qg024olsyQA+CPg
        9VGRT8NSB096hY/eIk4lwWPD+LY=
X-Google-Smtp-Source: APXvYqyjIH1Zo+lx6368vMEJ2REDUMdlSEZwfeHgMOaL4gsZ8ux8MkQl55qDn42mLa3z05FAdSZdRQ==
X-Received: by 2002:a9d:7515:: with SMTP id r21mr3504131otk.49.1566921496767;
        Tue, 27 Aug 2019 08:58:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s22sm4204272oij.37.2019.08.27.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:58:16 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:58:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: smiapp: Align documentation with
 current practices
Message-ID: <20190827155815.GA9693@bogus>
References: <20190813134518.5640-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813134518.5640-1-sakari.ailus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 13 Aug 2019 16:45:18 +0300, Sakari Ailus wrote:
> - The clock-lanes property is not needed for the sensors do not support
>   lane reordering. (The information possibly present in existing clock-lane
>   properties is simply not used.)
> 
> - There's no need to refer to the sensor device in the DT example, thus
>   remove the label.
> 
> - Rename the "camera" device node as "camera-sensor".
> 
> - Rename the endpoint label as "smiapp_ep" (was: "smiapp_1_1"). There is
>   in practice only one anyway.
> 
> - Remove the remote-endpoint documentation (it is covered by
>   graph.txt to which video-interfaces.txt refers to).
> 
> - Add a note on the port and endpoint nodes.
> 
> These changes make the smiapp bindings a better example.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../devicetree/bindings/media/i2c/nokia,smia.txt       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks.

Rob
