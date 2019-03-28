Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F47C43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A2C20811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 19:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800687;
	bh=8hjdCT0gTdO7N8C95+lkYgTpVcDI7SxPFtKmeF7Fn3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m3vQ3iprX4GPVpbPDqRb9KwMenpQOFGQIYjXxKaplLNLZIAKKQgkZzvVJQjU6qsbg
	 NycYy65OKQQOTv43BEsCFifSEa3mU2z5lcOqI6U9/oDJ7MEmlc83Rhd9JDyGlT5Q+d
	 YBkYg2XmqcTTGF0FNdyAZXc9N4Tzi5S64VYJuqrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfC1TSG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:18:06 -0400
Received: from casper.infradead.org ([85.118.1.10]:56804 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1TSG (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 15:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FTeKh+HslMZbsa12y6Pw6rObeNXdpOTBx7rvmmnMN1A=; b=EDHUklhnKUgIet4nhs5mvQgvLh
        ZKma4BErPBTxgkY0SVPgMIydK/g8jChD4r3jcBMTHvliwG00V+TvTwYvss16pbLQNrcX21hoW3ihS
        hfF6iNamzOVJZUDf1nlp00iAK2ahwlqZPlWrK1jbUR32FLAuvvX9o6ZYrZATxVRpfEBFVj6ajXpfK
        5SmpK6tA5GIed21azZbEiB9PBlRfBu44X72JtNioS0vDl3y56qW3PxsikDuK5Jfi3iFHvVpdkj38f
        9Q+qZLifJeqZaGazg3xAKrGsIwcjp9ZI4YZPbT1++ATGVSIxaBByz8oPOrF3re6phdlfhGOoB7K4Z
        EaPDC/tQ==;
Received: from [179.183.99.176] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9aXL-0003BS-9x; Thu, 28 Mar 2019 19:18:03 +0000
Date:   Thu, 28 Mar 2019 16:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Samuel CHEMLA <chemla.samuel@gmail.com>
Cc:     Sean Young <sean@mess.org>, Gregor Jasny <gjasny@googlemail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [Bug report] dvbv5-zap crash dvb-tool ARMHF builds
Message-ID: <20190328161758.2da2bf4e@coco.lan>
In-Reply-To: <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
        <20190317065242.137cb095@coco.lan>
        <20190319164507.7f95af89@coco.lan>
        <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com>
        <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
        <20190321083044.621f1922@coco.lan>
        <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
        <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
        <20190325140838.71f88eac@coco.lan>
        <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
        <20190326132643.r3svehoa764xagje@gofer.mess.org>
        <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
        <20190326123115.5d83f450@coco.lan>
        <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Thu, 28 Mar 2019 19:48:35 +0100
Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:

> Hi,

Please, don't top post.
>=20
>=20
> 1) I did reproduce the bug with a serial console, but the serial
> console was also frozen, and there was no message before freeze.

The only way for a machine to freeze even on serial console is due to
a very serious Kernel or hardware bug, like a bad lock/semaphore.

> 2) I also tried a powered USB HUB but it didn't change anything.

Ok.

> 3) I tried DVBJet, from https://github.com/lightful/DVBdirect , it is
> a tuner that directly does ioctl on linux kernel DVB device.
> I couldn't reproduce the issue with DVBJet.

I don't know DVBJet. If it uses the same Kernel drivers, maybe
it could then be a race issue: send commands on a slower way to
the Kernel would be solving the issue.

> It's been running for almost 48Hrs now, without a crash.
> I collect all PIDs on the multiplex, just like dvbv5-zap, so the USB
> port is solicited at it's maximum.
>=20
> That makes me think it is not a hardware issue.
> I'm pretty sure dvbv5-zap can still improve, and it already did when
> you fixed: struct arguments args =3D {};

Everything can be improved, but the thing is that we need first to
discover the root cause :-)

Can you post on pastebin (or equivalent) the dmesg with the
DVBJet running? Maybe it could be printing some Kernel messages
that might help to discover what's going wrong.

Btw, could you also apply this patch:
	https://patchwork.linuxtv.org/patch/55274/

It is probably unrelated, but this is the kind of bug that could cause
such issues.

>=20
>=20
> Regards
>=20
> Le mar. 26 mars 2019 =C3=A0 16:31, Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> a =C3=A9crit :
> >
> > Em Tue, 26 Mar 2019 16:10:33 +0100
> > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
> > =20
> > > Hi,
> > >
> > > =20
> > > > Earlier you said "random hangs are back". When this happens, does t=
he whole
> > > > device become unresponsive or just dvbv5-zap? =20
> > > The device completely freeze, you can't even switch numlock on/off. =
=20
> >
> > dvbv5-tools can't hang the machine. this is very likely happening due to
> > a Kernel crash.
> > =20
> > > I said "the issue is back", it is because I **thought** it was gone.
> > > To be more precise:
> > > - on raspberry zero W, the issue is gone since Mauro's patch
> > > (https://git.linuxtv.org/v4l-utils.git/commit/?id=3D22b06353227e04695=
b1b0a9622b896b948adba89)
> > > - on raspberry 2, the issue, it is still there and the patch has no
> > > effect (the issue was and is still there) =20
> >
> > RPi2 has a serious issue with their USB ports: on devices that require
> > more than a few mW to work, it causes several device disconnection and
> > re-connection, as it cannot sustain the required 5V.
> >
> > Depending on how fast this happens, it could be triggering some Kernel
> > bug.
> >
> > That affects most V4L and DVB devices. You should either use a powered
> > USB 2.0 hub (with may be problematic, as the USB host driver on RPi
> > has issues - and may cause data loss on high sustained ISOC traffic,
> > specially when used with hubs) or a device that has its own power
> > supply, like DVBSky T680C or S960.
> > =20
> > > > Since this issue is "back",
> > > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 an=
d 1.16.4. =20
> > > The issue doesn't appear anymore on raspberry zero W since Mauro's co=
mmit.
> > > So it did improve on that platform.
> > > =20
> > > > It would be useful to see the output from dmesg (best thing would b=
e after
> > > > the issue occurs). =20
> > > You can't, device is frozen.
> > > Logs are not flushed to disk, and journalctl -f freeze before showing=
 anything =20
