Return-Path: <SRS0=QOIR=2N=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECEC2D0C8
	for <linux-media@archiver.kernel.org>; Mon, 23 Dec 2019 01:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14622070A
	for <linux-media@archiver.kernel.org>; Mon, 23 Dec 2019 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577064277;
	bh=OYtBCtERK1c+Z0HHfojthNOuVGjSoQylUd0S4oD3WSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lgv+TT0h9G+1JnPSX5jHCLCOxqbJIsd1boEMTDN1DyX8U3g3NoMYZiJAwAsauRKpC
	 N6n08hd3t72RiHRlaOALv9urlm3jNan35D7/xCTGU0gVUEB/vgfInA1REYVLfndldy
	 GVyiXbFAx21xRe7+kV5bVEBljQrrwsEcS4cWd46M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLWBYd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfLWBYd (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 22 Dec 2019 20:24:33 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F3AB206B7;
        Mon, 23 Dec 2019 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577064273;
        bh=OYtBCtERK1c+Z0HHfojthNOuVGjSoQylUd0S4oD3WSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3eTRRzU/YOvgJmWrwq0rD/t44iTfgMFhyeb3UHS3/t4gVWXu3YxV8aVROa9u4JJY
         elKFLaHzk5b72rdNuUGqS16HwcUBSVuWui/tRib5nuMjuY5WX4YNp8JPCqnHj0iQOc
         jD/Yi7Io4lVe6AEdmbsg0sbVlz1fMJJRy72s/hbc=
Date:   Mon, 23 Dec 2019 09:24:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] media: dt-bindings: media: fsl-pxp: add missing
 imx6sll
Message-ID: <20191223012410.GA11523@dragon>
References: <20191202204748.6718-1-andreas@kemnade.info>
 <20191202204748.6718-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202204748.6718-2-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Dec 02, 2019 at 09:47:47PM +0100, Andreas Kemnade wrote:
> i.MX6SLL also has a pxp, so mention it among others in the bindings doc.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied both, thanks. 
