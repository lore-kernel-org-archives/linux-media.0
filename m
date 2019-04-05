Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF40C4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3921738
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 10:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ta6307gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfDEKCz (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:02:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50296 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDEKCy (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Fri, 5 Apr 2019 06:02:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190405100252euoutp0215cd0d1f095c1f2291e10f378e20f801~Si9XlrtG_3116631166euoutp02G
        for <linux-media@vger.kernel.org>; Fri,  5 Apr 2019 10:02:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190405100252euoutp0215cd0d1f095c1f2291e10f378e20f801~Si9XlrtG_3116631166euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554458572;
        bh=HZIz09HZhKqfvDXXCi1jGLd8WfOD6Td6mHrQGvMwLuM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ta6307gwV8U46YbGhRnUlAgwUlyG1X06zRB+0p9rAWUNjLvowc3aFbR8F8m6giyNr
         d2r52FIScsRA4whM0ZD8/JEpHWBA8NZtY6jCestXCRlTSckfjhqa+4TSJmtGwalfgi
         YgIVuOrnU3un8tjzGo1/vv0rA8lVliCXeb1sSHso=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190405100251eucas1p13a2adee40cef014db0592966d1a5c9cb~Si9XSC_uZ1861318613eucas1p1U;
        Fri,  5 Apr 2019 10:02:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.5E.04377.BC727AC5; Fri,  5
        Apr 2019 11:02:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190405100251eucas1p184f5c7ac64b28045ceb3ad091000ba2f~Si9WiG4Aj1860818608eucas1p1k;
        Fri,  5 Apr 2019 10:02:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190405100250eusmtrp189da21f1c9ac5f20a47b700c165bdde6~Si9WULCOe2865228652eusmtrp1I;
        Fri,  5 Apr 2019 10:02:50 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-fa-5ca727cb05a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.CD.04140.AC727AC5; Fri,  5
        Apr 2019 11:02:50 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190405100250eusmtip11e65f3f738859dfbf3f571efbf9f0351~Si9WH7DVa2310623106eusmtip1c;
        Fri,  5 Apr 2019 10:02:50 +0000 (GMT)
Subject: Re: [bug report] [media] s5p-mfc: use MFC_BUF_FLAG_EOS to identify
 last buffers in decoder capture queue
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-media@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f38dbe7a-d4b1-b012-d667-eaaade6e9ff6@samsung.com>
Date:   Fri, 5 Apr 2019 12:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404154216.GA24343@kadam>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOd3T6stjDCb+lbd4/W86i0XPhq2s
        DkweH5/eYvH4vEkugCmKyyYlNSezLLVI3y6BK+P+scmMBVOFKv6fjGpgXM3bxcjBISFgIjFv
        WU0XIxeHkMAKRolt01awQDhfGCXOfHvKCOF8ZpTo2HQLyOEE67j3axUbRGI5o8TatQtYIZy3
        jBK73m5lBakSFiiW+D19JxOILSKgI3G58wc7iM0sIC8x/9JhFhCbTUBT4u/mm2wgNq+AncTy
        jTfB6lkEVCS+79oHNkdUIELi/dPdLBA1ghInZz4BszkFtCW+7u1kgpm5/e0cZghbXOLWk/lM
        IAdJCLxnkzi+ppkV4mwXib7b11ggbGGJV8e3sEPYMhKnJ/dAxesl7q9oYYZo7mCU2LphJzNE
        wlri8PGLrKAQYwa6ev0ufUjgOUq8eqALYfJJ3HgrCHECn8SkbdOZIcK8Eh1tQhAzFCXun90K
        NU9cYumFr2wTGJVmIXlsFpJnZiF5ZhbC2gWMLKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNz
        NzEC08Xpf8e/7GDc9SfpEKMAB6MSD68G07IYIdbEsuLK3EOMEhzMSiK8ciuBQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZODilGhhZly+vu2ESJZJ7LrrlzLKs
        ewnXH34P76kQrFIrUFTL9SkUZmu+/8RC5s+Lgo+uZ+b98lN/d0VK5Ujwgn5mseyyyivhG3ue
        alRv2NsX+WBJxeO3Ce+UT+4qE37rZHBb790b009S8qLFApIiJVNnzQjJYHoyeVIMQ4vn6W2b
        a0VVfhcf1maWma/EUpyRaKjFXFScCAC2mjjGEwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7qn1JfHGOzq1bd4/W86i0XPhq2s
        DkweH5/eYvH4vEkugClKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYl
        NSezLLVI3y5BL+P+scmMBVOFKv6fjGpgXM3bxcjJISFgInHv1yq2LkYuDiGBpYwSGzY9YoVI
        iEvsnv+WGcIWlvhzrQuq6DWjxMSDr1lAEsICxRK/p+9kArFFBHQkLnf+YAexmQXkJeZfOgxW
        IyRQJ3GlYQGYzSagKfF38002EJtXwE5i+cabYL0sAioS33ftA1ssKhAhcffiCxaIGkGJkzOf
        gNmcAtoSX/d2MkHMV5f4M+8SM8yu7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWj
        SGppcW56brGRXnFibnFpXrpecn7uJkZgjGw79nPLDsaud8GHGAU4GJV4eDWYlsUIsSaWFVfm
        HmKU4GBWEuGVWwkU4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5Hxg/OaVxBuaGppbWBqaG5sb
        m1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDcccZoOntCwNbl04V3cuzXvxwd+PLC6h9V
        +7f8eZnbqiu1Oynw9JTANs2Se9lMUdyVFg1BuV3bgpeZccj1+7/+c3f5hOUffz/XqHZVsrPI
        sZkprfV+5TU2BjOj/qmHg8ttq5RLK/vkuz58+Bk2YRd/1ElDh9y0q1uNHZ3O9354c0uhecIe
        ob1KLMUZiYZazEXFiQACRJjWpwIAAA==
X-CMS-MailID: 20190405100251eucas1p184f5c7ac64b28045ceb3ad091000ba2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404154231epcas4p11c6ce6ab44d5b61c66e246fab78972e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404154231epcas4p11c6ce6ab44d5b61c66e246fab78972e9
References: <CGME20190404154231epcas4p11c6ce6ab44d5b61c66e246fab78972e9@epcas4p1.samsung.com>
        <20190404154216.GA24343@kadam>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dan,

On 04.04.2019 17:42, Dan Carpenter wrote:
> Hello Andrzej Hajda,
>
> The patch 4d0b0ed63660: "[media] s5p-mfc: use MFC_BUF_FLAG_EOS to
> identify last buffers in decoder capture queue" from Oct 7, 2015,
> leads to the following static checker warning:
>
> 	drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:664 vidioc_dqbuf()
> 	warn: uncapped user index 'ctx->dst_bufs[buf->index]'


Almost identical e-mail you have sent about year ago, and me and Hans
have explained you that it is false positive.

Has something changed?


Regards

Andrzej


>
> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
>     642 static int vidioc_dqbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>     643 {
>     644 	const struct v4l2_event ev = {
>     645 		.type = V4L2_EVENT_EOS
>     646 	};
>     647 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
>     648 	int ret;
>     649 
>     650 	if (ctx->state == MFCINST_ERROR) {
>     651 		mfc_err_limited("Call on DQBUF after unrecoverable error\n");
>     652 		return -EIO;
>     653 	}
>     654 
>     655 	switch (buf->type) {
>     656 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>     657 		return vb2_dqbuf(&ctx->vq_src, buf, file->f_flags & O_NONBLOCK);
>     658 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>     659 		ret = vb2_dqbuf(&ctx->vq_dst, buf, file->f_flags & O_NONBLOCK);
>     660 		if (ret)
>     661 			return ret;
>     662 
>     663 		if (ctx->state == MFCINST_FINISHED &&
> --> 664 		    (ctx->dst_bufs[buf->index].flags & MFC_BUF_FLAG_EOS))
>                                            ^^^^^^^^^^
> Smatch is saying that this isn't capped.  The truth is that v4l2 code is
> a bit complicated for Smatch, but in this case I can't see where
> "buf->index" does get capped.  I would have expected it to be capped in
> check_array_args() where we check "buf->length" but it's not.
>
> I've been going through these warnings really carefully in the past
> couple weeks trying to fix false positives so let me know what I'm
> missing and I will update the check.  Even if I have to manually muck
> in the DB.
>
>     665 			v4l2_event_queue_fh(&ctx->fh, &ev);
>     666 		return 0;
>     667 	default:
>     668 		return -EINVAL;
>     669 	}
>     670 }
>
> regards,
> dan carpenter
>
>

