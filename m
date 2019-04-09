Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E18C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 11:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCD920857
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 11:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vPBuuz2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDIL34 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:29:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47064 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDIL34 (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 9 Apr 2019 07:29:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BIjvM146255;
        Tue, 9 Apr 2019 11:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=eheQesBgWMRT66yPKl3dWp44JaNnfzxIOJTK/f3qxPg=;
 b=vPBuuz2FUMkq8UO935qZLOslhwcLtUmwzN/4YKZrWXTYABFc7qMi63/IDpnCExrxGPnf
 GZ8mLidXXaRdW1jQo5uivuNAAFPYmAawRsnz4vQlZFLE8ayQiBUdRE8APBm+E0KTXEnk
 8IZeB9oPyePFMKcp0sqjsOLvBHCRKUUIshE1G2Gg6A3b9vWyQVJPe94jn16VSCTo4esn
 I2WG9jAvBc2PXBPG9UJIR605Dc34QNEdwMwloo6aOUYRH/6AakF+52nJAgGu7XwgbMUJ
 ymX58tNHF14f5ItsZgQbJAOazYN+i/+CPs4aOPKf1n5omLaVj5TQJbo2uqaW3aW0qWih wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrq480y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:29:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39BRqiZ125892;
        Tue, 9 Apr 2019 11:29:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rpkej7k7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:29:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x39BTbo9021889;
        Tue, 9 Apr 2019 11:29:37 GMT
Received: from kadam (/197.157.0.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 04:29:36 -0700
Date:   Tue, 9 Apr 2019 14:29:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amber Jain <amber@ti.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] media: omap_vout: potential buffer overflow in vidioc_dqbuf()
Message-ID: <20190409112924.GA13643@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090074
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090074
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The "b->index" is a u32 the comes from the user in the ioctl.  It hasn't
been checked.  We aren't supposed to use it but we're instead supposed
to use the value that gets written to it when we call videobuf_dqbuf().

The videobuf_dqbuf() first memsets it to zero and then re-initializes it
inside the videobuf_status() function.  It's this final value which we
want.

Fixes: 72915e851da9 ("[media] V4L2: OMAP: VOUT: dma map and unmap v4l2 buffers in qbuf and dqbuf")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
UNTESTED!  I think I understand this code now, but I have struggled to
read it correctly in the past.  Please review carefully.


 drivers/media/platform/omap/omap_vout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 37f0d7146dfa..15e38990e85a 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1527,8 +1527,6 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 	unsigned long size;
 	struct videobuf_buffer *vb;
 
-	vb = q->bufs[b->index];
-
 	if (!vout->streaming)
 		return -EINVAL;
 
@@ -1539,6 +1537,8 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
 		/* Call videobuf_dqbuf for  blocking mode */
 		ret = videobuf_dqbuf(q, (struct v4l2_buffer *)b, 0);
 
+	vb = q->bufs[b->index];
+
 	addr = (unsigned long) vout->buf_phy_addr[vb->i];
 	size = (unsigned long) vb->size;
 	dma_unmap_single(vout->vid_dev->v4l2_dev.dev,  addr,
-- 
2.17.1

