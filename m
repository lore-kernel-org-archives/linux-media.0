Return-Path: <SRS0=PKt4=VM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A68C73C66
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 02:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1061020868
	for <linux-media@archiver.kernel.org>; Mon, 15 Jul 2019 02:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="uiFZZX/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfGOCx7 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 14 Jul 2019 22:53:59 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:60958 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfGOCx7 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 14 Jul 2019 22:53:59 -0400
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id mr7ShNEfdMC2xmr7mhHfuI; Mon, 15 Jul 2019 02:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1563159238;
        bh=2O5NT5zHqGcuPKe/sCh6FrRbIw7sAnpdZruO//Rg6+s=;
        h=Received:Received:Subject:From:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=uiFZZX/frTLNezbKzPO2qicf5WsevPuxbzXSAB+3J5NGn7Pzwrucp15NpEtnaWeSn
         qbm9f+2iCrmNjHFacdpiQZxGRuUt2Np7UjTEQ/Ok721+64KK7NCmppFjr59NgvAtyf
         SdLFVwWD1v2xxmPb0qD1KOc2ameaxsHgUZX72nfgWRGIJ5m7LUa3u+pYOUlfgbdw0j
         qn4AkkOt7NpzMXsTip8rnXufvGemNS54VO3ebEK3AuO0LzXAsPx9x14S3tn6MEkbme
         K8bpOacMdpvlTTDBvpEBVfoydWSd0QAUGho0bR/qTI/iKUkJseSsziRITnRq4OiNQp
         yWr6jx/gmtMRA==
Received: from [192.168.4.4] ([73.248.220.215])
        by resomta-po-08v.sys.comcast.net with ESMTPA
        id mr7lhndoIYHq2mr7lhrOVo; Mon, 15 Jul 2019 02:53:58 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddrheejgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuhffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeetucfuuhhnuceorghsuddtfeefgiestghomhgtrghsthdrnhgvtheqnecukfhppeejfedrvdegkedrvddvtddrvdduheenucfrrghrrghmpehhvghloheplgduledvrdduieekrdegrdegngdpihhnvghtpeejfedrvdegkedrvddvtddrvdduhedpmhgrihhlfhhrohhmpegrshdutdeffeigsegtohhmtggrshhtrdhnvghtpdhrtghpthhtohepmhgthhgvhhgrsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvggrnhesmhgvshhsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-Xfinity-VMeta: sc=-100;st=legit
Subject: Re: [PATCH v2 3/3] [media] mceusb: Show USB halt/stall error recovery
From:   A Sun <as1033x@comcast.net>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <999ae5cd-d72b-983f-2f96-5aaca72e8214@comcast.net>
 <43f4ef6e-2c64-cd7a-26f7-3c1309b68936@comcast.net>
 <20190606095337.jfhmc6jqgyhmxn4q@gofer.mess.org>
 <2548e827-1d11-4ce2-013f-bf36c9f5436e@comcast.net>
 <20190608083729.bw47vkplpf3r4e4b@gofer.mess.org>
 <2e8059be-d6ec-f649-356e-3f3b3095e6ec@comcast.net>
Message-ID: <95b6e8f5-1bad-ce36-f219-7931b84b055f@comcast.net>
Date:   Sun, 14 Jul 2019 22:54:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2e8059be-d6ec-f649-356e-3f3b3095e6ec@comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


This patch is superseded by
  [PATCH v1] [media] mceusb: USB reset device following USB clear halt error
