Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E11C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 02:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32BF21734
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 02:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDCC1K (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:27:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61547 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbfDCC1K (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 22:27:10 -0400
X-UUID: 7bcf47805340472498a6c68c7b28a48a-20190403
X-UUID: 7bcf47805340472498a6c68c7b28a48a-20190403
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <jerry-ch.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1331863561; Wed, 03 Apr 2019 10:26:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Apr 2019 10:26:54 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Apr 2019 10:26:54 +0800
Message-ID: <1554258414.11458.27.camel@mtksdccf07>
Subject: Re: [RFC PATCH V0 5/7] dts: arm64: mt8183: Add FD nodes
From:   Jerry-ch Chen <Jerry-ch.Chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "laurent.pinchart+renesas@ideasonboard.com" 
        <laurent.pinchart+renesas@ideasonboard.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "yuzhao@chromium.org" <yuzhao@chromium.org>,
        "zwisler@chromium.org" <zwisler@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sean Cheng =?UTF-8?Q?=28=E9=84=AD=E6=98=87=E5=BC=98=29?= 
        <Sean.Cheng@mediatek.com>,
        "Sj Huang =?UTF-8?Q?=28=E9=BB=83=E4=BF=A1=E7=92=8B=29?=" 
        <sj.huang@mediatek.com>,
        Christie Yu =?UTF-8?Q?=28=E6=B8=B8=E9=9B=85=E6=83=A0=29?= 
        <christie.yu@mediatek.com>,
        Holmes Chiou =?UTF-8?Q?=28=E9=82=B1=E6=8C=BA=29?= 
        <holmes.chiou@mediatek.com>,
        Frederic Chen =?UTF-8?Q?=28=E9=99=B3=E4=BF=8A=E5=85=83=29?= 
        <Frederic.Chen@mediatek.com>,
        Jungo Lin =?UTF-8?Q?=28=E6=9E=97=E6=98=8E=E4=BF=8A=29?= 
        <jungo.lin@mediatek.com>,
        Rynn Wu =?UTF-8?Q?=28=E5=90=B3=E8=82=B2=E6=81=A9=29?= 
        <Rynn.Wu@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        <Jerry-ch.chen@mediatek.com>
Date:   Wed, 3 Apr 2019 10:26:54 +0800
In-Reply-To: <20190325215728.GA32712@bogus>
References: <1550648893-42050-1-git-send-email-Jerry-Ch.chen@mediatek.com>
         <1550648893-42050-6-git-send-email-Jerry-Ch.chen@mediatek.com>
         <20190325215728.GA32712@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2019-03-26 at 05:57 +0800, Rob Herring wrote:
> On Wed, Feb 20, 2019 at 03:48:11PM +0800, Jerry-ch Chen wrote:
> > This patch adds nodes for Face Detection (FD) unit. FD is embedded
> > in Mediatek SoCs and works with the co-processor to perform face
> > detection on the input data and image and output detected face result.
> > 
> > Signed-off-by: Jerry-ch Chen <jerry-ch.chen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index b3d8dfd..45c7e2f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -440,6 +440,26 @@
> >  			#clock-cells = <1>;
> >  		};
> >  
> > +		fd_smem: fd_smem {
> > +			compatible = "mediatek,fd_smem";
> > +			mediatek,larb = <&larb5>;
> > +			iommus = <&iommu M4U_PORT_CAM_IMGI>;
> 
> This doesn't look like an actual h/w device...
> 
Thank you for your comments.

fd_smem is not an actual h/w device and it will not be used in the
future. We are going to remove the fd smem driver and fd_smem node.

> > +		};
> > +
> > +		fd:fd@1502b000 {
> 
> space after the :  ^
will be fixed.

> > +			compatible = "mediatek,fd";
> 
> Should be SoC specific.
> 
will be fixed as "mediatek, mt8183-fd".

Thanks and Best Regards
Jerry
> > +			mediatek,larb = <&larb5>;
> > +			mediatek,vpu = <&vpu>;
> > +			iommus = <&iommu M4U_PORT_CAM_FDVT_RP>,
> > +				 <&iommu M4U_PORT_CAM_FDVT_WR>,
> > +				 <&iommu M4U_PORT_CAM_FDVT_RB>;
> > +			reg = <0 0x1502b000 0 0x1000>;
> > +			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&imgsys CLK_IMG_FDVT>;
> > +			clock-names = "FD_CLK_IMG_FD";
> > +			smem_device = <&fd_smem>;
> > +		};
> > +
> >  		vdecsys: syscon@16000000 {
> >  			compatible = "mediatek,mt8183-vdecsys", "syscon";
> >  			reg = <0 0x16000000 0 0x1000>;
> > -- 
> > 1.9.1
> > 


