Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03EDC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE962064A
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 18:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTXN+y0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfC1Sst (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:48:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1Sst (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 14:48:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so18136158edd.13
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ncgIbsdnCr5I5/T8/qcbWRB53JQcZL8LXEP6b9PoZc=;
        b=sTXN+y0U2H8WAFs1MEA4DbjVKsj32A/hU8Y4y/b5W9nj51HLHdnkRXhc04mhDBJs0d
         pArohibt2V+WJn+nTHskjnvvTlKdzvjoC9RpNBr1Wu7vnzIkN3Fk454+qjTc71YoBkOz
         MGTnMmi3VzYNnvYWcMhbuwdqZYVGEGNsSw25mIhN51XsXOeIHkeFTOe6RTEYYqKZMF2Q
         yvi+lfzkfxclRCMZOxJE4Y+NWbnJCgqWgCK2X+aF34NXETz/h1ByrgevEnphw7GEb9XM
         6HImlyFiZUQBXa/inulL1XGazZ/NRdtBmlLVaoPhJC6HDejmNDV99az8bzcj20JWdFQL
         brkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ncgIbsdnCr5I5/T8/qcbWRB53JQcZL8LXEP6b9PoZc=;
        b=pGaC+PxTjmI07sl/3xRY4FtdQnza0UG17rU94lnkXCZdWuulkBmjGI4qGVZgzIA7FU
         dhTn5mLGNYsnl5FzRmmrg90D92FeI0OPdrDTJCU3xSBR/vG4OPmcMFysu6R7draDt2e7
         9hqe+PCle3UJ2he422Atx6sbkao6cHgrV4YUHDnX+d2Z/gHSnc0uSs4ALSHhAYz3HIrk
         hcV35HaBb/5M2vFYbFNDXe08n/YpA4tMGo24nQi87SVq5h9dHwcZawK8hPLpfiofkYdT
         x65QCYImQBfuRJPWR46bKgyrjyC58/wIXlcJiQ6udhckqA9bMpKwGCrtwF/uTS5O50O3
         53QA==
X-Gm-Message-State: APjAAAUCSIAanb13WA2dTCP0c7nkcBsJej5maCVyeMfJd1ltNrwy/Lrf
        PZ8s8xMhE6S9CjXkmEIwe7pyVf+mKVIEd3N8wkMqgb9l
X-Google-Smtp-Source: APXvYqw/ox9uQfJi3rz8tI2j5jzsR0NijgV7Ue3LSSnoOIvvuKFRtI9qI27dRqCctdYTTHJnDLcRndvfFyXnZfXfRUM=
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr25556716ejt.82.1553798927068;
 Thu, 28 Mar 2019 11:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
 <20190317065242.137cb095@coco.lan> <20190319164507.7f95af89@coco.lan>
 <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com> <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
 <20190321083044.621f1922@coco.lan> <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
 <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
 <20190325140838.71f88eac@coco.lan> <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
 <20190326132643.r3svehoa764xagje@gofer.mess.org> <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
 <20190326123115.5d83f450@coco.lan>
In-Reply-To: <20190326123115.5d83f450@coco.lan>
From:   Samuel CHEMLA <chemla.samuel@gmail.com>
Date:   Thu, 28 Mar 2019 19:48:35 +0100
Message-ID: <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
Subject: Re: [Bug report] dvbv5-zap crash dvb-tool ARMHF builds
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Sean Young <sean@mess.org>, Gregor Jasny <gjasny@googlemail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,


1) I did reproduce the bug with a serial console, but the serial
console was also frozen, and there was no message before freeze.
2) I also tried a powered USB HUB but it didn't change anything.
3) I tried DVBJet, from https://github.com/lightful/DVBdirect , it is
a tuner that directly does ioctl on linux kernel DVB device.
I couldn't reproduce the issue with DVBJet.
It's been running for almost 48Hrs now, without a crash.
I collect all PIDs on the multiplex, just like dvbv5-zap, so the USB
port is solicited at it's maximum.

That makes me think it is not a hardware issue.
I'm pretty sure dvbv5-zap can still improve, and it already did when
you fixed: struct arguments args =3D {};


Regards

Le mar. 26 mars 2019 =C3=A0 16:31, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> a =C3=A9crit :
>
> Em Tue, 26 Mar 2019 16:10:33 +0100
> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>
> > Hi,
> >
> >
> > > Earlier you said "random hangs are back". When this happens, does the=
 whole
