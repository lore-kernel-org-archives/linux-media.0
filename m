Return-Path: <SRS0=sYeE=AS=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E32C433DF
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90ABF2075B
	for <linux-media@archiver.kernel.org>; Tue,  7 Jul 2020 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kensnet.org header.i=@kensnet.org header.b="MBIiz9jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGRHC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:07:02 -0400
Received: from knetgate.kensnet.org ([80.168.136.138]:39340 "EHLO
        knet-dmarc.kensnet.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGGRHB (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 7 Jul 2020 13:07:01 -0400
X-Greylist: delayed 3794 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 13:07:00 EDT
Received: from knetgate.kensnet.org ([192.168.122.1])
        by knet-dmarc.kensnet.org (8.14.4/8.14.4) with ESMTP id 067G3fAq017006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-media@vger.kernel.org>; Tue, 7 Jul 2020 17:03:41 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 knet-dmarc.kensnet.org 067G3fAq017006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kensnet.org;
        s=default; t=1594137822;
        bh=dTiTE+CYwtdAjkN4q7q+6UxiSUZAYrNy+mVek9QYQqE=;
        h=From:Subject:To:Date:From;
        b=MBIiz9jR2xLVCKHCCOMDs3FN2Cc9dkJGiwgq+oEU47pB51kK5tsP37zDK06Dl4Zgh
         ihoagWZhI5Y2+ruwvDaLuV3IZFVQkd3mvLXtWERJzO6mB4YKX/c9xb3B95DE23VsXp
         3Kqml9HTsbjKaH7dMxtckm/1deIdt6w0TcfjGGjE=
Received: from [172.16.0.176] (kenslt3-CE6.kensnet [172.16.0.176] (may be forged))
        (authenticated bits=0)
        by knetgate.kensnet.org (8.14.4/8.14.4) with ESMTP id 067G3c12010801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <linux-media@vger.kernel.org>; Tue, 7 Jul 2020 17:03:39 +0100
From:   Ken Smith <kens@kensnet.org>
Subject: TBS 6902 Fedora 32
To:     linux-media@vger.kernel.org
Organization: K-Net Technology
Message-ID: <c1f384bf-90c2-175e-d8ae-43e61af1b8bf@kensnet.org>
Date:   Tue, 7 Jul 2020 17:03:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-kensnet-MailScanner-Information: Please contact the ISP for more information
X-kensnet-MailScanner-ID: 067G3c12010801
X-kensnet-MailScanner: Found to be clean
X-kensnet-MailScanner-From: kens@kensnet.org
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi All,

I've been trying to get the driver to compile for a TBS 6902. I'm using 
Fedora 32 with a 5.7.2 kernel. I've tried TBS's own driver, and two 
varieties of open source drivers ( Luis Alves and a forked one) and get 
various compile failures. Would anyone care to share if they have a 
working configuration that is on a similar configuration. That would 
save my re-inventing the wheel tracing the problem.

I've downloaded the kernel-header package, some of the errors suggest I 
need the kernel source. I'm not a developer, but I'm a reasonably 
tenacious fault tracer. If there is a particular driver package that is 
preferred for some reason then I'd be grateful for any pointers.

I have a few questions.

How come this driver is not part of the DVB package?

Why do the available packages for this also compile/replace the whole of 
the DVB module tree? Wouldn't it be better to be able to just compile 
this module alone and add the module to the remainder? Perhaps there is 
some subtlety in here that I'm missing.

Grateful for any pointers...

Many thanks

Ken


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

