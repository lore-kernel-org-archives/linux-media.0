Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182AC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60282147A
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDHNRn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:17:43 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:46057 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbfDHNRm (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 09:17:42 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud9.xs4all.net with ESMTPA
        id DU9ZhBgGSiLOmDU9ahzxGO; Mon, 08 Apr 2019 15:17:40 +0200
Subject: Re: [PATCH 1/7] cec-notifier: add cec_notifier_find_hdmi_dev helper
To:     Thierry Reding <treding@nvidia.com>
Cc:     linux-media@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>
References: <20190408110401.3345-1-hverkuil-cisco@xs4all.nl>
 <20190408110401.3345-2-hverkuil-cisco@xs4all.nl> <20190408130953.GA2219@ulmo>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <ce46429f-10ef-e68f-a5f7-9d884c7dd1ef@xs4all.nl>
Date:   Mon, 8 Apr 2019 15:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408130953.GA2219@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGhcWvvwx/HHIx+Erz3rakVopXaeqhVWq+Z0pS8W0WfImWrpsnlfCsKq6KeivWWN56PIGk+2joB82pWlzex8YRy0qaU4JFF0FiVnHuKji2VUamzaziFE
 U/IPHneQu9yqT5zRHdgpYE+MgrFeYHSALYZnBPClZ3Kpdf8W0exDxmgjtCWxS5IZFdnhRk+rNtcF6DzdjT3WQELcZmjlc8McID3ZMhed7mgfl6fUs/tu5YCC
 X1H1ILXWUwTQP0f8V63LYZ9WjdaC9y3waovjz9Vsklz89P+2sQ2mqtuGB8GZHAfZcJYC0mGT8zwkphsvK9prgTNdUIH4vJggAaP14oRIesLcff+Dets9DC3T
 bZ5cmXxwb68LoyejMqsmjkdSz3c1APcJrVFFHld6ePafDOrvsJyP6I4UEmBlghJGmj/InMxAzNB9SfV2vDEi3AEx5Fw/j/nbgaWkiphNpseabUN0nAeG/0q8
 jmm9F0EIq9k+n5mn
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 3:09 PM, Thierry Reding wrote:
> On Mon, Apr 08, 2019 at 01:03:55PM +0200, Hans Verkuil wrote:
>> Add helper function to parse the DT for the hdmi-phandle property
>> and find the corresponding struct device pointer.
>>
>> It takes care to avoid increasing the device refcount since all
>> we need is the device pointer. This pointer is used in the
>> notifier list as a key, but it is never accessed by the CEC driver.
>>
>> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>> Reported-by: Wen Yang <wen.yang99@zte.com.cn>
>> ---
>>  drivers/media/cec/cec-notifier.c | 24 ++++++++++++++++++++++++
>>  include/media/cec-notifier.h     | 19 ++++++++++++++++++-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
>> index dd2078b27a41..870b3788e9f7 100644
>> --- a/drivers/media/cec/cec-notifier.c
>> +++ b/drivers/media/cec/cec-notifier.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/list.h>
>>  #include <linux/kref.h>
>> +#include <linux/of_platform.h>
>>  
>>  #include <media/cec.h>
>>  #include <media/cec-notifier.h>
>> @@ -127,3 +128,26 @@ void cec_notifier_unregister(struct cec_notifier *n)
>>  	cec_notifier_put(n);
>>  }
>>  EXPORT_SYMBOL_GPL(cec_notifier_unregister);
>> +
>> +struct device *cec_notifier_find_hdmi_dev(struct device *dev)
> 
> This doesn't really do anything with notifiers, so perhaps rename this
> to something more independent?

It's only used if the driver uses notifiers, and is also in cec-notifier.c.
So I prefer to keep it like this.

> 
>> +{
>> +	struct platform_device *hdmi_pdev;
>> +	struct device *hdmi_dev = NULL;
>> +	struct device_node *np;
>> +
>> +	np = of_parse_phandle(dev->of_node, "hdmi-phandle", 0);
>> +
>> +	if (!np) {
>> +		dev_err(dev, "Failed to find hdmi node in device tree\n");
> 
> Perhaps "... to find HDMI node..."? HDMI here doesn't refer to a name,
> so I think it's better to use the capitalized abbreviation to avoid any
> potential confusion.

OK.

> 
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	hdmi_pdev = of_find_device_by_node(np);
>> +	of_node_put(np);
>> +	if (hdmi_pdev) {
>> +		hdmi_dev = &hdmi_pdev->dev;
>> +		put_device(hdmi_dev);
> 
> Don't you need to hold onto that reference and pass it to the caller?
> Otherwise somebody could be dropping the last reference to the struct
> device backing the HDMI device after this call finishes.

No, hdmi_dev is just a key to search in the list of notifiers. It is not
accessed or used in any other way.

I'll add a comment here to clarify this.

Regards,

	Hans

> 
> In conjunction with the above comment, perhaps it'd be clearer if we had
> a cec_hdmi_get()/cec_hdmi_put() pair of functions so that callers can
> explicitly manage the reference count.
> 
> Thierry
> 

