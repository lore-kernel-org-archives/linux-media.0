Return-Path: <SRS0=q2TO=DO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB12C41604
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 11:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3586520782
	for <linux-media@archiver.kernel.org>; Wed,  7 Oct 2020 11:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgJGLe3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:34:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgJGLeT (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Oct 2020 07:34:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 4BD7129C0D5
Message-ID: <4521d217f456dbab1279cfba2d23b426435c6d9c.camel@collabora.com>
Subject: Re: [PATCH v2 0/6] CODA timeout fix & assorted changes
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>, Benjamin.Bara@skidata.com,
        Lucas Stach <l.stach@pengutronix.de>, kernel@collabora.com
Date:   Wed, 07 Oct 2020 08:34:09 -0300
In-Reply-To: <CAOMZO5DpGXoyXm0D63BL84qMAnPkNOiUcmYsmp9QdogePrLxZw@mail.gmail.com>
References: <20201007103544.22807-1-ezequiel@collabora.com>
         <CAOMZO5DpGXoyXm0D63BL84qMAnPkNOiUcmYsmp9QdogePrLxZw@mail.gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Fabio,

On Wed, 2020-10-07 at 08:13 -0300, Fabio Estevam wrote:
> Hi Ezequiel,
> 
> On Wed, Oct 7, 2020 at 8:01 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > Hi all,
> > 
> > The main motivation for this series is to address a PIC_RUN
> > timeout, which we managed to link with a hardware bitstream
> > buffer underrun condition.
> > 
> > Upon further investigation we discovered that the underrun
> > was produced by a subtle issue in the way buffer_meta's were
> > being tracked.
> > 
> > The issue is fixed by patch "5/6 coda: coda_buffer_meta housekeeping fix".
> > 
> > Patches 1 to 4 are mostly cleanups and minor cosmetic changes.
> 
> Shouldn't the fix be the first patch in the series so that it can be
> backported to stable?
> 

While that is typically the case, it won't change much.

You'll find that the fix in patch 5 can be applied cleanly
on top of v5.4 and v5.8 :-)

Now that you mention this, I believe that the patch
should carry:

Cc: stable@vger.kernel.org # v5.4

Thanks,
Ezequiel


