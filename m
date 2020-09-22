Return-Path: <SRS0=5+7B=C7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6606CC2D0E2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF29239D2
	for <linux-media@archiver.kernel.org>; Tue, 22 Sep 2020 08:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVIDT (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:03:19 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54905 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgIVIDT (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 22 Sep 2020 04:03:19 -0400
Received: from [77.244.183.192] (port=61908 helo=[192.168.178.24])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kKdGc-0002t5-UF; Tue, 22 Sep 2020 10:03:14 +0200
Subject: Re: [PATCH v6] dt-bindings: media: imx274: Convert to json-schema
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        linux-renesas-soc@vger.kernel.org
References: <20200912103045.14375-1-jacopo+renesas@jmondi.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <b730792b-041b-01b9-9d73-c32862a5f760@lucaceresoli.net>
Date:   Tue, 22 Sep 2020 10:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912103045.14375-1-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,

On 12/09/20 12:30, Jacopo Mondi wrote:
> Convert the imx274 bindings document to json-schema and update
> the MAINTAINERS file accordingly.
> 
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

This patch is also fixing the supply names from uppercase to lowercase.
That change should go in 5.9, otherwise we'll have to stick to uppercase
names forever, yet I don't see it in current linux-media branches.

-- 
Luca
