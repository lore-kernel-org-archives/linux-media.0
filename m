Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E736C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96D62082E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="BdmS5V51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDLMg2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:36:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40583 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDLMg2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 08:36:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so8712384ljq.7
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C4DA7E9aKv3XIjAwonJPt1/YDNfsudHCvFtFtSvptFE=;
        b=BdmS5V51KL6V2WHAVQz9TUAuVwKBAB3rJShwnt4nIOw0HOdaTXhKDmojFVFWQfMzbE
         Yj05vvyZd+45wSbPI1JnWZS/3G6y9J+0n2fU/1XQ4o7iihEbEmfa7oRwJgcss44x1WOE
         rIzBwVmdnrSE49EMRtGukKFxgWQrjKVcPoLku795lYeWimL4UPdSjr11BTF8J/MlJOaA
         sr/o3CqCYH744cLd5yM2ZQzXtOlf364DKP20gQI+jmsTOeHZ+0xfH3JRwyjeJF7gl4pc
         UW5e0wh1hLrOHpUMY9UMTeL0wmeESI7ytS+hWcTqajRuVsdTz0ED6YXJgZByS2ayHis6
         qDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C4DA7E9aKv3XIjAwonJPt1/YDNfsudHCvFtFtSvptFE=;
        b=JvuDYcgbR/Espj8hvfwyPmTcguWx3Cj2hQtBylTx7DfoAhyRXPa0M62/Kbn+UN1DuG
         UgOQ47xqPbGKVTuY0REjHtPZReNyQ3hSJ9okgKMvBNKLUc9qJpMlzlwh5jwUjRiFKZos
         2EwEKrplk87UIiYlgwlzGmgp2rc5GKVpRKExksrVytN1qVpcej2/ujclObe2JYfi2ohS
         4PRTKlGb9PN1U6gForCksUnRbBTp8UnkWtg/ciQmtxmRLx3Z73UPgw32t+EAIa7wzCBP
         xAVd8Asaqs504sdqbZ0ll2BSHhHYosSE4nZH2icIVmusImywU+MqaPsoFPQh988RbH66
         v9HQ==
X-Gm-Message-State: APjAAAVM0TmWAiS4FE8YrHyros0rEP1gVN9tSGHSP8nFFHL2BiwZmxzG
        mqMRnWqB3S7p5kuSOGKPL1m9LA==
X-Google-Smtp-Source: APXvYqxVfsI/rcm4/sadRLXDy34QAQB7sCsas3nmtS5zyd3WNKmKbAmdTiY8jIt02no3iRKJYF3Fug==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr4714696ljk.78.1555072585644;
        Fri, 12 Apr 2019 05:36:25 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id n12sm1050419lfk.60.2019.04.12.05.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:36:24 -0700 (PDT)
Date:   Fri, 12 Apr 2019 14:36:24 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au,
        sergei.shtylyov@cogentembedded.com, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/2] media: rcar-vin: Make the number of VIN SoC-dependent
Message-ID: <20190412123624.GC1980@bigcity.dyn.berto.se>
References: <20190412113832.30075-1-jacopo+renesas@jmondi.org>
 <20190412113832.30075-2-jacopo+renesas@jmondi.org>
 <20190412115836.GA1980@bigcity.dyn.berto.se>
 <20190412121352.6hozzx4lm3ql2j2j@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412121352.6hozzx4lm3ql2j2j@uno.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On 2019-04-12 14:13:52 +0200, Jacopo Mondi wrote:
> Hi Niklas,
> 
> On Fri, Apr 12, 2019 at 01:58:36PM +0200, Niklas Söderlund wrote:
> > Hi Jacopo,
> >
> > Thanks for your work.
> >
> > On 2019-04-12 13:38:31 +0200, Jacopo Mondi wrote:
> > > In preparation to add ids to VIN's device tree nodes for the V3H SoC
> > > which features up to 16 VIN instances, remove the hardcoded number of
> > > VINs and make it a per-SoC property.
> > >
> > > Enlarge the existing RCAR_VIN_NUM definition, which is used to
> > > statically allocate the number of vin devices to 16, to accommodate
> > > SoCs with that many instances as V3H.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Nacked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > This is wrong for two reasons, as explained on irc.
> >
> > - The RCAR_VIN_NUM checks are bounds check for the array and not to
> >   validate that the renesas,id property in the DT is correct. Making it
> >   dynamic only serves to complicate the driver for no gain.
> 
> Regardless of V3H support, validating that the renesas,id property is
> valid for the current SoC is worth the "complication" imho.
> Why is bound checking different now? (we could discuss if allocating 8
> vin devices more for all SoC is worth, that I agree)
> Not to mention having that value fixed it means we alway cycle on all
> 8 vin devices instances, even if the SoC supports less than that.

I don't think the driver should validate the renesas,id property. We 
must assume that DT is correct. Only reason we do it now is that we have 
an array of RCAR_VIN_NUM size and it's more nasty to crash then then to 
check it if the DT happens to be incorrect. If we where to validate it 
with SoC knowledge we could drop the property completely and derive the 
information for the base address of the VIN.

