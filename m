Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D5C2D0E4
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 08:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB06B24671
	for <linux-media@archiver.kernel.org>; Tue, 17 Nov 2020 08:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX7fe33p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKQIhR (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Nov 2020 03:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKQIhQ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Nov 2020 03:37:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD5C0613CF
        for <linux-media@vger.kernel.org>; Tue, 17 Nov 2020 00:37:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l11so87304plt.1
        for <linux-media@vger.kernel.org>; Tue, 17 Nov 2020 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7cx+r6lAiPhOns5jDhcwlaOMcBrQyb+uVR6aL1R8yaE=;
        b=VX7fe33p9+VVa29UAVtXE/yZlODTu6YhFYmYKBL2yNND3LdniyprukCOH3zAmt5+ab
         6BWEfoSIRqr3AHI52kkstY7s2Ucco0m8uH6GinuRZE6oar3tguCzyIuU1K1Tw6V9Ppa+
         8V9KkJt6ZBLiDmkeghNBLhCnGFf3jDTVhYdEYeVJKgPedcaFzUnozi9L9t8/P7D59lhC
         Y+yT0VExcJ//JiDfN5NpuMNokkDyoWlk1rLVhmCKD8rzN3iXy0UzLH+vKmZVHqjXiUWA
         AqbGUJcIHBj3vkW4nnasjOfCRCx8IygDnwtFTnTw5VrOMVnefJ+5VM3CRw7MMuLbSOra
         CHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7cx+r6lAiPhOns5jDhcwlaOMcBrQyb+uVR6aL1R8yaE=;
        b=dXx1GJAzfZh3MGnnhapAVRg0c3/SUG/AKIjKBifTI1CAoLAVmYOBDk8N4VcQ9Qwvc1
         e7izEHjhsHylU4M4S3FdVBqYYkNra0dKlqg2WlsdPzBt8G0P+mtbFPFGLUbaUoerFxNc
         HpNXQLHcJZHtVX2M9Km4+7sK+YvHxlc8cm+XBxIFaqXn/U1S4BGiz8MV2Jq+MgGnSqyr
         ui2tMtwpRTbALw/RmrJ08rujuRzfBHCCBPeocEvwgbWEKoemC/c9Rxb4m7nZlPp+K7C4
         HJZBpHRWGL108/EaISoXRcByKDx0ESVth8ccLP8vIS270r2kH+qyHieHl7yBgcb+Kqcu
         8S4A==
X-Gm-Message-State: AOAM531wfRQ/Bz/ulLtPK55VpmkrzMrGFxAL36QYOCM+316qqy5LzIlh
        FPHyrfVRJUoGqCsZcs+eAf4=
X-Google-Smtp-Source: ABdhPJweLNkceyoJEk6cbUkcHJH8pykR1stKbOb/2HWmt/n9U4BgRhI01TPfawcbWy/RFkbrAKsT/w==
X-Received: by 2002:a17:90b:e08:: with SMTP id ge8mr3623868pjb.29.1605602236103;
        Tue, 17 Nov 2020 00:37:16 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id gm24sm2272997pjb.20.2020.11.17.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:37:15 -0800 (PST)
Date:   Tue, 17 Nov 2020 17:37:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, senozhatsky@chromium.org,
        tfiga@chromium.org, bingbu.cao@linux.intel.com,
        tian.shu.qiu@intel.com
Subject: Re: [PATCH] media: i2c: Add ov9734 image sensor driver
Message-ID: <X7OLuFejNyAPJEfB@jagdpanzerIV.localdomain>
References: <1603940341-25224-1-git-send-email-bingbu.cao@intel.com>
 <X7OEysbnAhTXEmUq@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7OEysbnAhTXEmUq@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On (20/11/17 17:07), Sergey Senozhatsky wrote:
> > +static int ov9734_set_stream(struct v4l2_subdev *sd, int enable)
> > +{
> > +	struct ov9734 *ov9734 = to_ov9734(sd);
> > +	struct i2c_client *client = v4l2_get_subdevdata(sd);
> > +	int ret = 0;
> > +
> > +	if (ov9734->streaming == enable)
> > +		return 0;
> > +
> > +	mutex_lock(&ov9734->mutex);
> > +	if (enable) {
> > +		ret = pm_runtime_get_sync(&client->dev);
> > +		if (ret < 0) {
> > +			pm_runtime_put_noidle(&client->dev);
> > +			mutex_unlock(&ov9734->mutex);
> > +			return ret;
> > +		}
> > +
> > +		ret = ov9734_start_streaming(ov9734);
> > +		if (ret) {
> > +			enable = 0;
> > +			ov9734_stop_streaming(ov9734);
> > +			pm_runtime_put(&client->dev);
> > +		}
> > +	} else {
> > +		ov9734_stop_streaming(ov9734);
> > +		pm_runtime_put(&client->dev);
> > +	}
> 
> I assume that we will never see erroneous ->s_stream(0) calls or
>  ->s_stream(0) after unsuccessful ->s_stream(1). Otherwise we will
> do extra pm_runtime_put(), not matched by pm_runtime_get().

Oh, no. There is (unprotected) if (ov9734->streaming) check
at the very top, so we are probably fine.

	-ss
