Return-Path: <SRS0=JUE0=SR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD576C10F0E
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 09:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73572077C
	for <linux-media@archiver.kernel.org>; Mon, 15 Apr 2019 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfDOJmd (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:42:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:45584 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJmc (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 15 Apr 2019 05:42:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 02:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="161649025"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.181]) ([10.238.232.181])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2019 02:42:31 -0700
Subject: Re: [PATCH v2] media:staging/intel-ipu3: parameter buffer refactoring
To:     Tomasz Figa <tfiga@chromium.org>,
        Cao Bing Bu <bingbu.cao@intel.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
References: <1553252826-15830-1-git-send-email-bingbu.cao@intel.com>
 <CAAFQd5BJXBYZDc58M=-OMQs5=m2QpiYJ3dnpoNW_-hEz1J5_7g@mail.gmail.com>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <cc5ebfff-4999-78a4-8bd7-8475dfa15ed6@linux.intel.com>
Date:   Mon, 15 Apr 2019 17:49:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BJXBYZDc58M=-OMQs5=m2QpiYJ3dnpoNW_-hEz1J5_7g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 4/15/19 5:28 PM, Tomasz Figa wrote:
> Hi Bingbu,
> 
> On Fri, Mar 22, 2019 at 8:00 PM <bingbu.cao@intel.com> wrote:
>>
>> From: Bingbu Cao <bingbu.cao@intel.com>
>>
>> Current ImgU driver processes and releases the parameter buffer
>> immediately after queued from user. This does not align with other
>> image buffers which are grouped in sets and used for the same frame.
>> If user queues multiple parameter buffers continuously, only the last
>> one will take effect.
>> To make consistent buffers usage, this patch changes the parameter
>> buffer handling and group parameter buffer with other image buffers
>> for each frame.
>> Each time driver will queue one more group of buffers when previous
>> frame processed and buffers consumed by css.
>>
>> Signed-off-by: Tianshu Qiu <tian.shu.qiu@intel.com>
>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>> ---
>>  drivers/staging/media/ipu3/ipu3-css.c  |  5 ----
>>  drivers/staging/media/ipu3/ipu3-v4l2.c | 46 ++++++++++++----------------------
>>  drivers/staging/media/ipu3/ipu3.c      | 30 ++++++++++++++++++++++
>>  3 files changed, 46 insertions(+), 35 deletions(-)
>>
>> ---
>> changes since v1:
>> - add payload check for parameter buffer
>> - queue buffer only when previous buffer consumed
>> ---
> 
> Thanks for the patch. With the issues pointed by Sakari fixed (+/-
> those for follow up patches):
> 
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> 
> By the way, has this been tested on an applicable platform with
> applicable platform (e.g. Pixel Slate with Chrome OS) and found no
> performance or functional regressions?
Hi, Tomasz

Yes, same change was verified in our own integration process with full
test, validation team did not find functional regressions.
However, if you have some extra tests which can check the performance, I
will add them into the test cases list.

> 
> Best regards,
> Tomasz
> 
