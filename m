Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BBC433E0
	for <linux-media@archiver.kernel.org>; Tue, 22 Dec 2020 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795C82312E
	for <linux-media@archiver.kernel.org>; Tue, 22 Dec 2020 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgLVNGN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLVNGN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Dec 2020 08:06:13 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB15C06179C;
        Tue, 22 Dec 2020 05:05:33 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 254D1C6357; Tue, 22 Dec 2020 13:05:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1608642329; bh=grqh//nnipOqJVPf+0cNEDd/AU0l7QPxDqtNZbyQiEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS2XDo+vhGdZ65j1EzAADkTLxZyEe2bkV9Ngm5gPvr8ea7hXRJ1vpHUiRS/lgUJQf
         cQHU+sdRCJnK+QUHMee77Xl3nSq6oISGbqPtAeob0hVstWyYqjMV4bb4nfan98mOa0
         shZYXh4/wE+yw9Shwneh3qfL6ovAmVedBIx4FdHf/F5fnLv1yH1sqAiqZ4bWlmKiut
         CrOWRCDtKjdaEiSgzNOpMSvUFyFGHwLWhP1tVvHc4lTCZUxBeQcd6KT6mG3B2P9lcx
         SHRm0zpssa8ZugUn+GT3xsO3fn7V0UNlSJ8eVGubnzD4QBdfP+Qe8IzQUpdBJafrQk
         Q7lSwcA2NzXNA==
Date:   Tue, 22 Dec 2020 13:05:29 +0000
From:   Sean Young <sean@mess.org>
To:     James Reynolds <jr@memlen.com>
Cc:     linux-media@vger.kernel.org, stable@vger.kernel.org,
        syzbot+ec3b3128c576e109171d@syzkaller.appspotmail.com
Subject: Re: [PATCH] media: mceusb: Fix potential out-of-bounds shift
Message-ID: <20201222130529.GA19018@gofer.mess.org>
References: <20201222120704.10534-1-jr@memlen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222120704.10534-1-jr@memlen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Dec 22, 2020 at 12:07:04PM +0000, James Reynolds wrote:
> When processing a MCE_RSP_GETPORTSTATUS command, the bit index to set in
> ir->txports_cabled comes from response data, and isn't validated.
> 
> As ir->txports_cabled is a u8, nothing should be done if the bit index
> is greater than 7.
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+ec3b3128c576e109171d@syzkaller.appspotmail.com
> Signed-off-by: James Reynolds <jr@memlen.com>
> ---
>  drivers/media/rc/mceusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
> index f1dbd059ed08..c8d63673e131 100644
> --- a/drivers/media/rc/mceusb.c
> +++ b/drivers/media/rc/mceusb.c
> @@ -1169,7 +1169,7 @@ static void mceusb_handle_command(struct mceusb_dev *ir, u8 *buf_in)
>  		switch (subcmd) {
>  		/* the one and only 5-byte return value command */
>  		case MCE_RSP_GETPORTSTATUS:
> -			if (buf_in[5] == 0)
> +			if (buf_in[5] == 0 && *hi < 8)
>  				ir->txports_cabled |= 1 << *hi;

So *hi is a port number. I don't know of any devices that have more than
2 ports, so this is fine.

Reviewed-by: Sean Young <sean@mess.org>


Thanks

Sean
