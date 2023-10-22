Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A71CC00A8F
	for <linux-media@archiver.kernel.org>; Sun, 22 Oct 2023 20:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJVUWt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Oct 2023 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVUWs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Oct 2023 16:22:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C5E5
        for <linux-media@vger.kernel.org>; Sun, 22 Oct 2023 13:22:47 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F00E43D6;
        Sun, 22 Oct 2023 22:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698006156;
        bh=9KgD1okmgCpMFAkrYqnz0z+3wVYMwcwVR107Jsntluw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLmDUig/HWJcU2Puiu1JhcKLwS0AnFkGeTiW47ECbtBVP9dbQbEPB22cLmBnhW/O9
         nh/c6X+YKniDFOUhZWTQHC4PGhdR8+lQRIa0tVL8p28ia+Yt31vpW7xdmyGQik4nqz
         RYeOF5mLXY/R41tTJ0ssnJZ5MRJli172RCbDWJOk=
Date:   Sun, 22 Oct 2023 23:22:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re:
Message-ID: <20231022202253.GA5445@pendragon.ideasonboard.com>
References: <CAOuULM555ZNXbsbZywJ8qkcNGbP+hdgBihqqEBYF_oA-FK2fxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuULM555ZNXbsbZywJ8qkcNGbP+hdgBihqqEBYF_oA-FK2fxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Jules,

(CC'ing the linux-media mailing list, as discussions about the driver
should happen there, in public)

On Sun, Oct 22, 2023 at 05:46:59PM +0100, Jules Irenge wrote:
> Hi 
> I have some time I would like to volunteer contributing to the omap4iss.
> If it's fine with you, would you give me more info about it

The driver has most likely bit-rotten over the last few years, as to my
knowledge nobody has really tested it recently. The first step would
thus be to try to capture images and see how it behaves (or doesn't
behave).

What hardware will you use for testing ?

-- 
Regards,

Laurent Pinchart
