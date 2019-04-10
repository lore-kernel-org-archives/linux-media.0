Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D3C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569F220820
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VUnu3WFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfDJLOu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:14:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34106 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfDJLOt (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 07:14:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ABDrLu132073;
        Wed, 10 Apr 2019 11:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=trmso9E69tCBdK6q+ef9qwAEkY+Ei+6Sz+VvGeW+1FQ=;
 b=VUnu3WFZJ7/7eWXLkTBq3xcbOTdYXHWHmiV3R30WxIvV9t8JUBj3hVsK8A7Fq+J6hiNo
 kMZjZtX20CXBRqEVr7Y7uLtFwIE5i9fDAe+/ucb++VRciNyNncGhc8fa4NNRJnfOa8yx
 8ndqEQ75eqFsaG8iSxdxgWeY2AvbSRvjEmKB/EQ/hkH9SJhjxZqqQmrTzL/o05iz7/sf
 jVJ1eMLislTQNhkBv2M4YUTZ+P3h/XpnNos9n1uqEJO7gVfmmxRPsaULLCyq17ugqlzp
 lOxnMVTiZGxQSVW7scV+755U0XFx0WHkre6GIhCcs/tA8ngIzjjt4pkxnO/9UCXgQSWe tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rpmrqab49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:14:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ABDaja178144;
        Wed, 10 Apr 2019 11:14:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rpj5b4e8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:14:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3ABEPg5021888;
        Wed, 10 Apr 2019 11:14:26 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 04:14:25 -0700
Date:   Wed, 10 Apr 2019 14:14:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amber Jain <amber@ti.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] media: omap_vout: potential buffer overflow in
 vidioc_dqbuf()
Message-ID: <20190410111415.GB31633@kadam>
References: <20190409112924.GA13643@kadam>
 <eb4fe291-85b5-540b-c210-5e9fb051f2cc@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4fe291-85b5-540b-c210-5e9fb051f2cc@xs4all.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100081
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100081
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 10, 2019 at 12:50:31PM +0200, Hans Verkuil wrote:
> On 4/9/19 1:29 PM, Dan Carpenter wrote:
> > diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
> > index 37f0d7146dfa..15e38990e85a 100644
> > --- a/drivers/media/platform/omap/omap_vout.c
> > +++ b/drivers/media/platform/omap/omap_vout.c
> > @@ -1527,8 +1527,6 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
> >  	unsigned long size;
> >  	struct videobuf_buffer *vb;
> >  
> > -	vb = q->bufs[b->index];
> > -
> >  	if (!vout->streaming)
> >  		return -EINVAL;
> >  
> > @@ -1539,6 +1537,8 @@ static int vidioc_dqbuf(struct file *file, void *fh, struct v4l2_buffer *b)
> >  		/* Call videobuf_dqbuf for  blocking mode */
> >  		ret = videobuf_dqbuf(q, (struct v4l2_buffer *)b, 0);
> 
> We need a:
> 
> 	if (ret)
> 		return ret;
> 
> here. Or alternatively, add 'if (!ret)' around the next five lines.
> 
> b->index is only valid if the videobuf_dqbuf call returned 0.
> 

Doh.  Thanks.

regards,
dan carpenter

