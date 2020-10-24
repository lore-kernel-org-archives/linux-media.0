Return-Path: <SRS0=y9/N=D7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28CC2D0A3
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 05:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24CE2226B
	for <linux-media@archiver.kernel.org>; Sat, 24 Oct 2020 05:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759621AbgJXF3d (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 24 Oct 2020 01:29:33 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:45510 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759619AbgJXF3c (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 24 Oct 2020 01:29:32 -0400
Received: by mail-io1-f49.google.com with SMTP id n6so4534249ioc.12
        for <linux-media@vger.kernel.org>; Fri, 23 Oct 2020 22:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=As9n3qcWWvKGGPjdS3Qebg0rqpZxnZVB1uZsMIudUP8=;
        b=Jl5h8S/Pyj8qjxYvmUl4bROwT3vc3lCHcYX+TnboMAX1W6O44+S+FiWTqx1aEwjyFp
         W4AQ5wklmn9PJ2o/d2kpKA8cgIWEqGrt0cySvpnYlqa6/B3QQvt1Gb62XD/fIR3z34Bc
         JXfaRHCsMMCDoVLQsTEmnSpLfG0NsYmbNSe8Rgirjcio7RdxtZwVOOvUzQ0DORv+l3rq
         l18RRBw0oCdrsLklQfPmkGvH1zdVUUe6XEd6SiysUAhzZkLLAkQN4hTnIA+wLKE5Y5dv
         3O7LNv3v7QpePX3pEYubp0exTlnTRuFm9+0JHhcvFNM0TGWLjxD+o89wJIfx8aBqxH3u
         M4fA==
X-Gm-Message-State: AOAM531/dDJ4RvidVZhNrNd6IU0dRu+bKOdU8fg0Ce8TmX+E3o7Lsb3p
        rN3WnGnCr+r3+bPLMaxWQxWPGuaUIwxTAT5kREPX5A8woCI=
X-Google-Smtp-Source: ABdhPJyb3qChk8sjLe46udq0Hs4Mpj1kvDk/kJV27JDhUlXpeHkhI0CpPFaI/LYHSfokt4gXFJbbvDc4DflJ/oIZ+Vc=
X-Received: by 2002:a5d:9717:: with SMTP id h23mr4189543iol.7.1603517371692;
 Fri, 23 Oct 2020 22:29:31 -0700 (PDT)
MIME-Version: 1.0
From:   John Butcher <john@butcher.name>
Date:   Sat, 24 Oct 2020 06:29:20 +0100
Message-ID: <CAHVy6OTs=bc95Bo8UONMRTkzeCKeLnJ1dJiKmpR43466kcuFfg@mail.gmail.com>
Subject: UVC Support for ELP cameras from Arc International 05a3:9310 and 05a3:9320
To:     linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

Does the UVC driver support these?

ID 05a3:9310 ARC International
ID 05a3:9230 ARC International Camera

The first one seems to work OK, the second has some issues for which I
am trying to rule out as being driver-specific.

Regards,

John

# uname -r
5.4.51-v7l+
