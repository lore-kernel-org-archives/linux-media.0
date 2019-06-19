Return-Path: <SRS0=8QUH=US=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A617C31E49
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 12:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699BF21670
	for <linux-media@archiver.kernel.org>; Wed, 19 Jun 2019 12:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFSM7P (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:59:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSM7O (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 19 Jun 2019 08:59:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 33DD3260A33
Message-ID: <e103923e3885711842d600d9e701d4dbc4120854.camel@collabora.com>
Subject: Re: [PATCH v3] media: v4l2-ctrl: Move compound control
 initialization
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
Cc:     kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>
Date:   Wed, 19 Jun 2019 09:59:05 -0300
In-Reply-To: <20190618231731.27646-1-ezequiel@collabora.com>
References: <d102e592-2f00-e28e-2956-6df6a47a125d@xs4all.nl>
         <20190618231731.27646-1-ezequiel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2019-06-18 at 20:17 -0300, Ezequiel Garcia wrote:
> Rework std_init adding an explicit initialization for
> compound controls.
> 
> While here, make sure the control is initialized to zero,
> before providing default values for all its fields.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v2:
> * Fix missing index usage
> 

Erratum, should be "Changes from v3" since this is v4 patch.

Thanks,
Ezequiel