> >
> > You can use a serial port in order to get the logs. On a serial console,
> > use something like:
> >
> >         # dmesg -n 8
> >
> > In order to make sure it will display all Kernel messages at console.
> > =20
> > > =20
> > > > Also what dvb hardware are you using? =20
> > > I reproduced it with different two tuners: rtl2832U from RTL-SDR.COM
> > > and a TerraTec Cinergy T Stick+ =20
> >
> > None of them supports an external power supply.
> > =20
> > > You can found all the details here:
> > > https://bugs.launchpad.net/raspbian/+bug/1819650
> > >
> > >
> > > Sam
> > >
> > >
> > > Le mar. 26 mars 2019 =C3=A0 14:26, Sean Young <sean@mess.org> a =C3=
=A9crit : =20
> > > >
> > > > Hi Sam,
> > > >
> > > > On Tue, Mar 26, 2019 at 08:35:44AM +0100, Samuel CHEMLA wrote: =20
> > > > > Hi,
> > > > >
> > > > >
> > > > > I am struggling with valgrind because it always complain with eit=
her :
> > > > >     ASan runtime does not come first in initial library list; you
> > > > > should either link runtime to your application or manually preloa=
d it
> > > > > with LD_PRELOAD =20
> > > > >     -> When I LD_PRELOAD, I'm getting a segfault, but I couldn't =
find =20
> > > > > any core dump
> > > > >
> > > > > or, if I link statically libasan with -static-libasan:
> > > > >     Shadow memory range interleaves with an existing memory mappi=
ng.
> > > > > ASan cannot proceed correctly. ABORTING.
> > > > >     ASan shadow was supposed to be located in the
> > > > > [0x00007fff7000-0x10007fff7fff] range.
> > > > >
> > > > >
> > > > > I retested again on my raspberry zero W, and I confirm i cannot
> > > > > reproduce the hang.
> > > > > Your fix did work on that device.
> > > > > I am testing with same OS (raspbian with latest updates, same ker=
nel),
> > > > > same configure options, same USB dongle... :-(
> > > > > The only differences are CPU architecture (armv6 vs armv7), memory
> > > > > constraints, and I was not using the same channels.conf, I'll fix=
 that
> > > > > today and re-check =20
> > > >
> > > > Earlier you said "random hangs are back". When this happens, does t=
he whole
> > > > device become unresponsive or just dvbv5-zap? Since this issue is "=
back",
> > > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 an=
d 1.16.4.
> > > >
> > > > It would be useful to see the output from dmesg (best thing would b=
e after
> > > > the issue occurs).
> > > >
> > > > Also what dvb hardware are you using?
> > > >
> > > > Thanks,
> > > >
> > > > san
> > > > =20
> > > > >
> > > > >
> > > > > Sam
> > > > >
> > > > > On 25/03/2019 18:08, Mauro Carvalho Chehab wrote:
> > > > >
> > > > > Em Mon, 25 Mar 2019 17:33:30 +0100
> > > > > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
> > > > >
> > > > > Hi guys,
> > > > >
> > > > > I'm afraid I'm coming with sad news.
> > > > > I just tried both stable-1.12 and stable-1.16 on a raspberry pi 2=
, and
> > > > > random hangs are back (see https://bugs.launchpad.net/raspbian/+b=
ug/1819650
> > > > > ).
> > > > > I previously test both branches on a raspberry zero and issues we=
re gone
> > > > > (same raspbian version).
> > > > > There may be more memory issues somewhere...
> > > > >
> > > > > Could you test it with valgrind?
> > > > >
> > > > > Sam
> > > > >
> > > > > Le jeu. 21 mars 2019 =C5=95 20:59, Gregor Jasny <gjasny@googlemai=
l.com> a =C3=A9crit :
> > > > >
> > > > > Hello,
> > > > >
> > > > > On 21.03.19 12:30, Mauro Carvalho Chehab wrote:
> > > > >
> > > > > I went ahead and cherry-picked the relevant patches to -1.12, -1.=
14 and
> > > > > -1.16, and tested both dvbv5-zap and dvbv5-scan with all versions=
. So,
> > > > >
> > > > > we can
> > > > >
> > > > > release a new minor version for all those stable branches.
> > > > >
> > > > > After the patches, on my tests, I didn't get any memory leaks or
> > > > > double-free issues.
> > > > >
> > > > > I issues a new 1.12, 1.14, and 1.16 release.
> > > > >
> > > > > Thanks,
> > > > > Gregor
> > > > >
> > > > >
> > > > >
> > > > > Thanks,
> > > > > Mauro =20
> >
> >
> >
> > Thanks,
> > Mauro =20



Thanks,
Mauro
