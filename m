Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09061EE49A3
	for <linux-media@archiver.kernel.org>; Wed, 23 Aug 2023 01:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjHWBld (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Aug 2023 21:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBlb (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Aug 2023 21:41:31 -0400
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:41:29 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337C1E46
        for <linux-media@vger.kernel.org>; Tue, 22 Aug 2023 18:41:28 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-52-64e54b4a1590
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 49.6B.10987.B4B45E46; Wed, 23 Aug 2023 04:56:59 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=a/QwjrDNR9ehH66+C9gS74w4Ft7NFsB7H1kNrrKlCEXOSDhuhSMcOeFhsW8DZJ41T
          Uq/GC69ttSnd7s6C5qhTcoJsbHSxC7OJdX/kx3haELwjAwzazjPY3am1WUXq2WDPb
          cWfsf0uI1PDUnQfw84t0kPP6Hn/H2KFrskHg1ECSE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=YbgY87UbjLMPTq94ZQZw9HE1a92yDfQhQKvIZJHp5+oFtQtIiVEbHjZgDc4cNHFbM
          mxftryZ8vv56E5RDwiQXgN9ahYqMW2h555eOuRy0dFLYIABpk5zkgN/KtaauwACTy
          3gUI9C/va2X0fIhOeZKhcrLPeGoYr5sYBWSyhOYeU=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:04 +0500
Message-ID: <49.6B.10987.B4B45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-media@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:17 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVyyUKGW9fb+2mKwc/nnBY9G7ayOjB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWxZN0FloLdzBVt/YtYGhgfM3UxcnJICJhIfN94h7WLkYtDSGAP
        k8SSj73sIA6LwGpmif3z30E5D5kldrW+YYMoa2aUeLlyHjNIP6+AtcStQ28YQWxmAT2JG1On
        sEHEBSVOznzCAhHXlli28DVQPQeQrSbxtasEJCwsICbxadoydhBbREBe4knvDbBWNgF9iRVf
        m8FGsgioShzc9J4VxBYSkJLYeGU92wRG/llIts1Csm0Wkm2zELYtYGRZxShRXJmbCAy2ZBO9
        5Pzc4sSSYr281BK9guxNjMBAPF2jKbeDcemlxEOMAhyMSjy8P9c9SRFiTSwD6jrEKMHBrCTC
        K/39YYoQb0piZVVqUX58UWlOavEhRmkOFiVxXluhZ8lCAumJJanZqakFqUUwWSYOTqkGRrOg
        /vqn+beeZzCfSl8WZ3H0mPeCzYZvV8tPkTOp3vGkaW5udUHulaCP2w+begsIzb+xco0FQ5PC
        4QnV3zNf7Dr+ofBz4B77y+l+UguTnsnNnM+ltmkHx0aGXt1Vp3fwLTznu/rTlObJP3bnLPn8
        yeWqi9J94VM21QUHDut7TFuwa97sN5fsn/xXYinOSDTUYi4qTgQA6hlNIUACAAA=
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

