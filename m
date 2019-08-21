Return-Path: <SRS0=4cU9=WR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4CC3A59E
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1C2332A
	for <linux-media@archiver.kernel.org>; Wed, 21 Aug 2019 07:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfHUH1J (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:27:09 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:43152 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHUH1J (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 21 Aug 2019 03:27:09 -0400
Received: from belgarion ([90.76.53.202])
        by mwinf5d09 with ME
        id rjSz200044MlyVm03jT47v; Wed, 21 Aug 2019 09:27:05 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 21 Aug 2019 09:27:05 +0200
X-ME-IP: 90.76.53.202
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, akinobu.mita@gmail.com,
        hverkuil@xs4all.nl, bparrot@ti.com
Subject: Re: [PATCH 3/4] pxa-camera: Match with device node, not the port node
References: <20190305135602.24199-1-sakari.ailus@linux.intel.com>
        <20190305135602.24199-4-sakari.ailus@linux.intel.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 21 Aug 2019 09:26:59 +0200
In-Reply-To: <20190305135602.24199-4-sakari.ailus@linux.intel.com> (Sakari
        Ailus's message of "Tue, 5 Mar 2019 15:56:01 +0200")
Message-ID: <87d0gzj7wc.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Sakari Ailus <sakari.ailus@linux.intel.com> writes:

> V4L2 fwnode matching right now still works based on device nodes, not port
> nodes. Fix this.
Mmmh why does it need a fix, and what's wrong on device node matching ? This
commit message is a bit too brief for me to understand why a fix is needed.

Moreover, does it have an impact on
Documentation/devicetree/bindings/media/pxa-camera.txt ?

Cheers.

--
Robert
