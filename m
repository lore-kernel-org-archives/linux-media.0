Return-Path: <SRS0=+Dkd=UN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C49C31E4B
	for <linux-media@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEBB21721
	for <linux-media@archiver.kernel.org>; Fri, 14 Jun 2019 14:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfFNOgw (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:36:52 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47045 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfFNOgw (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 14 Jun 2019 10:36:52 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 06E0520002
        for <linux-media@vger.kernel.org>; Fri, 14 Jun 2019 14:36:46 +0000 (UTC)
Message-ID: <e1c968df516b751769765e0b0947caea607e7b7f.camel@hadess.net>
Subject: Remote "Mouse mode" buttons, Keycode choices, etc.
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-media@vger.kernel.org
Date:   Fri, 14 Jun 2019 16:36:45 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hey,

I dug out a fair bunch of remote controls I got around 10 years ago[1],
and started trying them all out.

I bumped into a couple of problems:

- the Snapstream Firefly remote ([2] using the rc-snapstream-firefly
keymap and the ati_remote protocol) creates 2 input device nodes, one
for the remote keys, one for the mouse mode. The mouse button on the
remote just sends KEY_MODE, and doesn't change the mode, nothing is
ever sent on the mouse device node

- the Streamzap remote ([3]) uses KEY_NUMERIC_[0-9] keycodes, just like
a small minority of other devices. Is there any reason for them not to
use KEY_[0-9] instead? Or for all of them to use KEY_NUMERIC_*, for
consistencies' sake. I can send patches for those.

- Some receivers (raw IR ones) can be used to support more remotes than
just the one they came with. Is there documentation on doing that? (I
have a Windows MCE, XBox 360 and Sony "universal" remote that I'd like
to make work with the Streamzap receiver)

Cheers

[1]: http://www.hadess.net/2010/05/my-new-toys.html
[2]: https://www.mythtv.org/wiki/Snapstream_Firefly
[3]: https://kodi.wiki/view/Streamzap_PC_Remote

