Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A570C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDF92171F
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfDLPcx (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:32:53 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58797 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPcx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:32:53 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 117EFFF805;
        Fri, 12 Apr 2019 15:32:48 +0000 (UTC)
Date:   Fri, 12 Apr 2019 17:33:38 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, hverkuil@xs4all.nl,
        niklas.soderlund@ragnatech.se, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 0/9] Rework V4L2 fwnode parsing; add defaults and avoid
 iteration
Message-ID: <20190412153338.wk6cyjhctmkzzr45@uno.localdomain>
References: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4wuwdkfrtfovrd75"
Content-Disposition: inline
In-Reply-To: <20190405094127.18975-1-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--4wuwdkfrtfovrd75
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sakari,

On Fri, Apr 05, 2019 at 12:41:17PM +0300, Sakari Ailus wrote:
> Hi folks,
>
> This patchset reworks V4L2 fwnode endpoint parsing. It enables the use of
> endpoint configuration defaults that is available sensors and other
> drivers that only use a single endpoint. Well, the functionality was
> available already but no driver used it likely because of two reasons:
> lack of any examples in a non-trivial problem area as well as lack of a
> needed functionality to obtain through non-iterative means in the fwnode
> graph API. Also the fwnode framework did not provide the most convenient
> APIs to perform this for drivers.
>
> Conversion from the iterative API is done for the omap3isp and ipu3-cio2
> drivers. A downside here is that this adds code: what used to be done in
> the framework in a one-size-fits-all fashion is now the responsibility of
> the driver. The benefits (default settings and simplicity of the
> implementation from driver's point of view) are not really achievable
> without some of that.
>
> Also baked in the set is matching devices with endpoints by endpoint node
> rather than the device's node. This allows finding out more information
> than just the device bound (i.e. the port --- or endpoint --- through
> which it was bound). Compatibility support is provided for existing
> drivers by setting the fwnode to be matched based on the available
> endpoints. Drivers that use the async non-notifier API and have multiple
> ports will likely need special care and this is right now missing from the
> set, hence this is RFC for now.
>
> The set depends on a few other patches. They all can be found here:
>
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=fwnode-linear>
>

Compared to the above tree I see one missing patch:
"device property: Add fwnode_graph_get_endpoint_by_id"

Is this intentional?

Thanks
  j

> since RFC v1:
>
> - Add another patch to change fwnode refcounting for
>   v4l2_async_notifier_add_fwnode_subdev
>
> - Add a patch to fix OF node refcounting and use / put order for
>   davinci-vpif
>
> - Don't take endpoint reference in v4l2_async_register_subdev; that's not
>   intended
>
> - Fix kerneldoc documentation for
>   v4l2_async_notifier_add_fwnode_remote_subdev
>
> - Fix endpoint refcounting in the patch changing fwnode parsing for the
>   omap3isp driver
>
> - Fixed a compiler error in rcar_drif.c --- thanks, Niklas!
>
> Sakari Ailus (9):
>   davinci-vpif: Don't dereference endpoint after putting it, fix
>     refcounting
>   v4l2-async: Use endpoint node, not device node, for fwnode match
>   v4l2-async: Get fwnode reference when putting it to the notifier's
>     list
>   v4l2-async: Add v4l2_async_notifier_add_fwnode_remote_subdev
>   omap3isp: Rework OF endpoint parsing
>   v4l2-async: Safely clean up an uninitialised notifier
>   ipu3-cio2: Clean up notifier's subdev list if parsing endpoints fails
>   ipu3-cio2: Proceed with notifier init even if there are no subdevs
>   ipu3-cio2: Parse information from firmware without using callbacks
>
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  96 ++++----
>  drivers/media/platform/am437x/am437x-vpfe.c   |   7 +-
>  drivers/media/platform/atmel/atmel-isc.c      |   2 +-
>  drivers/media/platform/atmel/atmel-isi.c      |   2 +-
>  drivers/media/platform/cadence/cdns-csi2rx.c  |   2 +-
>  drivers/media/platform/davinci/vpif_capture.c |  37 +--
>  drivers/media/platform/exynos4-is/media-dev.c |  14 +-
>  drivers/media/platform/omap3isp/isp.c         | 331 +++++++++++++++-----------
>  drivers/media/platform/pxa_camera.c           |   2 +-
>  drivers/media/platform/qcom/camss/camss.c     |  10 +-
>  drivers/media/platform/rcar_drif.c            |   2 +-
>  drivers/media/platform/renesas-ceu.c          |   2 +-
>  drivers/media/platform/stm32/stm32-dcmi.c     |   2 +-
>  drivers/media/platform/ti-vpe/cal.c           |   2 +-
>  drivers/media/platform/xilinx/xilinx-vipp.c   |  15 +-
>  drivers/media/v4l2-core/v4l2-async.c          |  37 ++-
>  drivers/media/v4l2-core/v4l2-fwnode.c         |  26 +-
>  drivers/staging/media/soc_camera/soc_camera.c |  14 +-
>  include/media/v4l2-async.h                    |  30 ++-
>  19 files changed, 386 insertions(+), 247 deletions(-)
>
> --
> 2.11.0
>

--4wuwdkfrtfovrd75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlywr9IACgkQcjQGjxah
VjzLYg//XphlIjR47QUdx6v13hhdbBRqarXFqjPYBL8cXOTSjDlvjaJhQnhzAgxy
8VWMy9P7CMU2FrUi23yWNqqr2xh8hA92Hl39gBWlbziRYM2nfvkXjtz4FSFD29S9
0krWTNWzc2p/vefhPxGWcjFJNh3m4i6xbDR79vyl1pqpwGS5lZmOg4RezL9LT1lr
qDtE7oimEWjZ7kkl/SPd0OWno+pVYsutw9FRU6IGpIQHHHUr5GgZws8qsCO8vx9w
GVSjpfRZSS23JIdbNdNLe10agGSISpZMpu8hmhbQbKnrHTfu/I2XGYnB/ENFGcw6
QESqAb4nhysrGxtEmy222IuOC8GmlqWaWbrtVdEwd2lpxJzpjmlQoLuEMR0Nk1/x
SroDSTIbS+0eaBRDMdADAnqaN07U1D/0WPNPerQ9CwtDWPhfqhe586gn+Kmrpmzo
WRSH1T8BEX+KF4fhPjUPQDepjlTzOYbX4UmfyKIImKO8ebu48rmnjFagnCplw6mV
JRfKgqpTjeFdh1rbMDoDBK9FQJQ2X58Z38zIe3NdkAzXOJO46PT41enX/a17G4ip
uBReEdSRA6mQVve7cwp5/iQMIIE0IRXEZi/FxvyqAtakJCaQJ2uTC6GRbHzEdNsg
ZBXw3f8weSjhAwzdJgjPeIqvH2nAH/WSnuU6CqFpy4flRuRuhUM=
=GO97
-----END PGP SIGNATURE-----

--4wuwdkfrtfovrd75--
