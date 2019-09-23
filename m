Return-Path: <SRS0=741g=XS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E9C04EBF
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E044207FD
	for <linux-media@archiver.kernel.org>; Mon, 23 Sep 2019 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407984AbfIWOVK (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:21:10 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:48247 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407008AbfIWOVK (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 23 Sep 2019 10:21:10 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id CPD6ixuerKKNGCPDAimJe7; Mon, 23 Sep 2019 16:21:08 +0200
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [ANN] Media sessions in Lyon in October: libcamera
To:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Daniel Gomez <daniel@qtec.com>,
        Eugen Hristev <Eugen.Hristev@microchip.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Message-ID: <07f46758-66e3-5ac1-cc41-807a30f93359@xs4all.nl>
Date:   Mon, 23 Sep 2019 16:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfESG3Gy0XChbbQlleTTRHW4eVchSXZd7bgKnj/abrGRlxA3s9qEWBLvXjw9U0F2TayvyVgjXLrmB18AWbN+gQXrgDxxn7wRmZNBewPkj+weZrZr9A8Sh
 u5mBZT7+jSKsDy2F8IW9NX5KxtxOvmCebW6Ue8KIMgkxRfaB8Q1oNsnX58BYPO5l3rbZu9ff81vz1+JontwHX/IhogZW1m1ETqiX+IxqiWzDAwEdMXVuJ22R
 QFh9MoCvDJKHNm/56id/nYIBUt0+X5TYz94xX1/WTM4LrXx3UinCdUuCqxGKpZ9T97L5SOXpWTNAQPWIVrEfrJJmm64Re5DvN91Hur+qWm0cmSIWj5+OO31K
 1WqtDD9RHln8hEXNyB5GKOEEWj+yA4PQlGKJRAFrtW3xWpUBckDE/lCWgdnR32XU1j++AhRbTTZ7CtylG2J61UY2HNSYP5ngxYJ663ukPQDIA19xRUfUbFhB
 Ctrei1QxINXmKUPFUHbXbeBrS4SvAfmIZ6D93aZPnpkKjXHdisUBBued2fpEI7dtyCuBbdxDwhrdYj/vKoiUQ0NMGjsgMfPLuDYQePrxFz3N9FS64syvOAZs
 JRziy4lGvvcQXhwC0f5rj2jwMGHolhtNROo8q+ifBZ1WkA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

Since we have three separate half-day sessions for different topics I decided
to split the announcement for this in three emails as well, so these things
can be discussed in separate threads.

All sessions are in room Terreaux VIP Lounge - Level 0.
There is a maximum of 15 people.

The second session deals with libcamera and is on Wednesday morning
from 9:00 to 13:00.

Attendees for this session:

Kieran Bingham <kieran.bingham@ideasonboard.com>
Boris Brezillon <boris.brezillon@collabora.com>
Alexandre Courbot <acourbot@chromium.org>
Tomasz Figa <tfiga@chromium.org>
Ezequiel Garcia <ezequiel@collabora.com>
Daniel Gomez <daniel@qtec.com>
Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Eugen Hristev <Eugen.Hristev@microchip.com>
Shuah Khan <skhan@linuxfoundation.org>
Helen Koike <helen.koike@collabora.com>
Jacopo Mondi <jacopo@jmondi.org>
Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Niklas Söderlund <niklas.soderlund@ragnatech.se>
Hans Verkuil <hverkuil@xs4all.nl>

If I missed someone, or you are on the list but won't attend after all, then
please let me know.

Attendees: it is probably useful if you let us know whether you have to
join this meeting because you plan to use libcamera, or if you are 'just
interested'. After the libcamera presentation on Tuesday afternoon we
should know how many of the 'just interested' list can join.

Agenda:

Laurent, can you fill this in?

Regards,

	Hans
