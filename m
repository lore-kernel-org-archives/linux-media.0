Return-Path: <SRS0=WnEk=WS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C9C3A5A2
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4094923404
	for <linux-media@archiver.kernel.org>; Thu, 22 Aug 2019 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566502781;
	bh=ARblLlOQGo/W/oZER+VeKfUbTzCy0nABH96aq9/LphA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j1R8wAWgbTDnO9jVGePixegRytewf74G7a8zJc6dyld5C0VLf+D3Uy1iQqiKqrw/C
	 6VUUI82ouQYsdRO1DgkDtk8JpbYVn7WWShpo8BpQjaMPAQStRpZrO+kgeW2BaNqzMJ
	 Ev3+DEIJu6QEl5vbJwyIbGfx8vdBKkjmoyeYegNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbfHVTjk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:39:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfHVTjk (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 22 Aug 2019 15:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v60fBryrKzPTrb2LESAGxhaHHdlsP89G4dCrhZ3F+nc=; b=kFOA450i0enLLAOn4EDC7f6aCy
        f3UBFYag8v62zLyTntpd+mzDwvZPRaVzz0Vs1v7HtnVZEj6O5GYrYNZrRVkex1knmXcAg639C9POm
        2th2NS4+rDLkz/4kaPfxF6FLkRrniiTuTVczio937vr3RIpOoGQ5XKlW+3nvdGqXgO4XaKRotW0bB
        NpRijwlVJUU8zpuMPSrRgYYYtu1sc19Ptzr4Yt1mw5LIuKR4MGZn5smr/Qo2hLJhbXbu2dQvQ0dFO
        LTUa5DbtZxNxMJS2n2Jn9jHBT6+J3A8o0U8nA5txjYH+ofPjn05ptCl/nYLsdCCb5M6EgVG/WsPnA
        zRH0hvIw==;
Received: from [177.133.63.56] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0svr-0002lV-Kv; Thu, 22 Aug 2019 19:39:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1i0svo-0007Id-J8; Thu, 22 Aug 2019 16:39:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/7] media: ngene: don't try to memcpy from NULL
Date:   Thu, 22 Aug 2019 16:39:34 -0300
Message-Id: <11ef5297a62a8c3cc812495b69398b316e80ad73.1566502743.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
References: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

[drivers/media/pci/ngene/ngene-i2c.c:122] -> [drivers/media/pci/ngene/ngene-i2c.c:39]: (error) Null pointer dereference: out

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/pci/ngene/ngene-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/ngene/ngene-i2c.c b/drivers/media/pci/ngene/ngene-i2c.c
index 2e9e9774dc6f..bfdb7286f6f0 100644
--- a/drivers/media/pci/ngene/ngene-i2c.c
+++ b/drivers/media/pci/ngene/ngene-i2c.c
@@ -36,7 +36,10 @@ static int ngene_command_i2c_read(struct ngene *dev, u8 adr,
 	com.cmd.hdr.Opcode = CMD_I2C_READ;
 	com.cmd.hdr.Length = outlen + 3;
 	com.cmd.I2CRead.Device = adr << 1;
-	memcpy(com.cmd.I2CRead.Data, out, outlen);
+
+	if (out)
+		memcpy(com.cmd.I2CRead.Data, out, outlen);
+
 	com.cmd.I2CRead.Data[outlen] = inlen;
 	com.cmd.I2CRead.Data[outlen + 1] = 0;
 	com.in_len = outlen + 3;
-- 
2.21.0

