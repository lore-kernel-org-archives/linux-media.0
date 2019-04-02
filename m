Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA6C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749620830
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 08:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DFEsdR5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDBIGv (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:06:51 -0400
Received: from mout.web.de ([212.227.15.14]:57355 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728695AbfDBIGu (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Apr 2019 04:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554192394;
        bh=DlOsrgH58tufx3EwgUGjmWYurFHDNGOtw8OItSrsaOY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=DFEsdR5nJucotyh8Zi2HWno1x7qY2NgBW4LOVwtjNr6N9JJrXluorAi9uLdHnqLAk
         Q02mytlBZdSeBzr3OeANnOo+on7QuXIGUmCumzPvobntQa3T+phc/C8dfphbcUZ9+D
         f2t95J5O+zU10eUvI7fZZxzZFsGiN9a1smheK78g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([77.11.121.226]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLoc-1hRGUu06UY-00YeyK; Tue, 02
 Apr 2019 10:06:34 +0200
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andreas Regel <andreas.regel@gmx.de>,
        Manu Abraham <manu@linuxtv.org>,
        Oliver Endriss <o.endriss@gmx.de>,
        Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>,
        =?UTF-8?Q?Tycho_L=c3=bcrsen?= <tycholursen@gmail.com>,
        Uwe Scheffler <scheffler.u@web.de>,
        jogi-vdr@planetzork.ping.de, Soeren Moch <smoch@web.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Soeren Moch <smoch@web.de>
Subject: [GIT PULL v2] SAA716x DVB driver
Message-ID: <5fc93954-b5a6-c7d2-527f-1c60f3613318@web.de>
Date:   Tue, 2 Apr 2019 10:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:1gD/MJ4Ack8tBrMftEsldoMnFHKNcVyi6OYQZX5G6cucLbTNg6J
 2jH8qhTkZ+JLYA3Dm3rK5/EtgCBI+4OPiVCBPWh7cdL7XurZpyVUzzIl++Ek9qJSHv0zeNp
 J8jQUAzWI8LBGVoM6XDaPTpvA69LrMq1exxThJfRV5srjY0/dADQyDlHDpVv8NF6qaq04C9
 syoN4PDpIlMQVho1HrTQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uao1NMQFIIY=:bTT7cWvFy/YfuaGs1HSBse
 hIchS4AKwAsm4FGkVuKWsmPOtSAjiizXOwtCv14f2FOfOBQmJk8KfwJXfFa30jMrQGlaP/lb8
 BNuiew/D33BTbrZqgh/Fhs+qmqrp8Wh5TemiHGMM3QVn4HH7V2a5C+wdUeV7TN8+zmhknqirf
 eXosQ6nhsmGeaRbSOM9V6F+OMaPaUrIkuEfku90E9JcsBkOoGOiofGKCL/FqaNQM+4eb6FSr0
 Ifglo3mW+/qyV6rxeDUP7YAYmxzMUN9t1/CBQF+Dr9j1v2vNj8TbAYQz8GVDdMBYFwu5Yf1pq
 q23nHmyiWhhOos3vpZ+A0eZ6Cg3bGYuCWshgCybfSJt2NxFbJdxpiefq0MXGIzef4aoBceJPn
 P+myutkLaP4P3XsMpXaNKLzj+q7uzh2KaCUrNHTQdjYySSxspYMaTSwmkWOW+SuDh49os/q9J
 3MdH+RTts/GcU/oeRj62UHRvDOadkXY1+pvSw+k+QPZIWRsukIczkDMu8k/Ayg1j6OfIISPJP
 hA3rG/+74GoHxGZ/GPTmdabeiQrmMFq5rLaJb4yRyBSfMKex7uh3vMqyvQhITdWwwscAZcujE
 pW7L8YKrF1UbvCZzyfxFWjX+UTvdpMawwyinGnfgmywayN4VTPkyQ+z/Pl1oOcYkf0xHzCkdK
 F5hdY0WhorRFJys/qc7nNg81mvtMstOaCZm76/tN1YR3c3rUdWBIbo6Szh1WX9g2xlY0C+wGK
 H8dOq/YsvSVNBo98iTZjBkMbs77sniteQ5K4F5nGsxj1xwXEtgeavJeEVbEbuIZB0xlfHZ5g/
 Q2fkaR+OlleZZm2RATtrRXXPvVQ3MzpZX/i7yRSZrw3ZzdGUVaiuMRSNp3VrZH0dmdtmyxaOk
 lVwZdUfQeCmHw0UoVh41ZjWpHAzkg6su7+SLadJ1JAuHAUXioG0AiOdpFtKoit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This is a driver for DVB cards based on SAA7160/61/62 PCIe bridges from
Philips/NXP. The most important of these cards, at least for me, is the
TechnoTrend S2-6400, a high-definition full-featured DVB-S2 card, the
successor of the famous ttpci decoder cards for use with applications
like vdr. Although equipped with a decoder, the S2-6400 is not able to
send the decoded video back over PCIe, so the output part of this
card cannot be used with applications like kaffeine.

Other cards supported by this driver:
Technisat SkyStar 2 eXpress HD
TurboSight 6281 (DVB-T/T2/C)
TurboSight 6285 (DVB-T/T2/C)
Twinhan/Azurewave VP-6090

The driver was taken from [1], converted to git and moved to
drivers/media/pci. It is adapted for current mainline (v5.1-rc1)
with lots of clean-up work done.
This driver was licensed "GPL" from the beginning. S2-6400 firmware is
available at [2].

I preserved the development history of the driver, since this
is mainly work of Andreas Regel, Manu Abraham, and Oliver Endriss.
Additional support for TBS cards was provided by Luis Alves and
Tycho L=C3=BCrsen. Also thanks to Tobias Klausmann and Uwe Scheffler
for their code contributions and testing work.

Unfortunately Andreas seems not to take care of this driver anymore, he
also did not answer my requests to integrate patches for newer kernel
versions. So I send this upstream.

Changes since v1 of this pull request [3]:
- rebased and adapted to linux-5.1-rc1
- added support for TBS cards
- fixed IRQ/MSI init
- fixed module dependencies
- converted logging to pci_info/dbg/err
- submitted for media/pci, not staging/media, all clean-up work done
Remaining checkpatch warnings for lines over 80 characters are only
to keep message strings and "code tables" intact.

There was a request to convert the DVB API output part in this driver
to "something more modern", apparently under the wrong assumption that
this API is used here as some older version of a v4l2 decoder API.
But the S2-6400 is a completely different class of hardware, with
different and much simpler API requirements. The S2-6400 hardware
is not able to send the decoded video back over PCIe. This driver has
no access to the decoded video, and it is not in charge of controlling
the video decoder on this card. The only available hardware interface
for the dvb audio/video device is a fifo buffer to receive a DVB
transport stream. So this driver only uses following calls from the
DVB output API:
- write a TS to the fifo via the video device node
- 3 ioctls: reset fifo, get time stamp of packet at receiving end of fifo,
=C2=A0 switch from fifo interface to DVB frontend (or back) for received T=
S
=46rom an API point of view, this driver does not even know that there is
a video decoder behind the fifo. It could as well be a transmission
line, or a dvb modulator.
This simple DVB transport stream output API very well meets the needs of
the vdr application, I don't see why and how this should be converted
to something different.
Note: there is a debug access to a single decoded image in this driver,
this is gated by a module option and disabled by default. Due to
bandwith limitations on the card this should not be used in parallel
to normal vdr operation.

[1] https://bitbucket.org/powARman/v4l-dvb-saa716x/
[2] http://www.aregel.de/downloads/
[3] https://www.mail-archive.com/linux-media@vger.kernel.org/msg115690.htm=
l



The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231=
b:

=C2=A0 Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

=C2=A0 https://github.com/s-moch/linux-saa716x for-media-v2

for you to fetch changes up to 33590a6a58a3d350678cd8aef4ea1578d66494fa:

=C2=A0 saa716x: Add MAINTAINERS entry (2019-03-25 08:53:42 +0100)

=2D---------------------------------------------------------------
Andreas Regel (127):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Simplified the code for I2C transf=
ers.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Transport stream ports can be conf=
igured now.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Disable frontend support throug=
h STi7109 firmware.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Initialize the frontend of the =
TT S2-6400.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Add VIDEO_GET_PTS ioctl.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Add audio device for TT S2-6400=
.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Use separate interrupts for OSD=
 commands.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Use third TS input of the STi71=
09 for playback
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Set error code when boot of fir=
mware failed.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Added 10ms sleep after configur=
ing the FPGA.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reduce compiler warnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: fix kernel oops caused by missing =
initialisation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: fixed double frontend detach
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: 1ms is enough when waiting for the=
 PLL
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Adapted frontend init to latest=
 driver changes.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Improve PHI performance by shorten=
 timings a bit.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: use double buffering for block =
transfers.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Reset block_done after receivin=
g it.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: add interrupt source for firmwa=
re log messages
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: read FPGA version register
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: fixed PTS/STC signed/unsigned i=
ssue
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: query and print loader and firm=
ware versions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: disable debug printk
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 osd.h: Add const keyword to struct members
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: implement ioctl VIDEO_GET_SIZE
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: support production version of t=
he S2-6400
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: disable OVERFLOW and AV interrupts=
 in FGPI
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: add some FPGA register definiti=
ons
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: restart TS capturing in case of=
 non-aligned TS error
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: don't clear FGPI interrupts in =
IRQ routine.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: comment out SPI functions that are=
 not needed currently
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: add changes needed for kernel 2.6.=
36 and up.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: support building with media_build_=
experimental
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: use tasklet for FIFO transfer
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: fix not working MSI
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Disable shared IRQ when using MSI =
mode.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Do an explicit demodulator rese=
t.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: enable wait for PLL lock when sett=
ing clocks of all ports.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: add counting of interrupts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: don't set i2c_adapter id field
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: support non-aligned TS data
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Use a TS clock of 135Mhz instea=
d of 90 Mhz.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Ignore false remote events.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Fix possible crash in IRQ handl=
er.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: move firmware command interface=
 code to separate file.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Allow to have osd device opened=
 twice.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: support correct TS mux setting =
for FPGA 1.10.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Add missing GPIO initializa=
tion.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Add missing GPIO initializa=
tion.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: fix tuner settings for nemo=
 reference board
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: TS capturing on the nemo re=
ference board works.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Make TS capturing code more=
 generic.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused members from struct =
saa716x_config.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add function saa716x_fgpi_get_writ=
e_index.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Use saa716x_fgpi_get_write_=
index to simplify code.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Use saa716x_fgpi_get_write_inde=
x to simplify code.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Set maximum number of adapters per=
 saa716x to 4.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Add TS capturing code.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Do some cleanups.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused load_config function=
s.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Started with SkyStar 2 eXpr=
ess HD.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Add support for KWorld Dual=
 DVB-T PE310.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix I2C bus assignment on SAA7160E=
T.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix stack corruption when parsing =
ROM info.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix memory leak in ROM parsing.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Skip unknown device descriptors wh=
en parsing the ROM
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: change verbose level for some dpri=
ntk
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Enable now working EEPROM parsi=
ng.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Add error message when FPGA is =
not responding.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Add frontend attach for the=
 Skystar2 eXpress HD.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Reset the frontend on the SkySt=
ar2 eXpress HD.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: support CEC remote codes.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use interrupts for I2C writes inst=
ead of polling.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: separate I2C reading and writing i=
nto two functions.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: change remote event printk to h=
exadecimal output.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Support buffered I2C transaction u=
sing interrupts.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Use buffered I2C interrupt mode=
.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Don't use dvb_generic_ioctl.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Use GPIO 26 for reset on th=
e Skystar 2 eXpress HD.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Use I2C B for accessing the=
 frontend on the Skystar.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Get the Skystar 2 eXpress H=
D to work.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Implement LNB power switchi=
ng for Skystar 2
eXpress HD.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Fix memory leak.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Fix missing copy user <-> kerne=
l space.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: FGPI DMA buffer size is passed to =
saa716x_fgpi_init.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix FGPI settings for SD video cap=
ture.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Export some FGPI functions.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Remove unused header file.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Remove duplicate definition.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Make BAM register macros more gene=
ric.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use global macros for MMU register=
 access.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add VI module implementation.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Support one-shot video capturing.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Extend interrupt counters.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Change video capture format from Y=
UYV to UYUV.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Support capturing digital video=
 coming from STi7109.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Protect reading of the captured=
 video with a mutex.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Rename functions.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: video capture refactoring.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use pitch value from stream params=
 when setting FGPI_STRIDE.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: use offset from stream params inst=
ead of fixed value.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Clear DMA buffer after allocatiion
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Support capturing raw data via FGP=
I unit
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reset FGPI read index in saa716x_f=
gpi_start
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Cancel data transfer in case of=
 a block timeout
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: print decimal digits for firmwa=
re version.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: include fix for in-kernel build
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: support directory structure of lin=
ux-3.7+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: section mismatch fixes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove __devinit and friends
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: convert fifo_worker tasklet to wor=
kqueue
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: TS output buffer cleanup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix PHI address space offsets, cle=
anup register definitions.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Clean up PHI configuration.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reset PHI on init.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Print EEPROM content on DEBUG verb=
osity only.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix errors and improve saa716x_set=
_clk.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Fix not setting command result =
length to 0 per default.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: move card specific PHI code to saa=
716x_ff driver
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: use special phi_fifo_write func=
tion
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Add write-combining PCI iomem w=
indow for PHI1 access.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: implement PHI speedup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: IO memory of upper PHI1 regions is=
 mapped in saa716x_ff
driver.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Optimize access to FIFO.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Align block data on 32 bytes fo=
r firmware 0.5.0 and up
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Do not return on command ready =
timeout
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Usa faster EMI timings only for=
 FPGA version 1.10 and
later

Luis Alves (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for tbs 6281 and tbs 6=
285 cards.

Manu Abraham (137):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial framework driver to suppor=
t SAA7160, SAA7161,
SAA7162 chips
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add missing return, to avoid falli=
ng through the error codes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Updated board definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add some register definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add Read/Write macros
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial attempt to Boot the core
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial attempt to initialize the =
I2C core
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Setup CGU
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Whitespace cleanup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use subsystem Vendor ID
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Small cleanups
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Enable all inputs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial go at MSI setup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Update I2C register definitions an=
d fields
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial go at the I2C implementati=
on
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Remove unused definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Move i2c related stuff to it's own=
 header
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add some labels
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Rename files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix subdevice ID
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add more register definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Update/Reorganize register definit=
ions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Implement internal Boot mode
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Update register definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Still scratching
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initialize MSI
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Cleanup internal Boot configuratio=
n
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Cleanup external Boot configuratio=
n
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initialize CGU and MSI modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Enable more debugging
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Check DMA availability
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Small cleanups and fixes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix typo
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reset internal modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Still debugging
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code simplification
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Terminate PCI ID list
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Rename Rd/Wr operations
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix usage of wrong datatypes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: CGU related fixes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Continue MSI-X implementation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add routines to handle clock relat=
ed events
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for Avermedia HC82 PCI=
e expresscard
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Disable BAR2 access
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code cleanup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Register SAA716x Adapter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add initial support for the second=
 adapter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initialize adapters on the budget =
device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Register only the relevant adapter=
s for a specific device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add Avermedia HC82 specific device=
 configuration
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix typo
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Register an array of devices
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for the Avermedia H788=
 device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for the Azurewave VP-6=
002 device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Usea separate frontend_attach for =
each of the devices
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use a separate IRQ handler for sep=
arate modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Try to attach the demodulator
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix typo in register definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Updates and Code simplification=C2=
=A0 - Initialize the I2C
clock=C2=A0 - Disable core reset for hybrid cards
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Check device revision for I2C bus =
orderring
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for the NXP Atlantis r=
eference design
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Free IRQ before module unload
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code reorganization
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for the KNC1 Dual S2 d=
evice
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add support for the VP-3071 DVB-T =
dual device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add GPIO control functions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use power and reset controls withi=
n a sig\ngle loop
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use a configuration per adapter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: VP-1028: add power, reset configur=
ation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: H788: Add power, reset configurati=
on
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: HC82: Add power, reset configurati=
on
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Display Bus status
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Bug: Address needs to be shifted o=
ne bit
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initial go at DMA routines
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Print warning, if MSI module is no=
t supported
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Handle MSI in a generic manner
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add PHI port definitions
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initialize PHI bus
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add GREG routines
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reorganize CGU related routines
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Do not initialize the CGU twice
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add more debug info, initialize ha=
ndler count
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add/remove I2C MSI vectors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add interrupt debugging
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Return error on MSI enable failure
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Initialize FPGI pagetables
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Setup FGPI parameters
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use a separate module to handle Fu=
ll fledged cards
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: NULL terminate PCI ID list
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Read the mask bits instead
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reduce a bit of noise in the handl=
er debug mode
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Sleep a little while before enabli=
ng interrupts again
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use individual handlers
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Transmit D is programmed, not S da=
ta
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Print return values
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use adapter ordering
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Disable debugging
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 osd.h: Kickstart the TT S2 6400 Dual HD Pre=
mium - OSD update
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Kickstart the TT S2 6400 Dual HD P=
remium
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code simplification, Overhaul, ROM=
 dump
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Set the default rate for the NEMO =
reference design
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code simplification, Overhauling, =
I2C related fixes
Initial test with the NEMO reference device
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Try to attach the frontends
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Don't cast pointers to 32 bit int
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Partial rework of SPI I/O
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add video device support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: S2-6400: Try to attach the fronten=
d
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Handle multiple I2C messages
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix ROM parser
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Setup default I2C rates
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix BUS ordering
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix swapped I2C buses
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Print wait time, reduce number of =
loops
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix missing address in single writ=
e operation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: make register definitions specific=
 to each of the modules
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix register definition typo
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add function declaration
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix FGPI internal clock divider st=
ate
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix dmabuf allocation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Cleanup debug prints
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Handle failure correctly
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Handle proper buffer flush
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: FGPI DMA handling fixes
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Finally! we have stream capture
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Make the framework buildable
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix build issues
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Deinitialize I2C interrupts on exi=
t
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Factorize register/detach routines=
 to common code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Start DMA engine as and when reque=
sted
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Enable timeout for modules having =
no clock
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Reset the frontend after powerup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: GPIO fix
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Fix powerup/reset
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use the correct I2C Bus
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Code simplification
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Try to attach frontend on the Nemo=
 reference board
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Do not report non-fatal errors to =
avoid issues with buggy
BIOS's

Oliver Endriss (3):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Rename saa716x_ff.c to saa716x_=
ff_main.c
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Support remote control receiver
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use tasklet to transfer data to th=
e demuxer (TT S2-6400)

Soeren Moch (94):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: i2c_del_adapter() fix
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: init frontends to low-power mod=
e
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Add linux-4.5 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Avoid sleeping in fifo_worker
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused saa716x_msi_handler
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: pci: Remove asm includes for compa=
tibility with linux-4.6
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: add linux-4.10 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Remove broken MSI-X support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Use %zu printk format for sizeof r=
eturn values
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: Fix build in linux-4.13
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: Fix build in linux-4.13
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Remove autorepeat handling
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: Convert to new timer API
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: adapt for moved header files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: dvb/audio.h: re-add AUDIO_GET_PTS
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove kernel version conditionals
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: fix include directories
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: fix module dependencies
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: simplify irq registration
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused multi-vector MSI sup=
port
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused i2c irq code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: simplify MSI init
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: perform soft reset on device probe
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove separate msi reset
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: move phi reset to probe functio=
n
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: also soft-reset greg and gpio bloc=
ks on device probe
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: move demux_worker to saa716x_adap
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove rom debug code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused audio input port cod=
e
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused spi code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused audio function proto=
types
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove boot function prototypes fr=
om saa716x_priv.h
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused greg code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused gpio code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused private config and a=
dapter entries
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove decoder resets from common =
code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: move function headers from priv.h =
to own header files
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: remove incomplete Avermedia=
 H-788 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: remove incomplete Avermedia=
 HC-82 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: remove incomplete Twinhan V=
P-6090 DVB-S support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: remove incomplete KNC1 Dual=
 S2 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: remove incomplete Twinhan V=
P-6002 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: remove incomplete Twinhan V=
P-3071 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: remove incomplete Twinhan V=
P-1028 support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: document Technisat Skystar =
2 Express HD support
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: allow individual configuration of =
video ports
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup POINTER_LOCATION checkp=
atch errors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup SPACING checkpatch errors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup ASSIGN_IN_IF checkpatch er=
rors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup COMPLEX_MACRO checkpatch e=
rrors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup OPEN_BRACE and ELSE_AFTER_=
BRACE checkpatch errors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup CODE_INDENT and SWITCH_CAS=
E_INDENT_LEVEL
checkpatch errors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup SPACE_BEFORE_TAB checkpatc=
h warnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup Kconfig
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: constify structs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: constify config structs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: constify config structs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: convert printk to pci_info/err/dbg
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: convert printk to pci_info/err/=
dbg
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: convert printk to pci_err/d=
bg
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: convert printk to pci_err/d=
bg
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove dprintk macro
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: remove interrupt counting debug=
 code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup RETURN_VOID checkpatch war=
nings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: remove unused adap_lock
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: #include cleanup
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: use kcalloc for array memory alloc=
ation
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup CONSTANT_COMPARISON che=
ckpatch warning
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: cleanup UNNECESSARY_ELSE ch=
eckpatch warning
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup dma buffer sg list allocat=
ion
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: use common device struct
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup LINE_SPACING checkpatch=
 warning
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup BRACES checkpatch warnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: cleanup BRACES checkpatch w=
arnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: cleanup BRACES checkpatch w=
arnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup BRACES checkpatch warni=
ngs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: add SPDX license identifier
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: add SPDX license identifier
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: add SPDX license identifier
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: add SPDX license identifier
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup comment style and lengt=
h
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: cleanup comment style
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup comment style and length
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: cleanup LONG_LINE checkpatc=
h warnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_hybrid: cleanup LONG_LINE checkpatc=
h warnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: cleanup LONG_LINE checkpatch wa=
rnings
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: cleanup LONG_LINE checkpatch warni=
ngs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: do not report recoverable i2c tran=
sfer errors
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: simplify PHI code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget/ff/hybrid: autoselect PCI in=
terrupt mode
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff: autoselect phi_mode
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_budget: simplify TBS frontend attac=
h code
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: hook up driver in drivers/media/pc=
i
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: Add MAINTAINERS entry

Tobias Klausmann (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: add frontend selects to kconfig

Tycho L=C3=BCrsen (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x: constify pci_device_id.

Uwe Scheffler (1):
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 saa716x_ff : reduce ir repeat delay and per=
iod

=C2=A0Documentation/media/uapi/dvb/audio-get-pts.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 65 +
=C2=A0.../media/uapi/dvb/audio_function_calls.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
=C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
=C2=A0drivers/media/pci/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
=C2=A0drivers/media/pci/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
=C2=A0drivers/media/pci/saa716x/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 55 +
=C2=A0drivers/media/pci/saa716x/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 22 +
=C2=A0drivers/media/pci/saa716x/saa716x_adap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 327 ++++
=C2=A0drivers/media/pci/saa716x/saa716x_adap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +
=C2=A0drivers/media/pci/saa716x/saa716x_aip_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 64 +
=C2=A0drivers/media/pci/saa716x/saa716x_boot.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 95 ++
=C2=A0drivers/media/pci/saa716x/saa716x_boot.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
=C2=A0drivers/media/pci/saa716x/saa716x_budget.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 503 ++++++
=C2=A0drivers/media/pci/saa716x/saa716x_budget.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +
=C2=A0drivers/media/pci/saa716x/saa716x_cgu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 542 +++++++
=C2=A0drivers/media/pci/saa716x/saa716x_cgu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 65 +
=C2=A0drivers/media/pci/saa716x/saa716x_cgu_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 180 +++
=C2=A0drivers/media/pci/saa716x/saa716x_dcs_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 58 +
=C2=A0drivers/media/pci/saa716x/saa716x_dma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 297 ++++
=C2=A0drivers/media/pci/saa716x/saa716x_dma.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 65 +
=C2=A0drivers/media/pci/saa716x/saa716x_dma_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 204 +++
=C2=A0drivers/media/pci/saa716x/saa716x_ff.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 186 +++
=C2=A0drivers/media/pci/saa716x/saa716x_ff_cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 450 ++++++
=C2=A0drivers/media/pci/saa716x/saa716x_ff_cmd.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 18 +
=C2=A0drivers/media/pci/saa716x/saa716x_ff_ir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 194 +++
=C2=A0drivers/media/pci/saa716x/saa716x_ff_ir.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 27 +
=C2=A0drivers/media/pci/saa716x/saa716x_ff_main.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 1598
++++++++++++++++++++
=C2=A0drivers/media/pci/saa716x/saa716x_ff_phi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 103 ++
=C2=A0drivers/media/pci/saa716x/saa716x_ff_phi.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 15 +
=C2=A0drivers/media/pci/saa716x/saa716x_fgpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 397 +++++
=C2=A0drivers/media/pci/saa716x/saa716x_fgpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 94 ++
=C2=A0drivers/media/pci/saa716x/saa716x_fgpi_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 76 +
=C2=A0drivers/media/pci/saa716x/saa716x_gpio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 77 +
=C2=A0drivers/media/pci/saa716x/saa716x_gpio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 22 +
=C2=A0drivers/media/pci/saa716x/saa716x_gpio_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 49 +
=C2=A0drivers/media/pci/saa716x/saa716x_greg_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 96 ++
=C2=A0drivers/media/pci/saa716x/saa716x_hybrid.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 471 ++++++
=C2=A0drivers/media/pci/saa716x/saa716x_hybrid.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +
=C2=A0drivers/media/pci/saa716x/saa716x_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 578 +++++++
=C2=A0drivers/media/pci/saa716x/saa716x_i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 52 +
=C2=A0drivers/media/pci/saa716x/saa716x_i2c_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 147 ++
=C2=A0drivers/media/pci/saa716x/saa716x_mod.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 27 +
=C2=A0drivers/media/pci/saa716x/saa716x_msi_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 145 ++
=C2=A0drivers/media/pci/saa716x/saa716x_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 167 ++
=C2=A0drivers/media/pci/saa716x/saa716x_pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 9 +
=C2=A0drivers/media/pci/saa716x/saa716x_phi_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 96 ++
=C2=A0drivers/media/pci/saa716x/saa716x_priv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 105 ++
=C2=A0drivers/media/pci/saa716x/saa716x_spi_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 29 +
=C2=A0drivers/media/pci/saa716x/saa716x_vip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 396 +++++
=C2=A0drivers/media/pci/saa716x/saa716x_vip.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 60 +
=C2=A0drivers/media/pci/saa716x/saa716x_vip_reg.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 143 ++
=C2=A0include/uapi/linux/dvb/audio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
=C2=A0include/uapi/linux/dvb/osd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 16 +
=C2=A053 files changed, 8457 insertions(+)
=C2=A0create mode 100644 Documentation/media/uapi/dvb/audio-get-pts.rst
=C2=A0create mode 100644 drivers/media/pci/saa716x/Kconfig
=C2=A0create mode 100644 drivers/media/pci/saa716x/Makefile
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_adap.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_adap.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_aip_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_boot.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_boot.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_budget.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_budget.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_cgu.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_cgu.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_cgu_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_dcs_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_dma.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_dma.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_dma_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_cmd.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_cmd.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_ir.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_ir.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_main.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_phi.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_ff_phi.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_fgpi.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_fgpi.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_fgpi_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_gpio.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_gpio.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_gpio_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_greg_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_hybrid.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_hybrid.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_i2c.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_i2c.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_i2c_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_mod.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_msi_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_pci.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_pci.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_phi_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_priv.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_spi_reg.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_vip.c
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_vip.h
=C2=A0create mode 100644 drivers/media/pci/saa716x/saa716x_vip_reg.h

