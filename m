Return-Path: <SRS0=lOn+=T7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7424C04AB6
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 16:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF424D37
	for <linux-media@archiver.kernel.org>; Fri, 31 May 2019 16:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Es9Q9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaQHb (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 31 May 2019 12:07:31 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43820 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfEaQHb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 31 May 2019 12:07:31 -0400
Received: by mail-ot1-f52.google.com with SMTP id i8so9666337oth.10
        for <linux-media@vger.kernel.org>; Fri, 31 May 2019 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+6Hn0nFVDDkuAPujDZhWPety1dkf7dDFIkK6FkxeNc=;
        b=m9Es9Q9noI05Wm6DeIp22EnPOTplDd9hrqBJ2j+kYkgwK5RfKoR8PfkoRhViY8w3LU
         ZanmaW8XePI2JikQ5+dWTm4g02cVhpX4yCWnI6K4P/jyKdjMrXkpUHHTI3QTZ05fvwk7
         /QgcJw/V/7bo3Q3Rr+THIBIlEpmTBJUr2D98GsN1wEHpu0gzyHS3+8M+UiIalz5vPx9A
         CzOZ5czLM652rwpPEEutsWuMPk73NxNZDD0+B//lOSwgKx7zmL+nZ7islexlWBkYNDT8
         lD4eUYfI0KPgEe94PAv3wz/+IOL9wXYTBpl2SgsfsS0/U3SG73DkkOMud54wBzERtcsJ
         /euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+6Hn0nFVDDkuAPujDZhWPety1dkf7dDFIkK6FkxeNc=;
        b=mWjkAda6J5r9bQMnYstvMuyrU2piGAwJiYuXJWQfVkyCQATpY2LRDufMS6VTZGFfNQ
         2JbCivqq0stnT2g04ribdKJdzVXx3KMSJ+bQxJ/+Qu/Mqm/Xdb5NZGlgsKUdPY7Y/K8B
         6RY6em6CNT0XTWd54V8GXQ3U6fGYDQ3y7WjIjhDXRZoWytMoCgbEVxmKIlAdXdrxhJmB
         M8LHO6mcY7ZNC4+dvrHVemA2JVZc+/Fdm3ggpGIiBOOIG0jZNnYgYAw5bgsOhhi4Vj6G
         Qc4FYWOiMso6J1AHVP8186zWNkxJXfi6CMzPH+knqbGlbH7QwfayEhhtWRqRESoBEuLy
         UuyQ==
X-Gm-Message-State: APjAAAXkAZNlgplNgXGioqf4JYuJjlY4naJBTz9ASFxdpExsAggvCJD1
        MlCWdhZKftSlKyV26G8FkayufUb3pSWDDbavo7c=
X-Google-Smtp-Source: APXvYqxajrV0W3igqalAYSSBIKYfPqkq32wSYVp1+xY0wEK/Sc5kQcU8TMK0UGSSUz1Klx+kpwVZrs0cgN4k5KQtbmE=
X-Received: by 2002:a9d:6e0f:: with SMTP id e15mr2592138otr.0.1559318850195;
 Fri, 31 May 2019 09:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190418164414.29373-1-p.zabel@pengutronix.de>
 <20190529154431.11177-1-TheSven73@gmail.com> <CAOMZO5BeEMyEPUbPB8vAbJb1OoUuPxGLh=EBGif12uAMG4=qoQ@mail.gmail.com>
 <CAGngYiWdyzhmsRuAsH_35qdt1SLguh2sUxh=cAK58RWnhm2Y7A@mail.gmail.com>
 <fa48a38ee8e370c195a872ba302f70329d52dca5.camel@ndufresne.ca> <e16e87bfdeee242a1dfb8c62b6f1528b346c3a99.camel@ndufresne.ca>
In-Reply-To: <e16e87bfdeee242a1dfb8c62b6f1528b346c3a99.camel@ndufresne.ca>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 31 May 2019 12:07:19 -0400
Message-ID: <CAGngYiX3Hv3mkd-GB=LuvmwaAuVMsGg2vpjx_F2-J3F6hOBVZw@mail.gmail.com>
Subject: Re: [v8] media: imx: add mem2mem device
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Nicholas, thank you so much for investigating.

On Fri, May 31, 2019 at 11:34 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>
> Now, if that pipeline was live, this would be a problem.

This is where my gstreamer knowledge gets really hazy.
What does it mean for a pipeline to be 'live' ?
Would this be a problem when playing a 1080p30 h264
video from a file?
