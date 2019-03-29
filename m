Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E598C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7395D217F5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 14:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfC2OKh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:10:37 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:43241 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728774AbfC2OKg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 10:10:36 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9sDHhOx1FUjKf9sDKhwF4t; Fri, 29 Mar 2019 15:10:34 +0100
Subject: Re: [PATCH v2] media: replace strncpy() by strscpy()
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
References: <1ba964c82b9f3353945bab7da4cb7b713fe6e3a7.1553868148.git.mchehab+samsung@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5282d886-7cbd-4144-50b1-5b71e3db69d3@xs4all.nl>
Date:   Fri, 29 Mar 2019 15:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1ba964c82b9f3353945bab7da4cb7b713fe6e3a7.1553868148.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKnHq2kLT7di2cacP4DDFAQcfS9k1Hi9vo7hw6y8+hyQASC+RBZeXGtHFtYFL2bWXkLUnQV15SwoqHtCgdkaSOlmt41oPyza5Okoe59i4B8X1el4+KAz
 YIPm/0fF8nlz/8gWpol3QAGXLnNjRcvnTVmMG6GgSN0a5cyK9FUzU580I57PZyY5FlEF6uFLgZsmapmgwAi12pFjlQtXXhXEYGMO5/M2FbjgCOV7M94sKLr8
 RWYz34snBbFFyvM8wVTZLg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/29/19 3:02 PM, Mauro Carvalho Chehab wrote:
> The strncpy() function is being deprecated upstream. Replace
> it by the safer strscpy().
> 
> While here, replace a few occurences of strlcpy() that were
> recently added to also use strscpy().
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/media/dvb-frontends/as102_fe.c           |  2 +-
>  drivers/media/dvb-frontends/dib7000p.c           |  3 ++-
>  drivers/media/dvb-frontends/dib8000.c            |  4 ++--
>  drivers/media/dvb-frontends/dib9000.c            |  6 ++++--
>  drivers/media/dvb-frontends/dvb-pll.c            |  2 +-
>  drivers/media/dvb-frontends/m88ds3103.c          |  2 +-
>  drivers/media/pci/bt8xx/dst.c                    |  3 ++-
>  drivers/media/pci/mantis/mantis_i2c.c            |  2 +-
>  drivers/media/pci/saa7134/saa7134-go7007.c       |  2 +-
>  drivers/media/platform/am437x/am437x-vpfe.c      |  2 +-
>  drivers/media/platform/davinci/vpfe_capture.c    |  2 +-
>  drivers/media/platform/davinci/vpif_capture.c    |  3 ++-
>  drivers/media/platform/davinci/vpif_display.c    |  4 ++--
>  drivers/media/platform/exynos4-is/fimc-capture.c |  2 +-
>  drivers/media/platform/exynos4-is/fimc-m2m.c     |  2 +-
>  drivers/media/platform/imx-pxp.c                 |  4 ++--
>  drivers/media/platform/mtk-vpu/mtk_vpu.c         |  2 +-
>  drivers/media/platform/mx2_emmaprp.c             |  4 ++--
>  drivers/media/platform/s5p-g2d/g2d.c             |  6 +++---
>  .../media/platform/sunxi/sun6i-csi/sun6i_video.c |  4 ++--
>  drivers/media/platform/ti-vpe/vpe.c              |  6 +++---
>  drivers/media/platform/vicodec/vicodec-core.c    |  4 ++--
>  drivers/media/platform/vim2m.c                   |  4 ++--
>  drivers/media/platform/vivid/vivid-core.c        |  2 +-
>  drivers/media/radio/si4713/si4713.c              |  2 +-
>  drivers/media/usb/go7007/go7007-usb.c            | 16 ++++++++--------
>  drivers/media/usb/go7007/go7007-v4l2.c           |  2 +-
>  drivers/media/usb/hdpvr/hdpvr-video.c            | 10 ++++------
>  drivers/media/usb/pulse8-cec/pulse8-cec.c        |  4 ++--
>  drivers/media/usb/pvrusb2/pvrusb2-hdw.c          |  4 ++--
>  drivers/media/usb/pvrusb2/pvrusb2-v4l2.c         |  4 ++--
>  drivers/staging/media/bcm2048/radio-bcm2048.c    |  4 ++--
>  drivers/staging/media/imx/imx-ic-common.c        |  2 +-
>  drivers/staging/media/imx/imx-media-vdic.c       |  2 +-
>  drivers/staging/media/zoran/zoran_driver.c       | 10 +++++-----
>  35 files changed, 70 insertions(+), 67 deletions(-)
> 

<snip>

> diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
> index c94318c71a0c..3315a6d67edf 100644
> --- a/drivers/media/pci/bt8xx/dst.c
> +++ b/drivers/media/pci/bt8xx/dst.c
> @@ -1100,7 +1100,8 @@ static int dst_get_device_id(struct dst_state *state)
>  			/*	Card capabilities	*/
>  			state->dst_hw_cap = p_dst_type->dst_feature;
>  			pr_err("Recognise [%s]\n", p_dst_type->device_id);
> -			strncpy(&state->fw_name[0], p_dst_type->device_id, 6);
> +			strscpy((char *)state->fw_name, p_dst_type->device_id,

This cast is a bit ugly. Perhaps in a follow up patch the type of fw_name can
be changed from u8 to char?

> +				sizeof(state->fw_name));
>  			/*	Multiple tuners		*/
>  			if (p_dst_type->tuner_type & TUNER_TYPE_MULTI) {
>  				switch (use_dst_type) {

<snip>

> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> index 446a999dd2ce..bea28f589210 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> @@ -2459,8 +2459,8 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
>  		if (!(qctrl.flags & V4L2_CTRL_FLAG_READ_ONLY)) {
>  			ciptr->set_value = ctrl_cx2341x_set;
>  		}
> -		strncpy(hdw->mpeg_ctrl_info[idx].desc,qctrl.name,
> -			PVR2_CTLD_INFO_DESC_SIZE);
> +		strscpy(hdw->mpeg_ctrl_info[idx].desc, qctrl.name,
> +			sizeof(hdw->mpeg_ctrl_info[idx].desc));
>  		hdw->mpeg_ctrl_info[idx].desc[PVR2_CTLD_INFO_DESC_SIZE-1] = 0;

This line can now be removed.

>  		ciptr->default_value = qctrl.default_value;
>  		switch (qctrl.type) {

After removing that line in the pvrusb2 driver you can add my:

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Nice work!

Regards,

	Hans
