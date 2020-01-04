Return-Path: <SRS0=HsZd=2Z=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C289C2D0C2
	for <linux-media@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D503C24654
	for <linux-media@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=post.cz header.i=@post.cz header.b="cxoCy3i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgADQYP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:24:15 -0500
Received: from mxa1.seznam.cz ([77.75.78.90]:64094 "EHLO mxa1.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgADQYO (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 4 Jan 2020 11:24:14 -0500
Received: from email.seznam.cz
        by email-smtpc20b.ko.seznam.cz (email-smtpc20b.ko.seznam.cz [10.53.18.25])
        id 5379fb2284c2424753d1e5e5;
        Sat, 04 Jan 2020 17:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=post.cz; s=beta;
        t=1578155051; bh=w3/SGSyppjcjo0U3hSVmdY6GF1fAeH79vTfhtZ44I2o=;
        h=Received:From:To:Date:MIME-Version:Subject:CC:Message-ID:Priority:
         X-mailer:Content-type:Content-transfer-encoding:
         Content-description;
        b=cxoCy3i8ve5EmAwFakUAy4OBUTgDn0GE+pwFFWHLkFRK247Cwc7xkQT+9JZm6lmse
         3QEC/MpJnaVrpXzispHd63uuKnewLC8YXhLW9852tWErifuC2mYdx/9I1W4VhCt1W5
         56OetPvsuYOFzgl5RITKfgqF2Gs6dTWhUMFVboOs=
Received: from [192.168.12.172] (unknown [109.202.94.47])
        by email-relay28.ko.seznam.cz (Seznam SMTPD 1.3.108) with ESMTP;
        Sat, 04 Jan 2020 17:24:07 +0100 (CET)  
From:   "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To:     linux-media@vger.kernel.org
Date:   Sat, 04 Jan 2020 17:24:05 +0100
MIME-Version: 1.0
Subject: Re: Building own DVB-T channel file from frequencies (w_scan issues)?
CC:     Michal Zatloukal <myxal.mxl@gmail.com>
Message-ID: <5E10BC25.28008.1D98D978@Frantisek.Rysanek.post.cz>
X-mailer: Pegasus Mail for Windows (4.73.639)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4 Jan 2020 at 16:08, linux-media@vger.kernel.org wrote:
>
> ...just for the sake of completeness, t2scan seems to face some 
> misunderstanding with my Mygica T230C2, w_scan2 works fine...
> 
> [LOG SAMPLE of t2scan]
> Info: using DVB adapter auto detection.
>         /dev/dvb/adapter0/frontend0 -> TERRESTRIAL "Silicon Labs 
> Si2168": very good :-))
> 
> Using TERRESTRIAL frontend (adapter /dev/dvb/adapter0/frontend0)
> -_-_-_-_ Getting frontend capabilities-_-_-_-_
> main:2852: FATAL: FE_READ_STATUS failed: 121 Remote I/O error
> [/SAMPLE]
> 
> Apparently, compared to w_scan and w_scan2, t2scan is more pedantic 
> about checking the state of the tuner before starting its scan.
> And, I understand that these tuners have a fair share of their own HW 
> quirks.
> 
> I've already reported this to the author of t2scan.
> 
> Frank
>

It took mighty-p, the author of t2scan, just a couple minutes to 
respond. Amazing.

Apparently the check (and hence the error) can be suppressed by 
commenting out two lines in the source code:

if (ioctl(frontend_fd, FE_READ_STATUS, &fe_status) == -1) {
	//cleanup();
	//fatal("FE_READ_STATUS failed: %d %s\n",errno, strerror(errno));
}

After that, t2scan works just fine.

The hardware is a T230C v2, kernel 5.4.6.
Just in case someone has comments :-)

Frank
