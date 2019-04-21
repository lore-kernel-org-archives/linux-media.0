Return-Path: <SRS0=lO8N=SX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F32C10F14
	for <linux-media@archiver.kernel.org>; Sun, 21 Apr 2019 18:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC0620833
	for <linux-media@archiver.kernel.org>; Sun, 21 Apr 2019 18:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPaRYYGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfDUSgU (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:36:20 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35534 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDUSgU (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 21 Apr 2019 14:36:20 -0400
Received: by mail-lj1-f180.google.com with SMTP id t4so8604131ljc.2
        for <linux-media@vger.kernel.org>; Sun, 21 Apr 2019 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Rz5j0SOtP1m38McOjPsqPr4ZtpILGqUly+rO5ccyMPU=;
        b=oPaRYYGkzACAf4Jhj21pK1oFRTuwp5Cbf6Pf+R4lnsbWapfbPmNHVmVTsisK/HW67S
         xC+s4SzOW8pdMEUp+bPVMhjQlXBJz44wxHAQvEvHj6E8iGe8Nexpi2Nz+jxu8BTE6k1X
         vSSECuM+552sFFBcXS3MtkW75zLwoPjese1dSZCjKn6wgs4uCY7xDwNk2i1TWfci5rK6
         4098BoZ9DxTXFs0OqUiclkz223IJp8/Y9d3f49DXLAEJ9NwOI/Tcx0kT6ZVs0thSJY1t
         c+GnvutTdo4RpPGtPzrQh+zPFwYg+XpHW5mqvRVV26Q84dTfYT2VfsnnySGa9Q4IrpZp
         2JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Rz5j0SOtP1m38McOjPsqPr4ZtpILGqUly+rO5ccyMPU=;
        b=tdZiHk1q+ZFFlzhbmxRjaMH9DqZ95DljrBCI88DRxCJ78oRloI8U20k7kUG0cLXU58
         Wm0hElaYB5uCG/tS8E4opg2hekIZlzlguc+0Rf25M7eeTyl+9Mu9trWfkhIeuLnzA3YH
         fA4BzN2oflvJCpxGTRtlVLLopLyjsGZC0VAmLrCOBKzRGro8Q9dOrG0LbocRXaGAZgN6
         kFjcDKTpdaEzxCfFSvOJRWYMqfUzDJ8dR85jy7H7etmG5NucmEct+bWxqA81Q0f3yT7Y
         1dRSQJ5DWuO35OLaHY2b//yVfMyhrNtcEPvtzF9t5VAsxh9xVHeQfkhv3y2MY2hD4NIc
         2zfg==
X-Gm-Message-State: APjAAAUbtL5sLETlNYzyj5umc/ynADlOfzvvMRberJIQdVAn/83Rt3OT
        xFYB+JMXnyWArJVasYuXLI0A2NKjxMG23RNssVvKWGwIcZo=
X-Google-Smtp-Source: APXvYqxDndxDOOKS6lEwkoDxLkyCqxxGqL+//i2QRavDcC1qd4hX5+w6h9bcOGUBdXqbH3X+G6xbPQJCw7a1sBxXpeQ=
X-Received: by 2002:a2e:93c7:: with SMTP id p7mr8172312ljh.32.1555871778296;
 Sun, 21 Apr 2019 11:36:18 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Lung <dlung0@gmail.com>
Date:   Sun, 21 Apr 2019 08:36:02 -1000
Message-ID: <CAAT-ius5p80GU_o0vR_BPzBaU7=+Hr4Jn5v6rT3=b-3aq51dGA@mail.gmail.com>
Subject: Kaffeine can't find dvb devices after upgrade to v4l-utils 1.16.5
To:     Linux <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

v4l-utils version 1.16.5 results in the following error when launching
kaffeine with a dvb device connected:

[dl@p51 kaffeine]$ kaffeine
20-04-19 15:16:33.124 [Info    ] kaffeine.dvb: Using built-in dvb device manager
20-04-19 15:16:33.287 [Critical] kaffeine.dev: No such file or
directory while opening PKU
20-04-19 15:16:33.287 [Warning ] kaffeine.dev: Cannot open frontend
/dev/dvb/adapter0/frontend0
20-04-19 15:16:33.289 [Critical] kaffeine.dev: No such file or
directory while opening \KU
20-04-19 15:16:33.289 [Warning ] kaffeine.dev: Cannot open frontend
/dev/dvb/adapter1/frontend0
20-04-19 15:16:33.294 [Warning ] QObject::connect: No such slot
DvbTab::hideCursor()
20-04-19 15:16:51.674 [Warning ] qt.qpa.xcb: QXcbConnection: XCB
error: 3 (BadWindow), sequence: 3901, resource id: 31457455, major
code: 40 (TranslateCoords), minor code: 0
dl@p51 kaffeine]$ pacman -Qs v4l-utils
local/v4l-utils 1.16.5-1
    Userspace tools and conversion library for Video 4 Linux
dl@p51 uname -a
Linux p51 5.0.7-arch1-1-ARCH #1 SMP PREEMPT Mon Apr 8 10:37:08 UTC
2019 x86_64 GNU/Linux

v4l-utils 1.16.3 works fine.

This behavior was observed on Arch Linux with a Hauppauge WinTV dualHD
tuner. Another Arch user reported similar issues with a TechnoTrend
S2-4600S dvb-S2 USB-receiver. Note that the last word in the
"critical" error messages were not the letters shown but odd non-text
characters.

I tried recompiling kaffeine from GIT after upgrading v4l-utils to
1.16.5 and got the same errors.

I hope this helps track down the issue!

          ...Doug
