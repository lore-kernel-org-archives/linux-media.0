Return-Path: <SRS0=wpjx=S6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F224C43218
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8642067C
	for <linux-media@archiver.kernel.org>; Sun, 28 Apr 2019 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mycomm.com header.i=@mycomm.com header.b="PtzKOXmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfD1V1c (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:27:32 -0400
Received: from de.mycomm.com ([82.165.206.18]:34959 "EHLO yagodich.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbfD1V1a (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 28 Apr 2019 17:27:30 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 17:27:28 EDT
Received: from fairchild (c-68-84-2-242.hsd1.md.comcast.net [68.84.2.242])
        by yagodich.com (Postfix) with ESMTPSA id 09A63C0D5C
        for <linux-media@vger.kernel.org>; Sun, 28 Apr 2019 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mycomm.com; s=mail;
        t=1556486403; bh=PduLY0GbP/krhgi0lllSw3Qln7vk/0yFYFCVm+QFijo=;
        h=Subject:From:Reply-To:To:Date:From;
        b=PtzKOXmqsOL03ZJlC1Wm4iD6h/D0elbHJ4JlDelATK2f3p9G11XZLO6A1yTzzM6r2
         eZlK1j0H9MmUgBqwgt0Z8mXHs7Wk0XUSXfZ3B488VDDKICPl/adDuCiV/fSUU2rvL3
         mdwEkoJ0OK+Z0nEFEg39VTleZlBj8YCrKCT3xhKU=
Message-ID: <1556486397.1911.8.camel@mycomm.com>
Subject: Honestech Vidbox NW03 audio
From:   milan <milan@mycomm.com>
Reply-To: milan@mycomm.com
To:     linux-media@vger.kernel.org
Date:   Sun, 28 Apr 2019 17:19:57 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Synopsis:
Got the video to work by downloading latest drivers and rebuilding.
No audio.

Board not recognized.

Needed to 
	rmmod em28xx
	insmod em28xx card=83

Driver was not able to read eeprom.  I suspect that is why audio is not
working.  Tried VLC and audacity.  Audacity allows me to select
	USB Device 0xeb1a:0x2861 Audio (hw2:0) ...
but none of the selections work.

Logs and details below

Milan

4.9.0-4-amd64 #1 SMP Debian 4.9.65-3+deb9u1 (2017-12-23) x86_64
GNU/Linux

lsusb
Bus 002 Device 002: ID eb1a:2861 eMPIA Technology, Inc. 


dmesg outputs:

[104109.101187] usb 2-2: new high-speed USB device number 3 using ehci-
pci
[104109.249550] usb 2-2: New USB device found, idVendor=eb1a,
idProduct=2861
[104109.249558] usb 2-2: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[104109.250010] em28xx 2-2:1.0: New device   @ 480 Mbps (eb1a:2861,
interface 0, class 0)
[104109.250015] em28xx 2-2:1.0: Video interface 0 found: isoc
[104109.309293] em28xx 2-2:1.0: chip ID is em2860
[104109.443275] em28xx 2-2:1.0: unknown eeprom format or eeprom
corrupted !
[104109.530554] em28xx 2-2:1.0: No sensor detected
[104109.543519] em28xx 2-2:1.0: found i2c device @ 0x4a on bus 0
[saa7113h]
[104109.558018] em28xx 2-2:1.0: found i2c device @ 0xa0 on bus 0
[eeprom]
[104109.574271] em28xx 2-2:1.0: Your board has no unique USB ID and
thus need a hint to be detected.
                You may try to use card=<n> insmod option to workaround
that.
                Please send an email with this log to:
                	V4L Mailing List 
                Board eeprom hash is 0x00000000
                Board i2c devicelist hash is 0x6ba50080
[104109.574287] em28xx 2-2:1.0: Here is a list of valid choices for the
card=<n> insmod option:
[104109.574293] em28xx 2-2:1.0:     card=0 -> Unknown EM2800 video
grabber
[104109.574299] em28xx 2-2:1.0:     card=1 -> Unknown EM2750/28xx video
grabber
[104109.574307] em28xx 2-2:1.0:     card=2 -> Terratec Cinergy 250 USB
[104109.574311] em28xx 2-2:1.0:     card=3 -> Pinnacle PCTV USB 2
[104109.574316] em28xx 2-2:1.0:     card=4 -> Hauppauge WinTV USB 2
[104109.574321] em28xx 2-2:1.0:     card=5 -> MSI VOX USB 2.0
[104109.574326] em28xx 2-2:1.0:     card=6 -> Terratec Cinergy 200 USB
[104109.574330] em28xx 2-2:1.0:     card=7 -> Leadtek Winfast USB II
[104109.574335] em28xx 2-2:1.0:     card=8 -> Kworld USB2800
[104109.574340] em28xx 2-2:1.0:     card=9 -> Pinnacle Dazzle DVC
90/100/101/107 / Kaiser Baas Video to DVD maker / Kworld DVD Maker 2 /
Plextor ConvertX PX-AV100U
[104109.574345] em28xx 2-2:1.0:     card=10 -> Hauppauge WinTV HVR 900
[104109.574351] em28xx 2-2:1.0:     card=11 -> Terratec Hybrid XS
[104109.574356] em28xx 2-2:1.0:     card=12 -> Kworld PVR TV 2800 RF
[104109.574361] em28xx 2-2:1.0:     card=13 -> Terratec Prodigy XS
[104109.574366] em28xx 2-2:1.0:     card=14 -> SIIG AVTuner-PVR /
Pixelview Prolink PlayTV USB 2.0
[104109.574371] em28xx 2-2:1.0:     card=15 -> V-Gear PocketTV
[104109.574379] em28xx 2-2:1.0:     card=16 -> Hauppauge WinTV HVR 950
[104109.574384] em28xx 2-2:1.0:     card=17 -> Pinnacle PCTV HD Pro
Stick
[104109.574389] em28xx 2-2:1.0:     card=18 -> Hauppauge WinTV HVR 900
(R2)
[104109.574394] em28xx 2-2:1.0:     card=19 -> EM2860/SAA711X Reference
Design
[104109.574399] em28xx 2-2:1.0:     card=20 -> AMD ATI TV Wonder HD 600
[104109.574403] em28xx 2-2:1.0:     card=21 -> eMPIA Technology, Inc.
GrabBeeX+ Video Encoder
[104109.574409] em28xx 2-2:1.0:     card=22 -> EM2710/EM2750/EM2751
webcam grabber
[104109.574413] em28xx 2-2:1.0:     card=23 -> Huaqi DLCW-130
[104109.574418] em28xx 2-2:1.0:     card=24 -> D-Link DUB-T210 TV Tuner
[104109.574423] em28xx 2-2:1.0:     card=25 -> Gadmei UTV310
[104109.574427] em28xx 2-2:1.0:     card=26 -> Hercules Smart TV USB
2.0
[104109.574432] em28xx 2-2:1.0:     card=27 -> Pinnacle PCTV USB 2
(Philips FM1216ME)
[104109.574437] em28xx 2-2:1.0:     card=28 -> Leadtek Winfast USB II
Deluxe
[104109.574442] em28xx 2-2:1.0:     card=29 -> EM2860/TVP5150 Reference
Design
[104109.574447] em28xx 2-2:1.0:     card=30 -> Videology 20K14XUSB
USB2.0
[104109.574452] em28xx 2-2:1.0:     card=31 -> Usbgear VD204v9
[104109.574456] em28xx 2-2:1.0:     card=32 -> Supercomp USB 2.0 TV
[104109.574461] em28xx 2-2:1.0:     card=33 -> Elgato Video Capture
[104109.574466] em28xx 2-2:1.0:     card=34 -> Terratec Cinergy A
Hybrid XS
[104109.574470] em28xx 2-2:1.0:     card=35 -> Typhoon DVD Maker
[104109.574475] em28xx 2-2:1.0:     card=36 -> NetGMBH Cam
[104109.574480] em28xx 2-2:1.0:     card=37 -> Gadmei UTV330
[104109.574485] em28xx 2-2:1.0:     card=38 -> Yakumo MovieMixer
[104109.574489] em28xx 2-2:1.0:     card=39 -> KWorld PVRTV 300U
[104109.574494] em28xx 2-2:1.0:     card=40 -> Plextor ConvertX PX-
TV100U
[104109.574499] em28xx 2-2:1.0:     card=41 -> Kworld 350 U DVB-T
[104109.574503] em28xx 2-2:1.0:     card=42 -> Kworld 355 U DVB-T
[104109.574508] em28xx 2-2:1.0:     card=43 -> Terratec Cinergy T XS
[104109.574513] em28xx 2-2:1.0:     card=44 -> Terratec Cinergy T XS
(MT2060)
[104109.574517] em28xx 2-2:1.0:     card=45 -> Pinnacle PCTV DVB-T
[104109.574522] em28xx 2-2:1.0:     card=46 -> Compro, VideoMate U3
[104109.574527] em28xx 2-2:1.0:     card=47 -> KWorld DVB-T 305U
[104109.574532] em28xx 2-2:1.0:     card=48 -> KWorld DVB-T 310U
[104109.574537] em28xx 2-2:1.0:     card=49 -> MSI DigiVox A/D
[104109.574541] em28xx 2-2:1.0:     card=50 -> MSI DigiVox A/D II
[104109.574546] em28xx 2-2:1.0:     card=51 -> Terratec Hybrid XS Secam
[104109.574551] em28xx 2-2:1.0:     card=52 -> DNT DA2 Hybrid
[104109.574556] em28xx 2-2:1.0:     card=53 -> Pinnacle Hybrid Pro
[104109.574560] em28xx 2-2:1.0:     card=54 -> Kworld VS-DVB-T 323UR
[104109.574565] em28xx 2-2:1.0:     card=55 -> Terratec Cinergy Hybrid
T USB XS (em2882)
[104109.574570] em28xx 2-2:1.0:     card=56 -> Pinnacle Hybrid Pro
(330e)
[104109.574575] em28xx 2-2:1.0:     card=57 -> Kworld PlusTV HD Hybrid
330
[104109.574580] em28xx 2-2:1.0:     card=58 -> Compro VideoMate
ForYou/Stereo
[104109.574584] em28xx 2-2:1.0:     card=59 -> Pinnacle PCTV HD Mini
[104109.574589] em28xx 2-2:1.0:     card=60 -> Hauppauge WinTV HVR 850
[104109.574594] em28xx 2-2:1.0:     card=61 -> Pixelview PlayTV Box 4
USB 2.0
[104109.574599] em28xx 2-2:1.0:     card=62 -> Gadmei TVR200
[104109.574603] em28xx 2-2:1.0:     card=63 -> Kaiomy TVnPC U2
[104109.574608] em28xx 2-2:1.0:     card=64 -> Easy Cap Capture DC-60
[104109.574613] em28xx 2-2:1.0:     card=65 -> IO-DATA GV-MVP/SZ
[104109.574617] em28xx 2-2:1.0:     card=66 -> Empire dual TV
[104109.574622] em28xx 2-2:1.0:     card=67 -> Terratec Grabby
[104109.574627] em28xx 2-2:1.0:     card=68 -> Terratec AV350
[104109.574631] em28xx 2-2:1.0:     card=69 -> KWorld ATSC 315U HDTV TV
Box
[104109.574636] em28xx 2-2:1.0:     card=70 -> Evga inDtube
[104109.574641] em28xx 2-2:1.0:     card=71 -> Silvercrest Webcam
1.3mpix
[104109.574645] em28xx 2-2:1.0:     card=72 -> Gadmei UTV330+
[104109.574650] em28xx 2-2:1.0:     card=73 -> Reddo DVB-C USB TV Box
[104109.574655] em28xx 2-2:1.0:     card=74 ->
Actionmaster/LinXcel/Digitus VC211A
[104109.574660] em28xx 2-2:1.0:     card=75 -> Dikom DK300
[104109.574664] em28xx 2-2:1.0:     card=76 -> KWorld PlusTV 340U or
UB435-Q (ATSC)
[104109.574669] em28xx 2-2:1.0:     card=77 -> EM2874 Leadership ISDBT
[104109.574674] em28xx 2-2:1.0:     card=78 -> PCTV nanoStick T2 290e
[104109.574678] em28xx 2-2:1.0:     card=79 -> Terratec Cinergy H5
[104109.574683] em28xx 2-2:1.0:     card=80 -> PCTV DVB-S2 Stick (460e)
[104109.574688] em28xx 2-2:1.0:     card=81 -> Hauppauge WinTV HVR 930C
[104109.574693] em28xx 2-2:1.0:     card=82 -> Terratec Cinergy HTC
Stick
[104109.574698] em28xx 2-2:1.0:     card=83 -> Honestech Vidbox NW03
[104109.574702] em28xx 2-2:1.0:     card=84 -> MaxMedia UB425-TC
[104109.574707] em28xx 2-2:1.0:     card=85 -> PCTV QuatroStick (510e)
[104109.574712] em28xx 2-2:1.0:     card=86 -> PCTV QuatroStick nano
(520e)
[104109.574716] em28xx 2-2:1.0:     card=87 -> Terratec Cinergy HTC USB
XS
[104109.574721] em28xx 2-2:1.0:     card=88 -> C3 Tech Digital Duo
HDTV/SDTV USB
[104109.574726] em28xx 2-2:1.0:     card=89 -> Delock 61959
[104109.574731] em28xx 2-2:1.0:     card=90 -> KWorld USB ATSC TV Stick
UB435-Q V2
[104109.574736] em28xx 2-2:1.0:     card=91 -> SpeedLink Vicious And
Devine Laplace webcam
[104109.574741] em28xx 2-2:1.0:     card=92 -> PCTV DVB-S2 Stick (461e)
[104109.574746] em28xx 2-2:1.0:     card=93 -> KWorld USB ATSC TV Stick
UB435-Q V3
[104109.574750] em28xx 2-2:1.0:     card=94 -> PCTV tripleStick (292e)
[104109.574755] em28xx 2-2:1.0:     card=95 -> Leadtek VC100
[104109.574760] em28xx 2-2:1.0:     card=96 -> Terratec Cinergy T2
Stick HD
[104109.574764] em28xx 2-2:1.0:     card=97 -> Elgato EyeTV Hybrid 2008
INT
[104109.574769] em28xx 2-2:1.0:     card=98 -> PLEX PX-BCUD
[104109.574774] em28xx 2-2:1.0:     card=99 -> Hauppauge WinTV-dualHD
DVB
[104109.574779] em28xx 2-2:1.0:     card=100 -> Hauppauge WinTV-dualHD
01595 ATSC/QAM
[104109.574784] em28xx 2-2:1.0:     card=101 -> Terratec Cinergy H6
rev. 2
[104109.574789] em28xx 2-2:1.0:     card=102 -> :ZOLID HYBRID TV STICK
[104109.574793] em28xx 2-2:1.0: Board not discovered
[104109.574798] em28xx 2-2:1.0: Identified as Unknown EM2750/28xx video
grabber (card=1)
[104109.574804] em28xx 2-2:1.0: Your board has no unique USB ID and
thus need a hint to be detected.
                You may try to use card=<n> insmod option to workaround
that.
                Please send an email with this log to:
                	V4L Mailing List <linux-media@vger.kernel.org>
                Board eeprom hash is 0x00000000
                Board i2c devicelist hash is 0x6ba50080
[104109.574816] em28xx 2-2:1.0: Here is a list of valid choices for the
card=<n> insmod option:
[104109.574821] em28xx 2-2:1.0:     card=0 -> Unknown EM2800 video
grabber
[104109.574826] em28xx 2-2:1.0:     card=1 -> Unknown EM2750/28xx video
grabber
[104109.574830] em28xx 2-2:1.0:     card=2 -> Terratec Cinergy 250 USB
[104109.574835] em28xx 2-2:1.0:     card=3 -> Pinnacle PCTV USB 2
[104109.574839] em28xx 2-2:1.0:     card=4 -> Hauppauge WinTV USB 2
[104109.574844] em28xx 2-2:1.0:     card=5 -> MSI VOX USB 2.0
[104109.574848] em28xx 2-2:1.0:     card=6 -> Terratec Cinergy 200 USB
[104109.574853] em28xx 2-2:1.0:     card=7 -> Leadtek Winfast USB II
[104109.574858] em28xx 2-2:1.0:     card=8 -> Kworld USB2800
[104109.574863] em28xx 2-2:1.0:     card=9 -> Pinnacle Dazzle DVC
90/100/101/107 / Kaiser Baas Video to DVD maker / Kworld DVD Maker 2 /
Plextor ConvertX PX-AV100U
[104109.574868] em28xx 2-2:1.0:     card=10 -> Hauppauge WinTV HVR 900
[104109.574872] em28xx 2-2:1.0:     card=11 -> Terratec Hybrid XS
[104109.574877] em28xx 2-2:1.0:     card=12 -> Kworld PVR TV 2800 RF
[104109.574881] em28xx 2-2:1.0:     card=13 -> Terratec Prodigy XS
[104109.574886] em28xx 2-2:1.0:     card=14 -> SIIG AVTuner-PVR /
Pixelview Prolink PlayTV USB 2.0
[104109.574891] em28xx 2-2:1.0:     card=15 -> V-Gear PocketTV
[104109.574895] em28xx 2-2:1.0:     card=16 -> Hauppauge WinTV HVR 950
[104109.574900] em28xx 2-2:1.0:     card=17 -> Pinnacle PCTV HD Pro
Stick
[104109.574905] em28xx 2-2:1.0:     card=18 -> Hauppauge WinTV HVR 900
(R2)
[104109.574910] em28xx 2-2:1.0:     card=19 -> EM2860/SAA711X Reference
Design
[104109.574914] em28xx 2-2:1.0:     card=20 -> AMD ATI TV Wonder HD 600
[104109.574919] em28xx 2-2:1.0:     card=21 -> eMPIA Technology, Inc.
GrabBeeX+ Video Encoder
[104109.574924] em28xx 2-2:1.0:     card=22 -> EM2710/EM2750/EM2751
webcam grabber
[104109.574928] em28xx 2-2:1.0:     card=23 -> Huaqi DLCW-130
[104109.574933] em28xx 2-2:1.0:     card=24 -> D-Link DUB-T210 TV Tuner
[104109.574937] em28xx 2-2:1.0:     card=25 -> Gadmei UTV310
[104109.574942] em28xx 2-2:1.0:     card=26 -> Hercules Smart TV USB
2.0
[104109.574947] em28xx 2-2:1.0:     card=27 -> Pinnacle PCTV USB 2
(Philips FM1216ME)
[104109.574951] em28xx 2-2:1.0:     card=28 -> Leadtek Winfast USB II
Deluxe
[104109.574956] em28xx 2-2:1.0:     card=29 -> EM2860/TVP5150 Reference
Design
[104109.574961] em28xx 2-2:1.0:     card=30 -> Videology 20K14XUSB
USB2.0
[104109.574965] em28xx 2-2:1.0:     card=31 -> Usbgear VD204v9
[104109.574970] em28xx 2-2:1.0:     card=32 -> Supercomp USB 2.0 TV
[104109.574975] em28xx 2-2:1.0:     card=33 -> Elgato Video Capture
[104109.574979] em28xx 2-2:1.0:     card=34 -> Terratec Cinergy A
Hybrid XS
[104109.574984] em28xx 2-2:1.0:     card=35 -> Typhoon DVD Maker
[104109.574988] em28xx 2-2:1.0:     card=36 -> NetGMBH Cam
[104109.574993] em28xx 2-2:1.0:     card=37 -> Gadmei UTV330
[104109.574997] em28xx 2-2:1.0:     card=38 -> Yakumo MovieMixer
[104109.575002] em28xx 2-2:1.0:     card=39 -> KWorld PVRTV 300U
[104109.575006] em28xx 2-2:1.0:     card=40 -> Plextor ConvertX PX-
TV100U
[104109.575011] em28xx 2-2:1.0:     card=41 -> Kworld 350 U DVB-T
[104109.575015] em28xx 2-2:1.0:     card=42 -> Kworld 355 U DVB-T
[104109.575020] em28xx 2-2:1.0:     card=43 -> Terratec Cinergy T XS
[104109.575025] em28xx 2-2:1.0:     card=44 -> Terratec Cinergy T XS
(MT2060)
[104109.575029] em28xx 2-2:1.0:     card=45 -> Pinnacle PCTV DVB-T
[104109.575034] em28xx 2-2:1.0:     card=46 -> Compro, VideoMate U3
[104109.575038] em28xx 2-2:1.0:     card=47 -> KWorld DVB-T 305U
[104109.575043] em28xx 2-2:1.0:     card=48 -> KWorld DVB-T 310U
[104109.575047] em28xx 2-2:1.0:     card=49 -> MSI DigiVox A/D
[104109.575052] em28xx 2-2:1.0:     card=50 -> MSI DigiVox A/D II
[104109.575057] em28xx 2-2:1.0:     card=51 -> Terratec Hybrid XS Secam
[104109.575061] em28xx 2-2:1.0:     card=52 -> DNT DA2 Hybrid
[104109.575066] em28xx 2-2:1.0:     card=53 -> Pinnacle Hybrid Pro
[104109.575070] em28xx 2-2:1.0:     card=54 -> Kworld VS-DVB-T 323UR
[104109.575075] em28xx 2-2:1.0:     card=55 -> Terratec Cinergy Hybrid
T USB XS (em2882)
[104109.575080] em28xx 2-2:1.0:     card=56 -> Pinnacle Hybrid Pro
(330e)
[104109.575084] em28xx 2-2:1.0:     card=57 -> Kworld PlusTV HD Hybrid
330
[104109.575089] em28xx 2-2:1.0:     card=58 -> Compro VideoMate
ForYou/Stereo
[104109.575094] em28xx 2-2:1.0:     card=59 -> Pinnacle PCTV HD Mini
[104109.575098] em28xx 2-2:1.0:     card=60 -> Hauppauge WinTV HVR 850
[104109.575103] em28xx 2-2:1.0:     card=61 -> Pixelview PlayTV Box 4
USB 2.0
[104109.575108] em28xx 2-2:1.0:     card=62 -> Gadmei TVR200
[104109.575112] em28xx 2-2:1.0:     card=63 -> Kaiomy TVnPC U2
[104109.575117] em28xx 2-2:1.0:     card=64 -> Easy Cap Capture DC-60
[104109.575121] em28xx 2-2:1.0:     card=65 -> IO-DATA GV-MVP/SZ
[104109.575126] em28xx 2-2:1.0:     card=66 -> Empire dual TV
[104109.575130] em28xx 2-2:1.0:     card=67 -> Terratec Grabby
[104109.575135] em28xx 2-2:1.0:     card=68 -> Terratec AV350
[104109.575139] em28xx 2-2:1.0:     card=69 -> KWorld ATSC 315U HDTV TV
Box
[104109.575144] em28xx 2-2:1.0:     card=70 -> Evga inDtube
[104109.575148] em28xx 2-2:1.0:     card=71 -> Silvercrest Webcam
1.3mpix
[104109.575153] em28xx 2-2:1.0:     card=72 -> Gadmei UTV330+
[104109.575178] em28xx 2-2:1.0:     card=73 -> Reddo DVB-C USB TV Box
[104109.575183] em28xx 2-2:1.0:     card=74 ->
Actionmaster/LinXcel/Digitus VC211A
[104109.575187] em28xx 2-2:1.0:     card=75 -> Dikom DK300
[104109.575192] em28xx 2-2:1.0:     card=76 -> KWorld PlusTV 340U or
UB435-Q (ATSC)
[104109.575197] em28xx 2-2:1.0:     card=77 -> EM2874 Leadership ISDBT
[104109.575201] em28xx 2-2:1.0:     card=78 -> PCTV nanoStick T2 290e
[104109.575206] em28xx 2-2:1.0:     card=79 -> Terratec Cinergy H5
[104109.575210] em28xx 2-2:1.0:     card=80 -> PCTV DVB-S2 Stick (460e)
[104109.575215] em28xx 2-2:1.0:     card=81 -> Hauppauge WinTV HVR 930C
[104109.575220] em28xx 2-2:1.0:     card=82 -> Terratec Cinergy HTC
Stick
[104109.575224] em28xx 2-2:1.0:     card=83 -> Honestech Vidbox NW03
[104109.575229] em28xx 2-2:1.0:     card=84 -> MaxMedia UB425-TC
[104109.575234] em28xx 2-2:1.0:     card=85 -> PCTV QuatroStick (510e)
[104109.575238] em28xx 2-2:1.0:     card=86 -> PCTV QuatroStick nano
(520e)
[104109.575243] em28xx 2-2:1.0:     card=87 -> Terratec Cinergy HTC USB
XS
[104109.575248] em28xx 2-2:1.0:     card=88 -> C3 Tech Digital Duo
HDTV/SDTV USB
[104109.575252] em28xx 2-2:1.0:     card=89 -> Delock 61959
[104109.575257] em28xx 2-2:1.0:     card=90 -> KWorld USB ATSC TV Stick
UB435-Q V2
[104109.575262] em28xx 2-2:1.0:     card=91 -> SpeedLink Vicious And
Devine Laplace webcam
[104109.575266] em28xx 2-2:1.0:     card=92 -> PCTV DVB-S2 Stick (461e)
[104109.575271] em28xx 2-2:1.0:     card=93 -> KWorld USB ATSC TV Stick
UB435-Q V3
[104109.575276] em28xx 2-2:1.0:     card=94 -> PCTV tripleStick (292e)
[104109.575280] em28xx 2-2:1.0:     card=95 -> Leadtek VC100
[104109.575285] em28xx 2-2:1.0:     card=96 -> Terratec Cinergy T2
Stick HD
[104109.575290] em28xx 2-2:1.0:     card=97 -> Elgato EyeTV Hybrid 2008
INT
[104109.575294] em28xx 2-2:1.0:     card=98 -> PLEX PX-BCUD
[104109.575299] em28xx 2-2:1.0:     card=99 -> Hauppauge WinTV-dualHD
DVB
[104109.575304] em28xx 2-2:1.0:     card=100 -> Hauppauge WinTV-dualHD
01595 ATSC/QAM
[104109.575309] em28xx 2-2:1.0:     card=101 -> Terratec Cinergy H6
rev. 2
[104109.575313] em28xx 2-2:1.0:     card=102 -> :ZOLID HYBRID TV STICK
[104109.575319] em28xx 2-2:1.0: Currently, V4L2 is not supported on
this model
[104109.575757] em28xx 2-2:1.1: audio device (eb1a:2861): interface 1,
class 1

                 rmmod em28xx

[104436.261037] usbcore: deregistering interface driver em28xx
[104436.261074] em28xx 2-2:1.0: Disconnecting em28xx
[104436.261275] em28xx 2-2:1.0: Freeing device

		insmod em28xx card=83


[104538.219206] em28xx 2-2:1.0: New device   @ 480 Mbps (eb1a:2861,
interface 0, class 0)
[104538.219214] em28xx 2-2:1.0: Video interface 0 found: isoc
[104538.279897] em28xx 2-2:1.0: chip ID is em2860
[104538.409757] em28xx 2-2:1.0: unknown eeprom format or eeprom
corrupted !
[104538.503750] em28xx 2-2:1.0: Identified as Honestech Vidbox NW03
(card=83)
[104538.503756] em28xx 2-2:1.0: analog set to isoc mode.
[104538.504135] usbcore: registered new interface driver em28xx
[104538.513977] em28xx 2-2:1.0: Registering V4L2 extension
[104539.089372] saa7115 5-0025: saa7113 found @ 0x4a (2-2:1.0)
[104540.205203] em28xx 2-2:1.0: Config register raw data: 0x10
[104540.241247] em28xx 2-2:1.0: AC97 vendor ID = 0x83847650
[104540.257744] em28xx 2-2:1.0: AC97 features = 0x6a90
[104540.257750] em28xx 2-2:1.0: Empia 202 AC97 audio processor detected
[104543.384631] em28xx 2-2:1.0: V4L2 video device registered as video0
[104543.384637] em28xx 2-2:1.0: V4L2 VBI device registered as vbi0
[104543.384642] em28xx 2-2:1.0: V4L2 extension successfully initialized
[104543.384645] em28xx: Registered (Em28xx v4l2 Extension) extension

