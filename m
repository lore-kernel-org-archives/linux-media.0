Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62CC10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6511F2173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfC1PIJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:08:09 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33879 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1PIJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 11:08:09 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.localdomain (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5AEA6C000E;
        Thu, 28 Mar 2019 15:08:05 +0000 (UTC)
Date:   Thu, 28 Mar 2019 16:08:47 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 26/31] adv748x: csi2: add internal routing
 configuration
Message-ID: <20190328150847.khb2spjt2jotisfx@uno.localdomain>
References: <20190305185150.20776-1-jacopo+renesas@jmondi.org>
 <20190305185150.20776-27-jacopo+renesas@jmondi.org>
 <4f5b5763-be90-4040-7d55-986471168de1@lucaceresoli.net>
 <20190315094538.bs5ecsdzndrxjdbb@uno.localdomain>
 <20190315100613.avmsmavdraxetkzl@kekkonen.localdomain>
 <28dbf2c7-2834-2bae-d56e-43e50d763c9f@lucaceresoli.net>
 <20190320171406.s462267lssaxkqo4@uno.localdomain>
 <88863e6a-a09a-b3c7-7b00-da4fc823b55f@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6jnmsmbjgoscstr"
Content-Disposition: inline
In-Reply-To: <88863e6a-a09a-b3c7-7b00-da4fc823b55f@lucaceresoli.net>
User-Agent: NeoMutt/20180716
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--z6jnmsmbjgoscstr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Luca,

On Fri, Mar 22, 2019 at 05:52:15PM +0100, Luca Ceresoli wrote:
> Hi,
>
> thanks for the follow-up.
>
> On 20/03/19 18:14, Jacopo Mondi wrote:
> >>>> This is probably the wrong patch to use an example, as this one is for
> >>>> a multiplexed interface, where there is no need to go through an
> >>>> s_stream() for the two CSI-2 endpoints, but as you pointed out in our
> >>>> brief offline chat, the AFE->TX routing example for this very device
> >>>> is a good one: if we change the analogue source that is internally
> >>>> routed to the CSI-2 output of the adv748x, do we need to s_stream(1)
> >>>> the now routed entity and s_stream(0) on the not not-anymore-routed
> >>>> one?
> >>>>
> >>>> My gut feeling is that this is up to userspace, as it should know
> >>>> what are the requirements of the devices in the system, but this mean
> >>>> going through an s_stream(0)/s_stream(1) sequence on the video device,
> >>>> and that would interrupt the streaming for sure.
> >>>>
> >>>> At the same time, I don't feel too much at ease with the idea of
> >>>> s_routing calling s_stream on the entity' remote subdevices, as this
> >>>> would skip the link format validation that media_pipeline_start()
> >>>> performs.
> >>>
> >>> The link validation must be done in this case as well, it may not be
> >>> simply skipped.
> >>
> >> Agreed.
> >>
> >> The routing VS pipeline validation point is a very important one. The
> >> current proposed workflow is:
> >>
> >>  1. the pipeline is validated as a whole, having knowledge of all the
> >>     entities
> >
> > let me specify this to avoid confusions:
> >      "all the entities -with an active route in the pipeline-"
> >
> >>  2. streaming is started
> >>  3. s_routing is called on an entity (not on the pipeline!)
> >>
> >> Now the s_routing function in the entity driver is not in a good
> >> position to validate the candidate future pipeline as a whole.
> >>
> >> Naively I'd say there are two possible solutions:
> >>
> >>  1. the s_routing reaches the pipeline first, then the new pipeline is
> >>     computed and verified, and if verification succeeds it is applied
> >>  2. a partial pipeline verification mechanism is added, so the entity
> >>     receiving a s_routing request to e.g. change the sink pad can invoke
> >>     a verification on the part of pipeline that is about to be
> >>     activated, and if verification succeeds it is applied
> >>
> >> Somehow I suspect neither is trivial...
> >
> > I would say it is not, but if you have such a device that does not
> > require going through a s_stream(0)/s_stream(1) cycle and all the
> > associated re-negotiation and validations, it seems to me nothing
> > prevents you from handling this in the driver implementation. Maybe it
> > won't look that great, but this seems to be quite a custom design that
> > requires all input sources to be linked to your sink pads, their
> > format validated all at the same time, power, stream activation and
> > internal mux configuration controlled by s_routing. Am I wrong or
> > nothing in this series would prevent your from doing this?
>
> You're right, nothing prevents me from doing a custom hack for my custom
> design. It's what I'm doing right now. My concern is whether the
> framework will evolve to allow modifying a running pipeline without
> custom hacks.
>
> > tl;dr: I would not make this something the framework should be
> > concerned about, as there's nothing preventing you from
> > implementing support for such a use case. But again, without a real
> > example we can only guess, and I might be overlooking the issue or
> > missing some relevant detail for sure.
>
> I'm a bit surprised in observing that my use case looks so strange,
> perhaps yours is so different that we don't quite understand each other.
> So below is an example of what I have in mind. Can you explain your use
> case too?

