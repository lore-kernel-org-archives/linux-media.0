Return-Path: <SRS0=aOuj=6V=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB11C38A2A
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 20:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE120731
	for <linux-media@archiver.kernel.org>; Thu,  7 May 2020 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEGU7W (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 7 May 2020 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbgEGU7V (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 7 May 2020 16:59:21 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E3C05BD43
        for <linux-media@vger.kernel.org>; Thu,  7 May 2020 13:59:21 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B02A8C643A; Thu,  7 May 2020 21:59:18 +0100 (BST)
Date:   Thu, 7 May 2020 21:59:18 +0100
From:   Sean Young <sean@mess.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/3] input: serio: allow more than one byte to be sent at
 once
Message-ID: <20200507205918.GA13370@gofer.mess.org>
References: <20200507135337.2343-1-sean@mess.org>
 <20200507135337.2343-2-sean@mess.org>
 <20200507202546.GM89269@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507202546.GM89269@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, May 07, 2020 at 01:25:46PM -0700, Dmitry Torokhov wrote:
> On Thu, May 07, 2020 at 02:53:36PM +0100, Sean Young wrote:
> > serio drivers can only send one byte at a time. If the underlying tty
> > is a usb serial port, then each byte will be put into separate usb
> > urbs, which is not efficient.
> > 
> > Additionally, the Infrared Toy device refuses to transmit IR if the
> > IR data is sent one byte at a time. IR data is formatted in u16 values,
> > and the firmware expects complete u16 values in the packet.
> > 
> > https://github.com/DangerousPrototypes/USB_IR_Toy/blob/master/Firmware-main/IRs.c#L240
> 
> Ummm, serial protocol data size is at most 9 bits so I have no earthly
> idea how they expect to get 16.

serio is a layer on top several serial protocols, including ttys. ttys allow
more than one byte to be written at a time, see struct tty_operations:

        int  (*write)(struct tty_struct * tty,
                      const unsigned char *buf, int count);

ttys would be very inefficient if you could only write one byte at a time,
and they are very serial.

This patch exposes the underlying tty write() functionality to serio. When
the underlying tty is a usb serial port this makes for far fewer usb packets
being used to send the same data, and fixes my driver problem, and it
would reduce the number of calls in a few other cases too.

I'm happy to rework the patch if there are comments on the style or
approach.

Thanks,

Sean
