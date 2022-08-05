Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49477C00140
	for <linux-media@archiver.kernel.org>; Fri,  5 Aug 2022 04:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiHEEVQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Aug 2022 00:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHEEVP (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Aug 2022 00:21:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7C205D9;
        Thu,  4 Aug 2022 21:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DA9B827D4;
        Fri,  5 Aug 2022 04:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC41C433C1;
        Fri,  5 Aug 2022 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659673271;
        bh=IDgm74XCW7agRV4h7Bb9bHSULjnnigmzvUl77NFsex0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1f9V8o3YN+FSl4bBIRRaGIzHK2FgQM1wVUxuVHv55kbRPpKqRO6umsEqs+IG0d5S
         VrwOPbcz+N/a1l9Abhz2kfJEetOeYRr5Q8xbHAZes6I2ZZgya3rU68zqx+GVKHU9VC
         akRg7br92/QVoDH9nv9DXOGMehUhd1d51+z34RPI=
Date:   Fri, 5 Aug 2022 06:21:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mazin Al Haddad <mazinalhaddad05@gmail.com>
Cc:     linux-media@vger.kernel.org,
        syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com,
        mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: dvb-usb: fix memory leak in
 dvb_usb_adapter_init()
Message-ID: <YuyasvdntQp4mEt1@kroah.com>
References: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
 <CLXMEQRZRKJH.196H3FP8VFR8B@Arch-Desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CLXMEQRZRKJH.196H3FP8VFR8B@Arch-Desktop>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Aug 05, 2022 at 02:07:51AM +0300, Mazin Al Haddad wrote:
> Hi, did anyone have the opportunity to review this?

What is "this"?  There is no context here.

Also please realize this is the middle of the merge window, maintainers
can not accept anything until after -rc1 is out.  Normally you should
wait at least 2 weeks before resubmitting if you have not gotten a
response, but during the merge window, you should wait a bit longer.

thanks,

greg k-h
