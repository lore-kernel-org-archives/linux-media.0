Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E4AC433B4
	for <linux-media@archiver.kernel.org>; Fri, 21 May 2021 12:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1255611AD
	for <linux-media@archiver.kernel.org>; Fri, 21 May 2021 12:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhEUMUF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 21 May 2021 08:20:05 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:47454 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhEUMTx (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 21 May 2021 08:19:53 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d78 with ME
        id 7QJU2500J21Fzsu03QJUpX; Fri, 21 May 2021 14:18:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 May 2021 14:18:29 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yasunari.Takiguchi@sony.com, mchehab@kernel.org,
        narmstrong@baylibre.com, sean@mess.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] media: cxd2880-spi: Fix some error messages
Date:   Fri, 21 May 2021 14:18:27 +0200
Message-Id: <172cc58731c52da7c7b351349118a348d34a9913.1621599392.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <28a115d7207b258715a029f822ab88f7a4ee05e6.1621599392.git.christophe.jaillet@wanadoo.fr>
References: <28a115d7207b258715a029f822ab88f7a4ee05e6.1621599392.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Fix some erroneous function names in some error messages.
Remove some spurious or useless trailing and leading character in some
messages.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/spi/cxd2880-spi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index df1335e7061c..88aef9333ad8 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -147,7 +147,7 @@ static int cxd2880_spi_read_ts(struct spi_device *spi,
 
 	ret = spi_sync(spi, &message);
 	if (ret)
-		pr_err("spi_write_then_read failed\n");
+		pr_err("spi_sync failed\n");
 
 	return ret;
 }
@@ -401,7 +401,7 @@ static int cxd2880_start_feed(struct dvb_demux_feed *feed)
 							      dvb_spi,
 							      "cxd2880_ts_read");
 		if (IS_ERR(dvb_spi->cxd2880_ts_read_thread)) {
-			pr_err("kthread_run failed/\n");
+			pr_err("kthread_run failed\n");
 			kfree(dvb_spi->ts_buf);
 			dvb_spi->ts_buf = NULL;
 			memset(&dvb_spi->filter_config, 0,
@@ -448,7 +448,7 @@ static int cxd2880_stop_feed(struct dvb_demux_feed *feed)
 		 * in dvb_spi->all_pid_feed_count.
 		 */
 		if (dvb_spi->all_pid_feed_count <= 0) {
-			pr_err("PID %d not found.\n", feed->pid);
+			pr_err("PID %d not found\n", feed->pid);
 			return -EINVAL;
 		}
 		dvb_spi->all_pid_feed_count--;
@@ -485,7 +485,7 @@ static int cxd2880_stop_feed(struct dvb_demux_feed *feed)
 
 		ret_stop = kthread_stop(dvb_spi->cxd2880_ts_read_thread);
 		if (ret_stop) {
-			pr_err("'kthread_stop failed. (%d)\n", ret_stop);
+			pr_err("kthread_stop failed. (%d)\n", ret_stop);
 			ret = ret_stop;
 		}
 		kfree(dvb_spi->ts_buf);
@@ -512,7 +512,7 @@ cxd2880_spi_probe(struct spi_device *spi)
 	struct cxd2880_config config;
 
 	if (!spi) {
-		pr_err("invalid arg.\n");
+		pr_err("invalid arg\n");
 		return -EINVAL;
 	}
 
@@ -596,7 +596,7 @@ cxd2880_spi_probe(struct spi_device *spi)
 	ret = dvb_spi->demux.dmx.connect_frontend(&dvb_spi->demux.dmx,
 						  &dvb_spi->dmx_fe);
 	if (ret < 0) {
-		pr_err("dvb_register_frontend() failed\n");
+		pr_err("connect_frontend() failed\n");
 		goto fail_fe_conn;
 	}
 
-- 
2.30.2

