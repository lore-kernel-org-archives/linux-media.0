Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC86C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A042084A
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 00:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfDCAaR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:30:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53719 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfDCAaR (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 20:30:17 -0400
X-UUID: 17fe70f2ce974ff1aefb4aea6ea4723e-20190403
X-UUID: 17fe70f2ce974ff1aefb4aea6ea4723e-20190403
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <jungo.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1531167592; Wed, 03 Apr 2019 08:30:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Apr 2019 08:30:04 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Apr 2019 08:30:04 +0800
Message-ID: <1554251404.30711.2.camel@mtksdccf07>
Subject: Re: [PATCH v1] media: media_device_enum_links32: fix missing
 reserved field copy
From:   Jungo Lin <jungo.lin@mediatek.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <tfiga@chromium.org>, <hans.verkuil@cisco.com>,
        <laurent.pinchart+renesas@ideasonboard.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <Sean.Cheng@mediatek.com>,
        <sj.huang@mediatek.com>, <christie.yu@mediatek.com>,
        <holmes.chiou@mediatek.com>, <frederic.chen@mediatek.com>,
        <Jerry-ch.Chen@mediatek.com>, <frankie.chiu@mediatek.com>,
        <seraph.huang@mediatek.com>, <ryan.yu@mediatek.com>,
        <Rynn.Wu@mediatek.com>, <yuzhao@chromium.org>,
        <zwisler@chromium.org>, <srv_heupstream@mediatek.com>,
        Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>
Date:   Wed, 3 Apr 2019 08:30:04 +0800
In-Reply-To: <20190402113339.GT4805@pendragon.ideasonboard.com>
References: <jungo.lin@mediatek.com>
         <1554199444-16827-1-git-send-email-jungo.lin@mediatek.com>
         <20190402113339.GT4805@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi, Laurent,

On Tue, 2019-04-02 at 14:33 +0300, Laurent Pinchart wrote:
> Hi Jungo,
> 
> Thank you for the patch.
> 
> On Tue, Apr 02, 2019 at 06:04:04PM +0800, Jungo Lin wrote:
> > From: Jungo Lin <jungo.lin@mediatek.corp-partner.google.com>
> > 
> > In v4l2-compliance utility, test MEDIA_IOC_ENUM_ENTITIES
> > will check whether reserved field of media_links_enum filled
> > with zero. Reserved field is filled with zero in media_device_enum_links.
> > 
> > However, for 32 bit program, the reserved field is missing
> > copy from kernel space to user space in media_device_enum_links32
> > function.
> > 
> > This patch copies reserved field of media_links_enum from kernel space
> > to user space.
> > 
> > Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
> > ---
> >  drivers/media/media-device.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
> > index b8ec886..f420829 100644
> > --- a/drivers/media/media-device.c
> > +++ b/drivers/media/media-device.c
> > @@ -502,6 +502,7 @@ static long media_device_enum_links32(struct media_device *mdev,
> >  {
> >  	struct media_links_enum links;
> >  	compat_uptr_t pads_ptr, links_ptr;
> > +	int ret;
> >  
> >  	memset(&links, 0, sizeof(links));
> >  
> > @@ -513,7 +514,15 @@ static long media_device_enum_links32(struct media_device *mdev,
> >  	links.pads = compat_ptr(pads_ptr);
> >  	links.links = compat_ptr(links_ptr);
> >  
> > -	return media_device_enum_links(mdev, &links);
> > +	ret = media_device_enum_links(mdev, &links);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (copy_to_user(ulinks->reserved, &links.reserved,
> > +			 sizeof(links.reserved)))
> > +		return -EFAULT;
> 
> I think it would be better to zero the reserved field here instead of
> copying it, as we know it has to be zero.
> 

Got it.
We will revise the implementation and deliver the v2 patch.

Thanks,

Jungo 

> > +
> > +	return 0;
> >  }
> >  
> >  #define MEDIA_IOC_ENUM_LINKS32		_IOWR('|', 0x02, struct media_links_enum32)
> 


