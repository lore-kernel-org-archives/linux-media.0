Return-Path: <SRS0=7MnB=C2=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC6C43461
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 15:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCC52220D
	for <linux-media@archiver.kernel.org>; Thu, 17 Sep 2020 15:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgIQPG0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgIQPGW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 17 Sep 2020 11:06:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA75C06174A
        for <linux-media@vger.kernel.org>; Thu, 17 Sep 2020 08:06:18 -0700 (PDT)
Received: from [IPv6:2003:c7:cf13:ec00:15a4:c2da:98cf:28d0] (p200300c7cf13ec0015a4c2da98cf28d0.dip0.t-ipconnect.de [IPv6:2003:c7:cf13:ec00:15a4:c2da:98cf:28d0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D409D29BFA0;
        Thu, 17 Sep 2020 16:06:16 +0100 (BST)
Subject: Re: [PATCH v2 0/2] media: admin-guide: add documentation for rkisp1
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, helen.koike@collabora.com,
        ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com,
        sakari.ailus@linux.intel.com, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, tfiga@chromium.org
References: <20200818102703.30471-1-dafna.hirschfeld@collabora.com>
 <f696e967-ce1f-e7c1-a74b-ff944332bd67@xs4all.nl>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <745694bf-6609-c405-268e-7f387d01216d@collabora.com>
Date:   Thu, 17 Sep 2020 17:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f696e967-ce1f-e7c1-a74b-ff944332bd67@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



Am 17.09.20 um 12:52 schrieb Hans Verkuil:
> On 18/08/2020 12:27, Dafna Hirschfeld wrote:
>> Two patches that document the rkisp1 driver in the Documentation
>> directory.
>>
>> patch 1 adds documentation to the specific metadata formats
>> used by the driver.
>>
>> patch 2 adds a documentation of the driver.
>>
>> The documentation assumes that the patchsets:
>>
>> "v4l2: add support for colorspace conversion API (CSC) for video capture and subdevices"
>> https://patchwork.kernel.org/project/linux-media/list/?series=334393
>>
>> "media: staging: rkisp1: add support to V4L2_CAP_IO_MC"
>> https://patchwork.kernel.org/cover/11680993/
> 
> The MAINTAINERS file needs to be updated for these new doc files. Just post a new patch for
> this, no need for a v3.

Done,

thanks,
Dafna

> 
> Regards,
> 
> 	Hans
> 
>>
>> were accepted and it documents the features that those patchsets add.
>>
>> changes from v1:
>> ----------------
>> - limit lines within 80 chars
>> - rephrasing and fixing issues due to comments
>>
>> Dafna Hirschfeld (2):
>>    media: pixfmt-meta-rkisp1.rst: add description of rkisp1 metadata
>>      formats in pixfmt-meta-rkisp1.rst
>>    media: admin-guide: add documentation file rkisp1.rst
>>
>>   Documentation/admin-guide/media/rkisp1.dot    |  18 ++
>>   Documentation/admin-guide/media/rkisp1.rst    | 181 ++++++++++++++++++
>>   .../admin-guide/media/v4l-drivers.rst         |   1 +
>>   .../userspace-api/media/v4l/meta-formats.rst  |   1 +
>>   .../media/v4l/pixfmt-meta-rkisp1.rst          |  49 +++++
>>   .../uapi/v4l/pixfmt-meta-rkisp1-params.rst    |  23 ---
>>   .../uapi/v4l/pixfmt-meta-rkisp1-stat.rst      |  22 ---
>>   7 files changed, 250 insertions(+), 45 deletions(-)
>>   create mode 100644 Documentation/admin-guide/media/rkisp1.dot
>>   create mode 100644 Documentation/admin-guide/media/rkisp1.rst
>>   create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-rkisp1.rst
>>   delete mode 100644 drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-params.rst
>>   delete mode 100644 drivers/staging/media/rkisp1/Documentation/media/uapi/v4l/pixfmt-meta-rkisp1-stat.rst
>>
> 
