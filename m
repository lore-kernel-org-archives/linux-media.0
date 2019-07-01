Return-Path: <SRS0=uXYw=U6=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E630C0650E
	for <linux-media@archiver.kernel.org>; Mon,  1 Jul 2019 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570721473
	for <linux-media@archiver.kernel.org>; Mon,  1 Jul 2019 16:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfGAQi2 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:38:28 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49625 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfGAQi2 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Jul 2019 12:38:28 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EE02B1BF20D;
        Mon,  1 Jul 2019 16:38:26 +0000 (UTC)
Message-ID: <7d2bf66655bfdaeeea45ef0878e7920b485bb120.camel@hadess.net>
Subject: Keymap with duplicate entries
From:   Bastien Nocera <hadess@hadess.net>
To:     tvboxspy@gmail.com
Cc:     linux-media@vger.kernel.org, Sean Young <sean@mess.org>
Date:   Mon, 01 Jul 2019 18:38:26 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hey Malcolm,

There seems to be a problem in  the keymap you provided for inclusion
in the kernel.

In media/rc/keymaps/rc-it913x-v2.c, 2 keys are triggered by the same
keycode:
 53 ↦       { 0x866b18, KEY_VOLUMEDOWN },•
 55 ↦       { 0x866b18, KEY_CHANNELDOWN },•

Could you please check what the correct values are for both of those
keys?

Thanks!

