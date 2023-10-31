Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818D1C4332F
	for <linux-media@archiver.kernel.org>; Tue, 31 Oct 2023 00:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjJaAEN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Oct 2023 20:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjJaAEL (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Oct 2023 20:04:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB8AB
        for <linux-media@vger.kernel.org>; Mon, 30 Oct 2023 17:04:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0967F3D6;
        Tue, 31 Oct 2023 01:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698710632;
        bh=E3jrwwUX9XDF93DjwX37wojRoQalWokEToBWNDLT1Gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBwzgCzcCfwCA4hudFSZy1nCTU+uTd+/wJ9H8Fww7uW+kXFPNcfsZUk25f7yKWbeg
         hAeOg+Kv/lBRdd22g6A8AvLcXIOe0NPkjm5GsUjYvsg3Dnxdfgg3KtIfUWWETuD4pV
         AJWJ6PdWnx4K7cILO5epDzMQydMbP2FQ0F4NbnCA=
Date:   Tue, 31 Oct 2023 02:04:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: Need some guidance working on a TODO item
Message-ID: <20231031000413.GE12764@pendragon.ideasonboard.com>
References: <CAG-BmoeV6zGZLk53Z6jr2WSr+5wvmo5=YtnLAAUeEkEqn_nf5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG-BmoeV6zGZLk53Z6jr2WSr+5wvmo5=YtnLAAUeEkEqn_nf5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Ghanshyam,

CC'ing the linux-media mailing list, to let other developers chime in as
well.

On Sat, Oct 28, 2023 at 04:07:03PM +0530, Ghanshyam Agrawal wrote:
> Hello Laurent,
> 
> Line 90 in file "drivers/media/usb/uvc/uvcvideo.h" in linux_mainline tree
> states
> 
> /*
>  * TODO: Put the most frequently accessed fields at the beginning of
>  * structures to maximize cache efficiency.
>  */
> 
> I am working on this todo item. Can you please guide me regarding 
> 
> 1. How can I find the number of accesses of each of the fields?

By reading through the code :-) It may be possible to instrument that,
but I have no idea how.

> 2. How can I find out the cache efficiency?

Do you know how caches work ?

> 3. When we say cache, which cache are we talking about?

The CPU caches, any level.

-- 
Regards,

Laurent Pinchart
