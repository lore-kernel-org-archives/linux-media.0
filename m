Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C704C64E7C
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B712A2173E
	for <linux-media@archiver.kernel.org>; Wed,  2 Dec 2020 16:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgLBQWn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:22:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:41057 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728661AbgLBQWm (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 2 Dec 2020 11:22:42 -0500
Received: (qmail 1057890 invoked by uid 1000); 2 Dec 2020 11:22:00 -0500
Date:   Wed, 2 Dec 2020 11:22:00 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+44e64397bd81d5e84cba@syzkaller.appspotmail.com>
Cc:     hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: memory leak in hub_event
Message-ID: <20201202162200.GA1057740@rowland.harvard.edu>
References: <20201123215345.GA721643@rowland.harvard.edu>
 <0000000000004b629f05b4cd7124@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004b629f05b4cd7124@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

> commit:         4d02da97 Merge tag 'net-5.10-rc5' of git://git.kernel.org/..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Hans says to call v4l2_device_unregister rather than 
v4l2_device_disconnect.  Let's make sure that works.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4d02da97

Index: usb-devel/drivers/media/usb/gspca/gspca.c
===================================================================
--- usb-devel.orig/drivers/media/usb/gspca/gspca.c
+++ usb-devel/drivers/media/usb/gspca/gspca.c
@@ -1575,6 +1575,7 @@ out:
 		input_unregister_device(gspca_dev->input_dev);
 #endif
 	v4l2_ctrl_handler_free(gspca_dev->vdev.ctrl_handler);
+	v4l2_device_unregister(&gspca_dev->v4l2_dev);
 	kfree(gspca_dev->usb_buf);
 	kfree(gspca_dev);
 	return ret;