I hope to one day remove most of the group hack and for that reason I 
wish to keep this as simple as possible. Iterating 4 more times V3M, 7 
more times on D3 and 6 more times on E3 in the small loops in the probe 
path is acceptable for me to keep it simple.

> >
> > - It's true that the V3H have 16 VINs, but VIN8-15 are only connected to
> >   the ISP for which there exists no upstream driver and no support in
> >   the rcar-vin parsing code to handle it. With this change the rcar-vin
> >   would probe for such VINs but the result would be use-less as it can
> >   not get hold of the ISP, even if a driver would exist for it.
> >
> 
> Let's remove them from DT then?

DT should describe hardware, this is a driver limitation I think all 
VINs should be kept in DT.

> 
> >   I might be convinced to accept a patch which would allow DT to
> >   describe all 16 VIN's of the V3H but where the rcar-vin would still
> >   fail to probe if the renesas,id is above 7 but with a different
> >   dev_err() informing the user why it failed.
> 
> I cannot test on V3H but I think all VINs (included 0-7, which are
> connected to a CSI-2 receiver) fail to probe without a "renesas,id"
> property, and this should be fixed. I like less the idea of having a special
> failure path for the VIN[8-15] instances than removing them completely
> tbh.

My preferred option would be to:

- Add the renesas,id to all 16 VIN in the V3H DT.
- Keep all VIN in status = "disabled" as they are in r8a77980.dtsi.
- None of the users of r8a77980.dtsi (r8a77980-condor.dts, 
  r8a77980-v3hsk.dts) enables any of the VINs so there is no regression 
  upstream. If a new board is added it should only enable VIN0-7 as it's 
  the only ones they can use with rcar-vin.
- Keep the error message and logic as it is today in rcar-vin as a id 
  larger then 7 is invalid for the driver.

This would allow the DT to be correct and the driver to correctly report 
what it supports. If/When we add ISP support we can revisit this topic.

