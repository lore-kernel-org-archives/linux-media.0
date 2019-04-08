Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0691C10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 14:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754942147A
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 14:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDHOqG (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:46:06 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:38383 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfDHOqF (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 10:46:05 -0400
Received: from [IPv6:2001:983:e9a7:1:1170:5c87:411e:5806] ([IPv6:2001:983:e9a7:1:1170:5c87:411e:5806])
        by smtp-cloud8.xs4all.net with ESMTPA
        id DVX8haQmMUjKfDVXAhYaDS; Mon, 08 Apr 2019 16:46:04 +0200
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-media@vger.kernel.org
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
 <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
 <20190408072854.13077345@coco.lan>
 <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
 <1554734486.6439.6.camel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <e2a6772f-61a4-8ff8-d815-c71dfd7120e2@xs4all.nl>
Date:   Mon, 8 Apr 2019 16:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554734486.6439.6.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCuWGG50LX3uOt9oz52aeZvBDvj+NwF7fC/vesD9U9LHqnTego5MjZ1qYiGMX5jsdnjRLASa0Skjj2aZuCic1smYjx9KvF8cpwCcpGCyfgykOYwIvJTZ
 IhyYCINe3E2VspPYV6t+Ej+E1bJvYDChhQ8aMmEYIEQB+CnI8EHBhMg6oKz0wMLfyN63LuXIa1uHq5tCnqPcIRw6WrxE2okKUsMrho8UoFNapg4S2fxT5E7E
 d0UFeBX3gqXSV2J2oC2lFhCa6ktA1VMqphk7GXbbpwwmhxQCdzdfO8Er3dlWVhho3MJFB75l456c5hYLm5niylRCfi0GkhbdoIholstUsHc4JgM4BBOnLemv
 9WzeP0/A
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/8/19 4:41 PM, Philipp Zabel wrote:
> On Mon, 2019-04-08 at 12:44 +0200, Hans Verkuil wrote (paraphrased):
>> On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote (paraphrased):
> [...]
>>>> [I hate colors]
>>> [I love colors]
>> I could live with [compromise]
> 
> Sorry for opening that can of worms :-)
> 
> How about doing something similar to 'ls':
> 
> - an environment variable V4L_COLORS which, if not set, defaults to
>   V4L_COLORS="ok=32:warn=1:fail=1;31"
> - an option --color=always|never|auto, which if not set, defaults to
>   auto (check isatty())
> - to disable colors by default, set V4L_COLORS to "ok=0:warn=0:fail=0"
> 
> This would allow to pipe colors into non-terminal stdout like less -R if
> desired, or quickly disable colors with --color=never.
> The pattern could be extended to include dvbv5 log levels or fe tool
> quality levels.
> 
> Or alternatively, V4L_COLOR=always|never|auto for easier configuration,
> but with a fixed color scheme?

I think that is easiest. As long as the color scheme works for both black-on-white
and white-on-black it should be fine.

Regards,

	Hans
