Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EBC10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5362083E
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c437kRjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfDJLjq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:39:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfDJLjp (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 07:39:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ABTN93143997;
        Wed, 10 Apr 2019 11:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AmBxpYby2Sheq0p4SX1CRfBu/VH7dCOVhHAi7Gm+o2E=;
 b=c437kRjsjwgh+YxO0PMzr+P57hDa3ze69M6lMD16VXRiU6WISAVSkiEhSS2JYi6BoXAA
 0O37AW5tiDpGLC4muIYAEoDD7giobPz5CpCyEuLRHhNGfScBCjsSSm20mtTvOBbiJOJl
 UbPayRDkcx4my0YTYQHKZxEcBv49idlzkh1koFLlHLj0PBVqT66iLQ6Dblb6yUl/HxeM
 qNUEuwG1az7zCR7EBW3hFZfaIKrlkkfIeXD63xySrQ3jOJJTFENzeJuWq5kjLgTNi+52
 rPqyvwb56zoeaxvX7ES7IQpbysOucK4G5SwFwXAebF0R8BUl5nz5E16Cb4bl63UhTyfz OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2rpmrqaeee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:39:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3ABdaHb037846;
        Wed, 10 Apr 2019 11:39:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rpj5b4r3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 11:39:41 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3ABdf5s023905;
        Wed, 10 Apr 2019 11:39:41 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 04:39:40 -0700
Date:   Wed, 10 Apr 2019 14:39:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     hans.verkuil@cisco.com, linux-media@vger.kernel.org
Subject: Re: [bug report] [media] mxb: fix audio handling
Message-ID: <20190410113934.GC31633@kadam>
References: <20190410110934.GA3459@kadam>
 <9b5791ce-6de7-c769-ac14-2b155a44a438@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5791ce-6de7-c769-ac14-2b155a44a438@xs4all.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=964
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=986 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100083
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Apr 10, 2019 at 01:24:44PM +0200, Hans Verkuil wrote:
> On 4/10/19 1:09 PM, Dan Carpenter wrote:
> > [ Hi Hans,
> > 
> >   This might not really be your bug, but I just respect you a lot and
> >   so I always come to you with questions and for advice.  -dan ]
> 
> Hmm, in other words, I'm too nice!
> 

Indeed.

> >     657                  if (mxb->cur_audinput != a->index) {
> >     658                          mxb->cur_audinput = a->index;
> >                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Now here's the complication.  We also use a->index as an index into the
> > mxb_inputs[] array which only has MXB_INPUTS (4) elements, so just
> 
> We do? Where does that happen? I don't see that in the code. That would be
> a bug since mxb_inputs are the video inputs, whereas s_audio deals with
> audio inputs.
> 

Oh, you're right.  But then there is a smaller problem because we use
it as in index into the mxb_audios[] array and that array only has 6
elements so we're still out of bounds.  The bigger array has a mute
element at the end.

regards,
dan carpenter

