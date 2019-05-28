Return-Path: <SRS0=uFep=T4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC7C04AB6
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB52C208C3
	for <linux-media@archiver.kernel.org>; Tue, 28 May 2019 08:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfE1Iel (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 28 May 2019 04:34:41 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:39687 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfE1Iel (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 28 May 2019 04:34:41 -0400
Received: from marune.fritz.box ([IPv6:2001:983:e9a7:1:10b2:2e62:e4b1:bd13])
        by smtp-cloud9.xs4all.net with ESMTPA
        id VXZ7hgpQIsDWyVXZ8hcDJ9; Tue, 28 May 2019 10:34:38 +0200
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 1/2] v4l2-mem2mem: add try_en/decoder_cmd ioctl helpers
Date:   Tue, 28 May 2019 10:34:36 +0200
Message-Id: <20190528083437.103215-2-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528083437.103215-1-hverkuil-cisco@xs4all.nl>
References: <20190528083437.103215-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI9l6tLUfrUuVQofcLgE1S8ygrzy3IcIo+YkQYMmM6MfCekDOGXi/ihiQqP9b6udegUPzWcZ/p4CuSXGhNMi6DU4FS3J2OstAqtpgTCqju9X3EMLAxZm
 cshT2EpTyY0W3a9VEh5bjakARxTQBzRgXcp0Q2ZmgYKLpYBiGtR0HskBzCmy+PW8A+TJZhGJNKXCSHSra/+ge48+5IA2cT1bbScYtdwrsT/fVkDk48y3Rg+s
 dHZCnTDNajFrnRk/3OdsrBfbbQJGBzOvmUU2xEBknDXbte1OL13Ih+dAUWaK4THii70slJsqdB+yOD8swoArKQADkh0KF7BjoKHHQl2NQhN2t7Rnp6LsTA1R
 PPB7OGbBls4+tTKPQf5WhWjmp48oOYyNvwMZqqUw0j3BmFvidpPFmMBQZlWXb7t1W7NP6Z2MtvE2PVU7AErVKutoheB0EA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Most if not all codecs will need to implement these ioctls and
it is expected to be the same for all codecs. So add this to
the core v4l2-mem2mem framework so that this code can easily be
reused.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 32 ++++++++++++++++++++++++++
 include/media/v4l2-mem2mem.h           |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 3392833d9541..ba799db5866a 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1122,6 +1122,38 @@ int v4l2_m2m_ioctl_streamoff(struct file *file, void *priv,
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_streamoff);
 
+int v4l2_m2m_ioctl_try_encoder_cmd(struct file *file, void *fh,
+				   struct v4l2_encoder_cmd *ec)
+{
+	if (ec->cmd != V4L2_ENC_CMD_STOP && ec->cmd != V4L2_ENC_CMD_START)
+		return -EINVAL;
+
+	if (ec->cmd == V4L2_ENC_CMD_START)
+		ec->flags = 0;
+	return ec->flags ? -EINVAL : 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_try_encoder_cmd);
+
+int v4l2_m2m_ioctl_try_decoder_cmd(struct file *file, void *fh,
+				   struct v4l2_decoder_cmd *dc)
+{
+	if (dc->cmd != V4L2_DEC_CMD_STOP && dc->cmd != V4L2_DEC_CMD_START)
+		return -EINVAL;
+
+	if (dc->flags)
+		return -EINVAL;
+
+	if (dc->cmd == V4L2_DEC_CMD_STOP && dc->stop.pts)
+		return -EINVAL;
+
+	if (dc->cmd == V4L2_DEC_CMD_START) {
+		dc->start.speed = 0;
+		dc->start.format = V4L2_DEC_START_FMT_NONE;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_try_decoder_cmd);
+
 /*
  * v4l2_file_operations helpers. It is assumed here same lock is used
  * for the output and the capture buffer queue.
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bb3e63d6bd1a..2e0c989266a7 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -672,6 +672,10 @@ int v4l2_m2m_ioctl_streamon(struct file *file, void *fh,
 				enum v4l2_buf_type type);
 int v4l2_m2m_ioctl_streamoff(struct file *file, void *fh,
 				enum v4l2_buf_type type);
+int v4l2_m2m_ioctl_try_encoder_cmd(struct file *file, void *fh,
+				   struct v4l2_encoder_cmd *ec);
+int v4l2_m2m_ioctl_try_decoder_cmd(struct file *file, void *fh,
+				   struct v4l2_decoder_cmd *dc);
 int v4l2_m2m_fop_mmap(struct file *file, struct vm_area_struct *vma);
 __poll_t v4l2_m2m_fop_poll(struct file *file, poll_table *wait);
 
-- 
2.20.1

