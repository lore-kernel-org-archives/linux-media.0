Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D0C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D8A2186A
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z4Hp7NJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfDELdo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:33:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57242 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfDELdo (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 07:33:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35BDlkC179333;
        Fri, 5 Apr 2019 11:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7rtGbgQgrp7retaLGgwTZRpJNBxQd+iYFKb238jXdtU=;
 b=z4Hp7NJI6uFoRkZK8pO9Ic5BVbAaIm4MoTQ9NhIFE8TMpYJcMEY/BGFv02y48aJvxmp5
 05Lz7VyR8yyni7utCS7Q+SGhYX9D1+1DF35jdh+YbKGq4Xi1gMMeSj/ns8fpBxb2g4eW
 Gp/j3XQ+eHQm29w5pUZV3ut8eWo7DdQMZ0DJS7wkx6cRhg10dyhrnac3lTlLE8fDmYD6
 KiWZU5JFB6xjhcfToeaXEox+bLbdmERqKwOIZBmBJTScwDgZ1hjY8aOr7VM1Df8IhOqP
 d7ev7vzaV4+N1HIAWNuI7wLWcwhU3TShJvxtDNWGgpddkwFPPrsLO3ed7dihcu+2Xl2+ uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rhwydmga2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 11:33:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35BXTt6182308;
        Fri, 5 Apr 2019 11:33:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rp35rtdds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 11:33:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x35BXcba005749;
        Fri, 5 Apr 2019 11:33:38 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 04:33:37 -0700
Date:   Fri, 5 Apr 2019 14:33:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: [bug report] [media] s5p-mfc: use MFC_BUF_FLAG_EOS to identify
 last buffers in decoder capture queue
Message-ID: <20190405113331.GU32613@kadam>
References: <CGME20190404154231epcas4p11c6ce6ab44d5b61c66e246fab78972e9@epcas4p1.samsung.com>
 <20190404154216.GA24343@kadam>
 <f38dbe7a-d4b1-b012-d667-eaaade6e9ff6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38dbe7a-d4b1-b012-d667-eaaade6e9ff6@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050081
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=968 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050080
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 05, 2019 at 12:02:49PM +0200, Andrzej Hajda wrote:
> Hi Dan,
> 
> On 04.04.2019 17:42, Dan Carpenter wrote:
> > Hello Andrzej Hajda,
> >
> > The patch 4d0b0ed63660: "[media] s5p-mfc: use MFC_BUF_FLAG_EOS to
> > identify last buffers in decoder capture queue" from Oct 7, 2015,
> > leads to the following static checker warning:
> >
> > 	drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:664 vidioc_dqbuf()
> > 	warn: uncapped user index 'ctx->dst_bufs[buf->index]'
> 
> 
> Almost identical e-mail you have sent about year ago, and me and Hans
> have explained you that it is false positive.
> 
> Has something changed?

Wow!  It's remarkable how similar the emails are.  Thank you for
your patience on this.  I am testing a patch which should silence this
false positive in Smatch.

regards,
dan carpenter


