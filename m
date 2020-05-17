Return-Path: <SRS0=D5d7=67=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9CDC433DF
	for <linux-media@archiver.kernel.org>; Sun, 17 May 2020 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E92C206F9
	for <linux-media@archiver.kernel.org>; Sun, 17 May 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk1f0yox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgEQAFA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 16 May 2020 20:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEQAE7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 16 May 2020 20:04:59 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419DC061A0C
        for <linux-media@vger.kernel.org>; Sat, 16 May 2020 17:04:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f13so6676217qkh.2
        for <linux-media@vger.kernel.org>; Sat, 16 May 2020 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=HwdR2oSJeubyxJObstAoNY0VbZWC9XtBQV0xlMILnjU=;
        b=hk1f0yoxhjmfmMrTn/DXpRlHHJmGE4iUZsnhuAY+6HMcrJfdxAYlfR21sNsHOELxE5
         dyzOaNxznDxukdYgpDc28nHYpA3WhV7I/T/ot38CR9pmN19Zosjnm9LNxpmfKF1MvhxG
         J05PiKkHAIXnySihbI5inPc4oVs11ZBEFS3FclozMW+BZAyWsyexNf2V6AsewXMApFRR
         vCyAkDDuIEFvEfSKbLcn4viW95IwbUbu7jMB77zkBRQKidW/ZL4IdAJuqWJ1Y/CM4ALC
         FVSE9wshRUvq38Ajpxp235CDhWyg270xkJQc/o0ilYP0lfxHHVWroS4x0qRUHMu7g0rO
         SxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=HwdR2oSJeubyxJObstAoNY0VbZWC9XtBQV0xlMILnjU=;
        b=aS69G+cR3ItdQATWgLta8dATLog9yXq8God3fyYC89+74RTbqW8brdT18Xjugm2ZjS
         NFc3rtw6r2zI5ckD/OPcoj4oPtzVaHTr/qaQmQ1+qK7JOGtW1kM01Oxa3wqpdpQbrRNP
         Nc66r7dnB7bFq8VStBDFu5p9/QXGq4EcopeXd+6ySoNGGlG6vPLFoTlXvh6cb4YAZL4j
         bdtxfFkZTAxxbulO8stNQKqZh/27ZbI1zIc7ZGIVsLT31rncGWPdVCcSLQeMIxKRtdXQ
         0MYZU7rf71wMa5wdx73Lne2wrSm2kjH/SLQShR1dzkkBZH1bISui1+TLerBpxNlSrJOv
         xIZA==
X-Gm-Message-State: AOAM531BYiU4YjiiJBpqfq3aNsNizbgKPP/+fvkRleO95A6njbpxGwP2
        qgMwTzbXd6Xr1s5MsB/x0Nk=
X-Google-Smtp-Source: ABdhPJwrh5Q+3hoVWhc1D/quYBKHRf+7Gi0NigsFvlWuLbTqLjFjvcqtN6Kkr4oIjkeRorWJDstOag==
X-Received: by 2002:a37:5d3:: with SMTP id 202mr8635709qkf.324.1589673898188;
        Sat, 16 May 2020 17:04:58 -0700 (PDT)
Received: from dwls-dell ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id c24sm4867663qka.25.2020.05.16.17.04.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 May 2020 17:04:57 -0700 (PDT)
Date:   Sat, 16 May 2020 21:04:54 -0300
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "=?utf-8?Q?skhan=40linuxfoundation.org?=" <skhan@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "=?utf-8?Q?linux-kernel-mentees=40lists.linuxfoundation.org=22?=" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <A67F53F3-E285-4E60-B3ED-6747F60E11C9@getmailspring.com>
In-Reply-To: <20200517014237.30e521dd@coco.lan>
References: <20200517014237.30e521dd@coco.lan>
Subject: Re: modprobing 'vidtv' doesn't really do anything
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Yeah the Makefile was broken, although I corrected it in the last
revision, so this warning should be gone already?

I guess you're looking at v4, in which case I have sent in new code that
hopefully addresses the things you pointed out in the last code review :)

I will try what you said regarding the platform bus and report back.

- Daniel.
