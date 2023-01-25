Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B3C27C76
	for <linux-media@archiver.kernel.org>; Wed, 25 Jan 2023 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAYMfk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 25 Jan 2023 07:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYMfi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 25 Jan 2023 07:35:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934BF3C29E
        for <linux-media@vger.kernel.org>; Wed, 25 Jan 2023 04:35:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FB4DB81714
        for <linux-media@vger.kernel.org>; Wed, 25 Jan 2023 12:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C060C433EF;
        Wed, 25 Jan 2023 12:35:31 +0000 (UTC)
Message-ID: <aa96bde0-3e23-bdf6-11fe-1cf0608afc6e@xs4all.nl>
Date:   Wed, 25 Jan 2023 13:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] media: Add AV1 uAPI
Content-Language: en-US
To:     Daniel Almeida <daniel.almeida@collabora.com>
Cc:     linux-media@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
References: <20230103154832.6982-1-daniel.almeida@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230103154832.6982-1-daniel.almeida@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 1/3/23 16:48, Daniel Almeida wrote:
> This patch adds the  AOMedia Video 1 (AV1) kernel uAPI.
> 
> This design is based on currently available AV1 API implementations and
> aims to support the development of AV1 stateless video codecs
> on Linux.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Co-Developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

checkpatch says that this should be 'Co-developed-by'

It also expects the Co-developed-by to come before Nicolas' Signed-off-by line.

Regards,

	Hans
