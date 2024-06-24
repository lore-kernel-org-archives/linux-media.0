Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF44AECE
	for <linux-media@vger.kernel.org>; Mon, 24 Jun 2024 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217484; cv=none; b=q037hIjrwnRulfyl+kXa7QWglIpNkSc79KdKgQhoYpM3tqQHMIYWw7mdwzJrpcLc4FcO4RcAoSOnHBj7LMEKR88f+Bdd+CS1OWU8teYHMsjzofz6lWet9V18fjnskdXFEZ6pbQcSOD5nvaL7kwd0TZkxTJ6vksfwLYShfc7n7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217484; c=relaxed/simple;
	bh=OBcmSm1qeXwRxIUXt35R2OpL3DfIbxCj4Wth77KBE3Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KbdqMoYD/d1XzA5PlVMe1g8uyK4rOn7YvBBrbMh7M6ePZo9o9SVfNbOhVCOPMeGTMbKn4N+XzBiS3UOWzWlHMi8FTfW1s0l4ICxgjeSeETRO0lzJMmmD9IiMnoU8nuGXC+CTbkb1tc+OMuS3VH4ITIRqSYQ9edBvC6SZPpeL8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D89C32781
	for <linux-media@vger.kernel.org>; Mon, 24 Jun 2024 08:24:43 +0000 (UTC)
Message-ID: <f3475a3c-1de8-4c39-a296-99b703e171f0@xs4all.nl>
Date: Mon, 24 Jun 2024 10:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl
To: Linux Media Mailing List <linux-media@vger.kernel.org>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCHv2] media: b2c2: flexcop-usb: fix flexcop_usb_memory_req
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

smatch generated this warning:

drivers/media/usb/b2c2/flexcop-usb.c:199 flexcop_usb_memory_req() warn: iterator 'i' not incremented

and indeed the function is not using i or updating buf.

The reason this always worked is that this function is called to write just
6 bytes (a MAC address) to the USB device, and so in practice there is only
a single chunk written. If we ever would need to write more than one chunk,
this function would fail since each chunk would read from or write to the
same buf address.

Rewrite the function to properly handle this.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
Changes since v1:
- limit line length in log to 75 chars
- remove unused variable i
---
 drivers/media/usb/b2c2/flexcop-usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 90f1aea99dac..8033622543f2 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -179,7 +179,7 @@ static int flexcop_usb_memory_req(struct flexcop_usb *fc_usb,
 		flexcop_usb_request_t req, flexcop_usb_mem_page_t page_start,
 		u32 addr, int extended, u8 *buf, u32 len)
 {
-	int i, ret = 0;
+	int ret = 0;
 	u16 wMax;
 	u32 pagechunk = 0;

@@ -196,7 +196,7 @@ static int flexcop_usb_memory_req(struct flexcop_usb *fc_usb,
 	default:
 		return -EINVAL;
 	}
-	for (i = 0; i < len;) {
+	while (len) {
 		pagechunk = min(wMax, bytes_left_to_read_on_page(addr, len));
 		deb_info("%x\n",
 			(addr & V8_MEMORY_PAGE_MASK) |
@@ -206,11 +206,12 @@ static int flexcop_usb_memory_req(struct flexcop_usb *fc_usb,
 			page_start + (addr / V8_MEMORY_PAGE_SIZE),
 			(addr & V8_MEMORY_PAGE_MASK) |
 				(V8_MEMORY_EXTENDED*extended),
-			&buf[i], pagechunk);
+			buf, pagechunk);

 		if (ret < 0)
 			return ret;
 		addr += pagechunk;
+		buf += pagechunk;
 		len -= pagechunk;
 	}
 	return 0;
-- 
2.43.0

