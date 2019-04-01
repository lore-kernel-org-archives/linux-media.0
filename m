Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13286C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBCA206DD
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 18:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dct1Oebr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDAS6V (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:58:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45000 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDAS6V (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 14:58:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id x10so9219826edh.11
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6xZRaY46KMNareF6tOY3a7XT/7P4XS5D7ll7TdVHbw=;
        b=Dct1OebrBqd5IJRAmImcqVWhRriDHpRvv2e3wgI8/H5mFVbtAzCW0BYMR6CFv/uMpd
         b7rTp9zPqhsb5a/I0Cft3HwPrbBQJXPYvaKRiYNhK9AgCyfifY0YtD/arnvaNCXv4vyZ
         4RCZLb+JblDBKVOqb8vf1A8kx30CTbRNXNtrdxnsGEttJ05iG2kikDJ8AFmeoeGAGrNx
         64kb5hjHupo8hJ0C3T0lvgvCww+W0b+Z+bu3G/oslnU4i6PLSZkBVbbc2VzGEuWm/OIJ
         7uK1PMl48gElDiX0aQflqWFBBcY+6Rd1Zx/5kvi2VL4h0aZDZVyX4ZN3cPjQmfPLFBNq
         H93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6xZRaY46KMNareF6tOY3a7XT/7P4XS5D7ll7TdVHbw=;
        b=ogPnH7pRi45AKxl+Ljo8mwOS+14Ey7Hr5B0V8j03VzCmB1bozystMlFq7CIqlxd9Mu
         dY4Wi+oEQglsUwas1d4JgcdjytN1roiHn3b5psLXcg+gDn9DP/1XoqDOBTnBJDkxmM7n
         IleSdVlJWnBBrYGVH2ihxy6BOro1h95qEBRgUQ29SvzCjBb7xqFSVyl5PsQ6g3w8jrVe
         luw6RicrkGd2qP0kvrNo4Eao7XHmVaHnGydJd3r0f6QMWSO2dpZ8r1wPirXKRGgZYVh7
         CYuleYHUgJheBolvkMBRZsgq+9nmUqURih5p3l+J/yhb7qE4IE1BICzYzV4NM6oDTYYP
         7YUg==
X-Gm-Message-State: APjAAAXwyIdliTT7I+rLIj/slixVUy2bL68p4S8jtXjpDkoeQ3dpMJOL
        0TaJ1GmzjPzK29k4OMhd/wNwC9VfzfLT0MHfPV8=
X-Google-Smtp-Source: APXvYqztZ9wSXNbbORyMXS3oIJf+6n/buYlZCLdyUEMUq8MlhDUurZ/L2YfcctlD6/3Q9NSnLO3Ej4XcbcPv383j9QQ=
X-Received: by 2002:a17:906:1942:: with SMTP id b2mr37636271eje.5.1554145099283;
 Mon, 01 Apr 2019 11:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190315223425.hiq3qcjhjnirsizh@gofer.mess.org>
 <20190317065242.137cb095@coco.lan> <20190319164507.7f95af89@coco.lan>
 <a1f296ba-3c27-ed2c-3912-4edbeeb21eba@googlemail.com> <20190321094127.ysurm4u26zugmnmv@gofer.mess.org>
 <20190321083044.621f1922@coco.lan> <35ba4e81-fc2a-87ed-8da7-43cc4543de51@googlemail.com>
 <CANJnhGfRtEwAony5Z4rFMPcu58aF2k0G+9NSkMKsq_PhfmSNqw@mail.gmail.com>
 <20190325140838.71f88eac@coco.lan> <CANJnhGc_qx32nm7yZheC2ioHOij8QELbnwyJkZ83G9uYTxqwtA@mail.gmail.com>
 <20190326132643.r3svehoa764xagje@gofer.mess.org> <CANJnhGfgzrLZedeoCOq3L-MaEgjtHm1Bwn1cRPr54LvwZ=RBMQ@mail.gmail.com>
 <20190326123115.5d83f450@coco.lan> <CANJnhGe+nyq6a43BnPmGxb6_9JinFyy1EC=6Xo6K4RUpshm8Ow@mail.gmail.com>
 <20190328161758.2da2bf4e@coco.lan>
In-Reply-To: <20190328161758.2da2bf4e@coco.lan>
From:   Samuel CHEMLA <chemla.samuel@gmail.com>
Date:   Mon, 1 Apr 2019 20:58:07 +0200
Message-ID: <CANJnhGfjgejV=Vsj06JDfkDCPQ5z5tm7-sT2fBn=ALxdrSaQAw@mail.gmail.com>
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

Le jeu. 28 mars 2019 =C3=A0 20:18, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> a =C3=A9crit :
>
> Em Thu, 28 Mar 2019 19:48:35 +0100
> Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
>
> > Hi,
>
> Please, don't top post.
> >
> >
> > 1) I did reproduce the bug with a serial console, but the serial
> > console was also frozen, and there was no message before freeze.
>
> The only way for a machine to freeze even on serial console is due to
> a very serious Kernel or hardware bug, like a bad lock/semaphore.
>
> > 2) I also tried a powered USB HUB but it didn't change anything.
>
> Ok.
>
> > 3) I tried DVBJet, from https://github.com/lightful/DVBdirect , it is
> > a tuner that directly does ioctl on linux kernel DVB device.
> > I couldn't reproduce the issue with DVBJet.
>
> I don't know DVBJet. If it uses the same Kernel drivers, maybe
> it could then be a race issue: send commands on a slower way to
> the Kernel would be solving the issue.
>
> > It's been running for almost 48Hrs now, without a crash.
> > I collect all PIDs on the multiplex, just like dvbv5-zap, so the USB
> > port is solicited at it's maximum.
> >
> > That makes me think it is not a hardware issue.
> > I'm pretty sure dvbv5-zap can still improve, and it already did when
> > you fixed: struct arguments args =3D {};
>
> Everything can be improved, but the thing is that we need first to
> discover the root cause :-)
>
> Can you post on pastebin (or equivalent) the dmesg with the
> DVBJet running? Maybe it could be printing some Kernel messages
> that might help to discover what's going wrong.

