Return-Path: <SRS0=KukI=SG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE6C4360F
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8A206DD
	for <linux-media@archiver.kernel.org>; Thu,  4 Apr 2019 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+3tXlWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfDDPmc (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:42:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfDDPmb (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 4 Apr 2019 11:42:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34FcZZc063431;
        Thu, 4 Apr 2019 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=o8wl2ORZ26uVdXUXJhMH+JIyw82vzgi28x0M9dWEDo0=;
 b=b+3tXlWPBGPkotEbB1P3IzS1D2gqnKQ7k4wXEiEXUvMzgtaPkhlrm/v0KVt/lfWPbNbW
 rF4i/Nzgz5SgqbWl+kFCAyTC4asNKpOMnIVFH9t4EIZn54iJ7FJA9osHnJ/bZvQdSW9w
 7WDvVK5ecaHg9xO63EWxVwo2Hf6CebIS2xwp0joDA7wLl0K9kk4af5jxTKKLXZRieExa
 0nITnPovCoSXIKRxXunmI8je8tLg136gFFP2iAyae/fergn+geut67a+vQSXYSjOQw9O
 qx/9rEJUXkt4AEVCgpumhrLqe5hc3DHhW6y5ZqGtlzU3gnDNNUOxewGtmDkUyG5qz1vD RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydg4mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 15:42:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34FfMed022377;
        Thu, 4 Apr 2019 15:42:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rm8f60h1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 15:42:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x34FgOkY006339;
        Thu, 4 Apr 2019 15:42:24 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 08:42:24 -0700
Date:   Thu, 4 Apr 2019 18:42:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     a.hajda@samsung.com
Cc:     linux-media@vger.kernel.org
Subject: [bug report] [media] s5p-mfc: use MFC_BUF_FLAG_EOS to identify last
 buffers in decoder capture queue
Message-ID: <20190404154216.GA24343@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040101
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040101
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello Andrzej Hajda,

The patch 4d0b0ed63660: "[media] s5p-mfc: use MFC_BUF_FLAG_EOS to
identify last buffers in decoder capture queue" from Oct 7, 2015,
leads to the following static checker warning:

	drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:664 vidioc_dqbuf()
	warn: uncapped user index 'ctx->dst_bufs[buf->index]'

drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
    642 static int vidioc_dqbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
    643 {
    644 	const struct v4l2_event ev = {
    645 		.type = V4L2_EVENT_EOS
    646 	};
    647 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
    648 	int ret;
    649 
    650 	if (ctx->state == MFCINST_ERROR) {
    651 		mfc_err_limited("Call on DQBUF after unrecoverable error\n");
    652 		return -EIO;
    653 	}
    654 
    655 	switch (buf->type) {
    656 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
    657 		return vb2_dqbuf(&ctx->vq_src, buf, file->f_flags & O_NONBLOCK);
    658 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
    659 		ret = vb2_dqbuf(&ctx->vq_dst, buf, file->f_flags & O_NONBLOCK);
    660 		if (ret)
    661 			return ret;
    662 
    663 		if (ctx->state == MFCINST_FINISHED &&
--> 664 		    (ctx->dst_bufs[buf->index].flags & MFC_BUF_FLAG_EOS))
                                           ^^^^^^^^^^
Smatch is saying that this isn't capped.  The truth is that v4l2 code is
a bit complicated for Smatch, but in this case I can't see where
"buf->index" does get capped.  I would have expected it to be capped in
check_array_args() where we check "buf->length" but it's not.

I've been going through these warnings really carefully in the past
couple weeks trying to fix false positives so let me know what I'm
missing and I will update the check.  Even if I have to manually muck
in the DB.

    665 			v4l2_event_queue_fh(&ctx->fh, &ev);
    666 		return 0;
    667 	default:
    668 		return -EINVAL;
    669 	}
    670 }

regards,
dan carpenter
