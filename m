Return-Path: <SRS0=Pmhz=6L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B70C54FCB
	for <linux-media@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB40206B9
	for <linux-media@archiver.kernel.org>; Mon, 27 Apr 2020 15:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0PCF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:02:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:42328 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgD0PCF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 27 Apr 2020 11:02:05 -0400
Received: by mail-il1-f197.google.com with SMTP id l16so19692206ilf.9
        for <linux-media@vger.kernel.org>; Mon, 27 Apr 2020 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TfUPXfE+cTIMWHEFg4Dl9b/oLW/Udq/MPl9VKXgMmok=;
        b=AaV2ksF/Ol/N9l3V7GFvCdfkJNciecySIdNsZ0ZgWbeoil/h+X5fTEdWXKF4JUHCNG
         /YEGa+AKX0bQWcZxYgpv4ajBed2o3+ROEPk+RhuMZ+u2lNIIQbd+gF3khLpV5/T1G7nb
         9TIWBM38zV9BgNkqarQfUyCcKTXQx8npOqCV3s9b7c8Ieeo6z1IvxvsCLwzb8kWY6QDx
         JzFkX/cOEJgJoJfm5PfjiowWMryUM5xaO1xoIMyTb2JkrmkokKqiMPlevWYgveFE11xD
         roHXvti56ImdX8KD3d7VNvuvEcBU+sk40ZEIjZhqd41KeVGULNw20Y9PZrkFhRe/Homi
         1RGQ==
X-Gm-Message-State: AGi0Pual0GcApXBSu/810ZkWvB5XY+NVcn8mvmfD5Md0k3HBg7av8zHB
        LyYSMvUmvQv0ETvPk4dsuzd+wS30Z1iTlmEcUkRegN+NmiUn
X-Google-Smtp-Source: APiQypL38u/Fn/pFodfcLRM1XK4BHxaVuMTFystRgZIhu07N9kJA6Yq8V9okZv7VSqr1LnfCu93YVrBkOZXUvBvnmUfJyxrixMPE
MIME-Version: 1.0
X-Received: by 2002:a5d:85d7:: with SMTP id e23mr21430309ios.174.1587999723210;
 Mon, 27 Apr 2020 08:02:03 -0700 (PDT)
Date:   Mon, 27 Apr 2020 08:02:03 -0700
In-Reply-To: <CAAEAJfAnMeZw3H3PJccpJTEME877i3=21CehykkSgnSnCZbOVQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067d2de05a446ffb5@google.com>
Subject: Re: KASAN: use-after-free Read in vkms_dumb_create
From:   syzbot <syzbot+e3372a2afe1e7ef04bc7@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        ezequiel@vanguardiasur.com.ar, hamohammed.sa@gmail.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to apply patch:
checking file drivers/gpu/drm/vkms/vkms_gem.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c578ddb3 Merge tag 'linux-kselftest-5.7-rc3' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=e3372a2afe1e7ef04bc7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165806efe00000