Here is the dmesg: https://pastebin.com/3XRim4XL
Just look at the code, it's quite straightforward, just a few ioctl.

>
> Btw, could you also apply this patch:
>         https://patchwork.linuxtv.org/patch/55274/

OK, I'll give it a try and provide feedback

>
> It is probably unrelated, but this is the kind of bug that could cause
> such issues.
>
> >
> >
> > Regards
> >
> > Le mar. 26 mars 2019 =C3=A0 16:31, Mauro Carvalho Chehab
> > <mchehab+samsung@kernel.org> a =C3=A9crit :
> > >
> > > Em Tue, 26 Mar 2019 16:10:33 +0100
> > > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
> > >
> > > > Hi,
> > > >
> > > >
> > > > > Earlier you said "random hangs are back". When this happens, does=
 the whole
> > > > > device become unresponsive or just dvbv5-zap?
> > > > The device completely freeze, you can't even switch numlock on/off.
> > >
> > > dvbv5-tools can't hang the machine. this is very likely happening due=
 to
> > > a Kernel crash.
> > >
> > > > I said "the issue is back", it is because I **thought** it was gone=
.
> > > > To be more precise:
> > > > - on raspberry zero W, the issue is gone since Mauro's patch
> > > > (https://git.linuxtv.org/v4l-utils.git/commit/?id=3D22b06353227e046=
95b1b0a9622b896b948adba89)
> > > > - on raspberry 2, the issue, it is still there and the patch has no
> > > > effect (the issue was and is still there)
> > >
> > > RPi2 has a serious issue with their USB ports: on devices that requir=
e
> > > more than a few mW to work, it causes several device disconnection an=
d
> > > re-connection, as it cannot sustain the required 5V.
> > >
> > > Depending on how fast this happens, it could be triggering some Kerne=
l
> > > bug.
> > >
> > > That affects most V4L and DVB devices. You should either use a powere=
d
> > > USB 2.0 hub (with may be problematic, as the USB host driver on RPi
> > > has issues - and may cause data loss on high sustained ISOC traffic,
> > > specially when used with hubs) or a device that has its own power
> > > supply, like DVBSky T680C or S960.
> > >
> > > > > Since this issue is "back",
> > > > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 =
and 1.16.4.
> > > > The issue doesn't appear anymore on raspberry zero W since Mauro's =
commit.
> > > > So it did improve on that platform.
> > > >
> > > > > It would be useful to see the output from dmesg (best thing would=
 be after
> > > > > the issue occurs).
> > > > You can't, device is frozen.
> > > > Logs are not flushed to disk, and journalctl -f freeze before showi=
ng anything
> > >
> > > You can use a serial port in order to get the logs. On a serial conso=
le,
> > > use something like:
> > >
> > >         # dmesg -n 8
> > >
> > > In order to make sure it will display all Kernel messages at console.
> > >
> > > >
> > > > > Also what dvb hardware are you using?
> > > > I reproduced it with different two tuners: rtl2832U from RTL-SDR.CO=
M
> > > > and a TerraTec Cinergy T Stick+
> > >
> > > None of them supports an external power supply.
> > >
> > > > You can found all the details here:
> > > > https://bugs.launchpad.net/raspbian/+bug/1819650
> > > >
> > > >
> > > > Sam
> > > >
> > > >
> > > > Le mar. 26 mars 2019 =C3=A0 14:26, Sean Young <sean@mess.org> a =C3=
=A9crit :
> > > > >
> > > > > Hi Sam,
> > > > >
> > > > > On Tue, Mar 26, 2019 at 08:35:44AM +0100, Samuel CHEMLA wrote:
> > > > > > Hi,
> > > > > >
> > > > > >
> > > > > > I am struggling with valgrind because it always complain with e=
ither :
> > > > > >     ASan runtime does not come first in initial library list; y=
ou
> > > > > > should either link runtime to your application or manually prel=
oad it
> > > > > > with LD_PRELOAD
> > > > > >     -> When I LD_PRELOAD, I'm getting a segfault, but I couldn'=
t find
> > > > > > any core dump
> > > > > >
> > > > > > or, if I link statically libasan with -static-libasan:
> > > > > >     Shadow memory range interleaves with an existing memory map=
ping.
> > > > > > ASan cannot proceed correctly. ABORTING.
> > > > > >     ASan shadow was supposed to be located in the
> > > > > > [0x00007fff7000-0x10007fff7fff] range.
> > > > > >
> > > > > >
> > > > > > I retested again on my raspberry zero W, and I confirm i cannot
> > > > > > reproduce the hang.
> > > > > > Your fix did work on that device.
> > > > > > I am testing with same OS (raspbian with latest updates, same k=
ernel),
> > > > > > same configure options, same USB dongle... :-(
> > > > > > The only differences are CPU architecture (armv6 vs armv7), mem=
ory
> > > > > > constraints, and I was not using the same channels.conf, I'll f=
ix that
> > > > > > today and re-check
> > > > >
> > > > > Earlier you said "random hangs are back". When this happens, does=
 the whole
> > > > > device become unresponsive or just dvbv5-zap? Since this issue is=
 "back",
> > > > > I wouldn't be surprised this is unrelated to the fixes in 1.12.7 =
and 1.16.4.
> > > > >
> > > > > It would be useful to see the output from dmesg (best thing would=
 be after
> > > > > the issue occurs).
> > > > >
> > > > > Also what dvb hardware are you using?
> > > > >
> > > > > Thanks,
> > > > >
> > > > > san
> > > > >
> > > > > >
> > > > > >
> > > > > > Sam
> > > > > >
> > > > > > On 25/03/2019 18:08, Mauro Carvalho Chehab wrote:
> > > > > >
> > > > > > Em Mon, 25 Mar 2019 17:33:30 +0100
> > > > > > Samuel CHEMLA <chemla.samuel@gmail.com> escreveu:
> > > > > >
> > > > > > Hi guys,
> > > > > >
> > > > > > I'm afraid I'm coming with sad news.
> > > > > > I just tried both stable-1.12 and stable-1.16 on a raspberry pi=
 2, and
> > > > > > random hangs are back (see https://bugs.launchpad.net/raspbian/=
+bug/1819650
> > > > > > ).
> > > > > > I previously test both branches on a raspberry zero and issues =
were gone
> > > > > > (same raspbian version).
> > > > > > There may be more memory issues somewhere...
> > > > > >
> > > > > > Could you test it with valgrind?
> > > > > >
> > > > > > Sam
> > > > > >
> > > > > > Le jeu. 21 mars 2019 =C5=95 20:59, Gregor Jasny <gjasny@googlem=
ail.com> a =C3=A9crit :
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On 21.03.19 12:30, Mauro Carvalho Chehab wrote:
> > > > > >
> > > > > > I went ahead and cherry-picked the relevant patches to -1.12, -=
1.14 and
> > > > > > -1.16, and tested both dvbv5-zap and dvbv5-scan with all versio=
ns. So,
> > > > > >
> > > > > > we can
> > > > > >
> > > > > > release a new minor version for all those stable branches.
> > > > > >
> > > > > > After the patches, on my tests, I didn't get any memory leaks o=
r
> > > > > > double-free issues.
> > > > > >
> > > > > > I issues a new 1.12, 1.14, and 1.16 release.
> > > > > >
> > > > > > Thanks,
> > > > > > Gregor
> > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Mauro
> > >
> > >
> > >
> > > Thanks,
> > > Mauro
>
>
>
> Thanks,
> Mauro
