Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD7C433F5
	for <linux-media@archiver.kernel.org>; Tue, 22 Feb 2022 07:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiBVHrL (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiBVHrH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Feb 2022 02:47:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE6250
        for <linux-media@vger.kernel.org>; Mon, 21 Feb 2022 23:46:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3FCADCE1303
        for <linux-media@vger.kernel.org>; Tue, 22 Feb 2022 07:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A21C340E8;
        Tue, 22 Feb 2022 07:46:32 +0000 (UTC)
Message-ID: <5d5dee88-9dbf-e4d0-4a91-11ff4ecd82ea@xs4all.nl>
Date:   Tue, 22 Feb 2022 08:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Deprecated Maintainer entries?
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     dafna@fastmail.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Helen Fornazier <helen.fornazier@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org
References: <20220222063202.petjwwcfctzsbhxx@basti-TUXEDO-Book-XA1510>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220222063202.petjwwcfctzsbhxx@basti-TUXEDO-Book-XA1510>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The same is true for VIMC where Helen was maintainer. Shuah, would you
be willing to take over VIMC as maintainer? If not, then I can put myself
up there as maintainer (but 'odd fixes' only, probably).

I added a few collabora people to the CC and also Helen's email, although
I don't know if she actively monitors her gmail address.

Thanks for pointing this out, Sebastian.

Regards,

	Hans

On 2/22/22 07:32, Sebastian Fricke wrote:
> Hey folks,
> 
> I noticed that in:
> ```
> ROCKCHIP ISP V1 DRIVER
> M:    Helen Koike <helen.koike@collabora.com>
> M:    Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> L:    linux-media@vger.kernel.org
> L:    linux-rockchip@lists.infradead.org
> S:    Maintained
> F:    Documentation/admin-guide/media/rkisp1.rst
> F:    Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> F:    Documentation/userspace-api/media/v4l/pixfmt-meta-rkisp1.rst
> F:    drivers/media/platform/rockchip/rkisp1
> F:    include/uapi/linux/rkisp1-config.h
> ```
> 
> Both maintainers do not work for Collabora anymore, so they probably
> will not receive any mail on those mail addresses.
> 
> @Dafna: I do not know which mail address Helen currently uses, are you
> aware of any?
> 
> Greetings,
> Sebastian