> > > device become unresponsive or just dvbv5-zap?
> > The device completely freeze, you can't even switch numlock on/off.
>
> dvbv5-tools can't hang the machine. this is very likely happening due to
> a Kernel crash.
>
> > I said "the issue is back", it is because I **thought** it was gone.
> > To be more precise:
> > - on raspberry zero W, the issue is gone since Mauro's patch
> > (https://git.linuxtv.org/v4l-utils.git/commit/?id=3D22b06353227e04695b1=
b0a9622b896b948adba89)
> > - on raspberry 2, the issue, it is still there and the patch has no
> > effect (the issue was and is still there)
>
> RPi2 has a serious issue with their USB ports: on devices that require
> more than a few mW to work, it causes several device disconnection and
> re-connection, as it cannot sustain the required 5V.
>
> Depending on how fast this happens, it could be triggering some Kernel
> bug.
>
> That affects most V4L and DVB devices. You should either use a powered
> USB 2.0 hub (with may be problematic, as the USB host driver on RPi
> has issues - and may cause data loss on high sustained ISOC traffic,
> specially when used with hubs) or a device that has its own power
> supply, like DVBSky T680C or S960.
>
> > > Since this issue is "back",
> > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 and =
1.16.4.
> > The issue doesn't appear anymore on raspberry zero W since Mauro's comm=
it.
> > So it did improve on that platform.
> >
> > > It would be useful to see the output from dmesg (best thing would be =
after
> > > the issue occurs).
> > You can't, device is frozen.
> > Logs are not flushed to disk, and journalctl -f freeze before showing a=
nything
>
> You can use a serial port in order to get the logs. On a serial console,
> use something like:
>
>         # dmesg -n 8
>
> In order to make sure it will display all Kernel messages at console.
>
> >
> > > Also what dvb hardware are you using?
> > I reproduced it with different two tuners: rtl2832U from RTL-SDR.COM
> > and a TerraTec Cinergy T Stick+
>
> None of them supports an external power supply.
>
> > You can found all the details here:
> > https://bugs.launchpad.net/raspbian/+bug/1819650
> >
> >
> > Sam
> >
> >
> > Le mar. 26 mars 2019 =C3=A0 14:26, Sean Young <sean@mess.org> a =C3=A9c=
rit :
> > >
> > > Hi Sam,
> > >
> > > On Tue, Mar 26, 2019 at 08:35:44AM +0100, Samuel CHEMLA wrote:
> > > > Hi,
> > > >
> > > >
> > > > I am struggling with valgrind because it always complain with eithe=
r :
> > > >     ASan runtime does not come first in initial library list; you
> > > > should either link runtime to your application or manually preload =
it
> > > > with LD_PRELOAD
> > > >     -> When I LD_PRELOAD, I'm getting a segfault, but I couldn't fi=
nd
> > > > any core dump
> > > >
> > > > or, if I link statically libasan with -static-libasan:
> > > >     Shadow memory range interleaves with an existing memory mapping=
.
> > > > ASan cannot proceed correctly. ABORTING.
> > > >     ASan shadow was supposed to be located in the
> > > > [0x00007fff7000-0x10007fff7fff] range.
> > > >
> > > >
> > > > I retested again on my raspberry zero W, and I confirm i cannot
> > > > reproduce the hang.
> > > > Your fix did work on that device.
> > > > I am testing with same OS (raspbian with latest updates, same kerne=
l),
> > > > same configure options, same USB dongle... :-(
> > > > The only differences are CPU architecture (armv6 vs armv7), memory
> > > > constraints, and I was not using the same channels.conf, I'll fix t=
hat
> > > > today and re-check
> > >
> > > Earlier you said "random hangs are back". When this happens, does the=
 whole
> > > device become unresponsive or just dvbv5-zap? Since this issue is "ba=
ck",
> > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 and =
1.16.4.
> > >
> > > It would be useful to see the output from dmesg (best thing would be =
after
> > > the issue occurs).
> > >
> > > Also what dvb hardware are you using?
> > >
> > > Thanks,
> > >
> > > san
> > >
> > > >
> > > >
> > > > Sam
> > > >
> > > > On 25/03/2019 18:08, Mauro Carvalho Chehab wrote:
> > > >
> > > > Em Mon, 25 Mar 2019 17:33:30 +0100
> > > > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
> > > >
> > > > Hi guys,
> > > >
> > > > I'm afraid I'm coming with sad news.
> > > > I just tried both stable-1.12 and stable-1.16 on a raspberry pi 2, =
and
> > > > random hangs are back (see https://bugs.launchpad.net/raspbian/+bug=
/1819650
> > > > ).
> > > > I previously test both branches on a raspberry zero and issues were=
 gone
> > > > (same raspbian version).
> > > > There may be more memory issues somewhere...
> > > >
> > > > Could you test it with valgrind?
> > > >
> > > > Sam
> > > >
> > > > Le jeu. 21 mars 2019 =C5=95 20:59, Gregor Jasny <gjasny@googlemail.=
com> a =C3=A9crit :
> > > >
> > > > Hello,
> > > >
> > > > On 21.03.19 12:30, Mauro Carvalho Chehab wrote:
> > > >
> > > > I went ahead and cherry-picked the relevant patches to -1.12, -1.14=
 and
> > > > -1.16, and tested both dvbv5-zap and dvbv5-scan with all versions. =
So,
> > > >
> > > > we can
> > > >
> > > > release a new minor version for all those stable branches.
> > > >
> > > > After the patches, on my tests, I didn't get any memory leaks or
> > > > double-free issues.
> > > >
> > > > I issues a new 1.12, 1.14, and 1.16 release.
> > > >
> > > > Thanks,
> > > > Gregor
> > > >
> > > >
> > > >
> > > > Thanks,
> > > > Mauro
>
>
>
> Thanks,
> Mauro
