Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2101FC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 04:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB87B217D6
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 04:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfDJEoB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:44:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:54376 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfDJEoB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 00:44:01 -0400
Received: by mail-it1-f197.google.com with SMTP id i188so1189346iti.4
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 21:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D9uY9wfjPgxafxN96VuhVPMk10AftLSB40jLhWMlsHI=;
        b=nEb5BPfIiedZHzQxsdhyViz7sg/CCJOhHoWJJ/dylh1BfwGlu8ESbK8tDs7or4IX9Q
         /wbcufCJAIQxFBsg+EjSRkey7V6dCbTpmCokNX+JGsg4XeRXz+hwbxpdA8RJmO/Nl3mY
         qXouAP3WVp4Hhr+nsvxj4zYfTCuz3Dhzmojc9KcTyKfi1PD9AXOV/WeBvDd6+R+NWzx9
         pBTCYr9dmFE0s0SsnOXLA7Qm1hIAeU5UdgxUlEr4izhAvHVl36RsffxSl8OWGBcz07JW
         t9epLDk7mPmWRKexqTgBi9s7Xh4whWScgerTSOl0RXAmoozgryDq4meMlajOffz/kmcI
         6JXw==
X-Gm-Message-State: APjAAAXcz0KxzCe4UY+A9GIeiCLqv65LNCBw5psaP18SbSky0r5kJ83x
        SGTNyrYgycy4R1SBh8PqUbhKREsvzgva0c7OY2V+g4OX8NSK
X-Google-Smtp-Source: APXvYqyRga4bPij5qUcrQx4xWsEU9LjTYsqP7NCaiTpwsE98in8ZkuCKcwGGAqI6XtY//X0d/xl51snDvrGW0RclSd38s4pqcpE7
MIME-Version: 1.0
X-Received: by 2002:a05:660c:34a:: with SMTP id b10mr369669itl.13.1554871440701;
 Tue, 09 Apr 2019 21:44:00 -0700 (PDT)
Date:   Tue, 09 Apr 2019 21:44:00 -0700
In-Reply-To: <0000000000005b7c64057ba003fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e50a29058625b741@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tpg_fill_plane_buffer
From:   syzbot <syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com>
To:     bwinther@cisco.com, hans.verkuil@cisco.com,
        helen.koike@collabora.com, hverkuil-cisco@xs4all.nl,
        hverkuil@xs4all.nl, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, mchehab@s-opensource.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

syzbot has bisected this bug to:

commit f2fe89061d79706eca5c47e4efdc09bbc171e74a
Author: Helen Koike <helen.koike@collabora.com>
Date:   Fri Apr 7 17:55:19 2017 +0000

     [media] vimc: Virtual Media Controller core, capture and sensor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b9542d200000
start commit:   6a1d2932 Add linux-next specific files for 20181224
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16b9542d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9542d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9369d117d073843
dashboard link: https://syzkaller.appspot.com/bug?extid=aa8212f63ea8ffaf3bfa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0363b400000

Reported-by: syzbot+aa8212f63ea8ffaf3bfa@syzkaller.appspotmail.com
Fixes: f2fe89061d79 ("[media] vimc: Virtual Media Controller core, capture  
and sensor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
