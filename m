Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80EC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5831217F9
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KMxlkJZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfC1Olu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:41:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42942 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Olu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 10:41:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SEcUJN070244;
        Thu, 28 Mar 2019 14:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=LvWgLzWwvCjYTEClHSidJCh3lS0LsBLibWPi6n72P5E=;
 b=KMxlkJZhvY4+uLEtIuvN6cx+skhoLH9qjjp512YAUfc30AYm06SEb8EjmwY5zgqbum2Z
 pmK6GujLG31n//PQqAxdCV5P3udN66OOeGBATbQbpz9nRmuLX6WiaJS2O9Fwor9jUihf
 Gqij668nKOtFlbeD26IfUW8302B6omRVa4FYi2Feu4jxmkx0NHsLIaCeEc66WL0v8lVi
 d215TNP2M8UmM+1QLqbqXaxpJZkj42Dtc2jJG6gb20/3qauWJrqL4UMPEdsACTl9S0EN
 95ugyR2r5zTdiQm/ovxCGxoaNtWLohy1PuNoJAUddSffj0dVYwAfkPrER0O5Wp8A0wlZ GQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2re6djq300-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:41:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEflgC008497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:41:47 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2SEflEo015224;
        Thu, 28 Mar 2019 14:41:47 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 07:41:46 -0700
Date:   Thu, 28 Mar 2019 17:41:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] media: wl128x: Fix some error handling in fmc_prepare()
Message-ID: <20190328144137.GS32590@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280100
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The st_register() returns have changed over time, but these days it
never returns -1.  We should just be checking for any negative error
codes.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 1614809f7d35..c3b90f2ac93f 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1521,7 +1521,7 @@ int fmc_prepare(struct fmdev *fmdev)
 		}
 
 		ret = 0;
-	} else if (ret == -1) {
+	} else if (ret < 0) {
 		fmerr("st_register failed %d\n", ret);
 		return -EAGAIN;
 	}
-- 
2.17.1

