Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1BC001B0
	for <linux-media@archiver.kernel.org>; Thu, 20 Jul 2023 02:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjGTChN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Jul 2023 22:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGTChM (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Jul 2023 22:37:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694792106
        for <linux-media@vger.kernel.org>; Wed, 19 Jul 2023 19:37:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5xfX0ZrszBRDrL
        for <linux-media@vger.kernel.org>; Thu, 20 Jul 2023 10:37:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689820626; x=1692412627; bh=yDmsFZdUx//T+d2JUdth5wQgh+t
        umS2t3JK5YxYiAHE=; b=qSpU6VthrVdb9qW4+QsmcSiiQzF9QghP5HAeAoVFqWO
        IoG/9YQTEz2pHqNzsFqvEqGDZ0rhmzD2sIOKvqSF8n3DVGYKzauCzuQyWxVyD+mu
        4YLQKAELvB2IRIfd1aLL9d0skfqJSk6s0/3zC2cYzarh+TktO+u0Y3P3w+sh52mA
        wYL15kKER00jN0NXeFlsDasLRh8loXUMcmMtW2jCtXXmJGrS/9vtBv6KBTvulLg+
        UVh6Jv6gPCb21xipvd5oKiSDlPEvv//ESlJIgtTUjdMZ4+9ZNr7CUiw98fdbKv7K
        zyFHcbBqLHt8aL2hCF6ywjr4wo3J369DGrtQ+Lw5f9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hduJ9y2kZJ8J for <linux-media@vger.kernel.org>;
        Thu, 20 Jul 2023 10:37:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5xfV1fZKzBJDhY;
        Thu, 20 Jul 2023 10:37:06 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 10:37:06 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] dvb-frontends: add missing spaces before ','
In-Reply-To: <20230720023552.1070-1-xujianghui@cdjrlc.com>
References: <20230720023552.1070-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9bf6cfcbeb9a0854fdb2a29d74885725@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/dib3000mc.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib3000mc.h 
b/drivers/media/dvb-frontends/dib3000mc.h
index 5ed3d9147f8b..b837e107881e 100644
--- a/drivers/media/dvb-frontends/dib3000mc.h
+++ b/drivers/media/dvb-frontends/dib3000mc.h
@@ -73,7 +73,7 @@ struct i2c_adapter 
*dib3000mc_get_tuner_i2c_master(struct dvb_frontend *demod,
  }
  #endif // CONFIG_DVB_DIB3000MC

-extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, 
int pid,int onoff);
+extern int dib3000mc_pid_control(struct dvb_frontend *fe, int index, 
int pid, int onoff);
  extern int dib3000mc_pid_parse(struct dvb_frontend *fe, int onoff);

  extern void dib3000mc_set_config(struct dvb_frontend *, struct 
dib3000mc_config *);
