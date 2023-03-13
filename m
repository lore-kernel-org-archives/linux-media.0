Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542BC74A5B
	for <linux-media@archiver.kernel.org>; Mon, 13 Mar 2023 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCMLBi (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMLBe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 13 Mar 2023 07:01:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330F3771C
        for <linux-media@vger.kernel.org>; Mon, 13 Mar 2023 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678705268; x=1710241268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DhNT6YSK+UEI0b0gWLOmqRcelvoE01zdZe21ehOwpRg=;
  b=CTCHIE/ETEKS7eXeRsljY94p7O9nB3eYzMeDCdlvgVvQMj171gsrW4j5
   LhxENletsqmqMpeAtMLIZwQ3Lv8BoyDiobY5ZwcpQCYNaAekDhxLFDcmD
   mGrjpXfbmL34VgCfpPGwdv8kyKgXUtO0DMx+hqlzxMF6GtNWB4AueEeHv
   +9rin5qXAzsggmuo/3fFCIn+5ULe6Oasb+Ik8VPFZlff3wUnQ2LDdy0ff
   Wv9n/GpbNXPIMj5MeKXUjUdFORfwmcskjzfKkPyfgOvk0H2Nt0nDQLLcV
   Y6XlP6phtGY+JzoN/tFya3CZ5ns4Vy6dEW9bOlbslx5IEfnjyspbhEy7l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="423382846"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="423382846"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="655938779"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="655938779"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 04:00:38 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 5BEB6120C21;
        Mon, 13 Mar 2023 13:00:35 +0200 (EET)
Date:   Mon, 13 Mar 2023 13:00:35 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arec Kao <arec.kao@intel.com>
Cc:     linux-media@vger.kernel.org, bingbu.cao@linux.intel.com,
        andy.yeh@intel.com
Subject: Re: [PATCH] media: ov13b10: Support device probe in non-zero ACPI D
 state
Message-ID: <ZA8CU403GwyCE1Hq@kekkonen.localdomain>
References: <20230312155637.29961-1-arec.kao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312155637.29961-1-arec.kao@intel.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Arec,

Thanks for the patch.

On Sun, Mar 12, 2023 at 11:56:37PM +0800, Arec Kao wrote:
> Tell ACPI device PM code that the driver supports the device being in
> non-zero ACPI D state when the driver's probe function is entered.
> 
> Also do identification on the first access of the device, whether in
> probe or when starting streaming.
> 
> Signed-off-by: Arec Kao <arec.kao@intel.com>
> ---
>  drivers/media/i2c/ov13b10.c | 74 +++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 27 deletions(-)
>  mode change 100644 => 100755 drivers/media/i2c/ov13b10.c
> 
> diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
> old mode 100644
> new mode 100755

Apart from this part patch seems fine.

-- 
Kind regards,

Sakari Ailus
