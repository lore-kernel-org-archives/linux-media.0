Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E530C10F05
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069422173C
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfC2IcN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:32:13 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39917 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfC2IcN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 04:32:13 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 793EF60011;
        Fri, 29 Mar 2019 08:32:09 +0000 (UTC)
Date:   Fri, 29 Mar 2019 09:32:51 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 00/31] v4l: add support for multiplexed streams
Message-ID: <20190329083251.3otgywm573dd4lir@uno.localdomain>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
 <20190329011707.2m2mgckmlxj3edby@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2zfpth2sfa2szia"
Content-Disposition: inline
In-Reply-To: <20190329011707.2m2mgckmlxj3edby@kekkonen.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--h2zfpth2sfa2szia
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sakari,

On Fri, Mar 29, 2019 at 03:17:11AM +0200, Sakari Ailus wrote:
> Hi Jacopo,
>
> On Thu, Mar 28, 2019 at 09:05:37PM +0100, Jacopo Mondi wrote:
> > Hello,
> >    new iteration of multiplexed stream support patch series.
> >
> > V3 available at:
> > https://patchwork.kernel.org/cover/10839889/
> >
> > V2 sent by Niklas is available at:
> > https://patchwork.kernel.org/cover/10573817/
> >
> > Series available at:
> > git://jmondi.org/linux v4l2-mux/media-master/v4
> >
> > Few changes compared to v3:
> > - Rebased on latest media master
> > - Include Sakari's and Luca's comments on documentation patch
> > - Improve connected pad operator as suggested by Ian and Sakari
> > - Fix a bogus -EINVAL return in 31/31 as suggested by Sakari
> > - Improve adv748x afe has_route as suggested by Luca and Sakari
> > - Closed some checkpatch warnings (there are still a few though)
>
> Thank you for working on this.
>
> I still need to read the documentation tomorrow, but this begins to look
> like material for merging. Your SoB seems to be missing from the patches
> you haven't written. Shouldn't it be there?

Should it? As "someone in the patch deliery path" (quoting
submitting-patches.rst) I probably should. I didn't as Niklas didn't
do that in v2, but I can add it to v5.

Thanks for pointing it out!

>
> --
> Kind regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

--h2zfpth2sfa2szia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlyd2DMACgkQcjQGjxah
VjyjJxAAinXd+TSZaQldkklAXkixIvDdxVpQUE7nlWwPbD36tHE5I1e5b/ittdZH
7Tf7nN96IxT/2/agFKFyGgxXtdm+1Na8ZqvRvNQQj8bHpzqPqjjCkM8XdiIZGfKA
THfCGZ4b/n9VulbYh4dY1pQOnQD4j8NOTK4D6OLVtIbiGSj1g2OeFiW6AHSXheHU
nR/70mwc/7bOE/rmRBFoM9oveoOT6BQ763pPvABF/w7ygLscZfkIplCh8ksEijXL
geA7zoMot8J3IdrVa5I0gqW7pz74/YyUzC4m+FaQJGHBZinx3q5N5P/8/WoLDkv0
zpjnYKxS49OgY2AYAo13YOO7cprzu6TEuAnvCKISIyx2LaRKp/vGeUawn2xW/pu4
GkYbTBAiXzPdBgADIrjZAT74ltrEvvyXjWxGsT2XddfeWWchPkYH+U54RxFrIcst
9ThFkQc/hIsyxM3oeW7Fzt6CK1a0YmVPhobNNEubG4/hnSAgpO47uab0T8eS4h/F
6q1iwfZYe7elpTXClO5r9Jy+OVwMptDvGDkVlPCxlMSNulcMPL1hPkJq5Pc33vKy
jtacKc71FfBscsfrcx344RMAAy2q0IQPVXE994FCQ9nMsqr/PUAIo857rptwfOhj
oIGRlODPdrMbA1UU0r6B/fvAnyze55dVtX2F6oqFKBZIT4TZH80=
=iV3f
-----END PGP SIGNATURE-----

--h2zfpth2sfa2szia--
