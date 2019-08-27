Return-Path: <SRS0=pW3C=WX=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4066C3A5A3
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 13:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968182184D
	for <linux-media@archiver.kernel.org>; Tue, 27 Aug 2019 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566911399;
	bh=5Unp+1hTvun9Pago8po8h6X+4i+h0xfR0orpz+sED+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QHOEo1ctneJeA83TPeGWKYzoGKdACLBCc0hfrXrP+5HbP0wxSWnLY8nGCB22USo7F
	 bfga99GwfgeFruf7ikf1ZHtJS740ku3NU+ioLMtndn8tCkEde3Ib0Tm/O5LnOMS71O
	 RO9TqgQ8UMCGGALCM/bPKER+LSOzj0KXuSY8B3DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH0NJ7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:09:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfH0NJ7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Aug 2019 09:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XMwq+w9d/m/WBkMhGFnvfZLcnVM+faVFVq/Cs6eIFJY=; b=A07J7YymmK+Q1bFJrFeT/yp6g
        ixuxidEi5woZ5kNVRg/qA4RiM38xGEAZKYdaqRkbKlbqbASUMs5v2YShciLzPh5Yd27cgR9xtytvk
        /+cmu8wg9FWh0rUgklyZKzPteHDmux2faQTqpA8zYxij+Hf1OyVgeDSzEgNe+MTxgBwROpi496Pjo
        YbOunCn5I3pr6i84m0IcM8XyEfK8RQYnYjqZnF0OiQQDi8cPdRL9FYEWEzrn6xH4c1Srd3lfTD0Wb
        097Hpcr2Vl8LQ9ryEMUHuKeHWsUdHvImk/NpCpMAp5qZovM6Ce+bCs9zBpGwPe2irt+g+5hau47jN
        cnPro7WzA==;
Received: from 177.17.135.157.dynamic.adsl.gvt.net.br ([177.17.135.157] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2bET-0006kw-Tx; Tue, 27 Aug 2019 13:09:58 +0000
Date:   Tue, 27 Aug 2019 10:09:53 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Olcay Korkmaz <olcay.krkmz@gmail.com>
Cc:     linux-media@vger.kernel.org
Subject: Re: bug: dvbv5-scan segfaults
Message-ID: <20190827100953.0e8dc268@coco.lan>
In-Reply-To: <CADBDwkdbeRPC9VWYqLUcw-As8d14EqhD3qpdjc4c43s4dS5Nsg@mail.gmail.com>
References: <CADBDwkcKFGLQ_uv4U-gCTXeR09n3uz7dJt3OkufuR_4QsMb0AQ@mail.gmail.com>
        <20190826144014.02e0a85b@coco.lan>
        <CADBDwkdbeRPC9VWYqLUcw-As8d14EqhD3qpdjc4c43s4dS5Nsg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 26 Aug 2019 22:25:28 +0300
Olcay Korkmaz <olcay.krkmz@gmail.com> escreveu:

> 1.14.2 and git tree build gives the same error
> TS of entire transponder:
> https://drive.google.com/file/d/1zHouZSlbPowyJY5tzT5ro0r4ciPURkbi/view?usp=sharing

Thanks!

Please don't top-post.

> > Em Mon, 26 Aug 2019 19:59:17 +0300
> > Olcay Korkmaz <olcay.mz@gmail.com> escreveu:
> >  


> > > Service TV8, provider TV8: digital television
> > > Storing as channel TV8
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x00007ffff7ba5cff in dvb_store_channel ()
> > >    from /usr/lib/x86_64-linux-gnu/libdvbv5.so.0
> > > (gdb) backtrace  
> >
> >  
> > > #0 0x00007ffff7ba5cff in dvb_store_channel ()
> > >    from /usr/lib/x86_64-linux-gnu/libdvbv5.so.0
> > > #1 0x00005555555560c6 in run_scan (dvb=0x55555575d2e0, args=0x7fffffffdc80)
> > >     at dvbv5-scan.c:313
> > > #2 main (argc=<optimized out>, argv=<optimized out>) at dvbv5-scan.c:562

Ok, the problem is happening here:

Program received signal SIGSEGV, Segmentation fault.
dvb_store_channel (dvb_file=0x7fffffffe460, __p=0x5555555605d0, dvb_scan_handler=0x555555565060, get_detected=0, 
    get_nit=0) at dvb-file.c:1345
1345			if (dvb_scan_handler->nit->transport) {
(gdb) bt
#0  dvb_store_channel (dvb_file=0x7fffffffe460, __p=0x5555555605d0, dvb_scan_handler=0x555555565060, get_detected=0, 
    get_nit=0) at dvb-file.c:1345
#1  0x0000555555556847 in run_scan (dvb=0x5555555604f0, args=0x7fffffffe4b0) at dvbv5-scan.c:313
#2  main (argc=<optimized out>, argv=<optimized out>) at dvbv5-scan.c:562

The enclosed patch should fix the issue. Could you please check?

diff --git a/lib/libdvbv5/dvb-file.c b/lib/libdvbv5/dvb-file.c
index d077271a6546..474b59cb6fce 100644
--- a/lib/libdvbv5/dvb-file.c
+++ b/lib/libdvbv5/dvb-file.c
@@ -1342,7 +1342,7 @@ int dvb_store_channel(struct dvb_file **dvb_file,
 			dvb_log(_("Storing as channel %s"), channel);
 		vchannel = dvb_vchannel(parms, dvb_scan_handler->nit, service->service_id);
 
-		if (dvb_scan_handler->nit->transport) {
+		if (dvb_scan_handler->nit && dvb_scan_handler->nit->transport) {
 			network_id = dvb_scan_handler->nit->transport->network_id;
 			transport_id = dvb_scan_handler->nit->transport->transport_id;
 		}


Regards,
Mauro
