Return-Path: <SRS0=Mt3G=7C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA07C433E0
	for <linux-media@archiver.kernel.org>; Wed, 20 May 2020 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47402075F
	for <linux-media@archiver.kernel.org>; Wed, 20 May 2020 10:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LiZcA0uL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgETKCG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 20 May 2020 06:02:06 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:33771 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgETKCF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 20 May 2020 06:02:05 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id bLXzjmaqPFjnUbLY3jXnV8; Wed, 20 May 2020 12:02:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1589968923; bh=F6dNqo0JpBgUDVWBOlxOwirjy3/+V4+DwtBLPzyWc5M=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:From:
         Subject;
        b=LiZcA0uLnkyRBvzaszYvQGeAfbRxci2nZq3aU4jO736coTuRiZ8HfpQJPUBbfxfnU
         q5Ss9BUdHklT4hLckoDzZdYTVIlV8omiP5j3PayBgYEQI5uO6XaTynCPACfwt3e2Li
         GdYbRD481ggSL9SHWozub7SIkDJJUu32HuszxtfmBnf7fQsx3XmdPIwRgMBi6YcznP
         nk5aSP+5jrMIShKfBZuLtKQpuOlQTP34BqPyLNbC1Cq/Ocmeggi88uhHH6Y+iUtfy8
         pSYNzmfGXkyhQSjXAAHyoIUg/t8LZPTqpgTr//dwk1kIsnv3i3FQmFtigMSsjageJe
         ycOfdhv4x4iHw==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCHv2 0/2] Stateful Encoding: final bits
Date:   Wed, 20 May 2020 12:01:57 +0200
Message-Id: <20200520100159.2094831-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCs9/CCYUK+6+QKsuPFHPr7qEQUpFHs/KBz8Hj/ouWTUnkZmOcmE7BG41rAONqh7UlwbQEgceu8Y3+6MQMG4KfwTQ2VCNnM531a4dAFnbIddkoQS64qS
 ffu+BUUGHmXuhSvjG/PSxHoKyd8LOTWhd2AL3yLz/Yfpa89lplvNHPFcjlSqJ1jZjKztaoD2jfO90nuGdre+0/a/V462wQQCV0Jsem/jg/enUl1bXfJ/l9RX
 Tnhk3vqL6fLu0iu5yRSPjTQPU+PZLuxwwJ6ACrgO2ULRcyZvfar5LZv2LL4HoVl6
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This series adds the encoder spec and updates the VIDIOC_G/S_PARM
documentation.

This is a follow-up of the original "Stateful Encoding: final bits"
series (1). 

The patches in that series that add support for V4L2_CID_MPEG_VIDEO_ENC_FRAME_RATE
and V4L2_BUF_FLAG_TOO_SMALL have been dropped (the first is not necessary
and the second can be skipped for now, see the irc discussion with
Nicolas [3]).

The encoder spec has been updated since [2] with the following
changes:

- Document the optional VIDIOC_ENUM_FRAMEINTERVALS ioctl.

- Document how to use VIDIOC_S_PARM:

  1) calling S_PARM for the OUTPUT queue sets both the raw frame interval
     (this is a hint only) and the coded frame interval.

  2) calling S_PARM for the CAPTURE queue sets the coded frame interval
     only. This is optional and can be used for off-line encoding. In
     that case the OUTPUT frame interval can be used by the driver to
     schedule multiple encoders.
 
  Ideally S_PARM for the OUTPUT queue would just provide a hint, but
  existing encoder drivers all use S_PARM for the OUTPUT queue to
  define the coded frame interval, and that can't be changed.

- Added a note that if a capture buffer is too small it will be
  returned with V4L2_BUF_FLAG_ERROR and that more work has to be
  done to properly support this corner case.

- Clarify in the 'Encoding' section that there are more reasons
  why 'a buffer queued to OUTPUT may result in more than one buffer
  produced on CAPTURE'.

I think that with these changes this stateful encoder spec is ready
to be merged.

Regards,

	Hans

[1] https://lore.kernel.org/linux-media/20191119113457.57833-6-hverkuil-cisco@xs4all.nl/T/
[2] https://www.mail-archive.com/linux-media@vger.kernel.org/msg149211.html
[3] https://linuxtv.org/irc/irclogger_log/v4l?date=2020-05-19,Tue

Hans Verkuil (1):
  vidioc-g-parm.rst: update the VIDIOC_G/S_PARM documentation

Tomasz Figa (1):
  media: docs-rst: Document memory-to-memory video encoder interface

 .../userspace-api/media/v4l/dev-encoder.rst   | 727 ++++++++++++++++++
 .../userspace-api/media/v4l/dev-mem2mem.rst   |   1 +
 .../userspace-api/media/v4l/pixfmt-v4l2.rst   |   5 +
 .../userspace-api/media/v4l/v4l2.rst          |   2 +
 .../media/v4l/vidioc-encoder-cmd.rst          |  51 +-
 .../userspace-api/media/v4l/vidioc-g-parm.rst |  51 +-
 6 files changed, 798 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/dev-encoder.rst

-- 
2.25.1

