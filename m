Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567ECC38145
	for <linux-media@archiver.kernel.org>; Thu,  8 Sep 2022 08:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIHIt0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Sep 2022 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiIHIss (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Sep 2022 04:48:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24075FCA15
        for <linux-media@vger.kernel.org>; Thu,  8 Sep 2022 01:48:00 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 13D3EFF80A;
        Thu,  8 Sep 2022 08:47:43 +0000 (UTC)
Date:   Thu, 8 Sep 2022 10:47:42 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hidenori Kobayashi <hidenorik@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Scally <djrscally@gmail.com>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [ANN] Media Summit at ELCE Dublin, September 12: Draft Agenda V2
Message-ID: <20220908084742.5summdtjxv4twmei@uno.localdomain>
References: <3840c3cc-00fb-45dd-cb89-39b36fb6d733@xs4all.nl>
 <YxX8dzSsquJmO5hP@paasikivi.fi.intel.com>
 <YxYLSk2pKdGnNDP3@pendragon.ideasonboard.com>
 <166255477952.2677993.18296326616035616015@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166255477952.2677993.18296326616035616015@Monstersaurus>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Sep 07, 2022 at 01:46:19PM +0100, Kieran Bingham wrote:
> Quoting Laurent Pinchart (2022-09-05 15:44:26)
> > On Mon, Sep 05, 2022 at 01:41:11PM +0000, Sakari Ailus wrote:
> > > I think it'd be great to have a GPG key signing party at the end of the
> > > meeting.
> >
> > It's a good idea. Could everybody please send their GPG key fingerprint
> > in an e-mail reply to prepare for that ? It can easily be retrieved with
> > 'gpg -K' (make sure to pick the right key if you have multiple of them).

sec#  rsa4096 2016-10-19 [SC]
      72392EDC88144A65C701EA9BA5826A2587AD026B
uid           [ultimate] Jacopo Mondi <jacopo@jmondi.org>
ssb   rsa4096 2016-10-19 [E]
ssb   rsa4096 2016-10-20 [S]
