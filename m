Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC398286427
	for <linux-media@vger.kernel.org>; Thu, 18 Sep 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197354; cv=none; b=OYQUMmg3kgx+NpWgcpnCXVtIQbYYIgDXX6ZbPfUjp3DuQEblcgxrFEtJGRJv8OxXXAuUa6GLZ2SYKmTuggp1WzHYM+W1UfKZSBoudYM4O79xsIn5763LtdMSPGTeZp5WrKE1zImnv3XgFO36NWacPbRLw4KIbCSHiq2vyqX9GlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197354; c=relaxed/simple;
	bh=QNIGtamG6mL9Cw8rIuidVNIiFUf3eLWRIrQEXNqSJcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uW/1y5FEjJsf3tnVy1rHFpysEtMxf/PxTSTrEBVwpB6+fKCVBAgeOrw3dOkYI6Z3CCCkDKRVrWXiwFAdBXNMv2I3fJXn9juYdFo29sdJBoei3F42QudJQP7lk9Z8dQFrhGgDR66x9KKzGechRbkTtM1zHIw1UXjew27psz4Ev80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=baAHNJbL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="baAHNJbL"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8092B55A;
	Thu, 18 Sep 2025 14:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758197263;
	bh=QNIGtamG6mL9Cw8rIuidVNIiFUf3eLWRIrQEXNqSJcw=;
	h=From:Date:Subject:To:Cc:From;
	b=baAHNJbLHxcV3oLpXZaDbF5zQEVnQ3FvkpixKnkypml4hNEg5h6X7uq6IT3qRPfhH
	 Wsy56H0B3DAODhF95trVBgi8HqxQLNlVGbT3gC0p4EV4xVIIgSJi0ujIttSDbAo24W
	 0KSe0czBcJwAl5usjJ+ZcbnB8dJiTCZqe0HCPVXQ=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Thu, 18 Sep 2025 13:08:55 +0100
Subject: [PATCH] media: rzg2l-cru: rework rzg2l_cru_fill_hw_slot()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-rzg2l-cru-v1-1-fe110fdb91e5@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAFb2y2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ML3aKqdKMc3eSiUl0DU1OTRBNjU6NEcwMloPqCotS0zAqwWdGxtbU
 AD75XrlsAAAA=
X-Change-ID: 20250918-rzg2l-cru-0554a4352a70
To: linux-media@vger.kernel.org
Cc: laurent.pinchart+renesas@ideasonboard.com, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, tommaso.merciai.xr@bp.renesas.com, 
 biju.das.jz@bp.renesas.com, Daniel Scally <dan.scally@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4991;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=QNIGtamG6mL9Cw8rIuidVNIiFUf3eLWRIrQEXNqSJcw=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBoy/ZeyeTlU+JRy2XX6WhtWBD05CiIpgy59wZsx
 kAC2CjRVqyJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCaMv2XgAKCRDISVd6bEV1
 Mj+/EAC8AlMngg0VHAebP68D3HX11sMMKTZGpJlV5KxfoGecLeL3Foajc5UuRJ7Qtpl1a11AIDF
 GtAXpdzwnEJTC3o/AHCn2HrP3XEEuicJQPBRd0lONwRYJFgPDEFHv1o+QKjoDLR5o3aE3HgM+VP
 o1TqE20rq5Mpg0rmJ2PddDAoR9GdaxbOZY6qKsUdFL1A8fvmFpki+ShnQhILMUUpL3ky3iwHO7O
 O70As56rQBxiuD2V8khTMQoekNENO2JUupc9oont5WhAzt13B4gEoiL9h1js2RcxvEjb1Kg33h8
 3x50pkl5bzwAjf8erdRacKpM1F4AC2BSbYeK5IsuTnKT3M1wCcS3AKOsTQ1Sc8qDIkZ9dw8IdHu
 SOMABfGJodtOwYCR2dWGWTWdej0r7VTPN8EDAyz5RIVYTsHmmCp6ldYh4NiVlK0ZJWTsc4vetat
 wHukCd21HXIkukmc5mdzAD/fJ3PmRFoS3HkzKYe0We1cKuMekpL9e1OdXEGOiP7zb5QZjNl8dAe
 tsCqqPdl4EzDGwZhORHu8xxFEm2lKwClEF/JXAUNYmLxBJz+LXmaiJpEYR+xqY23xQINPDYXJWY
 /C/wThC2KxKc4Ewd47cjto+h16J+hRhoBr0Asgv73ip4J93tOv8lrtH4fb25U1BHefnBfZ+X0xn
 LlT+X/9257+/CMg==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

The current implementation of rzg2l_cru_fill_hw_slot() results in the
artificial loss of frames. At present whenever a frame-complete IRQ
is received the driver fills the hardware slot that was just written
to with the address of the next buffer in the driver's queue. If the
queue is empty, that hardware slot's address is set to the address of
the scratch buffer to enable the capture loop to keep running. There
is a minimum of a two-frame delay before that slot will be written to
however, and in the intervening period userspace may queue more
buffers which could be used.

