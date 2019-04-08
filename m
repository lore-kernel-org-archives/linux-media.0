Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BEC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142E1214C6
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfb9hTXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDHNVo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:21:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35375 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDHNVo (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 09:21:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so11253110ljc.2
        for <linux-media@vger.kernel.org>; Mon, 08 Apr 2019 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/d0MMjIMGPKImoadGCpBguJOSKJB40ti3rzTa7xOU9c=;
        b=Zfb9hTXRmC9TqBufoPaiBCios5d8AysEbS1eMZ+ux/BUzdcj7A+kahKOZvaiMCD2Z0
         Y4gJQ8qNVRWqWBfZchn6X+HbDpmrsl9VU1yXFnExF4C9GpfVPEErpH5ExIvGwn6/RVFp
         C2bS4gc+TAfbqkk0Knusm21kbzlo0OIh9WdNVAD2BcXU+NT0cA+m/T9ZBYG3xQH15/EW
         z3l6NBwjxhcRCJSdLPqKjgUkOpqHHD+aKKyAzpDGcmvDLG4TvcxaUVepE4kuEWr+B4iR
         8yC8z6Rm3Gp/RWVdT+O8qLUPnzdcD7r/L7zGKbubm7ZQd5rOhJtwhafLPgWH09K+BaAA
         9BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/d0MMjIMGPKImoadGCpBguJOSKJB40ti3rzTa7xOU9c=;
        b=fpT64MI87aML6PHm/vl8DtB4AsyXaZaCfQejMs3M9nDpTit6lkXONfnlbQ/YkXsoSr
         EaIhBp9O6GFQwT0nhJ3Iub20eb7TVnH6I/hkvZ+rHqznwlSsUyIRYvDbji1wSuh4R++0
         QXcIUndRr+Cbx+DcZdVN3g0kVkVsz5Dd9Fs0FMz7PeQVmGxWvQYu8z4n4129epNDwhS+
         R4JWAqaZAuLTb2I2eYV2K8nopeqs5LslhIvo4fYeiVsdBfm1siZl3kXn5uN9FU22s6Mx
         Pfs2dzghIzpAl6e7xbfT1Z1rIL1Bj5J/RHqomDhUTBZ0BIm0uXsLF5Le7uP33kbxFF27
         7AzQ==
X-Gm-Message-State: APjAAAUd6WRhGPfFUaT2cVPFeWk1ShgYVJBo/pAu+XQ49wFtYZU2LinJ
        AQc0k0/yasMnTOMHYsUWZow=
X-Google-Smtp-Source: APXvYqx+tFkQDA1nJgzEUhSl2YFoYg98qKQdsVsPgV/HJFKnTqm6zyUIehqB0QX+7nEFgyPXi6whSg==
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr15435609ljf.95.1554729702219;
        Mon, 08 Apr 2019 06:21:42 -0700 (PDT)
Received: from Ettosoft-T55 (94-255-191-177.cust.bredband2.com. [94.255.191.177])
        by smtp.gmail.com with ESMTPSA id k10sm6423501ljh.86.2019.04.08.06.21.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 06:21:41 -0700 (PDT)
Date:   Mon, 8 Apr 2019 15:21:40 +0200
From:   Ettore Chimenti <ek5.chimenti@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH 6/7] seco-cec: decrement HDMI device refcount
Message-ID: <20190408132138.GA8314@Ettosoft-T55>
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
 <20190408110401.3345-7-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408110401.3345-7-hverkuil-cisco@xs4all.nl>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 08, 2019 at 01:04:00PM +0200, Hans Verkuil wrote:
> The SECO CEC driver never decremented the HDMI device refcount.
> CEC drivers only need the HDMI device pointer as a key in the
> notifier list, it never accesses the device, so there is no
> need to keep a reference.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Acked-by: Ettore Chimenti <ek5.chimenti@gmail.com>

Thanks,
Ettore

> ---
>  drivers/media/platform/seco-cec/seco-cec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
> index a425a10540c1..e5080d6f5b2d 100644
> --- a/drivers/media/platform/seco-cec/seco-cec.c
> +++ b/drivers/media/platform/seco-cec/seco-cec.c
> @@ -536,6 +536,7 @@ static int secocec_cec_get_notifier(struct cec_notifier **notify)
>  				return -EPROBE_DEFER;
>  
>  			*notify = cec_notifier_get_conn(d, m->conn);
> +			put_device(d);
>  
>  			return 0;
>  		}
> -- 
> 2.20.1
> 

