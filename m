Return-Path: <SRS0=MIHa=26=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CBBC282DD
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFC42077B
	for <linux-media@archiver.kernel.org>; Thu,  9 Jan 2020 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOVY9gQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgAINRG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:17:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730738AbgAINRD (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 9 Jan 2020 08:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578575822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eaDduvQU2guS4vrvwK6lDYPLKtspFkgjS3v1PAKChuA=;
        b=XOVY9gQb7icvHTlEtlb6+PYzVcJYahkpCW8aMSgkI+ArE5/yuLoIJEM7LX78OLUE7aLqz2
        /TJGIS0pycywubFqeh3wJWWd5r4xMFu0gJU/ar4WhTODPntDEvOfBtT+i5icrj6gho+Hdn
        e/tPXCfjXl8bf96F2aN/TpCEuGAMye8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-NPJZrxSXNniMwTFzbHqz1Q-1; Thu, 09 Jan 2020 08:16:59 -0500
X-MC-Unique: NPJZrxSXNniMwTFzbHqz1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B924910054E3;
        Thu,  9 Jan 2020 13:16:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 663C6620A6;
        Thu,  9 Jan 2020 13:16:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 89B0B31F29; Thu,  9 Jan 2020 14:16:55 +0100 (CET)
Date:   Thu, 9 Jan 2020 14:16:55 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Alex Lau <alexlau@chromium.org>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        Pawel Osciak <posciak@chromium.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Message-ID: <20200109131655.45hxjqofrtzu25sz@sirius.home.kraxel.org>
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
 <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
 <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

  Hi,

> At that point, I think it's just a matter of aesthetics. I lean
> slightly towards returning the uuid from the host, since that rules
> out any implementation with the aforementioned race.

Ok, design the API in a way that you can't get it wrong.  Makes sense.
I'd still name it ressource_assign_uuid though.

cheers,
  Gerd

