Return-Path: <SRS0=TZ7q=3Z=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BCAC35247
	for <linux-media@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08F921741
	for <linux-media@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580930620;
	bh=u2UIn7F+9QuQQyPEXQ+hPn66a/4sZE4MOJ97XcYdzrk=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=oWmR8VXS5ov/Bzl1XyFfiaXJAV8FfA72XFIo8GGwzJBwhW5Z/vpyNQMrB60dpVc8H
	 vNQBTRNNlEC5TB0hFsUOwSQ1+VETiW7xkKlXq97Op+2JFTM+zittR0jAb64iKF6J6V
	 VElm8SEuw7IWYXVBqt2t6iS6SGDcUYQmBIv0G8hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBETXh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBETXh (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 5 Feb 2020 14:23:37 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923B72072B;
        Wed,  5 Feb 2020 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580930616;
        bh=u2UIn7F+9QuQQyPEXQ+hPn66a/4sZE4MOJ97XcYdzrk=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=FJ1MCrdI1mNYYExkWaWxASa0jTixCeY/Myz3thcYyCHss/2HeB2LIsFuRuo85/Sq0
         FbLViC0gDI/PdgSxcZ5MoGJs8Lmds4CDdW/uQDh9SgP0GHbeDXsNxrTb/ewB8IhVtG
         YGammme3f5t04VhnbQIWlQN/gEsvdWSdR4E1knPs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580235801-4129-2-git-send-email-skomatineni@nvidia.com>
References: <1580235801-4129-1-git-send-email-skomatineni@nvidia.com> <1580235801-4129-2-git-send-email-skomatineni@nvidia.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v1 1/5] dt-bindings: clock: tegra: Add clk id for CSI TPG clock
To:     frankc@nvidia.com, hverkuil@xs4all.nl, jonathanh@nvidia.com,
        skomatineni@nvidia.com, thierry.reding@gmail.com
User-Agent: alot/0.8.1
Date:   Wed, 05 Feb 2020 11:23:35 -0800
Message-Id: <20200205192336.923B72072B@mail.kernel.org>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Quoting Sowjanya Komatineni (2020-01-28 10:23:17)
> Tegra210 uses PLLD out internally for CSI TPG.
>=20
> This patch adds clk id for this CSI TPG clock from PLLD.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

