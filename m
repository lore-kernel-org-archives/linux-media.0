Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F0C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8CB2084F
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PViJHg/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDIMi7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:38:59 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43755 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMi7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 08:38:59 -0400
Received: by mail-lj1-f173.google.com with SMTP id f18so14285498lja.10
        for <linux-media@vger.kernel.org>; Tue, 09 Apr 2019 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMEFfBWwckdGay6XicwPC8o+hIt/04fBkog1xB0Gvz8=;
        b=PViJHg/ocrAfJ4Iw5+1NKmmV4Yx4CODZw4J+gdlvFREFuQiV8OctKFrGT8gIo9UVla
         Xml7f7/Eg9MXZnxWOYtnfWQCvbHmEexlgxsEZSm/KYpcNYHA73WX/JbAGESQZf5nnjNA
         iQMLJ5xq6AWwPJWN5zFFdZBXEijC6u7Qn3QcaVmAcU3z1WOlhhCMp3cvuPG66CYTsgiX
         KbKNUyxKbNogbeOlPLNf3uxxWJmQ+TYJj/1dxgal7rNsoDtqefhgVV01a1EFy9Yo5NHB
         4bn2kRCOivbaDq0pV6HJurWmfNXNZ5ZIcMZpfBuTyO59M/RhkuMjZIJVIVXEsf4AbxJp
         /puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMEFfBWwckdGay6XicwPC8o+hIt/04fBkog1xB0Gvz8=;
        b=X5a3jA6mdV++u3FER6XbFq0uhApLWxQRgkbDpiYqG+8Ua1C/kkkmFwgjClmy5eIdQ9
         iydTFi+oEgsyTp+mvYu72zogBN12lCKTChMNRAN3gjbxtcG+nzhZc/t7ItgRGRIZI9G4
         dqut0wRKkR9XpL/bwsGUG/s/md+PI5jL1uggcWG96v5MUdYi3JjQ0uuhLn/3GHu+GBv1
         SpGH8K7egLHg4q84NvNXl6m+NmV0VdaaH4iryqPBvZqRa2aZTrHfXddhQAaujvg78Dmh
         sLHUokfATzOxl6MJ5OGeOtlUHRUq9TtEhqHCmbeBN6KPmL1FMuvXc982Q8+ACtMCXviq
         zG1g==
X-Gm-Message-State: APjAAAVPp2Hr9jO1b2693vq+VvdM2dC7t01Aim4a/wTGrgT6zmZAm10z
        Bpombf77TAlHjKHJ7zQ0E1doZTzh
X-Google-Smtp-Source: APXvYqyHhJWhpehTqp/fOUSoL+kXcNGJkQnAqUMgzpI/jZPnJTU5FnLwSXhnQY4nAhtV54XWdkI5dg==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr19174735ljc.143.1554813536709;
        Tue, 09 Apr 2019 05:38:56 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-200-6.ip.moscow.rt.ru. [95.84.200.6])
        by smtp.gmail.com with ESMTPSA id t23sm6749976ljc.13.2019.04.09.05.38.55
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:38:55 -0700 (PDT)
From:   =?UTF-8?q?=D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD=20=D0=98=D0=B6=D0=B1=D1=83=D0=BB=D0=B0=D1=82=D0=BE=D0=B2?= 
        <lrn1986@gmail.com>
To:     linux-media@vger.kernel.org
Subject: [PATCH 0/8] [PATCH for ZBar] MinGW compatibility patches
Date:   Tue,  9 Apr 2019 12:38:34 +0000
Message-Id: <20190409123842.19600-1-lrn1986@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Here's a few patches that might be useful.

Руслан Ижбулатов (8):
  Include windows.h for vfw
  Specify correct path to barcode.png
  Check for clock_gettime on pthread library as well
  Disable zbarcam-gtk on Windows
  Use -no-undefined for libzbargtk
  Make zbargtk build on Windows
  Make use of glib thread names
  Correctly generate version.xml and reldate.xml

 Makefile.am             |  2 +-
 configure.ac            |  8 ++++----
 gtk/Makefile.am.inc     |  2 +-
 gtk/zbargtk.c           | 12 +++++++++++-
 zbarcam/Makefile.am.inc |  2 ++
 5 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.4.0

