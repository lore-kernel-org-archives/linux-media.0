Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84108C433EF
	for <linux-media@archiver.kernel.org>; Mon, 13 Sep 2021 02:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6895261004
	for <linux-media@archiver.kernel.org>; Mon, 13 Sep 2021 02:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhIMCvq (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 12 Sep 2021 22:51:46 -0400
Received: from ozlabs.org ([203.11.71.1]:33189 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236949AbhIMCvm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sun, 12 Sep 2021 22:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1631501426;
        bh=CAV4NOXlEMwGjvPVzT2IjuVrKKEzT0HbuXN0U00IH28=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=c7EMRka50jfxf/moIeEpLtNLGH8uYYvzFr1HhBusVv+KsyrgP5rYlgDZnRdMmeEE3
         8convlPjKAFsuX3DZrUy8DklGyK5Ff7RMgyR/FE86aZMbgUBL4cglJ4ENTRNeRaHV1
         fB3S30VO5fIw5+86gFTdcpWxhLQJUKKs1cOBCme2vvn09BomEpXg0dTPK2A3khIFW4
         Y6/+Mo0jmmWH47E1Nor1wFwLY7fYuUoltVDXqPhwX8pypfOoSnH3mD9Z1V1cCWdY09
         qwtJyGJhkbggaPyPL7rFM8LrZ64XGEbfG30wWffZVv2D/QBYMzXhi1P9awv+l4mVPU
         crxd6NX7djhgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4H79vN4njgz9sW5;
        Mon, 13 Sep 2021 12:50:24 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Luo Likang <luolikang@nsfocus.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux1394-devel@lists.sourceforge.net,
        Yang Yanchao <yangyanchao6@huawei.com>,
        Security Officers <security@kernel.org>
Subject: Re: [PATCH v2 RESEND] media: firewire: firedtv-avc: fix a buffer
 overflow in avc_ca_pmt()
In-Reply-To: <CAHk-=wjOW3Fx8td1Snezd1_9sf8q7KuQx8TyQNR0ypS2rVBHtg@mail.gmail.com>
References: <YRoNTX3Krtw9NdkI@eldamar.lan> <20210816072721.GA10534@kili>
 <20210901104026.GB2129@kadam> <YT39LBTgGL/b/V5N@eldamar.lan>
 <CAHk-=wjOW3Fx8td1Snezd1_9sf8q7KuQx8TyQNR0ypS2rVBHtg@mail.gmail.com>
Date:   Mon, 13 Sep 2021 12:50:19 +1000
Message-ID: <87pmtdkx3o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Linus Torvalds <torvalds@linuxfoundation.org> writes:
> On Sun, Sep 12, 2021 at 6:14 AM Salvatore Bonaccorso <carnil@debian.org> wrote:
>>
>> On Wed, Sep 01, 2021 at 01:40:26PM +0300, Dan Carpenter wrote:
>> > On Mon, Aug 16, 2021 at 10:27:22AM +0300, Dan Carpenter wrote:
>> > > The bounds checking in avc_ca_pmt() is not strict enough.  It should
>> > > be checking "read_pos + 4" because it's reading 5 bytes.  If the
>> > > "es_info_length" is non-zero then it reads a 6th byte so there needs to
>> > > be an additional check for that.
>> > >
>> > > I also added checks for the "write_pos".  I don't think these are
>> > > required because "read_pos" and "write_pos" are tied together so
>> > > checking one ought to be enough.
>
> They may be in sync at a fixed offset, but the buffer length of the
> read ("int length") is not in sync with the buffer length for the
> write ("sizeof(c->operand)").
>
> So I do think the write pos limit checking is actually necessary and needed.
>
>> > > RESEND: this patch got lost somehow.
>> >
>> > What the heck?  Someone on patchwork just marked this patch as obsolete
>> > again!!!
>
> Can we please make sure patchwork has some logging so that that kind
> of thing shows _who_ did this?

It's not easily visible in the web UI, but patchwork does log that sort
of info.

The v2 RESEND is:

 https://patchwork.linuxtv.org/project/linux-media/patch/20210816072721.GA10534@kili/

In the top right is the patch id (76352), you can then get the list of
events for that patch at:

  https://patchwork.linuxtv.org/api/events/?patch=76352

Which shows that hverkuil changed it to obsolete on 2021-09-01T10:16:43.

Presumably because they picked up the non-resend version, which was
marked as under-review around the same time:

  https://patchwork.linuxtv.org/api/events/?patch=74849

And then also visible on the above page, it was marked as accepted by
mchehab on 2021-09-03T13:06:16.

But I don't see the patch in linux-next, or in linux-media.git, so I'm
not sure where it's been accepted to?

cheers
