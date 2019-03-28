Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CDC43381
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB572173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfC1N7K (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:59:10 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:49249 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbfC1N7J (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 09:59:09 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9VYah6iWJNG8z9VYehpDTk; Thu, 28 Mar 2019 14:59:07 +0100
Subject: Re: [PATCH v2 08/11] rockchip/vpu: Support the Request API
To:     Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-9-ezequiel@collabora.com>
 <CAAFQd5C5zo=03-mLh4OztKS+dCjVMUe1Za25ff+dWjxQDLFLng@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0618322f-ac2b-fbcd-47f2-68173318f8d7@xs4all.nl>
Date:   Thu, 28 Mar 2019 14:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5C5zo=03-mLh4OztKS+dCjVMUe1Za25ff+dWjxQDLFLng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNLjR8JM7NexffErSxScLP/V4HuDrSsG7rLVyCAdlYYoxCXWTc14OMKFP2qCP7OtmnEXtbnYy+Zh7wsheuCCune9NeYMy5E251grp39Z2QOgUV7eNYcd
 wn3odgPhFf3lfUpmHedfbBupb1uycIEef43ZfHy/lUwcCL9NZ7FenBJio3xsYAzspNp/CipYwe8BNlpbB18s8S2IWiz461H+WHqK5YfVQvswqOLIU/7jweWm
 PhSnmuR469te8T5wYRVQnuiP9JZfEW4PndN3XIGorxNVEsEuIDDZKnHkFYFmcPdBJ/2tpTTl4yUvUZxdTBi5HKvDXwOKozg6gWQ8+hM7lBfne6spdlsdpF9N
 qeBY8t4Kc9eludH5eDTyWxcG49ApxUNrQWAp1LUD9aagPLfWERx8sjxmbbwQX3l27yXxISb5KhHqdoky8+GUh8z74i9T7SvtRFGmgF3xvzL7zBuZgZlrT9kS
 oO5Tm94DUPysFYyJlBfBx450A0YBeVaLY5eAYDSFL+R3GZdYs8hPpOJ4D3Q8KorSJIFQSO2j5ARkDlzngSr7Eg5Zr41Ii8eh/UeSag==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 3/28/19 8:20 AM, Tomasz Figa wrote:

<snip>

>> +static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
>> +{
>> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +
>> +       vbuf->field = V4L2_FIELD_NONE;
> 
> Hmm, "validate" in the name of this callback would suggest that we
> should just check the contents, not change them. Hans, what was the
> intention when adding this callback? Are we missing the const
> specifier in the argument?

See the original commit log:

https://www.mail-archive.com/linux-media@vger.kernel.org/msg143163.html

It is allowed to either just validate and return an error if wrong,
or change it to something known to be valid. In particular, userspace
can set this to FIELD_ANY, and in that case the driver must replace
it with something valid.

Most drivers just support FIELD_NONE, and just set it.

That said, I think we should tighten the spec for this as this is
not well documented.

I propose that if vbuf->field == FIELD_ANY, then replace it with something
sane. Otherwise validate it and return an error if the field value
is not supported.

And FIELD_ALTERNATE is never allowed here, that's always wrong.

Regards,

	Hans
