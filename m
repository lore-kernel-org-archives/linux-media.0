Return-Path: <SRS0=gKyG=UM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A31C31E45
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974A215EA
	for <linux-media@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USSYQR1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404095AbfFMQqj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:46:39 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34859 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfFMFKF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 13 Jun 2019 01:10:05 -0400
Received: by mail-qt1-f175.google.com with SMTP id d23so21156325qto.2
        for <linux-media@vger.kernel.org>; Wed, 12 Jun 2019 22:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6v0qjuPzO2HE72GVoc1kOy6XhlVRA18zPxAUBQbHC7E=;
        b=USSYQR1HkIkJVpEAqgLAlgtCS+mpkQy/CWJhE4hbJbw/fwxzGw+attKZ40a3eSMG4Y
         OQ2gARfJ645G2lPi5DnEMhHfM+4zsyun6ueakZ3sHJtQbKzV4PfbA11UCVtKLCmWsLYT
         g1BC3UYV37xqVhWKbVDLQyNGqgmkBA9AIGj1LlT3uBtY9j95IaTj6OVWwllQ8lT49HgJ
         v1zCAx1x3wIboLrihBOE3+9rekcltW+YmPbYjQXZ94QSSfqMUaQGg9FZNL0MIlwCskgh
         p33K3E3n8uLaVbOpvunLOnLAJgL7k+SVv3UzLUMJlsd1K7cUKdCirDYx491cii2zX37L
         Fz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6v0qjuPzO2HE72GVoc1kOy6XhlVRA18zPxAUBQbHC7E=;
        b=YE2BkdqfhSdLXjUxQ3aRedwT9k5yMX6VH2H30WQdP63J3yQphstx8TeP7HvD6sYjb8
         BZCoRrBCXJvJBJt4qgF0sKwsD6+bcjXgfqm9+P/sqmiP2s/RShqEcTQOu/Zniw4tyyPr
         PiCX58/muf43LPBCpxI1h+KldFoNjHE8BKWtzcWS5lHAxqEayFNjEiI6k33ca5mEI2nn
         9mrfP0QZeoUxheba9ibOYNIAIovq5fvuowPBTQeqMR2YapnUAkB9vK00ZCF0iMaVT88x
         GP06gKfxMN4IKn+Cztk8XiTjJgX9vMCMrrVKsD7TL/1+ZYjNOYSn74sSkqDZ8CNl5Voq
         7hNg==
X-Gm-Message-State: APjAAAX1/c5wadVZDyIffZsVYDsskTvaWSMoRh98N5WkgPUn0LOkEssz
        /v1sAh2z4nC8FSF81Ia6M8FWsT3ZCDUiNEzpKoQFKue+
X-Google-Smtp-Source: APXvYqzN86HSJwrXgzb5Wnfmt2SM6jhTNodgCRBLT7Yj+Qtww4vTtfBSiln8G/VUCBWLQtcrPf5xljXyr39q6M3my2w=
X-Received: by 2002:a0c:ad7a:: with SMTP id v55mr1786272qvc.130.1560402604599;
 Wed, 12 Jun 2019 22:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAKL8oB_qPGVXd3MCj=f1Lzh02ifGzYTS2YAD77s2MY2LAnc+1A@mail.gmail.com>
 <20190612150132.iemhbronjjaonpt2@gofer.mess.org>
In-Reply-To: <20190612150132.iemhbronjjaonpt2@gofer.mess.org>
From:   Takashi Kanamaru <neuralassembly@gmail.com>
Date:   Thu, 13 Jun 2019 14:09:51 +0900
Message-ID: <CAKL8oB-KxsGxHAUac7sYBf-Gs4UkAPVkXg75LwwVbut9GkQ-sQ@mail.gmail.com>
Subject: Re: The restricted number (LIRCBUF_SIZE) of pulse-spaces in IR
 sequences is too small
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Dear Sean Young,

> I don't see any reason why it can't be increased. For the record, it would
> be interesting to know what your air conditioner model is and what the
> IR signal looks like. I have not seen such a signal before.

I observed the IR signals of my air conditioner (Panasoic ACXA75C00600)
and TV (Belson DS16-11B) with the oscilloscope,
and uploaded their graph as follows:

https://github.com/neuralassembly/raspi/blob/master/IRSignalGraph.png

It is observed that the length of IR signal of air conditioner is long
(about 250ms),
and that of TV is short (about 60ms).

It is difficult to count the number of pulses and spaces in this graph,
so I counted them from the output of the "mode2" command.
They had 439 pulse-spaces and 67 pulse-spaces, respectively.

Sincerely,

Takashi Kanamaru
