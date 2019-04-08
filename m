Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51585C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4C220870
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wt785l1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHGxe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:53:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDHGxe (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 02:53:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x386mx64082887;
        Mon, 8 Apr 2019 06:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZR4I45azy+jrNM6G9/FVB6oLpYS9VlAc7fLcpCpw6ds=;
 b=Wt785l1o65iet3tV+ECLofzGwMDgJVzyDHF1IVRx04jZIJrlZnDh4jSeXMOIFYcjM3Dz
 V93jQUzyKKLI1vbXr0Gwl1DKzqYNZWxLD+ux7kmKnLrm56tgPwezoGjzJaKKyrU9IJra
 +caiAvgMEasSHOsm3zy9WR86rU88mjZgeB0i4fNuO6K4tWd8tFlSBeeRh5Iu54xbp4pj
 WHhfqU1yKEmE8DY5tNms1Yxa2z3lfct0fgW9+MMqJpLexP6Q9WvSW34nhLjjzMfTDL2p
 IsIT6+pgY5iWwzV0LAkfiBLgZZX4x8s7cl+sCN1tPu5n+mciBg44mPjaRFVhKhX9o+mS Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrpv72d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 06:53:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x386nm8s125636;
        Mon, 8 Apr 2019 06:51:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rpkehhxys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 06:51:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x386pDTq003031;
        Mon, 8 Apr 2019 06:51:13 GMT
Received: from kadam (/41.202.241.3)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Apr 2019 23:51:13 -0700
Date:   Mon, 8 Apr 2019 09:51:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.or,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: media: zoran: fix trailing whitespaces
Message-ID: <20190408065103.GA6095@kadam>
References: <20190408043530.21594-1-arthurmoraeslago@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408043530.21594-1-arthurmoraeslago@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=692
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080063
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9220 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=719 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080064
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 08, 2019 at 01:35:30AM -0300, Arthur Moraes do Lago wrote:
> There were several form feeds(^L) in the file, this patch removes them
> to conform with the coding style.
> 
> Signed-off-by: Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
> ---
>  drivers/staging/media/zoran/videocodec.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
> index 4946791fce0d..c37c0e4fb624 100644
> --- a/drivers/staging/media/zoran/videocodec.h
> +++ b/drivers/staging/media/zoran/videocodec.h
> @@ -49,7 +49,7 @@
>     device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
>     ----------------------------------------------------------------------------
>  */
> -
> +
>  

Checkpatch also complains if you have two consecutive blank lines so
really we should just delete the lines entirely...  But this driver is
scheduled for deletion in May.  Let's not bother with cleaning it up.

regards,
dan carpenter

