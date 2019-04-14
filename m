Return-Path: <SRS0=V0pp=SQ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5ACC10F13
	for <linux-media@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C047120850
	for <linux-media@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDNUGJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:06:09 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:55181 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfDNUGJ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Apr 2019 16:06:09 -0400
Received: by mail-it1-f197.google.com with SMTP id i188so14653572iti.4
        for <linux-media@vger.kernel.org>; Sun, 14 Apr 2019 13:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XnDbyPMLrw+4rsIZ66ETw+Ocod4UqEi2f/uuyW0yOUk=;
        b=RswIApHnowKpXnzTXId9J8QGVCcWsW31XeG96p33POyqibayDNl30ox7n3fcfTI38F
         VQ7ISj5CocAkrLxzOvvUbtq7EknmBKQ3X488coM8NBKlx8VfiaIZBND4zBXmTFxKDjpq
         HkG6ub3fdRW0MYx75wTR5vJ3Lz2EXnRv0HEQ7XroC8wNX1fcC3LeizjFgerlGcWCRLxh
         pA/MdiJhJOkyY+6C5DX/uSfWaKRN6cV1+lfz/YrqpiCt1THTx0LJqvisIvo3/1ngpCKM
         OZ5dn2vHjjo7iKFMfOhmCIOBPAc7pqmVrANKoepmZewqISpZZXC5BDAZkUWWbYqRMyAF
         y8DQ==
X-Gm-Message-State: APjAAAX+8TRLtm1dBqPBzCxevWnrBk9Kkp2MkHzx0YaEXPYpWc5zbnaW
        5mVvZy7v0Z/1GSSBg9l4ooHLQrJgmBWH+WYMIAXV9hCISlDh
X-Google-Smtp-Source: APXvYqws1ThwJhoK1JrxywMmoR5/VrI82rgmYq2QvD7AzL0hHk2yt/eOK7T4/I3B2eemPKkD0B4rf929ZyVf6ENiW5Fo361679o8
MIME-Version: 1.0
X-Received: by 2002:a05:660c:50:: with SMTP id p16mr1734429itk.3.1555272368165;
 Sun, 14 Apr 2019 13:06:08 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:06:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000089d7f058683115e@google.com>
Subject: KASAN: slab-out-of-bounds Read in technisat_usb2_rc_query
From:   syzbot <syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hans.verkuil@cisco.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1441219f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=eaaaf38a95427be88f4b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174a67bb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17aa2023200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eaaaf38a95427be88f4b@syzkaller.appspotmail.com

rc rc1: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.0/usb1/1-1/rc/rc1
input: Technisat SkyStar USB HD (DVB-S/S2) as  
/devices/platform/dummy_hcd.0/usb1/1-1/rc/rc1/input10
rc rc1: lirc_dev: driver technisat-usb2 registered at minor = 1, raw IR  
receiver, no transmitter
dvb-usb: schedule remote query interval to 100 msecs.
==================================================================
BUG: KASAN: slab-out-of-bounds in technisat_usb2_get_ir  
drivers/media/usb/dvb-usb/technisat-usb2.c:664 [inline]
BUG: KASAN: slab-out-of-bounds in technisat_usb2_rc_query+0x5fa/0x660  
drivers/media/usb/dvb-usb/technisat-usb2.c:679
Read of size 1 at addr ffff8880a8791ea8 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events dvb_usb_read_remote_control
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  technisat_usb2_get_ir drivers/media/usb/dvb-usb/technisat-usb2.c:664  
[inline]
  technisat_usb2_rc_query+0x5fa/0x660  
drivers/media/usb/dvb-usb/technisat-usb2.c:679
  dvb_usb_read_remote_control  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:128 [inline]
  dvb_usb_read_remote_control+0xe5/0x1c0  
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:105
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 615:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:152 [inline]
  dvb_usb_device_init.cold+0x317/0x10b3  
drivers/media/usb/dvb-usb/dvb-usb-init.c:277
  technisat_usb2_probe+0x82/0x2d0  
drivers/media/usb/dvb-usb/technisat-usb2.c:763
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 1:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  krealloc+0x7d/0xc0 mm/slab_common.c:1570
  add_sysfs_param.isra.0+0xcd/0x930 kernel/params.c:633
  kernel_add_sysfs_param kernel/params.c:794 [inline]
  param_sysfs_builtin kernel/params.c:833 [inline]
  param_sysfs_init+0x364/0x435 kernel/params.c:954
  do_one_initcall+0xde/0x597 init/main.c:901
  do_initcall_level init/main.c:969 [inline]
  do_initcalls init/main.c:977 [inline]
  do_basic_setup init/main.c:995 [inline]
  kernel_init_freeable+0x4da/0x5c7 init/main.c:1150
  kernel_init+0x12/0x1ca init/main.c:1068
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a8791dc0
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 232 bytes inside of
  256-byte region [ffff8880a8791dc0, ffff8880a8791ec0)
The buggy address belongs to the page:
page:ffffea0002a1e440 count:1 mapcount:0 mapping:ffff88812c3f4e00 index:0x0
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 dead000000000100 dead000000000200 ffff88812c3f4e00
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a8791d80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff8880a8791e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8880a8791e80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                   ^
  ffff8880a8791f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a8791f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