I'm mostly interested in this series as it allows me to add data lane
negotiation at run time. In my case, there are no stream continuity
constraints, but I get your point here.
>
>
> Here's a use case. Consider a product that takes 3 camera inputs,
> selects one of them and produces a continuous video stream with the
> camera image and an OSD on top of it. The selected camera can be changed
> at any time (e.g. upon user selection).
>
>                   OSD FB ---.
>                             |
>             .--------.      V
> Camera 0 -->|        |   .-----.
> Camera 1 -->|  MUX   |-->| OSD |--> DMA --> /dev/video0
> Camera 2 -->|        |   `-----'
>             `--------'
>
> A prerequisite is obviously that each piece of hardware and software
> involved is able to cope with a sudden stream change. Perhaps not that
> common, but no rocket science.
>
> It looks to me that each of these pieces can be modeled as an entity and
> the s_routing API is a perfect fit for the mux block. Am I wrong?
>

Personally, I would say that your muxer driver, if able to switch
source without requiring a pipeline restart, should handle it
internally. There are specific details that the mux should be able to
handle, and we're still pretty vague on the details. As a start, which
is the bus type your sources connects to the muxer with? Parallel?
CSI-2? How is the video stream multiplexed? with CSI-2 VC? Do you need
to control your source power during inactive period? I'm sure there
are more questions... I agree a partial pipeline restart might be
something to consider, but at the same time I think this is not
something strictly required to get this series merged, isn't it?

Thanks
  j


> Thanks,
> --
> Luca

--z6jnmsmbjgoscstr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAlyc438ACgkQcjQGjxah
VjzMnw/+MOokBuCYODokregv2u9qiiDCKeUY5e/bkZZmKvhQFqNEiLsSl7QjyFmw
4OJzbmbgTC+mH3SomDnq3UwaD6mOpREoPb3tUtDAyt+SyU0W2INuliCGBpyQE6Eh
tYqZqwJE0igA9t1ZQokCpkBCwYzQZiwHWxmWK1d5HkheGIx7cF5ntq67NsNAIDS0
ays8SIxcVzzxQQbtWDYU09XN36L6E2lXGzFLqFCLONICfbXULdsnrXC+q7Jo9v6L
VZuVZhVMXYasTxR0Ye9ftnm1BRkZkjDyMDzxXuKi5X099k5NG9W8Rrg4WaLlxxhq
yvK04RZb1rjpL/6O2NDHPIafg1C6+nPtLCBI02hcoxzVX6w/EwWKiTv5fyPtFfNh
Y/mD8WU92MIxONkLYBHHmvD4kNB9POUqh8Mr/+khR/8WRPPlNzF4dn+DqFzOPDvy
MlBO/TUjSJyqGy4Z5iGJdODY5tr2xURGWuAdQGhuGI7j7j5hO0H7MKOsAnfBKhf2
Z0IqHWttwsA4X79PW3M5A+S/kYXIVdeimv8NtSmdmmhkvEXw3gJv7VME2mdKCDtD
Z5eKNqHeJCpgL/molA3R5D0mLHS6Ka40e4t9q6nSuUD+wvPvjfa/yotITFXIYsBN
TlQJO7Wtv2f5AxTpwp8KvfwBNnueZyHOKkIOGmA6Et0QxwbgINE=
=jA0j
-----END PGP SIGNATURE-----

--z6jnmsmbjgoscstr--
