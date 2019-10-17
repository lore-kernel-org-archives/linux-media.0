Return-Path: <SRS0=c9eX=YK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A56ECE58E
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 09:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45702089C
	for <linux-media@archiver.kernel.org>; Thu, 17 Oct 2019 09:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405313AbfJQJIj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:08:39 -0400
Received: from gofer.mess.org ([88.97.38.141]:33671 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJQJIj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Oct 2019 05:08:39 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E160AC6464; Thu, 17 Oct 2019 10:08:37 +0100 (BST)
Date:   Thu, 17 Oct 2019 10:08:37 +0100
From:   Sean Young <sean@mess.org>
To:     Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org
Subject: Logilink VG0022A firmware/si2157 probe
Message-ID: <20191017090837.GA26546@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Antti,

I have a Logilink VG0022A device which is an af9035.c type device (with
ITE 9xxx frontned). The probe of the si2146 tuner fails and returns 0xffs.

Now I would like to work on fixing this. Mauro suggested the firmware might
be incorrect. Any tips on extracting the firmware? I can try and dump
usb traffic from Windows and see what firmware is being used there. How did
you extract the firmware?

Any other suggestions for this device? You might be able to save me a lot
of time since you have experience with these types of devices, I do not.

Thanks
Sean
