Return-Path: <SRS0=z7aI=SZ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD5C10F14
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BC72077C
	for <linux-media@archiver.kernel.org>; Tue, 23 Apr 2019 10:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDWKSl (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:18:41 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52623 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWKSk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 23 Apr 2019 06:18:40 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6D44A1C000C;
        Tue, 23 Apr 2019 10:18:37 +0000 (UTC)
Date:   Tue, 23 Apr 2019 12:19:32 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: Route lifetime in SUBDEV_[GS]_ROUTING
Message-ID: <20190423101932.gszkn4olqatoisde@uno.localdomain>
References: <20190417104147.zlmbw32dr46vmtrq@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2veaf4as5vw3ipis"
Content-Disposition: inline
In-Reply-To: <20190417104147.zlmbw32dr46vmtrq@paasikivi.fi.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--2veaf4as5vw3ipis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Sakari,

On Wed, Apr 17, 2019 at 01:41:48PM +0300, Sakari Ailus wrote:
> Hi Jacopo,
>
> I promised to write a bit about the routing problem I attempted to write on
> #v4l. It's a bit late, but here it is. Let me know if you share my
> understanding (and especially do so if you don't :)).

Thanks for doing this, and sorry it took me a while to reply!

>
> A route is identified by the source and sink pads as well as the stream ID
> on the source and the sink pads. Its flags allow enabling or disabling a
> route.
>
> Most devices that function as transmitters (such as sensors) have a fixed
> number of routes they can support. These's no need to change them; enabling
> and disabling them will be enough for the user.
>

Fine so far.

We indeed define routes as:
(sink pad - sink stream) -> (source pad - source stream)

> For receivers this is different. What needs to be supported on the receiver
> side is directing any incoming stream (a 32-bit unsigned integer) to any
> source pad.
>
> This is because pads are not alike --- one may be connected to a block that
> further processes the image whereas the others may be connected to a DMA
> engine, just writing the data to memory.
>
> The receivers also may not make assumptions beyond the sub-device API: the
> stream is a 32-bit unsigned integer, there is currently no API requirement
> to have the stream IDs on a particular low integer range. In principle we
> could define that range, but I'd rather try to find better solutions than
> that: it's hard to come up with a number as it depends on the hardware.
> Some kind of an upper limit could be the number of CSI-2 channels
> multiplied by CSI-2 data types. That would be enough for CSI-2. 16 or 32
> virtual channels and up to 64 data types would mean up to 2048 routes
> between a demultiplexer's sink pad and *each* of its source pads. And this
> comes with an assumption that the source pads only support a single
> stream...

I lost you here.

My mental model was far more (too?) simple:

- Routing tables inside an entity might have an arbitrary size, as how
  that configuration depends on the device and the driver
  implementation. As an example, the adv748x accepts 7 analogue
  inputs to chose from and route to a CSI-2 source pad.
  depending on the implementation, those 7 inputs could be modeled as
  7 pads with one stream each, or a single pad with 7 channels or
  whatever else, and I agree the 'stream_id' values range is totally
  up to the driver implementation -inside an entity-.

- The cross-entity (sorry, I lack a better term here) multiplexing
  happens on physical bus that allows so, and I can only think of
  CSI-2 at the moment. Sure, you could share the lines of a parallel
  bus playing with enables/disables of the transmitters, but this
  is a custom hack that does not play well in this model.
  Each CSI-2 source pad has up to 4 streams (one per VC) and the
  content of those streams is retrieved from the transmitter by the
  receiver through the remote frame_desc operation [*], as receivers
  might need to be setup using to filter on particular VC/DT combinations
  to receive the stream.

- Each CSI-2 receiver sink pad supports 4 streams (the CSI-2 VCs) and any
  of those streams can be directed to any of its source pads, to
  implement what you have described (one pad connected to an ISP-like
  device, on other to the DMA engine directly etc)

- DT negotiation is still a bit vague. The example we have on the
  series (adv748x and r-car csi2) configure the receiver's accepted DT
  inspecting the remote frame_desc. Again, as per [*] this migh be
  limitied to 1 DT for VC, which might not be enough and would require
  re-thinking the operation used for the negotiation.

- Configuring a multiplexed source pad image format is today not
  possible, the format is always propagated from the sink pad to which
  a route is enabled to the source pad. Might this be a limitation on
  how we control which DTs are multiplexed inside a VC and won't allow
  to model any format conversion that might happen at the source pad
  output. I was toying myself with the idea of a stream-aware set
  format operation for multiplexed source pads, not sure it might work
  though.

Can I ask you why:
- you mention 16 or 32 VCs ? Each CSI-2 link supports up to 4.
- you put DT in the routing mix, and I suspect it is here where our
  disconnection happens. I always assume DT configuration as a result
  of a format configuration operation, which currently has limitations
  as noted here above.


[*] I would later like to talk about if this is the most appropriate
operation to handle this negotiation, as I'm not sure we can handle DT
negotiation properly with that, but that's for later.

>
> CSI-2 receivers support a number of simultaneous streams, and as the stream
> is demultiplexed there, this means there will be as many source pads as
> there are supported simultaneous streams. This heavily depe`nds on the
> hardware, but the number could be e.g. 1, 4 or 8. Much smaller than 2048 in
> any case.
>

Why 8? Is this related to DT multiplexing again?

> Another option could be creating no routes at all at device init time, and
> letting the user create them. We could add a new flag for routes telling
> that a route is dynamic: disabling a dynamic route would simply delete it.
> Likewise, a SUBDEV_G_ROUTING returning no routes (but no error either)
> would also tell the user only dynamic routes are supported.
>
> We should document this and change the driver implementation accordingly.
> No API changes are needed (apart from adding the dynamic flag --- or rather
> call it "volatile", to avoid confusing with routes that can be enabled or
> disabled while streaming).
>

I have v5 of the series ready. Do you want me to post it to progress
discussion, or should we clarify this first?

Thanks
   j


> --
> Best regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

--2veaf4as5vw3ipis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAly+5rQACgkQcjQGjxah
VjwXBRAAxaS2q1c5AMsgwFePW5s2d/aUdU8wBVc9wWmEX7ZJ30aHVPoIXTKmAxhG
ql2gpLgIaCu1QEgQYZEaOAtmfo9hK25hE1IcvmYRHYOEz1WRj6dzRQLatnaf6nV7
OH6q/DVR5Bl+zTlmD7kvjZYlWkZc+n5vOloUB5MxlKkBjxzqYUDr1eRf3hmNj6lX
3A3h11I6XOXQC72uFSdUo7vJnyPa2JBjkStrOEphfbV5rPCIbzNL/SrUDuOGdPFN
osBMjcV3M+ffeScBqT7TVWmtfjFFMSA1JFAGW3e48iH2erR8oyxvlaV8mDj0DDKy
9/J+441tmyB7fsqjpT9pcn+4C2BjKtNKfJh49+aNQ9DB0sKwVpl/85kXC63+Uwx0
PgNQN6t0hF2eMbix0dKHI1qdvxKHl6xpDrK4OMm7LwyhA59SUqMR5P7lVs6OUXXN
CMDLnqg1lj5c+LJSRFE8IbhgJO3NTvDqljn2M4vmjwf5ckn5PRQEDf7ZPdBAP1ZW
H/8IcJWW2d4CsXw0XsuySb2PJoOHtetb/9EhWmW80/9L4bfy4hoW1gxvlNAQaTLc
d44MJqwCQkK7+qUfVxN5d7YGumgDgOXHQKAZhOHXqCgbbAunchaVIzDYJCPSlrED
yXF2uzBcptOdpLOfdEz5m+0m2IFbkKgIheprZj/x7J+RPqRRIYc=
=+uF6
-----END PGP SIGNATURE-----

--2veaf4as5vw3ipis--
