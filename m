Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED19C2B9F4
	for <linux-media@archiver.kernel.org>; Sat, 26 Jun 2021 00:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEABE61969
	for <linux-media@archiver.kernel.org>; Sat, 26 Jun 2021 00:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFZAxh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 25 Jun 2021 20:53:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36286 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhFZAxg (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 25 Jun 2021 20:53:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 5CFA21F40F21
Message-ID: <017548f29279297fc79537cf486bcf3df2b603a1.camel@collabora.com>
Subject: Re: [PATCH 1/2] media: rkisp1: remove field 'vaddr' from
 'rkisp1_buffer'
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, helen.koike@collabora.com,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
Date:   Fri, 25 Jun 2021 21:51:03 -0300
In-Reply-To: <20210625082309.24944-2-dafna.hirschfeld@collabora.com>
References: <20210625082309.24944-1-dafna.hirschfeld@collabora.com>
         <20210625082309.24944-2-dafna.hirschfeld@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Dafna,

On Fri, 2021-06-25 at 11:23 +0300, Dafna Hirschfeld wrote:
> The virtual address can be accessed using vb2_plane_vaddr
> therefore there is no need to save it in an extra field in
> 'rkisp1_buffer'. Remove it.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

-- 
Kindly,
Ezequiel

