Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C63C433E0
	for <linux-media@archiver.kernel.org>; Thu, 25 Mar 2021 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1969461A27
	for <linux-media@archiver.kernel.org>; Thu, 25 Mar 2021 08:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYIwV (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 25 Mar 2021 04:52:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:35109 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhCYIwL (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Thu, 25 Mar 2021 04:52:11 -0400
IronPort-SDR: 6fC6MCW/VKqWG6BhYe7m61xFhw0+4pmXDoINK5PQvz3OsA+heMlFhehLMDGDua1MhG8e1cXUBx
 tVs7J37HWX7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170236569"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170236569"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 01:52:10 -0700
IronPort-SDR: zs+SB7lb6LLXt85zal5NPVqsCM4paZ7+Bu0x4GB+P7wyhqOjImKsgHS0ONW+S4NN/UsrgcIsOe
 OFfQU3n1Jk5Q==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="593697007"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 01:52:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6CF6D2017A;
        Thu, 25 Mar 2021 10:52:06 +0200 (EET)
Date:   Thu, 25 Mar 2021 10:52:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: media: video-interfaces: Drop the example
Message-ID: <20210325085206.GF3@paasikivi.fi.intel.com>
References: <20210324202253.3576798-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324202253.3576798-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Mar 24, 2021 at 02:22:53PM -0600, Rob Herring wrote:
> The example in video-interfaces.yaml uses a bunch of undocumented
> bindings which will cause warnings when undocumented compatible checks
> are enabled. The example could be fixed to use documented bindings, but
> doing so would just duplicate other examples. So let's just remove the
> example.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
