Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C7FC10F14
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2CF20850
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDLQNt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:13:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:5963 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfDLQNr (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 12:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 09:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="315430939"
Received: from unknown (HELO [10.7.153.148]) ([10.7.153.148])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2019 09:13:46 -0700
Subject: Re: [PATCH v2] media: platform: fix a kernel warning on clk control
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org
References: <20190329212710.5378-1-jae.hyun.yoo@linux.intel.com>
 <09113211-ef61-2168-cf78-37c76f21edba@xs4all.nl>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <e921f245-5a8b-58ce-411f-f4142aeb67c1@linux.intel.com>
Date:   Fri, 12 Apr 2019 09:13:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <09113211-ef61-2168-cf78-37c76f21edba@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/12/2019 4:00 AM, Hans Verkuil wrote:
> Eddie, can you review this?
> 
> Jae Hyun Yoo, for future reference: please add the driver name in the subject.
> I.e. something like this: [PATCH v2] media: aspeed: fix a kernel warning on clk control
> 
> That helps maintainers figuring out who should look at which patch.

Hi Hans,

I see. I'll change the subject like you suggested. Thanks for your
comments.

Regards,

Jae

> Regards,
> 
> 	Hans