> 
> >
> >   I would of course also be happy about a driver for the ISP and added
> >   support for it in rcar-vin ;-)
> >
> > > ---
> > >  drivers/media/platform/rcar-vin/rcar-core.c | 23 +++++++++++++++------
> > >  drivers/media/platform/rcar-vin/rcar-vin.h  |  5 ++++-
> > >  2 files changed, 21 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
> > > index 64519b3097f7..6e9c6c8471e9 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-core.c
> > > +++ b/drivers/media/platform/rcar-vin/rcar-core.c
> > > @@ -188,7 +188,7 @@ static int rvin_group_link_notify(struct media_link *link, u32 flags,
> > >  		 * we can return here.
> > >  		 */
> > >  		sd = media_entity_to_v4l2_subdev(link->source->entity);
> > > -		for (i = 0; i < RCAR_VIN_NUM; i++) {
> > > +		for (i = 0; i <= vin->info->vin_max_id ; i++) {
> > >  			if (group->vin[i] && group->vin[i]->parallel &&
> > >  			    group->vin[i]->parallel->subdev == sd) {
> > >  				group->vin[i]->is_csi = false;
> > > @@ -319,7 +319,7 @@ static int rvin_group_get(struct rvin_dev *vin)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	if (id >= RCAR_VIN_NUM) {
> > > +	if (id > vin->info->vin_max_id) {
> > >  		vin_err(vin, "%pOF: Invalid renesas,id '%u'\n",
> > >  			vin->dev->of_node, id);
> > >  		return -EINVAL;
> > > @@ -662,7 +662,7 @@ static int rvin_group_notify_complete(struct v4l2_async_notifier *notifier)
> > >  	}
> > >
> > >  	/* Register all video nodes for the group. */
> > > -	for (i = 0; i < RCAR_VIN_NUM; i++) {
> > > +	for (i = 0; i <= vin->info->vin_max_id; i++) {
> > >  		if (vin->group->vin[i] &&
> > >  		    !video_is_registered(&vin->group->vin[i]->vdev)) {
> > >  			ret = rvin_v4l2_register(vin->group->vin[i]);
> > > @@ -720,7 +720,7 @@ static void rvin_group_notify_unbind(struct v4l2_async_notifier *notifier,
> > >  	struct rvin_dev *vin = v4l2_dev_to_vin(notifier->v4l2_dev);
> > >  	unsigned int i;
> > >
> > > -	for (i = 0; i < RCAR_VIN_NUM; i++)
> > > +	for (i = 0; i <= vin->info->vin_max_id; i++)
> > >  		if (vin->group->vin[i])
> > >  			rvin_v4l2_unregister(vin->group->vin[i]);
> > >
> > > @@ -809,7 +809,7 @@ static int rvin_mc_parse_of_graph(struct rvin_dev *vin)
> > >  	mutex_lock(&vin->group->lock);
> > >
> > >  	/* If not all VIN's are registered don't register the notifier. */
> > > -	for (i = 0; i < RCAR_VIN_NUM; i++) {
> > > +	for (i = 0; i <= vin->info->vin_max_id; i++) {
> > >  		if (vin->group->vin[i]) {
> > >  			count++;
> > >  			vin_mask |= BIT(i);
> > > @@ -830,7 +830,7 @@ static int rvin_mc_parse_of_graph(struct rvin_dev *vin)
> > >  	 * overlap but the parser function can handle it, so each subdevice
> > >  	 * will only be registered once with the group notifier.
> > >  	 */
> > > -	for (i = 0; i < RCAR_VIN_NUM; i++) {
> > > +	for (i = 0; i <= vin->info->vin_max_id ; i++) {
> > >  		if (!(vin_mask & BIT(i)))
> > >  			continue;
> > >
> > > @@ -884,6 +884,7 @@ static int rvin_mc_init(struct rvin_dev *vin)
> > >  static const struct rvin_info rcar_info_h1 = {
> > >  	.model = RCAR_H1,
> > >  	.use_mc = false,
> > > +	.vin_max_id = 3,
> > >  	.max_width = 2048,
> > >  	.max_height = 2048,
> > >  };
> > > @@ -891,6 +892,7 @@ static const struct rvin_info rcar_info_h1 = {
> > >  static const struct rvin_info rcar_info_m1 = {
> > >  	.model = RCAR_M1,
> > >  	.use_mc = false,
> > > +	.vin_max_id = 1,
> > >  	.max_width = 2048,
> > >  	.max_height = 2048,
> > >  };
> > > @@ -898,6 +900,7 @@ static const struct rvin_info rcar_info_m1 = {
> > >  static const struct rvin_info rcar_info_gen2 = {
> > >  	.model = RCAR_GEN2,
> > >  	.use_mc = false,
> > > +	.vin_max_id = 5,
> > >  	.max_width = 2048,
> > >  	.max_height = 2048,
> > >  };
> > > @@ -941,6 +944,7 @@ static const struct rvin_group_route rcar_info_r8a7795_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a7795 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 7,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a7795_routes,
> > > @@ -995,6 +999,7 @@ static const struct rvin_group_route rcar_info_r8a7795es1_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a7795es1 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 7,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a7795es1_routes,
> > > @@ -1035,6 +1040,7 @@ static const struct rvin_group_route rcar_info_r8a7796_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a7796 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 7,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a7796_routes,
> > > @@ -1079,6 +1085,7 @@ static const struct rvin_group_route rcar_info_r8a77965_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a77965 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 7,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a77965_routes,
> > > @@ -1098,6 +1105,7 @@ static const struct rvin_group_route rcar_info_r8a77970_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a77970 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 3,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a77970_routes,
> > > @@ -1126,6 +1134,7 @@ static const struct rvin_group_route rcar_info_r8a77980_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a77980 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 15,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a77980_routes,
> > > @@ -1142,6 +1151,7 @@ static const struct rvin_group_route rcar_info_r8a77990_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a77990 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 5,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a77990_routes,
> > > @@ -1154,6 +1164,7 @@ static const struct rvin_group_route rcar_info_r8a77995_routes[] = {
> > >  static const struct rvin_info rcar_info_r8a77995 = {
> > >  	.model = RCAR_GEN3,
> > >  	.use_mc = true,
> > > +	.vin_max_id = 4,
> > >  	.max_width = 4096,
> > >  	.max_height = 4096,
> > >  	.routes = rcar_info_r8a77995_routes,
> > > diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/rcar-vin/rcar-vin.h
> > > index 0b13b34d03e3..2726c56935e4 100644
> > > --- a/drivers/media/platform/rcar-vin/rcar-vin.h
> > > +++ b/drivers/media/platform/rcar-vin/rcar-vin.h
> > > @@ -28,7 +28,8 @@
> > >  #define HW_BUFFER_MASK 0x7f
> > >
> > >  /* Max number on VIN instances that can be in a system */
> > > -#define RCAR_VIN_NUM 8
> > > +#define RCAR_VIN_NUM 16
> > > +
> > >
> > >  struct rvin_group;
> > >
> > > @@ -126,6 +127,7 @@ struct rvin_group_route {
> > >   * struct rvin_info - Information about the particular VIN implementation
> > >   * @model:		VIN model
> > >   * @use_mc:		use media controller instead of controlling subdevice
> > > + * @vin_max_id:		id of the last VIN instance
> > >   * @max_width:		max input width the VIN supports
> > >   * @max_height:		max input height the VIN supports
> > >   * @routes:		list of possible routes from the CSI-2 recivers to
> > > @@ -135,6 +137,7 @@ struct rvin_info {
> > >  	enum model_id model;
> > >  	bool use_mc;
> > >
> > > +	unsigned int vin_max_id;
> > >  	unsigned int max_width;
> > >  	unsigned int max_height;
> > >  	const struct rvin_group_route *routes;
> > > --
> > > 2.21.0
> > >
> >
> > --
> > Regards,
> > Niklas Söderlund



-- 
Regards,
Niklas Söderlund
