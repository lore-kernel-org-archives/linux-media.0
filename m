Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC4BC3DA78
	for <linux-media@archiver.kernel.org>; Tue, 17 Jan 2023 19:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjAQTfj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 17 Jan 2023 14:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjAQTeh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 17 Jan 2023 14:34:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94AD4901D;
        Tue, 17 Jan 2023 10:37:20 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="389279277"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="389279277"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748138394"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748138394"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 10:37:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1pHqpf-00Aj8m-3D;
        Tue, 17 Jan 2023 20:37:15 +0200
Date:   Tue, 17 Jan 2023 20:37:15 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     ailus@linux.intel.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH v3] media: atomisp: pci: Replace bytes macros with
 functions
Message-ID: <Y8bq25jjRdgTTd7/@smile.fi.intel.com>
References: <CAHp75VcxaSXeMNmkPoMnA+zjp+JWmHp5aE+2yPhXaqxMC6QWEQ@mail.gmail.com>
 <20230117183152.6521-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117183152.6521-1-bpappas@pappasbrent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, Jan 17, 2023 at 01:31:52PM -0500, Brent Pappas wrote:

Read to the end this message, please!

> Replace the function-like macros FPNTBL_BYTES, SCTBL_BYTES, and
> MORPH_PLANE_BYTES with static inline functions to comply with Linux coding
> style standards.
> Replace multiplication with calls to size_mul to prevent accidental
> arithmetic overflow.

We refer to MACRO() and func() as depicted.
Otherwise looks good.

...

> Changelog:
> V1 -> V2: Use size_mul to perform size_t multiplication without risk of
> 		  overflow.
> 		  Remove the inline keyword from function definitions.
> 
> V2 -> V3: Add commit message.

You missed my other comments. Please, read reply in full and address all
reviewer's comments.

-- 
With Best Regards,
Andy Shevchenko


