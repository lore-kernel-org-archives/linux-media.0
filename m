Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A5BC10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1963217F9
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="2ieoUYmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfC1PRj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:17:39 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50668 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfC1PRi (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 11:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lucaceresoli.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fumpby5Es2pOy+EuSCWPzP6LPhmNbB6AWXJXT/mF214=; b=2ieoUYmKLNxBxju7McBsoYKI2h
        eMtMlE9Ya4WSoG8pjIXiBA5weMGo91pYfRcKjbmu3RaMyiwNQp/u0h8vxmW0gb6sWJrtaqVUknMeO
        HbWsE4Uj9weiVuiaNQJoQgZzVT97jlKuvypwyrxB58CYOYzXYUF3YoQ8FAdxsMkBHv9o=;
Received: from [109.168.11.45] (port=43166 helo=[192.168.101.64])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1h9Wmc-00HPOo-5J; Thu, 28 Mar 2019 16:17:34 +0100
Subject: Re: [PATCH v3 26/31] adv748x: csi2: add internal routing
 configuration
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20190305185150.20776-1-jacopo+renesas@jmondi.org>
 <20190305185150.20776-27-jacopo+renesas@jmondi.org>
 <4f5b5763-be90-4040-7d55-986471168de1@lucaceresoli.net>
 <20190315094538.bs5ecsdzndrxjdbb@uno.localdomain>
 <20190315100613.avmsmavdraxetkzl@kekkonen.localdomain>
 <28dbf2c7-2834-2bae-d56e-43e50d763c9f@lucaceresoli.net>
 <20190320171406.s462267lssaxkqo4@uno.localdomain>
 <88863e6a-a09a-b3c7-7b00-da4fc823b55f@lucaceresoli.net>
 <20190328150847.khb2spjt2jotisfx@uno.localdomain>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <63fd5938-0b2a-5c81-8a0a-4bd3ca07a291@lucaceresoli.net>
Date:   Thu, 28 Mar 2019 16:17:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328150847.khb2spjt2jotisfx@uno.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Jacopo,

On 28/03/19 16:08, Jacopo Mondi wrote:
> Hi Luca,
> 
> On Fri, Mar 22, 2019 at 05:52:15PM +0100, Luca Ceresoli wrote:
>> Hi,
>>
>> thanks for the follow-up.
>>
>> On 20/03/19 18:14, Jacopo Mondi wrote:
>>>>>> This is probably the wrong patch to use an example, as this one is for
>>>>>> a multiplexed interface, where there is no need to go through an
>>>>>> s_stream() for the two CSI-2 endpoints, but as you pointed out in our
>>>>>> brief offline chat, the AFE->TX routing example for this very device
>>>>>> is a good one: if we change the analogue source that is internally
>>>>>> routed to the CSI-2 output of the adv748x, do we need to s_stream(1)
>>>>>> the now routed entity and s_stream(0) on the not not-anymore-routed
>>>>>> one?
>>>>>>
>>>>>> My gut feeling is that this is up to userspace, as it should know
>>>>>> what are the requirements of the devices in the system, but this mean
>>>>>> going through an s_stream(0)/s_stream(1) sequence on the video device,
>>>>>> and that would interrupt the streaming for sure.
>>>>>>
>>>>>> At the same time, I don't feel too much at ease with the idea of
>>>>>> s_routing calling s_stream on the entity' remote subdevices, as this
>>>>>> would skip the link format validation that media_pipeline_start()
>>>>>> performs.
>>>>>
>>>>> The link validation must be done in this case as well, it may not be
>>>>> simply skipped.
>>>>
>>>> Agreed.
>>>>
>>>> The routing VS pipeline validation point is a very important one. The
>>>> current proposed workflow is:
>>>>
>>>>  1. the pipeline is validated as a whole, having knowledge of all the
>>>>     entities
>>>
>>> let me specify this to avoid confusions:
>>>      "all the entities -with an active route in the pipeline-"
>>>
>>>>  2. streaming is started
>>>>  3. s_routing is called on an entity (not on the pipeline!)
>>>>
>>>> Now the s_routing function in the entity driver is not in a good
>>>> position to validate the candidate future pipeline as a whole.
>>>>
>>>> Naively I'd say there are two possible solutions:
>>>>
>>>>  1. the s_routing reaches the pipeline first, then the new pipeline is
>>>>     computed and verified, and if verification succeeds it is applied
>>>>  2. a partial pipeline verification mechanism is added, so the entity
>>>>     receiving a s_routing request to e.g. change the sink pad can invoke
>>>>     a verification on the part of pipeline that is about to be
>>>>     activated, and if verification succeeds it is applied
>>>>
>>>> Somehow I suspect neither is trivial...
>>>
>>> I would say it is not, but if you have such a device that does not
>>> require going through a s_stream(0)/s_stream(1) cycle and all the
>>> associated re-negotiation and validations, it seems to me nothing
>>> prevents you from handling this in the driver implementation. Maybe it
>>> won't look that great, but this seems to be quite a custom design that
>>> requires all input sources to be linked to your sink pads, their
>>> format validated all at the same time, power, stream activation and
>>> internal mux configuration controlled by s_routing. Am I wrong or
>>> nothing in this series would prevent your from doing this?
>>
>> You're right, nothing prevents me from doing a custom hack for my custom
>> design. It's what I'm doing right now. My concern is whether the
>> framework will evolve to allow modifying a running pipeline without
>> custom hacks.
>>
>>> tl;dr: I would not make this something the framework should be
>>> concerned about, as there's nothing preventing you from
>>> implementing support for such a use case. But again, without a real
>>> example we can only guess, and I might be overlooking the issue or
>>> missing some relevant detail for sure.
>>
>> I'm a bit surprised in observing that my use case looks so strange,
>> perhaps yours is so different that we don't quite understand each other.
>> So below is an example of what I have in mind. Can you explain your use
>> case too?
> 
> I'm mostly interested in this series as it allows me to add data lane
> negotiation at run time. In my case, there are no stream continuity
> constraints, but I get your point here.
>>
>>
>> Here's a use case. Consider a product that takes 3 camera inputs,
>> selects one of them and produces a continuous video stream with the
>> camera image and an OSD on top of it. The selected camera can be changed
>> at any time (e.g. upon user selection).
>>
>>                   OSD FB ---.
>>                             |
>>             .--------.      V
>> Camera 0 -->|        |   .-----.
>> Camera 1 -->|  MUX   |-->| OSD |--> DMA --> /dev/video0
>> Camera 2 -->|        |   `-----'
>>             `--------'
>>
>> A prerequisite is obviously that each piece of hardware and software
>> involved is able to cope with a sudden stream change. Perhaps not that
>> common, but no rocket science.
>>
>> It looks to me that each of these pieces can be modeled as an entity and
>> the s_routing API is a perfect fit for the mux block. Am I wrong?
>>
> 
> Personally, I would say that your muxer driver, if able to switch
> source without requiring a pipeline restart, should handle it
> internally. There are specific details that the mux should be able to
> handle, and we're still pretty vague on the details. As a start, which
> is the bus type your sources connects to the muxer with? Parallel?
> CSI-2? How is the video stream multiplexed? with CSI-2 VC? Do you need
> to control your source power during inactive period?

Not completely defined, but it could be either parallel or MIPI CSI-2,
and each input could be connected either directly from the sensor or
through a ser/des. Controlling power would be important as well.

> I'm sure there
> are more questions... I agree a partial pipeline restart might be
> something to consider, but at the same time I think this is not
> something strictly required to get this series merged, isn't it?

Right. As far as I can understand this series is already OK if you need
to change routing while the stream is not running.

-- 
Luca
