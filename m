Return-Path: <SRS0=gA2F=S4=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2AEC43219
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C4206E0
	for <linux-media@archiver.kernel.org>; Fri, 26 Apr 2019 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDZQ7R (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:59:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDZQ7Q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 26 Apr 2019 12:59:16 -0400
Received: from [IPv6:2804:214:82b9:c466:36a8:60fb:3e79:2f43] (unknown [IPv6:2804:214:82b9:c466:36a8:60fb:3e79:2f43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 46C56281F8A;
        Fri, 26 Apr 2019 17:59:10 +0100 (BST)
Subject: Re: [PATCH v4 10/14] media: vimc: Add and use new struct vimc_frame
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, kernel@collabora.com,
        lucmaga@gmail.com, lkcamp@lists.libreplanetbr.org
References: <20190426012223.17826-1-andrealmeid@collabora.com>
 <20190426012223.17826-11-andrealmeid@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 mQINBFmOMD4BEADb2nC8Oeyvklh+ataw2u/3mrl+hIHL4WSWtii4VxCapl9+zILuxFDrxw1p
 XgF3cfx7g9taWBrmLE9VEPwJA6MxaVnQuDL3GXxTxO/gqnOFgT3jT+skAt6qMvoWnhgurMGH
 wRaA3dO4cFrDlLsZIdDywTYcy7V2bou81ItR5Ed6c5UVX7uTTzeiD/tUi8oIf0XN4takyFuV
 Rf09nOhi24bn9fFN5xWHJooFaFf/k2Y+5UTkofANUp8nn4jhBUrIr6glOtmE0VT4pZMMLT63
 hyRB+/s7b1zkOofUGW5LxUg+wqJXZcOAvjocqSq3VVHcgyxdm+Nv0g9Hdqo8bQHC2KBK86VK
 vB+R7tfv7NxVhG1sTW3CQ4gZb0ZugIWS32Mnr+V+0pxci7QpV3jrtVp5W2GA5HlXkOyC6C7H
 Ao7YhogtvFehnlUdG8NrkC3HhCTF8+nb08yGMVI4mMZ9v/KoIXKC6vT0Ykz434ed9Oc9pDow
 VUqaKi3ey96QczfE4NI029bmtCY4b5fucaB/aVqWYRH98Jh8oIQVwbt+pY7cL5PxS7dQ/Zuz
 6yheqDsUGLev1O3E4R8RZ8jPcfCermL0txvoXXIA56t4ZjuHVcWEe2ERhLHFGq5Zw7KC6u12
 kJoiZ6WDBYo4Dp+Gd7a81/WsA33Po0j3tk/8BWoiJCrjXzhtRwARAQABtCdIZWxlbiBLb2lr
 ZSA8aGVsZW4ua29pa2VAY29sbGFib3JhLmNvbT6JAlQEEwEKAD4CGwEFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSofQA6zrItXEgHWTzAfqwo9yFiXQUCXEz3bwUJBKaPRQAKCRDAfqwo
 9yFiXdUCD/4+WZr503hQ13KB4DijOW76ju8JDPp4p++qoPxtoAsld3yROoTI+VPWmt7ojHrr
 TZc7sTLxOFzaUC8HjGTb3r9ilIhIKf/M9KRLkpIJ+iLA+VoUbcSOMYWoVNfgLmbnqoezjPcy
 OHJwVw9dzEeYpvG6nkY6E4UktANySp27AniSXNuHOvYsOsXmUOqU1ScdsrQ9s732p/OGdTyw
 1yd3gUMLZvCKFOBVHILH59HCRJgpwUPiws8G4dGMs4GTRvHT2s2mDQdQ0HEvcM9rvCRVixuC
 5ZeOymZNi6lDIUIysgiZ+yzk6i5l/Ni6r7v20N3JppZvhPK6LqtaYceyAGyc3jjnOqoHT/qR
 kPjCwzmKiPtXjLw6HbRXtGgGtP5m3y8v6bfHH+66zd2vGCY0Z9EsqcnK4DCqRkLncFLPM2gn
 9cZcCmO4ZqXUhTyn1nHM494kd5NX1Op4HO+t9ErnpufkVjoMUeBwESdQwwwHT3rjUueGmCrn
 VJK69/qhA4La72VTxHutl+3Z0Xy20HWsZS8Gsam39f95/LtPLzbBwnOOi5ZoXnm97tF8HrAZ
 2h+kcRLMWw3BXy5q4gic+oFZMZP9oq1G9XTFld4FGgJ9ys8aGmhLM+uB1pFxb3XFtWQ2z4AJ
 iEp2VLl34quwfD6Gg4csiZe2KzvQHUe0w8SJ9LplrHPPprkCDQRZjjChARAAzISLQaHzaDOv
 ZxcoCNBk/hUGo2/gsmBW4KSj73pkStZ+pm3Yv2CRtOD4jBlycXjzhwBV7/70ZMH70/Y25dJa
 CnJKl/Y76dPPn2LDWrG/4EkqUzoJkhRIYFUTpkPdaVYznqLgsho19j7HpEbAum8r3jemYBE1
 AIuVGg4bqY3UkvuHWLVRMuaHZNy55aYwnUvd46E64JH7O990mr6t/nu2a1aJ0BDdi8HZ0RMo
 Eg76Avah+YR9fZrhDFmBQSL+mcCVWEbdiOzHmGYFoToqzM52wsNEpo2aStH9KLk8zrCXGx68
 ohJyQoALX4sS03RIWh1jFjnlw2FCbEdj/HDX0+U0i9COtanm54arYXiBTnAnx0F7LW7pv7sb
 6tKMxsMLmprP/nWyV5AfFRi3jxs5tdwtDDk/ny8WH6KWeLR/zWDwpYgnXLBCdg8l97xUoPQO
 0VkKSa4JEXUZWZx9q6kICzFGsuqApqf9gIFJZwUmirsxH80Fe04Tv+IqIAW7/djYpOqGjSyk
 oaEVNacwLLgZr+/j69/1ZwlbS8K+ChCtyBV4kEPzltSRZ4eU19v6sDND1JSTK9KSDtCcCcAt
 VGFlr4aE00AD/aOkHSylc93nPinBFO4AGhcs4WypZ3GGV6vGWCpJy9svfWsUDhSwI7GS/i/v
 UQ1+bswyYEY1Q3DjJqT7fXcAEQEAAYkEcgQYAQoAJgIbAhYhBKh9ADrOsi1cSAdZPMB+rCj3
 IWJdBQJcTPfVBQkEpo7hAkDBdCAEGQEKAB0WIQSomGMEg78Cd/pMshveCRfNeJ05lgUCWY4w
 oQAKCRDeCRfNeJ05lp0gD/49i95kPKjpgjUbYeidjaWuINXMCA171KyaBAp+Jp2Qrun4sIJB
 Z6srMj6O/gC34AhZln2sXeQdxe88sNbg6HjlN+4AkhTd6DttjOfUwnamLDA7uw+YIapGgsgN
 lznjLnqOaQ9mtEwRbZMUOdyRf9osSuL14vHl4ia3bYNJ52WYre6gLMu4K+Ghd02og+ILgIio
 Q827h0spqIJYHrR3Ynnhxdlv5GPCobh+AKsQMdTIuCzR6JSCBk6GHkg33SiWScKMUzT8B/cn
 ypLfGnfV/LDZ9wS2TMzIlK/uv0Vd4C0OGDd/GCi5Gwu/Ot0aY7fzZo2CiRV+/nJBWPRRBTji
 bE4FG2rt7WSRLO/QmH2meIW4f0USDiHeNwznHkPei59vRdlMyQdsxrmgSRDuX9Y3UkERxbgd
 uscqC8Cpcy5kpF11EW91J8aGpcxASc+5Pa66/+7CrpBC2DnfcfACdMAje7yeMn9XlHrqXNlQ
 GaglEcnGN2qVqRcKgcjJX+ur8l56BVpBPFYQYkYkIdQAuhlPylxOvsMcqI6VoEWNt0iFF3dA
 //0MNb8fEqw5TlxDPOt6BDhDKowkxOGIA9LOcF4PkaR9Qkvwo2P4vA/8fhCnMqlSPom4xYdk
 Ev8P554zDoL/XMHl+s7A0MjIJzT253ejZKlWeO68pAbNy/z7QRn2lFDnjwkQwH6sKPchYl2f
 0g//Yu3vDkqk8+mi2letP3XBl2hjv2eCZjTh34VvtgY5oeL2ROSJWNd18+7O6q3hECZ727EW
 gIb3LK9g4mKF6+Rch6Gwz1Y4fmC5554fd2Y2XbVzzz6AGUC6Y+ohNg7lTAVO4wu43+IyTB8u
 ip5rX/JDGFv7Y1sl6tQJKAVIKAJE+Z3Ncqh3doQr9wWHl0UiQYKbSR9HpH1lmC1C3EEbTpwK
 fUIpZd1eQNyNJl1jHsZZIBYFsAfVNH/u6lB1TU+9bSOsV5SepdIb88d0fm3oZ4KzjhRHLFQF
 RwNUNn3ha6x4fbxYcwbvu5ZCiiX6yRTPoage/LUNkgQNX2PtPcur6CdxK6Pqm8EAI7PmYLfN
 NY3y01XhKNRvaVZoH2FugfUkhsBITglTIpI+n6YU06nDAcbeINFo67TSE0iL6Pek5a6gUQQC
 6w+hJCaMr8KYud0q3ccHyU3TlAPDe10En3GsVz7Y5Sa3ODGdbmkfjK8Af3ogGNBVmpV16Xl8
 4rETFv7POSUB2eMtbpmBopd+wKqHCwUEy3fx1zDbM9mp+pcDoL73rRZmlgmNfW/4o4qBzxRf
 FYTQLE69wAFU2IFce9PjtUAlBdC+6r3X24h3uD+EC37s/vWhxuKj2glaU9ONrVJ/SPvlqXOO
 WR1Zqw57vHMKimLdG3c24l8PkSw1usudgAA5OyO5Ag0EWY4wyQEQAMVp0U38Le7d80Mu6AT+
 1dMes87iKn30TdMuLvSg2uYqJ1T2riRBF7zU6u74HF6zps0rPQviBXOgoSuKa1hnS6OwFb9x
 yQPlk76LY96SUB5jPWJ3fO78ZGSwkVbJFuG9gpD/41n8Unn1hXgDb2gUaxD0oXv/723EmTYC
 vSo3z6Y8A2aBQNr+PyhQAPDazvVQ+P7vnZYq1oK0w+D7aIix/Bp4mo4VbgAeAeMxXWSZs8N5
 NQtXeTBgB7DqrfJP5wWwgCsROfeds6EoddcYgqhG0zVU9E54C8JcPOA0wKVs+9+gt2eyRNtx
 0UhFbah7qXuJGhWy/0CLXvVoCoS+7qpWz070TBAlPZrg9D0o2gOw01trQgoKAYBKKgJhxaX/
 4gzi+5Ccm33LYH9lAVTdzdorejuV1xWdsnNyc8OAPeoXBf9RIIWfQVmbhVXBp2DAPjV6/kIJ
 Eml7MNJfEvqjV9zKsWF9AFlsqDWZDCyUdqR96ahTSD34pRwb6a9H99/GrjeowKaaL95DIVZT
 C6STvDNL6kpys4sOe2AMmQGv2MMcJB3aYLzH8f1sEQ9S0UMX7/6CifEG6JodG6Y/W/lLo1Vv
 DxeDA+u4Lgq6qxlksp8M78FjcmxFVlf4cpCi2ucbZxurhlBkjtZZ8MVAEde3hlqjcBl2Ah6Q
 D826FTxscOGlHEfNABEBAAGJAjwEGAEKACYCGwwWIQSofQA6zrItXEgHWTzAfqwo9yFiXQUC
 XEz31QUJBKaOuQAKCRDAfqwo9yFiXUvnEACBWe8wSnIvSX+9k4LxuLq6GQTOt+RNfliZQkCW
 5lT3KL1IJyzzOm4x+/slHRBl8bF7KEZyOPinXQXyJ/vgIdgSYxDqoZ7YZn3SvuNe4aT6kGwL
 EYYEV8Ecj4ets15FR2jSUNnVv5YHWtZ7bP/oUzr2LT54fjRcstYxgwzoj8AREtHQ4EJWAWCO
 ZuEHTSm5clMFoi41CmG4DlJbzbo4YfilKYm69vwh50Y8WebcRN31jh0g8ufjOJnBldYYBLwN
 Obymhlfy/HKBDIbyCGBuwYoAkoJ6LR/cqzl/FuhwhuDocCGlXyYaJOwXgHaCvVXI3PLQPxWZ
 +vPsD+TSVHc9m/YWrOiYDnZn6aO0Uk1Zv/m9+BBkWAwsreLJ/evn3SsJV1omNBTITG+uxXcf
 JkgmmesIAw8mpI6EeLmReUJLasz8QkzhZIC7t5rGlQI94GQG3Jg2dC+kpaGWOaT5G4FVMcBj
 iR1nXfMxENVYnM5ag7mBZyD/kru5W1Uj34L6AFaDMXFPwedSCpzzqUiHb0f+nYkfOodf5xy0
 46+3THy/NUS/ZZp/rI4F7Y77+MQPVg7vARfHHX1AxYUKfRVW5j88QUB70txn8Vgi1tDrOr4J
 eD+xr0CvIGa5lKqgQacQtGkpOpJ8zY4ObSvpNubey/qYUE3DCXD0n2Xxk4muTvqlkFpOYA==
Message-ID: <63375ef0-13d4-b5d8-8bef-12007ce1fe2d@collabora.com>
Date:   Fri, 26 Apr 2019 13:59:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426012223.17826-11-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 4/25/19 10:22 PM, André Almeida wrote:
> Struct vimc_frame is intended to hold metadata about a frame,
> such as memory address of a plane, number of planes and size
> of each plane, to better integrated with the multiplanar operations.
> The struct can be also used with singleplanar formats, making the
> implementation of frame manipulation generic for both type of
> formats.
> 
> vimc_fill_frame function fills a vimc_frame structure given a
> pixelformat, height and width. This is done once to avoid recalculations
> and provide enough information to subdevices work with
> the frame.
> 
> Change the return and argument type of process_frame from void* to
> vimc_frame*. Change the frame in subdevices structs from u8* to vimc_frame.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

> ---
> Changes in v4: 
> - Remove unused parameter `bool multiplanar`
> 
> Changes in v3:
> - Refactor vimc_frame struct, now it have fewer fields with the same
> content
> - Refactor vimc_fill_frame to be more simple
> 
> Change in v2:
> - Fix alignment issues
> 
>  drivers/media/platform/vimc/vimc-capture.c  |  6 +--
>  drivers/media/platform/vimc/vimc-common.c   |  8 ++++
>  drivers/media/platform/vimc/vimc-common.h   | 41 +++++++++++++++++++--
>  drivers/media/platform/vimc/vimc-debayer.c  | 33 +++++++++--------
>  drivers/media/platform/vimc/vimc-scaler.c   | 25 +++++++------
>  drivers/media/platform/vimc/vimc-sensor.c   | 18 ++++-----
>  drivers/media/platform/vimc/vimc-streamer.c |  2 +-
>  7 files changed, 89 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
> index 0439a5a008e8..d9dae5b3a0bf 100644
> --- a/drivers/media/platform/vimc/vimc-capture.c
> +++ b/drivers/media/platform/vimc/vimc-capture.c
> @@ -517,8 +517,8 @@ static void vimc_cap_comp_unbind(struct device *comp, struct device *master,
>  	video_unregister_device(&vcap->vdev);
>  }
>  
> -static void *vimc_cap_process_frame(struct vimc_ent_device *ved,
> -				    const void *frame)
> +static struct vimc_frame *vimc_cap_process_frame(struct vimc_ent_device *ved,
> +						 const struct vimc_frame *frame)
>  {
>  	struct vimc_cap_device *vcap = container_of(ved, struct vimc_cap_device,
>  						    ved);
> @@ -547,7 +547,7 @@ static void *vimc_cap_process_frame(struct vimc_ent_device *ved,
>  
>  	vbuf = vb2_plane_vaddr(&vimc_buf->vb2.vb2_buf, 0);
>  
> -	memcpy(vbuf, frame, vcap->format.fmt.pix.sizeimage);
> +	memcpy(vbuf, frame->plane_addr[0], vcap->format.fmt.pix.sizeimage);
>  
>  	/* Set it as ready */
>  	vb2_set_plane_payload(&vimc_buf->vb2.vb2_buf, 0,
> diff --git a/drivers/media/platform/vimc/vimc-common.c b/drivers/media/platform/vimc/vimc-common.c
> index fad7c7c6de93..9bd163ae326c 100644
> --- a/drivers/media/platform/vimc/vimc-common.c
> +++ b/drivers/media/platform/vimc/vimc-common.c
> @@ -380,6 +380,14 @@ int vimc_ent_sd_register(struct vimc_ent_device *ved,
>  }
>  EXPORT_SYMBOL_GPL(vimc_ent_sd_register);
>  
> +void vimc_fill_frame(struct vimc_frame *frame, u32 pixelformat, u32 width,
> +		     u32 height)
> +{
> +	frame->fmt_info = v4l2_format_info(pixelformat);
> +	v4l2_fill_pixfmt_mp(&frame->fmt, pixelformat, width, height);
> +}
> +EXPORT_SYMBOL_GPL(vimc_fill_frame);
> +
>  void vimc_ent_sd_unregister(struct vimc_ent_device *ved, struct v4l2_subdev *sd)
>  {
>  	media_entity_cleanup(ved->ent);
> diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
> index 142ddfa69b3d..ab5eccc95af4 100644
> --- a/drivers/media/platform/vimc/vimc-common.h
> +++ b/drivers/media/platform/vimc/vimc-common.h
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <media/media-device.h>
>  #include <media/v4l2-device.h>
> +#include <media/tpg/v4l2-tpg.h>
>  
>  #include "vimc-streamer.h"
>  
> @@ -79,6 +80,25 @@ struct vimc_platform_data {
>  	char entity_name[32];
>  };
>  
> +/**
> + * struct vimc_frame - metadata about frame components
> + *
> + * @plane_addr:		pointer to kernel address of the plane
> + * @fmt:		pixel format attributes
> + * @fmt_info:		pointer to a struct with pixel format metadata
> + *
> + * This struct helps subdevices to get information about the frame on
> + * multiplanar formats. If a singleplanar format is used, only the first
> + * index of the array is used and num_planes is set to 1, so the
> + * implementation is generic and the code will work for both formats.
> + */
> +
> +struct vimc_frame {
> +	u8 *plane_addr[TPG_MAX_PLANES];
> +	struct v4l2_pix_format_mplane fmt;
> +	const struct v4l2_format_info *fmt_info;
> +};
> +
>  /**
>   * struct vimc_ent_device - core struct that represents a node in the topology
>   *
> @@ -101,10 +121,10 @@ struct vimc_ent_device {
>  	struct media_entity *ent;
>  	struct media_pad *pads;
>  	struct vimc_stream *stream;
> -	void * (*process_frame)(struct vimc_ent_device *ved,
> -				const void *frame);
> +	struct vimc_frame * (*process_frame)(struct vimc_ent_device *ved,
> +				const struct vimc_frame *frame);
>  	void (*vdev_get_format)(struct vimc_ent_device *ved,
> -			      struct v4l2_pix_format *fmt);
> +				struct v4l2_pix_format *fmt);
>  };
>  
>  /**
> @@ -206,4 +226,19 @@ void vimc_ent_sd_unregister(struct vimc_ent_device *ved,
>   */
>  int vimc_link_validate(struct media_link *link);
>  
> +/**
> + * vimc_fill_frame - fills struct vimc_frame
> + *
> + * @frame: pointer to the frame to be filled
> + * @pixelformat: pixelformat fourcc code
> + * @width: width of the image
> + * @height: height of the image
> + *
> + * This function fills the fields of vimc_frame in order to subdevs have
> + * information about the frame being processed, works both for single
> + * and multiplanar pixel formats.
> + */
> +void vimc_fill_frame(struct vimc_frame *frame, u32 pixelformat, u32 width,
> +		     u32 height);
> +
>  #endif
> diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
> index b221f26e01cf..df7b39850632 100644
> --- a/drivers/media/platform/vimc/vimc-debayer.c
> +++ b/drivers/media/platform/vimc/vimc-debayer.c
> @@ -62,7 +62,7 @@ struct vimc_deb_device {
>  	void (*set_rgb_src)(struct vimc_deb_device *vdeb, unsigned int lin,
>  			    unsigned int col, unsigned int rgb[3]);
>  	/* Values calculated when the stream starts */
> -	u8 *src_frame;
> +	struct vimc_frame src_frame;
>  	const struct vimc_deb_pix_map *sink_pix_map;
>  	unsigned int sink_bpp;
>  };
> @@ -325,7 +325,7 @@ static void vimc_deb_set_rgb_pix_rgb24(struct vimc_deb_device *vdeb,
>  
>  	index = VIMC_FRAME_INDEX(lin, col, vdeb->sink_fmt.width, 3);
>  	for (i = 0; i < 3; i++)
> -		vdeb->src_frame[index + i] = rgb[i];
> +		vdeb->src_frame.plane_addr[0][index + i] = rgb[i];
>  }
>  
>  static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
> @@ -335,7 +335,6 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
>  	if (enable) {
>  		u32 src_pixelformat = vdeb->ved.stream->producer_pixfmt;
>  		const struct v4l2_format_info *pix_info;
> -		unsigned int frame_size;
>  
>  		/* We only support translating bayer to RGB24 */
>  		if (src_pixelformat != V4L2_PIX_FMT_RGB24) {
> @@ -354,9 +353,8 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
>  			vdeb->sink_pix_map->pixelformat;
>  
>  		/* Calculate frame_size of the source */
> -		pix_info = v4l2_format_info(src_pixelformat);
> -		frame_size = vdeb->sink_fmt.width * vdeb->sink_fmt.height *
> -			     pix_info->bpp[0];
> +		vimc_fill_frame(&vdeb->src_frame, src_pixelformat,
> +				vdeb->sink_fmt.width, vdeb->sink_fmt.height);
>  
>  		/* Get bpp from the sink */
>  		pix_info = v4l2_format_info(vdeb->sink_pix_map->pixelformat);
> @@ -366,16 +364,18 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
>  		 * Allocate the frame buffer. Use vmalloc to be able to
>  		 * allocate a large amount of memory
>  		 */
> -		vdeb->src_frame = vmalloc(frame_size);
> -		if (!vdeb->src_frame)
> +		vdeb->src_frame.plane_addr[0] =
> +			vmalloc(vdeb->src_frame.fmt.plane_fmt[0].sizeimage);
> +		if (!vdeb->src_frame.plane_addr[0])
>  			return -ENOMEM;
>  
> +
>  	} else {
> -		if (!vdeb->src_frame)
> +		if (!vdeb->src_frame.plane_addr[0])
>  			return 0;
>  
> -		vfree(vdeb->src_frame);
> -		vdeb->src_frame = NULL;
> +		vfree(vdeb->src_frame.plane_addr[0]);
> +		vdeb->src_frame.plane_addr[0] = NULL;
>  	}
>  
>  	return 0;
> @@ -487,8 +487,8 @@ static void vimc_deb_calc_rgb_sink(struct vimc_deb_device *vdeb,
>  	}
>  }
>  
> -static void *vimc_deb_process_frame(struct vimc_ent_device *ved,
> -				    const void *sink_frame)
> +static struct vimc_frame *vimc_deb_process_frame(struct vimc_ent_device *ved,
> +					const struct vimc_frame *sink_frame)
>  {
>  	struct vimc_deb_device *vdeb = container_of(ved, struct vimc_deb_device,
>  						    ved);
> @@ -496,16 +496,17 @@ static void *vimc_deb_process_frame(struct vimc_ent_device *ved,
>  	unsigned int i, j;
>  
>  	/* If the stream in this node is not active, just return */
> -	if (!vdeb->src_frame)
> +	if (!vdeb->src_frame.plane_addr[0])
>  		return ERR_PTR(-EINVAL);
>  
>  	for (i = 0; i < vdeb->sink_fmt.height; i++)
>  		for (j = 0; j < vdeb->sink_fmt.width; j++) {
> -			vimc_deb_calc_rgb_sink(vdeb, sink_frame, i, j, rgb);
> +			vimc_deb_calc_rgb_sink(vdeb, sink_frame->plane_addr[0],
> +					       i, j, rgb);
>  			vdeb->set_rgb_src(vdeb, i, j, rgb);
>  		}
>  
> -	return vdeb->src_frame;
> +	return &vdeb->src_frame;
>  
>  }
>  
> diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
> index 617f2920b86b..f655b8312dc9 100644
> --- a/drivers/media/platform/vimc/vimc-scaler.c
> +++ b/drivers/media/platform/vimc/vimc-scaler.c
> @@ -50,7 +50,7 @@ struct vimc_sca_device {
>  	 */
>  	struct v4l2_mbus_framefmt sink_fmt;
>  	/* Values calculated when the stream starts */
> -	u8 *src_frame;
> +	struct vimc_frame src_frame;
>  	unsigned int src_line_size;
>  	unsigned int bpp;
>  };
> @@ -234,16 +234,16 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
>  		/* Allocate the frame buffer. Use vmalloc to be able to
>  		 * allocate a large amount of memory
>  		 */
> -		vsca->src_frame = vmalloc(frame_size);
> -		if (!vsca->src_frame)
> +		vsca->src_frame.plane_addr[0] = vmalloc(frame_size);
> +		if (!vsca->src_frame.plane_addr[0])
>  			return -ENOMEM;
>  
>  	} else {
> -		if (!vsca->src_frame)
> +		if (!vsca->src_frame.plane_addr[0])
>  			return 0;
>  
> -		vfree(vsca->src_frame);
> -		vsca->src_frame = NULL;
> +		vfree(vsca->src_frame.plane_addr[0]);
> +		vsca->src_frame.plane_addr[0] = NULL;
>  	}
>  
>  	return 0;
> @@ -306,8 +306,9 @@ static void vimc_sca_scale_pix(const struct vimc_sca_device *const vsca,
>  				vsca->sd.name, index + j);
>  
>  			/* copy the pixel to the position index + j */
> -			vimc_sca_fill_pix(&vsca->src_frame[index + j],
> -					  pixel, vsca->bpp);
> +			vimc_sca_fill_pix(
> +				&vsca->src_frame.plane_addr[0][index + j],
> +				pixel, vsca->bpp);
>  		}
>  
>  		/* move the index to the next line */
> @@ -327,8 +328,8 @@ static void vimc_sca_fill_src_frame(const struct vimc_sca_device *const vsca,
>  			vimc_sca_scale_pix(vsca, i, j, sink_frame);
>  }
>  
> -static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
> -				    const void *sink_frame)
> +static struct vimc_frame *vimc_sca_process_frame(struct vimc_ent_device *ved,
> +				    const struct vimc_frame *sink_frame)
>  {
>  	struct vimc_sca_device *vsca = container_of(ved, struct vimc_sca_device,
>  						    ved);
> @@ -337,9 +338,9 @@ static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
>  	if (!ved->stream)
>  		return ERR_PTR(-EINVAL);
>  
> -	vimc_sca_fill_src_frame(vsca, sink_frame);
> +	vimc_sca_fill_src_frame(vsca, sink_frame->plane_addr[0]);
>  
> -	return vsca->src_frame;
> +	return &vsca->src_frame;
>  };
>  
>  static void vimc_sca_release(struct v4l2_subdev *sd)
> diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
> index 1b2b75b27952..3495a3f3dd60 100644
> --- a/drivers/media/platform/vimc/vimc-sensor.c
> +++ b/drivers/media/platform/vimc/vimc-sensor.c
> @@ -36,7 +36,7 @@ struct vimc_sen_device {
>  	struct device *dev;
>  	struct tpg_data tpg;
>  	struct task_struct *kthread_sen;
> -	u8 *frame;
> +	struct vimc_frame frame;
>  	/* The active format */
>  	struct v4l2_mbus_framefmt mbus_format;
>  	struct v4l2_ctrl_handler hdl;
> @@ -177,14 +177,14 @@ static const struct v4l2_subdev_pad_ops vimc_sen_pad_ops = {
>  	.set_fmt		= vimc_sen_set_fmt,
>  };
>  
> -static void *vimc_sen_process_frame(struct vimc_ent_device *ved,
> -				    const void *sink_frame)
> +static struct vimc_frame *vimc_sen_process_frame(struct vimc_ent_device *ved,
> +				    const struct vimc_frame *sink_frame)
>  {
>  	struct vimc_sen_device *vsen = container_of(ved, struct vimc_sen_device,
>  						    ved);
>  
> -	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame);
> -	return vsen->frame;
> +	tpg_fill_plane_buffer(&vsen->tpg, 0, 0, vsen->frame.plane_addr[0]);
> +	return &vsen->frame;
>  }
>  
>  static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
> @@ -206,8 +206,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
>  		 * Allocate the frame buffer. Use vmalloc to be able to
>  		 * allocate a large amount of memory
>  		 */
> -		vsen->frame = vmalloc(frame_size);
> -		if (!vsen->frame)
> +		vsen->frame.plane_addr[0] = vmalloc(frame_size);
> +		if (!vsen->frame.plane_addr[0])
>  			return -ENOMEM;
>  
>  		/* configure the test pattern generator */
> @@ -215,8 +215,8 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
>  
>  	} else {
>  
> -		vfree(vsen->frame);
> -		vsen->frame = NULL;
> +		vfree(vsen->frame.plane_addr[0]);
> +		vsen->frame.plane_addr[0] = NULL;
>  		return 0;
>  	}
>  
> diff --git a/drivers/media/platform/vimc/vimc-streamer.c b/drivers/media/platform/vimc/vimc-streamer.c
> index 26b674259489..216ac8a83ba5 100644
> --- a/drivers/media/platform/vimc/vimc-streamer.c
> +++ b/drivers/media/platform/vimc/vimc-streamer.c
> @@ -125,7 +125,7 @@ static int vimc_streamer_pipeline_init(struct vimc_stream *stream,
>  static int vimc_streamer_thread(void *data)
>  {
>  	struct vimc_stream *stream = data;
> -	u8 *frame = NULL;
> +	struct vimc_frame *frame = NULL;
>  	int i;
>  
>  	set_freezable();
> 
