Return-Path: <SRS0=19ZY=S3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2BC10F03
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1A2217FA
	for <linux-media@archiver.kernel.org>; Thu, 25 Apr 2019 08:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfDYI1N (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:27:13 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51967 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfDYI1N (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Apr 2019 04:27:13 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JZimhQnG8ZVjxJZiphdzzC; Thu, 25 Apr 2019 10:27:11 +0200
Subject: Re: [PATCH v4 00/21] Add MPEG-2 decoding to Rockchip VPU
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
References: <20190425071242.18315-1-boris.brezillon@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b6e8aaf5-caaa-e022-414e-e6715f168492@xs4all.nl>
Date:   Thu, 25 Apr 2019 10:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190425071242.18315-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEMBIZw/Kxf5BIBNErTEc0WT2wXV687McK71jSKsDGoWzvd9+jzIztMFrmoPdUvjR4xqJrFGrDp6ym2KGiZvDo7dEboVDfGx9IUTirZHlD6hx3DmmPOR
 KFTr6SOFzh40UloOKwGS/BbQDKFOZ8IdQCGp25P/2AjSPn+FLE9qhU1VZxtrmV+Vjm7BylOT74zeaYCW8Egr3pfs+8NXeoqsOPkP+5/BoiHFVMaKFix2FbP+
 CVk6DWJxOVvOeud9+JpuR2qRA2OMGvEtWI41zVzjPR1asvGnHoVX0FOXScXwR50xmI5ecPX4kbWC/7R3ntG401o6UjnorYS+F1KHCqvl6RrEhE/lgDA0fdd6
 ox+zHN5y04xusTA6hmviN1gIcvoAZnZEvTGRJHoUiLK7isQWpsQ17Q4qBdGiNjWRvsOULDGE1v4T7qrqtSio41nws1/3KzuX6EkcBIwqcoRz0ClxFf0B+nPk
 Xcixs0tArxpBl+KJ7hdmfltKCe5QggceqsbyQGxqaZax1h4VA8frz909eCErJUB/BMcPSButPSU8YMmpMJkFJrC/5JHfna/tET1ldC74dN7IcleeWISxw5+Q
 TGpgLIukiMFzfzltA70/PV+1sSybOGC1IBV59cVcg47LnA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Compile tested this series and I get the following sparse/smatch wanings:


sparse: WARNINGS
SPARSE:/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:38:6:  warning: symbol 'rockchip_vpu_get_ctrl' was not
declared. Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:46:12:  warning: symbol 'rockchip_vpu_get_ref' was not
declared. Should it be static?
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:38:7: warning: no previous prototype for
'rockchip_vpu_get_ctrl' [-Wmissing-prototypes]
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:46:12: warning: no previous prototype for
'rockchip_vpu_get_ref' [-Wmissing-prototypes]
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:298:6: warning: variable 'j' set but not used
[-Wunused-but-set-variable]


smatch: WARNINGS
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:38:7: warning: no previous prototype for
'rockchip_vpu_get_ctrl' [-Wmissing-prototypes]
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:46:12: warning: no previous prototype for
'rockchip_vpu_get_ref' [-Wmissing-prototypes]
/home/hans/work/build/media-git/drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c:298:6: warning: variable 'j' set but not used
[-Wunused-but-set-variable]

Looks trivial to fix.

Regards,

	Hans