To resolve the issue rework rzg2l_cru_fill_hw_slot() so that it
iteratively fills all slots from the queue which currently do not
have a buffer assigned, until the queue is empty. The scratch
buffer is only resorted to in the event that the queue is empty and
the next slot that will be written to does not already have a buffer
assigned.

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 63 +++++++++++-----------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 941badc90ff55c5225644f88de1d70239eb3a247..9ffafb0239a7388104219b2b72eec9051db82078 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -192,45 +192,47 @@ static void rzg2l_cru_set_slot_addr(struct rzg2l_cru_dev *cru,
 }
 
 /*
- * Moves a buffer from the queue to the HW slot. If no buffer is
- * available use the scratch buffer. The scratch buffer is never
- * returned to userspace, its only function is to enable the capture
- * loop to keep running.
+ * Move as many buffers as possible from the queue to HW slots. If no buffer is
+ * available and the next slot currently lacks one then use the scratch buffer.
+ * The scratch buffer is never returned to userspace, its only function is to
+ * enable the capture loop to keep running.
  */
-static void rzg2l_cru_fill_hw_slot(struct rzg2l_cru_dev *cru, int slot)
+static void rzg2l_cru_fill_hw_slots(struct rzg2l_cru_dev *cru, int slot)
 {
-	struct vb2_v4l2_buffer *vbuf;
+	unsigned int from_slot = slot;
 	struct rzg2l_cru_buffer *buf;
+	struct vb2_v4l2_buffer *vbuf;
 	dma_addr_t phys_addr;
 
-	/* A already populated slot shall never be overwritten. */
-	if (WARN_ON(cru->queue_buf[slot]))
-		return;
-
-	dev_dbg(cru->dev, "Filling HW slot: %d\n", slot);
+	do {
+		if (cru->queue_buf[slot]) {
+			slot = (slot + 1) % cru->num_buf;
+			continue;
+		}
 
-	if (list_empty(&cru->buf_list)) {
-		cru->queue_buf[slot] = NULL;
-		phys_addr = cru->scratch_phys;
-	} else {
-		/* Keep track of buffer we give to HW */
-		buf = list_entry(cru->buf_list.next,
-				 struct rzg2l_cru_buffer, list);
-		vbuf = &buf->vb;
-		list_del_init(to_buf_list(vbuf));
-		cru->queue_buf[slot] = vbuf;
-
-		/* Setup DMA */
-		phys_addr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
-	}
+		if (list_empty(&cru->buf_list)) {
+			if (slot == from_slot)
+				phys_addr = cru->scratch_phys;
+			else
+				return;
+		} else {
+			buf = list_first_entry(&cru->buf_list,
+					       struct rzg2l_cru_buffer, list);
+			vbuf = &buf->vb;
+			list_del_init(&buf->list);
+			cru->queue_buf[slot] = vbuf;
+			phys_addr = vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+		}
 
-	rzg2l_cru_set_slot_addr(cru, slot, phys_addr);
+		dev_dbg(cru->dev, "Filling HW slot: %d\n", slot);
+		rzg2l_cru_set_slot_addr(cru, slot, phys_addr);
+		slot = (slot + 1) % cru->num_buf;
+	} while (slot != from_slot);
 }
 
 static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 {
 	const struct rzg2l_cru_info *info = cru->info;
-	unsigned int slot;
 	u32 amnaxiattr;
 
 	/*
@@ -239,8 +241,7 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_dev *cru)
 	 */
 	rzg2l_cru_write(cru, AMnMBVALID, AMnMBVALID_MBVALID(cru->num_buf - 1));
 
-	for (slot = 0; slot < cru->num_buf; slot++)
-		rzg2l_cru_fill_hw_slot(cru, slot);
+	rzg2l_cru_fill_hw_slots(cru, 0);
 
 	if (info->has_stride) {
 		u32 stride = cru->format.bytesperline;
@@ -652,7 +653,7 @@ irqreturn_t rzg2l_cru_irq(int irq, void *data)
 	cru->sequence++;
 
 	/* Prepare for next frame */
-	rzg2l_cru_fill_hw_slot(cru, slot);
+	rzg2l_cru_fill_hw_slots(cru, (slot + 1) % cru->num_buf);
 
 done:
 	spin_unlock_irqrestore(&cru->qlock, flags);
@@ -752,7 +753,7 @@ irqreturn_t rzg3e_cru_irq(int irq, void *data)
 		cru->sequence++;
 
 		/* Prepare for next frame */
-		rzg2l_cru_fill_hw_slot(cru, slot);
+		rzg2l_cru_fill_hw_slots(cru, (slot + 1) % cru->num_buf);
 	}
 
 	return IRQ_HANDLED;

---
base-commit: a75b8d198c55e9eb5feb6f6e155496305caba2dc
change-id: 20250918-rzg2l-cru-0554a4352a70

Best regards,
-- 
Daniel Scally <dan.scally@ideasonboard.com>

