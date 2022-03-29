Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA89C433F5
	for <linux-media@archiver.kernel.org>; Tue, 29 Mar 2022 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiC2WOB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiC2WNw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Mar 2022 18:13:52 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB3F186FA6
        for <linux-media@vger.kernel.org>; Tue, 29 Mar 2022 15:12:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so13276061iow.5
        for <linux-media@vger.kernel.org>; Tue, 29 Mar 2022 15:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OOoVa+V/irW/x+0wA9yzjLGHzahFLKZsDL8MQwHOdOk=;
        b=4xVEzoF7Ig1tl3bzh0HBiHksDCVLs5TInTrpdZo1GmJU7XjYQ7Y+EHjWEd1pxPRiBx
         J51oikQL6a1SbOM8DTvPVLOPbYhb5/MDu2RrftnZNFmEvohuumAfREF8p4J6DFG2w21d
         4oKH0qgokCyY2G2bcHdKRlc2jcOGGDvvGJDq7RFKOsZRyW/D+tKfkkNwPlCy0uUPm002
         JWOcbt4lIhnhR9b7Gc3grGX/6iUc1dTuTHw/8z/eOyDPnAoedNfONGqBexAqOvtQLrQV
         2D0ZjzTCamISdUtCkMYN0acww51XoJRRTKxsSw8Yxd/aSuP6m4gAtHrBCxG9ealF1MU+
         TMIw==
X-Gm-Message-State: AOAM533b6drRfJxIZZwiTliJKHEtQ87jPJ0CQMBYKRVblj5J0gLIeq9o
        n1n+vh79DdAFxTXgYLrnk5yGAW5R+C5aGPEISDyi7nzCHhov
X-Google-Smtp-Source: ABdhPJw3pahBeObtq8ZwZuFbJHHaAzDqVoMW2fRmLcGfMwRzoQkSN2/0Mynl0syuHLCkZzBNOgbVxEEbxorg8AC0mn61Oh8R+l2M
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2053:b0:31a:4907:ff65 with SMTP id
 t19-20020a056638205300b0031a4907ff65mr16979897jaj.224.1648591928519; Tue, 29
 Mar 2022 15:12:08 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:12:08 -0700
In-Reply-To: <419a9bb8-cb68-8add-e7be-275a48b2126d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000476f2c05db62b851@google.com>
Subject: Re: [syzbot] general protection fault in dma_fence_array_first
From:   syzbot <syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, gustavo@padovan.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, paskripkin@gmail.com,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com

Tested on:

commit:         c2528a0c Add linux-next specific files for 20220329
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=88d1370cc1f241e6
dashboard link: https://syzkaller.appspot.com/bug?extid=5c943fe38e86d615cac2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128372e7700000

Note: testing is done by a robot and is best-effort only.
