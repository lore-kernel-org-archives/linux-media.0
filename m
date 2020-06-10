Return-Path: <SRS0=cH4w=7X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57CFC433E1
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22232072E
	for <linux-media@archiver.kernel.org>; Wed, 10 Jun 2020 16:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNJT/c3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFJQhT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJQhS (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Jun 2020 12:37:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5AC03E96B
        for <linux-media@vger.kernel.org>; Wed, 10 Jun 2020 09:37:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so2415022wmd.5
        for <linux-media@vger.kernel.org>; Wed, 10 Jun 2020 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x/GwKp0pF1c+WHYyvunrjPKROoiPDpTyBwp2iRJzC6E=;
        b=NNJT/c3vHOw64dt28xCLLEYxppoSe/DIMpD2Y0IO/1cDpfxkPdlFQ8FYJXWuyvklwr
         pViU+GKf12AlL7MgTJs8EMZk7sh8kMX9j8loX8YlHtJL/LZEYRPtkjZManzBPtMw0J8I
         V6jiv1l4TiPjfV+bTCmZuFHVTgE1l9OpSBQPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x/GwKp0pF1c+WHYyvunrjPKROoiPDpTyBwp2iRJzC6E=;
        b=PqwsFFZErHe7qDOno+p3WsJUbQ3vRMtE1LoL0z2G6HpZCBvMcQTXhEZ8j517BJUU2y
         Xv8Ftv2jnP4yXt79BBAjyIczgMQB1DM+blplYZxLXO/1g75UF+cI3ofKdPHxUq1v6wdA
         ujMpp/J7YnxBDZnylbQS/LCtM9asgzOnKg1LKrfEoqvttJQG3xnrc59PHeAWYB0VABvr
         JYEbySYDWzxWlqn0ak6HEBrjWHpzRPde13fiVKW5+x9ELUNBfSl4uptJBx1scCcaL7+Q
         k7lOSQ6KH+iXU9Q6LXBM6szPgBJwkKqyKcnWiYU6KTd00dyJoQcm9KbmJZ38ULPGDyla
         Sh6w==
X-Gm-Message-State: AOAM530SV4p9oNz/8Q8Wk9GFbA3BeFCesLLpes1zPzHglfy0APyuMa72
        cH5KCrjyv6AL0nI9hY/HSG5rsg==
X-Google-Smtp-Source: ABdhPJwTYqUh1Z42tS8/+r1TdIuaPrc9u6+HXE7CX4mWC3Z0wigKmmRMYrIkdN82D/KlN0gSOYetUQ==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr4005337wmg.63.1591807035767;
        Wed, 10 Jun 2020 09:37:15 -0700 (PDT)
Received: from chromium.org (205.215.190.35.bc.googleusercontent.com. [35.190.215.205])
        by smtp.gmail.com with ESMTPSA id u12sm428991wrq.90.2020.06.10.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:37:14 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:37:13 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        hans.verkuil@cisco.com, kernel@collabora.com
Subject: Re: [PATCH v2 0/2] media: staging: rkisp1: allow simultaneous
 streaming from multiple capture devices
Message-ID: <20200610163713.GA201868@chromium.org>
References: <20200316210044.595312-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316210044.595312-1-helen.koike@collabora.com>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Mar 16, 2020 at 06:00:42PM -0300, Helen Koike wrote:
> Hi,
> 
> This series adds support for simultaneous streaming from both capture
> devices (rkisp1_selfpath and rkisp1_mainpath).
> 
> It depends on the following series for multistream to work properly, but
> it doesn't mean it can't be merged before:
> 
> 	"media: add v4l2_pipeline_stream_{enable,disable} helpers"
> 	https://patchwork.linuxtv.org/cover/62233/
> 
> And it is also available at:
> 
> 	https://gitlab.collabora.com/koike/linux/tree/rockchip/isp/multistream
> 
> Patch 1/2 fixes return error handling from pm functions, which was
> preventing the second stream to start.
> 
> Patch 2/2 serializes start/stop streaming calls, since they both
> and modify shared variables.
> 
> Changes in v2:
> - Rebased on media/master
> - Removed the following patch from the series:
> "media: staging: rkisp1: do not call s_stream if the entity is still in use"
> It was replaced by "media: add v4l2_pipeline_stream_{enable,disable} helpers"
> https://patchwork.linuxtv.org/cover/62233/
> 

For the whole series:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
