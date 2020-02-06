Return-Path: <SRS0=0Sen=32=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FAC33CAC
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7277217BA
	for <linux-media@archiver.kernel.org>; Thu,  6 Feb 2020 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me92aZ1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBFQRt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:17:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727613AbgBFQRt (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 6 Feb 2020 11:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581005868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/Qft0V8xjpz5L2nA4UniKh71mergu/nSXCSw/xoDUU=;
        b=Me92aZ1dd8sNlEOcwVgM/ZXm7e47GkjLpeyeYuLMSal8HdxLJEfpM/dMvX18JeZFLmuZJS
        JPo1AdTbe+4w0TE4SMZckNHqewnAwnlBMucOyJKLNyeJPOpd1uB7lXG/0SvDgFn9y9lv2s
        oW202ivILjOEm46gHbe1iJp1UH5SehQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-EV9chORxOEadFW-G8wx9rg-1; Thu, 06 Feb 2020 11:17:45 -0500
X-MC-Unique: EV9chORxOEadFW-G8wx9rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BCFF18B5FA9;
        Thu,  6 Feb 2020 16:17:43 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91EF18EA0C;
        Thu,  6 Feb 2020 16:17:40 +0000 (UTC)
Date:   Thu, 6 Feb 2020 17:17:38 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-doc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, kvm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 00/27] docs: virt: manually convert text documents to
 ReST format
Message-ID: <20200206171738.75f374da.cohuck@redhat.com>
In-Reply-To: <cover.1581000481.git.mchehab+huawei@kernel.org>
References: <cover.1581000481.git.mchehab+huawei@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu,  6 Feb 2020 15:49:57 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Manually convert the documentation under Documentation/virt to ReST,
> minimizing the usage of uneeded markups and preserving the documentation
> writer's style.

While you're at it: Would it make sense to convert and move the lone
file under Documentation/virtual/ that survived 2f5947dfcaec
("Documentation: move Documentation/virtual to Documentation/virt")
(probably due to a conflict) under virt/ as well?

