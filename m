Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1833EC433EF
	for <linux-media@archiver.kernel.org>; Wed, 29 Jun 2022 14:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiF2OyF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 29 Jun 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiF2OyD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 29 Jun 2022 10:54:03 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4924F1F
        for <linux-media@vger.kernel.org>; Wed, 29 Jun 2022 07:54:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1656514439; x=1656773639;
        bh=jgx5qL+qt7rskFGOjzbeoMeHSUpyUNBp4rUtF20noHY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=RvNY50jFfbWs6i3uWd6/n0DzDoh2xDnOYu0beLZt6sSTpsrB8MWCVVUgJTJom3Uwl
         WZ7ChuCxhpQkJE7GZc7HXyRnMAFb79ayGeHojQ06SA6mjh/lHqBKxQIVTskjkus9O0
         nCgyQ1erYSfQy6UbK0XNLy2X6BVi5XBJ1gBCxO8Qw8oYnkCKjY7WVcuj+g804g7Twq
         kERswDzm7RZkCejmB7BhqCqq2QXFwnEuwWw3BVA6iWGbbYpYQ0l6mf7NwPKLagYmoR
         qL+oHWowC28FhXSArbHOnULpcuaeTAGnQZLFb5mHrwM9rvLCCihxdaqgX8tN99TWYp
         2XSKslO0Pmgng==
To:     Dennis Tsiang <dennis.tsiang@arm.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Normunds Rieksts <Normunds.Rieksts@arm.com>, airlied@linux.ie,
        tzimmermann@suse.de, Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        david.harvey-macaulay@arm.com, Lisa Wu <lisa.wu@arm.com>,
        nd <nd@arm.com>, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned R16_UINT/RG1616_UINT formats
Message-ID: <o1qcCo8e19pmmNe-YJbPkmu4SBrOQ_E3u7eqdrcXUzdBccLtFswL_ARTpbrX9C10tippuy5ieXAsqdf7H47JuT7Hqa1NlizAPqVuRM0kRt4=@emersion.fr>
In-Reply-To: <05513f59-0bd9-77cd-36d4-41027bc339be@arm.com>
References: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com> <20220627175026.6a5dd239@eldfell> <05513f59-0bd9-77cd-36d4-41027bc339be@arm.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wednesday, June 29th, 2022 at 16:46, Dennis Tsiang <dennis.tsiang@arm.co=
m> wrote:

> Thanks for your comments. This is not intended to be used for KMS, where
> indeed there would be no difference. This proposal is for other Graphics
> APIs such as Vulkan, which requires the application to be explicit
> upfront about how they will interpret the data, whether that be UNORM,
> UINT .etc. We want to be able to import dma_bufs which create a VkImage
> with a "_UINT" VkFormat. However there is currently no explicit mapping
> between the DRM fourccs + modifiers combos to "_UINT" VkFormats. One
> solution is to encode that into the fourccs, which is what this RFC is
> proposing.

As a general comment, I don't think it's reasonable to encode all of the
VkFormat information inside DRM FourCC. For instance, VkFormat has SRGB/UNO=
RM
variants which describe whether pixel values are electrical or optical
(IOW, EOTF-encoded or not). Moreover, other APIs may encode different
information in their format enums.
