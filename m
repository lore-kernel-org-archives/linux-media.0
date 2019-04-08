Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00346C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50C920880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742246;
	bh=Vh3RF2vAh8XltLAmFofHScRjMXZJ78p2PRFHxIPi+s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=amT/BKb28XZDKwZGuntDSVAT8X2RHGYNJYGIAXeEJVxvB0YucIHOjxls5cU1V5Id8
	 4hHrjTCDmh30Yhg96RkK5VsoGd13oTzrJMtquC7WInWnlwb8sr9ICRUN3GGnIh1del
	 +Uf3f8D9OKqQq0nITBW38oCiLNlA81iA9A9EojEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfDHQuq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:50:46 -0400
Received: from casper.infradead.org ([85.118.1.10]:37998 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHQuq (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 12:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4AgoShBlhExy9l5Do3JMV9tKenU+6LXUqdXOzd20ye0=; b=PoT2umfQmyyC+LhobBCF6tlB16
        vK9miyu7NvLw4hhujLr1k2q/WYPLo7GIYZuUOaoLCYMz8YqSszC6Nm/uryopbdVvdQkjqZqdgfS1K
        TaoW55j1EHSAM+KBaMS/i9CLq0XCSjLo/WBpKo+1CwAdryx3NMdW9OZeQOWcKljCdgY3ZBfKHVqvq
        fTmrDnEN2F4Zk6WGpsLnURpgNXV9P2Nk/gGw8uZDQGjuPCelabkM5vHSv04v38t2tIeYv57bA+Fnl
        JCCsUNLAuhjRgrSrfUJ+ptzuPka25brann/D/HVX/zwWAekIcOB+YjEJqqg0bljHKtGMsQqNLNROv
        /sZm99XQ==;
Received: from [179.95.33.162] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXTm-0007Sq-Av; Mon, 08 Apr 2019 16:50:42 +0000
Date:   Mon, 8 Apr 2019 13:50:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
Message-ID: <20190408135038.6387d595@coco.lan>
In-Reply-To: <e2a6772f-61a4-8ff8-d815-c71dfd7120e2@xs4all.nl>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
        <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
        <20190408072854.13077345@coco.lan>
        <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
        <1554734486.6439.6.camel@pengutronix.de>
        <e2a6772f-61a4-8ff8-d815-c71dfd7120e2@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 8 Apr 2019 16:46:02 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 4/8/19 4:41 PM, Philipp Zabel wrote:
> > On Mon, 2019-04-08 at 12:44 +0200, Hans Verkuil wrote (paraphrased): =20
> >> On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote (paraphrased): =20
> > [...] =20
> >>>> [I hate colors] =20
> >>> [I love colors] =20
> >> I could live with [compromise] =20
> >=20
> > Sorry for opening that can of worms :-)
> >=20
> > How about doing something similar to 'ls':
> >=20
> > - an environment variable V4L_COLORS which, if not set, defaults to
> >   V4L_COLORS=3D"ok=3D32:warn=3D1:fail=3D1;31"
> > - an option --color=3Dalways|never|auto, which if not set, defaults to
> >   auto (check isatty())
> > - to disable colors by default, set V4L_COLORS to "ok=3D0:warn=3D0:fail=
=3D0"
> >=20
> > This would allow to pipe colors into non-terminal stdout like less -R if
> > desired,=C2=A0or quickly disable colors with --color=3Dnever.
> > The pattern could be extended to include dvbv5 log levels or fe tool
> > quality levels.
> >=20
> > Or alternatively, V4L_COLOR=3Dalways|never|auto for easier configuratio=
n,
> > but with a fixed color scheme? =20
>=20
> I think that is easiest. As long as the color scheme works for both black=
-on-white
> and white-on-black it should be fine.

Instead of V4L2_COLOR, perhaps MEDIA_APPS_COLLOR would be a better name,
as the same env var could be used also for DVB tools.

>=20
> Regards,
>=20
> 	Hans



Thanks,
Mauro
