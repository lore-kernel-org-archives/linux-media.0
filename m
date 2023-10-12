Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F92CDB474
	for <linux-media@archiver.kernel.org>; Thu, 12 Oct 2023 22:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443052AbjJLWyb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Oct 2023 18:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443035AbjJLWy3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Oct 2023 18:54:29 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A920CC
        for <linux-media@vger.kernel.org>; Thu, 12 Oct 2023 15:54:27 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af602b6512so2458423b6e.0
        for <linux-media@vger.kernel.org>; Thu, 12 Oct 2023 15:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697151266; x=1697756066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4GepxVdDqnOhbaVFfKyJNSNxiwxVpwbYv24b5W+rg=;
        b=FO7tLfULnK72Kltf5AtWE3Y/OfA3BAXC3IctD5HV2TONPRSlTvp5jpm+MZ9gt0gj+I
         32nPBbRLltUaK3ocAlTi1oIrde/hscCciJlRBpgRTdzeuguekAMpp5FD1CR2Txej5Kmg
         PqabIeJhh7cvJoXY7O0Dzng71KfcNswvuW2D5Zw5CpKQP3ckaaCVf6HlmIPSsAqnbPx1
         R/eRWQ07nsXu0H93YK9V8s21BPevGbMkJ4QaXrH463wgGtRmqTaL0YCFxdRtkaMRZqTO
         1AGmOuB0m/T1aGWTzxNveTjBWJt2hiKTVvljQUsPnpQsJEA8GJbyBEMEy5JpMTcSdSCR
         xl3A==
X-Gm-Message-State: AOJu0YybnOmOZR/ygCWYR+Qh90RIpI/vZDi0PV/V7gAeZG3mgIygJLY4
        Sw1jZjXX2RuikZcRsQFcBOv0Kh6ypg52SIoNMdKMDtljZeS0
X-Google-Smtp-Source: AGHT+IFiFZCMZCnrYzOGO0I8ReDLC4j6yQVUiDVIELqVouH34B2TrIHyrLW5aeNBURvFTdw4IZu44eAbjHQFOC1ShPajiGKi6zhk
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1916:b0:3ae:2024:837d with SMTP id
 bf22-20020a056808191600b003ae2024837dmr13564961oib.8.1697151266486; Thu, 12
 Oct 2023 15:54:26 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:54:26 -0700
In-Reply-To: <cwc32sg4vzz6akduyvze6tu2dkzpljtvpycuhz43t7lmbzbyvb@jgywtsrcvuzw>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e814006078cd293@google.com>
Subject: Re: [syzbot] [usb?] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
From:   syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net, ricardo@marliere.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com

Tested on:

commit:         ce9ecca0 Linux 6.6-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10be5209680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59eae8406319284a
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131dd84d680000

Note: testing is done by a robot and is best-effort only.
