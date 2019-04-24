Return-Path: <SRS0=rHfj=S2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435F3C282E1
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D35218B0
	for <linux-media@archiver.kernel.org>; Wed, 24 Apr 2019 09:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfDXJ3b (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:29:31 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:37381 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727876AbfDXJ3a (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 24 Apr 2019 05:29:30 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JEDUhJAZUZVjxJEDYhZidg; Wed, 24 Apr 2019 11:29:28 +0200
Subject: Re: [PATCH 09/13] media: v4l2-ctrl: add MPEG-2 profile and level
 controls
To:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20190412155135.13907-1-p.zabel@pengutronix.de>
 <20190412155135.13907-9-p.zabel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2959673c-86d1-64ec-f0f7-ed4a7ca71ce4@xs4all.nl>
Date:   Wed, 24 Apr 2019 11:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190412155135.13907-9-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDwpwzOU9BXsJLpLO3rcga0F7tNprmWmvbyl/ZLncbzzUzP/CZ+b8b68kjbnjrJhBgLxq1u8AN7/mZ15brH7cwafGpGwG3isMd/2pCOqLk68RnD70UQQ
 y+YChdUqHKuxLPCyuPO3dWeOMBbPv8MiBy5XnHpaAonbIRyuQ1vjFNbFg4PRYTyS3Rbn7fsEQVqEUBPJjESXv0uPq+/XRfVitLtsoXlqVfZUacV7u1EK637b
 U+RI2jDwbr4nU9c4nWjK0qxGAjlzlbw678pTmu7dYie6UImijWfVxBpFW7300euI/lGhnnJgIcGn/Da+Fm71eIYKu9HRU6eEVLdE7fgtbZkPTGD1wKrmFTlZ
 nPUaO4pP
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/19 5:51 PM, Philipp Zabel wrote:
> Add MPEG-2 CID definitions for profiles and levels defined in ITU-T Rec.
> H.262.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../media/uapi/v4l/ext-ctrls-codec.rst        | 56 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 23 ++++++++
>  include/uapi/linux/v4l2-controls.h            | 16 ++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> index 67a122339c0e..b4e6a7c94b42 100644
> --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> @@ -759,6 +759,32 @@ enum v4l2_mpeg_video_h264_level -
>  
>  
>  
> +.. _v4l2-mpeg-video-mpeg2-level:
> +
> +``V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL``
> +    (enum)
> +
> +enum v4l2_mpeg_video_mpeg2_level -
> +    The level information for the MPEG2 elementary stream. Applicable to
> +    MPEG2 codecs. Possible values are:
> +
> +
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW``
> +      - Low Level (LL)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN``
> +      - Main Level (ML)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440``
> +      - High-1440 Level (H-14)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH``
> +      - High Level (HL)
> +
> +
> +
>  .. _v4l2-mpeg-video-mpeg4-level:
>  
>  ``V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL``
> @@ -845,6 +871,36 @@ enum v4l2_mpeg_video_h264_profile -
>  
>  
>  
> +.. _v4l2-mpeg-video-mpeg2-profile:
> +
> +``V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE``
> +    (enum)
> +
> +enum v4l2_mpeg_video_mpeg2_profile -
> +    The profile information for MPEG2. Applicable to MPEG2 codecs.
> +    Possible values are:
> +
> +
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE``
> +      - Simple profile (SP)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN``
> +      - Main profile (MP)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE``
> +      - SNR Scalable profile (SNR)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE``
> +      - Spatially Scalable profile (Spt)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH``
> +      - High profile (HP)
> +    * - ``V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW``
> +      - Multi-view profile (MVP)
> +
> +
> +
>  .. _v4l2-mpeg-video-mpeg4-profile:
>  
>  ``V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE``
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index b1ae2e555c68..a7e80e389003 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -406,6 +406,21 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"Explicit",
>  		NULL,
>  	};
> +	static const char * const mpeg_mpeg2_level[] = {
> +		"Low",
> +		"Main",
> +		"High 1440",
> +		"High",
> +		NULL,
> +	};
> +	static const char * const mpeg2_profile[] = {
> +		"Simple",
> +		"Main",
> +		"SNR Scalable",
> +		"Spatially Scalable",
> +		"High",
> +		NULL,
> +	};
>  	static const char * const mpeg_mpeg4_level[] = {
>  		"0",
>  		"0b",
> @@ -622,6 +637,10 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return h264_fp_arrangement_type;
>  	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
>  		return h264_fmo_map_type;
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
> +		return mpeg_mpeg2_level;
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
> +		return mpeg2_profile;
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
>  		return mpeg_mpeg4_level;
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
> @@ -828,6 +847,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
>  								return "H264 Constrained Intra Pred";
>  	case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:	return "H264 Chroma QP Index Offset";
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:			return "MPEG2 Level";
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:			return "MPEG2 Profile";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:		return "MPEG4 I-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:		return "MPEG4 P-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:		return "MPEG4 B-Frame QP Value";
> @@ -1192,6 +1213,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
>  	case V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE:
>  	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
> +	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
>  	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
>  	case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 78816ec88751..ec2832f88f4f 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -704,6 +704,22 @@ enum v4l2_cid_mpeg_video_hevc_size_of_length_field {
>  #define V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_BR	(V4L2_CID_MPEG_BASE + 642)
>  #define V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES	(V4L2_CID_MPEG_BASE + 643)
>  #define V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR	(V4L2_CID_MPEG_BASE + 644)
> +#define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_MPEG_BASE + 645)

The codec controls are grouped per codec, so it is not a good idea to add
the MPEG2-specific controls to the HEVC controls. I suggest starting a new
MPEG2 group at (V4L2_CID_MPEG_BASE + 270).

Unless you expect many more MPEG2 specific controls? The range 290-299 is
reserved for the FWHT codec, so if we start at 270, then that leaves room
for 20 controls.

Regards,

	Hans

> +enum v4l2_mpeg_video_mpeg2_level {
> +	V4L2_MPEG_VIDEO_MPEG2_LEVEL_LOW		= 0,
> +	V4L2_MPEG_VIDEO_MPEG2_LEVEL_MAIN	= 1,
> +	V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH_1440	= 2,
> +	V4L2_MPEG_VIDEO_MPEG2_LEVEL_HIGH	= 3,
> +};
> +#define V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE		(V4L2_CID_MPEG_BASE + 646)
> +enum v4l2_mpeg_video_mpeg2_profile {
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SIMPLE				= 0,
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_MAIN				= 1,
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SNR_SCALABLE			= 2,
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_SPATIALLY_SCALABLE		= 3,
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_HIGH				= 4,
> +	V4L2_MPEG_VIDEO_MPEG2_PROFILE_MULTIVIEW				= 5,
> +};
>  
>  /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
>  #define V4L2_CID_MPEG_CX2341X_BASE				(V4L2_CTRL_CLASS_MPEG | 0x1000)
> 

