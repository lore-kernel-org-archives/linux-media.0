Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8353C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA42320870
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RuK+yl09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDHJwy (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:52:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHJwx (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 05:52:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x389mrlZ043350;
        Mon, 8 Apr 2019 09:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=QmpryLwopkrXS4BZgf4BOEuDyboKLzUJTejCo1WKkiU=;
 b=RuK+yl09NOkq/hTqeOzbN8m1G7ScKF3WBWPr0V4qK4IyipiyVWrCdZ8vtLvnWZJo7C0q
 GLMskLZA5SXTbNXcRV7Xshc6ziPD5mTqC/dLIE3bm7LLKg/ydSnehNbji/mus5EXc98J
 8ytD4EhKrFU/2YfJhFOT0kjwUVn22v/zXKQAlfYKJjrMjKNx2wMYjXlAv0gVHE1JjmqG
 MFsyLVyDKfmmePARl6k3i3AB+aRdy+aidsFNGsiYpWJeIyPPbz4/74sWY6323fkOR9ZF
 mP6MTwyGY3SJ4F3yyi2bUXjJCtgutG2bf0kIkZVNoDscDuDSE3SnRLIfMi1JcI4CD+1a uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rpmrpw55a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 09:52:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x389pmqV172949;
        Mon, 8 Apr 2019 09:52:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rpytaxrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 09:52:48 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x389qk1F023105;
        Mon, 8 Apr 2019 09:52:47 GMT
Received: from kadam (/41.202.241.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 02:52:46 -0700
Date:   Mon, 8 Apr 2019 12:52:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mike Isely <isely@pobox.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] media: pvrusb2: Prevent a buffer overflow
Message-ID: <20190408095238.GA19971@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080090
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The ctrl_check_input() function is called from pvr2_ctrl_range_check().
It's supposed to validate user supplied input and return true or false
depending on whether the input is valid or not.  The problem is that
negative shifts or shifts greater than 31 are undefined in C.  In
practice with GCC they result in shift wrapping so this function returns
true for some inputs which are not valid and this could result in a
buffer overflow:

    drivers/media/usb/pvrusb2/pvrusb2-ctrl.c:205 pvr2_ctrl_get_valname()
    warn: uncapped user index 'names[val]'

The cptr->hdw->input_allowed_mask mask is configured in pvr2_hdw_create()
and the highest valid bit is BIT(4).

Fixes: 7fb20fa38caa ("V4L/DVB (7299): pvrusb2: Improve logic which handles input choice availability")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 2 ++
 drivers/media/usb/pvrusb2/pvrusb2-hdw.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.h b/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
index 25648add77e5..bd2b7a67b732 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.h
@@ -50,6 +50,7 @@
 #define PVR2_CVAL_INPUT_COMPOSITE 2
 #define PVR2_CVAL_INPUT_SVIDEO 3
 #define PVR2_CVAL_INPUT_RADIO 4
+#define PVR2_CVAL_INPUT_MAX PVR2_CVAL_INPUT_RADIO
 
 enum pvr2_config {
 	pvr2_config_empty,    /* No configuration */
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 51112b7988e4..816c85786c2a 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -666,6 +666,8 @@ static int ctrl_get_input(struct pvr2_ctrl *cptr,int *vp)
 
 static int ctrl_check_input(struct pvr2_ctrl *cptr,int v)
 {
+	if (v < 0 || v > PVR2_CVAL_INPUT_MAX)
+		return 0;
 	return ((1 << v) & cptr->hdw->input_allowed_mask) != 0;
 }
 
-- 
2.17.1

