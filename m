Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D63C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAA321971
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QUeyXCMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfDJLJq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:09:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfDJLJp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 07:09:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AB97xQ122937;
        Wed, 10 Apr 2019 11:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=o0pnIcaJARFiiWh2S6yRRL3WDoYl5ge4lgLjhyDBCSc=;
 b=QUeyXCMs7/2ZY67FeLb/7FKC+bxPaIha+qhF5c8HhTEuwLdf3mYuEIjj1Y/kodtARdeu
 vpPl8T268rx8K5knU5PQ8ie0Ty39i+3F/QRgXuY74qTqDOemHtVEonJRuw+UxiHpepiE
 SbZ/bvXuamoTPmjnptReiO27GAjAm4+zw5kZUzOAxHPMNkOweeyOZQaqjfUzDbapjoPU
 uAwZVX37L2Sbv0qlv2JwrGS09/TrU5KT8EK/d6R3fcBs12o5/KHhdav+q3IdqaEY/539
 ZX1OsNW3AhTkuEsEnD/zVpRCJ35rdQWLVYUJgZAnpqA1iua7yYZNzumcIMkslx5mkc30 nA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmejhvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:09:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AB9h26169731;
        Wed, 10 Apr 2019 11:09:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rpj5b4c7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:09:42 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AB9fIh019309;
        Wed, 10 Apr 2019 11:09:42 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 04:09:40 -0700
Date:   Wed, 10 Apr 2019 14:09:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org
Subject: [bug report] [media] mxb: fix audio handling
Message-ID: <20190410110934.GA3459@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100080
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100080
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

[ Hi Hans,

  This might not really be your bug, but I just respect you a lot and
  so I always come to you with questions and for advice.  -dan ]

Hello Hans Verkuil,

The patch 6680427791c9: "[media] mxb: fix audio handling" from Apr
30, 2012, leads to the following static checker warning:

	drivers/media/pci/saa7146/mxb.c:196 tea6420_route()
	warn: uncapped user index 'TEA6420_cd[idx]'

drivers/media/pci/saa7146/mxb.c
    194 static inline void tea6420_route(struct mxb *mxb, int idx)
    195 {
--> 196 	v4l2_subdev_call(mxb->tea6420_1, audio, s_routing,
    197 		TEA6420_cd[idx][0].input, TEA6420_cd[idx][0].output, 0);
                                   ^^^
Index overflow.  The TEA6420_cd[] array has MXB_AUDIOS + 1 (which is 7
altogether) elements.

    198 	v4l2_subdev_call(mxb->tea6420_2, audio, s_routing,
    199 		TEA6420_cd[idx][1].input, TEA6420_cd[idx][1].output, 0);
    200 	v4l2_subdev_call(mxb->tea6420_1, audio, s_routing,
    201 		TEA6420_line[idx][0].input, TEA6420_line[idx][0].output, 0);
    202 	v4l2_subdev_call(mxb->tea6420_2, audio, s_routing,
    203 		TEA6420_line[idx][1].input, TEA6420_line[idx][1].output, 0);
    204 }

[ snip ]

    650  static int vidioc_s_audio(struct file *file, void *fh, const struct v4l2_audio *a)
    651  {
    652          struct saa7146_dev *dev = ((struct saa7146_fh *)fh)->dev;
    653          struct mxb *mxb = (struct mxb *)dev->ext_priv;
    654  
    655          DEB_D("VIDIOC_S_AUDIO %d\n", a->index);
    656          if (mxb_inputs[mxb->cur_input].audioset & (1 << a->index)) {

This a->index comes from the ioctl and it's a u32 so the shift can wrap.
The .audioset variable is always 0x3f.  In other words BIT(6) is the
highest valid bit so we could add a check:

		if (a->index > MXB_AUDIOS)
			return;

    657                  if (mxb->cur_audinput != a->index) {
    658                          mxb->cur_audinput = a->index;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Now here's the complication.  We also use a->index as an index into the
mxb_inputs[] array which only has MXB_INPUTS (4) elements, so just
adding the limit would still lead to a different array out of bounds
later...

    659                          tea6420_route(mxb, a->index);
    660                          if (mxb->cur_audinput == 0)
    661                                  mxb_update_audmode(mxb);
    662                  }
    663                  return 0;
    664          }
    665          return -EINVAL;
    666  }

regards,
dan carpenter
