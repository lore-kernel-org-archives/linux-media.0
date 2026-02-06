Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848883E8C51
	for <linux-media@vger.kernel.org>; Fri,  6 Feb 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385170; cv=none; b=etmE0Xh36LRHW38j/vcrg98DUlr7I6bejd96S4jVVZFKjuHAtgn2tT52Rui0mRSFF8Qq+MqvmcEnvKdIT07La7tpGZRcqeKvn9vgr31kFfikX0C/JaFn8jeDUryuilB6+QVQgwAJG1Lnr2w7dGEqCxFEon7LIFFL0n8Ld8/fD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385170; c=relaxed/simple;
	bh=VAi/DliN2PqkeWyB69lo4z+vs40QemwOf98Sx+YRLpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/wGbKFdt1+T2yHVUo4I5MhS37R+CH77JbnFx5dNUAC0udxaTqzFZp8tc4qn3ZXYBTr6rwNp7MIzAfv1KvGJayvBw+NilZg1vbjvqvEBkDjMs6h02MpxspwkIvOitPRU+WQds6fo5hzYs0qX+Q13SomPT3eMy3EM3VZHuALJg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPML3bfX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPML3bfX"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso8140715e9.0
        for <linux-media@vger.kernel.org>; Fri, 06 Feb 2026 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385169; x=1770989969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgkdoioUU+RhOWyr0UvEiFmF3wCxL0ED61NZyLKRXMw=;
        b=TPML3bfXdtYHFsnApsvT7P5rc3Nalnewd4XCDgxZRL/8Zl+iJeyk/KBLAZ1Td7MV53
         pCnxueXHtKEVBHle/0gio7D2471h8RV63s+oiNgV3YEkqxV+HKckGce5k3EsVMT8LMJ8
         a0EONFo6dwmIwBC0t110P4aIvqVB8+S1V3cWG+olzHGD1lK157TS0ausuyXZ7GrdDpGQ
         F74VNpLWzmlzExeR2ZgDkJUfuaV/HCcEXIzy0Ni5umEnKFvWtjnBT8dVnBGpIO45UGoi
         tDonxQqSU9PAS+dpP3vpT7jJi3SGiQYGUChqBkW4ecf9ojDmT+OYA2v9nGFV5tAtz/GP
         WEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385169; x=1770989969;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgkdoioUU+RhOWyr0UvEiFmF3wCxL0ED61NZyLKRXMw=;
        b=r297y1Qw8FbwHAoQWly8FfdB8nxaetHT+4ENDPThTDNyDsgP9MisyEjbW9jS1Z8bc0
         i12V5gv1BG1dZ03+fvPLJOOrum7SIycyjWETtz4AcmrGkdrSxPsULS8GPUeG0Hz/IS6D
         gcddkz9kNNYTGRtcSV2W2kaW1xUfJP6gJUw44OY6B7ob5pCiAucAqjkRxZh3qYG3pLVD
         nOHaFaVcWYhZheLf834I9Sk39+BUGcZpNz22dVPdE+xpZpnSeFLo2tyajc+EBncIduzj
         BgJxH8oZqumSdVfawpsviwr9Z2PhmcKh3pCAocFuU1+KjZhG863aOUkkUW9Qi2ubGBWR
         PzPQ==
X-Gm-Message-State: AOJu0Yxw08fp9S4PlQmihP9w74PJSGwgL1NJ9XkHk/qXzcQcYBoDIT2z
	2GPnlWpeAfsvY95OPqWFMZRsJ9RO+TXK/u32cQTrMw7EHoO0EUfynFORyG1zA/YiE1o=
X-Gm-Gg: AZuq6aKm1ZnGukqdw7p65wDv2K2XDmrzZg8NUOof7zXhUL205d1wq2OVhaW46e/+SUV
	4cV/O3EVQHIjYVQqs3876iw9Dr0NgtIjvgSU5G06sar5x+12QFHfSSmWBoDvAae/LVvGNvdPidl
	eKCwSdZ7qjET2za4LHJePmPoW4EJCLkcMA/v+6Ypp8WDW0nVpPMSJsH1QQdNq1iBzSRJBXZH2Mu
	4McTwDfayqezaio8lIw7GqcvRc2rUexlgGfSsKY6tbaxHD4OIAplgWF95ZR5EuRbvWWQD8p8FtL
	38H1WSFMQoTff465ligT57rHAZkYzUoz2N1CTsTrM0mhM4IZYnIZqnM3Owk8FiKqo/XWJh9gpNh
	QV1Kvpuhx7pxDdmpLEiZSSDP+vxwQfwCcs23XY7fuTIuF5XFqL+Z1/HhTCVqtq8TcYHxLUUMFEU
	l4UZiEbEisuh536ODB
X-Received: by 2002:a05:600c:3f12:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-483201e476emr39967365e9.12.1770385168829;
        Fri, 06 Feb 2026 05:39:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm192988315e9.10.2026.02.06.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:39:28 -0800 (PST)
Date: Fri, 6 Feb 2026 16:39:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] media: rockchip: rkcif: add support for rk3568 vicap
 mipi capture
Message-ID: <aYXvDURNPu_5NILk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Michael Riesch,

Commit 1f2353f5a1af ("media: rockchip: rkcif: add support for rk3568
vicap mipi capture") from Nov 14, 2025 (linux-next), leads to the
following Smatch static checker warning:

drivers/media/platform/rockchip/rkcif/rkcif-capture-mipi.c:519 rkcif_mipi_id_get_reg()
index hardmax out of bounds 'rkcif->match_data->mipi->regs_id[id]' size=4 max='4' rl='0-u32max'

drivers/media/platform/rockchip/rkcif/rkcif-capture-mipi.c:519 rkcif_mipi_id_get_reg()
index hardmax out of bounds 'rkcif->match_data->mipi->regs_id[id][index]' size=11 max='11' rl='0-11'

drivers/media/platform/rockchip/rkcif/rkcif-capture-mipi.c
    504 static inline unsigned int rkcif_mipi_id_get_reg(struct rkcif_stream *stream,
    505                                                  unsigned int index)
    506 {
    507         struct rkcif_device *rkcif = stream->rkcif;
    508         unsigned int block, id, offset, reg;
    509 
    510         block = stream->interface->index - RKCIF_MIPI_BASE;
    511         id = stream->id;
    512 
    513         if (WARN_ON_ONCE(block > RKCIF_MIPI_MAX - RKCIF_MIPI_BASE) ||
    514             WARN_ON_ONCE(id > RKCIF_ID_MAX) ||
    515             WARN_ON_ONCE(index > RKCIF_MIPI_ID_REGISTER_MAX))


The id and index checks should be >=.  Not sure about block but I assume
it's off by one as well.

    516                 return RKCIF_REGISTER_NOTSUPPORTED;
    517 
    518         offset = rkcif->match_data->mipi->blocks[block].offset;
--> 519         reg = rkcif->match_data->mipi->regs_id[id][index];
    520         if (reg == RKCIF_REGISTER_NOTSUPPORTED)
    521                 return reg;
    522 
    523         return offset + reg;
    524 }

regards,
dan carpenter
