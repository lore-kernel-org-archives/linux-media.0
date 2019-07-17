Return-Path: <SRS0=lr8S=VO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAF9C7618F
	for <linux-media@archiver.kernel.org>; Wed, 17 Jul 2019 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985BA21743
	for <linux-media@archiver.kernel.org>; Wed, 17 Jul 2019 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfGQSFq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 17 Jul 2019 14:05:46 -0400
Received: from jpvw.nl ([80.127.100.2]:46700 "EHLO jpvw.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbfGQSFq (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 17 Jul 2019 14:05:46 -0400
Received: from jp by jpvw.nl with local (Exim 4.92)
        (envelope-from <jp@jpvw.nl>)
        id 1hnoJE-0001Pt-5d; Wed, 17 Jul 2019 20:05:44 +0200
Date:   Wed, 17 Jul 2019 20:05:44 +0200
From:   Jan Pieter van Woerkom <jp@jpvw.nl>
To:     linux-media@vger.kernel.org
Cc:     Michael Ira Krufky <mkrufky@linuxtv.org>,
        Antti Palosaari <crope@iki.fi>, Sean Young <sean@mess.org>,
        Frantisek Rysanek <Frantisek.Rysanek@post.cz>
Subject: [PATCH V3.6 0/2] linux-media: dvbsky: add support for Mygica T230C v2
Message-ID: <20190717180544.GA5356@jpvw.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add support for the "Mygica T230C v2" into the "dvbsky" driver.
A small enhancement in the si2168 demodulator driver is also
needed, and a USB device ID in dvb-usb-ids.h .

This is v3.6 of proposed patch, based on work from an
anonymous author, and with feedback from Sean Young and
Antti Palosaari. Tested by patch author on DVB-(T/T2/C).
Tested by Frank Rysanek: can tune into locally available
DVB-T and DVB-T2 muxes, video and audio playback works.
Applies cleanly against Linux 5.2 .
