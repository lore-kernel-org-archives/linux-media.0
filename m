Return-Path: <SRS0=pHRl=B4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579EEC433DF
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3767E20866
	for <linux-media@archiver.kernel.org>; Tue, 18 Aug 2020 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="gvXXdzxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHROhg (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:37:36 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:43841 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbgHROhX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 18 Aug 2020 10:37:23 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 82jnkV8V2uuXO82jpkcevT; Tue, 18 Aug 2020 16:37:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1597761441; bh=nXE++WV7vSTYUsAx1anAj5g+i8ZYaSIMkXK58BSLnyk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=gvXXdzxt4Q/dqFT6Q+zMQIsM4e+QmrKEHuF6qwhMgipQdJav6mDvFICexBfvXXYuY
         QT0t1esKEaph1Ey8yvi0zhyzPaFxQlaHmWMymfZxYuLVymVFVD5M5I7xUX7e7u9Q/9
         q1pEhBssgEo9LymrZKwtYaE2QdjhClyiipjyTvFKs94vLAfIE+kCsrhM0S84Q1pyfy
         jqJ/FQumhUyLxwKlh7Il7LOS7vale03vFwzcvjLtFdt5op0wvcK8uSwmgolTk3qG/K
         RzJJ8uG7OvzN1tPJKJhLfFD1PmiEdTJKRxuvsUpfkIRmvBGzIBENdxZFfrsjkwgeFq
         Jow+lVmWfQIHg==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2 03/12] media: document read-only requests
Date:   Tue, 18 Aug 2020 16:37:10 +0200
Message-Id: <20200818143719.102128-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
References: <20200818143719.102128-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCuwSrPvT4fumm6uq5Q5WMyOX6OnYFqvqUTKnnAc42oTX5UrWuzWMQXEHZ0Xwab3bjAqBvapkeMtcnah8py0+THUdibAVA3JlkwbJKBA3FfrJVRuZCf9
 MutHBxYoEallZtP/q0OB2XnCJYFdu6h4EqCQrwiCWra8okfqXdZAkac5bbCbmkYM4fe4xJG4EgawT0xEbOL5+hT3oI9SgWjgRVgJ29iPievIqXhZJd6d629a
 vLCVQBuRiPUnJBSOtzjJGfW8g2/2zvya2zTX+mLp3FNEr3SVaCewyR1Wov6ClyHz5BVDVJeeN6e+zXNlMbcW5xoP9uhUmaOfWpjS5OYLoWNoNuaLH/wbAw26
 Wji31XDc
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This patch documents reaed-only requests, including the new
V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS capability flag.

Based in part on a patch from Yunfei Dong <yunfei.dong@mediatek.com>.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../media/mediactl/media-request-ioc-queue.rst        |  5 +++++
 .../userspace-api/media/mediactl/request-api.rst      | 11 +++++++++++
 .../userspace-api/media/v4l/vidioc-reqbufs.rst        |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst b/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
index ad55b6b32616..4ed1b3585ce1 100644
--- a/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
+++ b/Documentation/userspace-api/media/mediactl/media-request-ioc-queue.rst
@@ -76,6 +76,11 @@ queued directly and you next try to queue a request, or vice versa.
 A request must contain at least one buffer, otherwise this ioctl will
 return an ``ENOENT`` error.
 
+If the :ref:`buffer capabilities <v4l2-buf-capabilities>` indicate that
+only read-only requests are supported, then the request can only contain
+buffers. If anything else is present then this ioctl will return an
+``EINVAL`` error.
+
 Return Value
 ============
 
diff --git a/Documentation/userspace-api/media/mediactl/request-api.rst b/Documentation/userspace-api/media/mediactl/request-api.rst
index 37d9442a541e..88bfe8b735e8 100644
--- a/Documentation/userspace-api/media/mediactl/request-api.rst
+++ b/Documentation/userspace-api/media/mediactl/request-api.rst
@@ -53,6 +53,13 @@ with different configurations in advance, knowing that the configuration will be
 applied when needed to get the expected result. Configuration values at the time
 of request completion are also available for reading.
 
+In some cases it does not make sense for user-space to associate configuration
+values with a frame, instead it only makes sense to retrieving configuration
+values at the time of request completion. In that case read-only requests can be
+used that only allow buffers to be queued and not configuration values. Which
+type of requests (regular or read-only) are supported is signalled through
+:ref:`buffer capabilities <v4l2-buf-capabilities>`.
+
 General Usage
 -------------
 
@@ -95,6 +102,10 @@ A queued request cannot be modified anymore.
    output buffers, not for capture buffers. Attempting to add a capture buffer
    to a request will result in an ``EBADR`` error.
 
+If the buffer type supports only read-only requests, and the request contains
+configuration values such as controls, then ``EINVAL`` is returned since no
+configuration values are allowed when submitting a read-only request.
+
 If the request contains configurations for multiple entities, individual drivers
 may synchronize so the requested pipeline's topology is applied before the
 buffers are processed. Media controller drivers do a best effort implementation
diff --git a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
index 75d894d9c36c..13454146d5fc 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
@@ -134,6 +134,7 @@ aborting or finishing any DMA in progress, an implicit
 .. _V4L2-BUF-CAP-SUPPORTS-ORPHANED-BUFS:
 .. _V4L2-BUF-CAP-SUPPORTS-M2M-HOLD-CAPTURE-BUF:
 .. _V4L2-BUF-CAP-SUPPORTS-MMAP-CACHE-HINTS:
+.. _V4L2-BUF-CAP-SUPPORTS-RO-REQUESTS:
 
 .. cssclass:: longtable
 
@@ -154,6 +155,7 @@ aborting or finishing any DMA in progress, an implicit
     * - ``V4L2_BUF_CAP_SUPPORTS_REQUESTS``
       - 0x00000008
       - This buffer type supports :ref:`requests <media-request-api>`.
+        This flag is mutually exclusive with ``V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS``.
     * - ``V4L2_BUF_CAP_SUPPORTS_ORPHANED_BUFS``
       - 0x00000010
       - The kernel allows calling :ref:`VIDIOC_REQBUFS` while buffers are still
@@ -172,6 +174,10 @@ aborting or finishing any DMA in progress, an implicit
         :ref:`V4L2_FLAG_MEMORY_NON_CONSISTENT <V4L2-FLAG-MEMORY-NON-CONSISTENT>`,
         :ref:`V4L2_BUF_FLAG_NO_CACHE_INVALIDATE <V4L2-BUF-FLAG-NO-CACHE-INVALIDATE>` and
         :ref:`V4L2_BUF_FLAG_NO_CACHE_CLEAN <V4L2-BUF-FLAG-NO-CACHE-CLEAN>`.
+    * - ``V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS``
+      - 0x00000080
+      - This buffer type supports read-only :ref:`requests <media-request-api>`.
+        This flag is mutually exclusive with ``V4L2_BUF_CAP_SUPPORTS_REQUESTS``.
 
 
 Return Value
-- 
2.27.0

