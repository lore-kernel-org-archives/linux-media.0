Return-Path: <SRS0=jMCU=AV=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B3C433DF
	for <linux-media@archiver.kernel.org>; Fri, 10 Jul 2020 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D202A2063A
	for <linux-media@archiver.kernel.org>; Fri, 10 Jul 2020 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="IJHYsDaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGJO2q (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:28:46 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51987 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbgGJO2q (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 10 Jul 2020 10:28:46 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id tu13jnYP3JcNHtu16jsE56; Fri, 10 Jul 2020 16:28:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1594391324; bh=nJHdorJHF3YcO6eS7DzhJdt7fHlfN68sWWCLuit3rG4=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=IJHYsDaVRBpLQW2/0LeC5GQO4KR2xfPg4usDVkJZ6C4SbKmgXp09cgKYnyF/wY8UW
         e6/Vm4d+1dgcQnK9w+n3DmBKCSBdGRWmv18P+ejRBdQrDImI5JXlt5x7oRIQpGBZvm
         QN06WnTHU7FCYsnnee1/c8NgSmgP7aflkaQHbmrUZVDs0pok4wh3Qac70vN4057vrP
         +CfgkGdv3wzpv/Iq+qxDaB5gNZfLIYHxsT5+Au02M/ZYyS/3M1hWuRfQAr3ghEPkLr
         F6zKqwjWvc0sYsbN8PPzvW9/vGX3LZVwHJPB3tgmxUEx/5DW3Qf7V3lI/zJ478e8jM
         1TKvu8Hk+HObg==
Subject: Re: Range values for V4L2_CID_* commands
To:     Lucas <lucasavdantas1992@gmail.com>, linux-media@vger.kernel.org
References: <ab88a3cf-bc05-d43b-dfe2-5f9e78422132@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <01fd7935-2793-c1a5-5aa3-4f453019394c@xs4all.nl>
Date:   Fri, 10 Jul 2020 16:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ab88a3cf-bc05-d43b-dfe2-5f9e78422132@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHighm/7htOgnxLfQirybAOJabrr4Of/dPxZIGc7uegNGY3sVTrrfk8JLJTr0AEzW1u5NuMys8NlQRr8Hgbbk04q5UJwiml4lICEhD9sbb+DfVHqipto
 TEnEdNGrPZsNtmU+ADnIpw5eH7W0vCDkLEAo12a35Vk1mhJ92FRBq48klNUpDFWIlkMnYL/DjADSjPABHBW71mYPHlRenYm6Fxp1sCk9raLtxrdzdgCdW+aP
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 10/07/2020 16:18, Lucas wrote:
> Hello, how do I obtain the accepted range of values for each V4L2_CID 
> command? Take V4L2_CID_BRIGHTNESS as an example, how do I know what is 
> the maximum and minimum values accepted for it? I have tried to use 
> 'v4l2_ioctl(fd, VIDIOC_G_CTRL, &query);' thinking that would be stored 
> in the maximum and minimum members for the struct v4l2_queryctrl but 
> that does not appear to be the case as the values for those members are 
> always zero.

Use VIDIOC_QUERYCTRL for that. See:

https://linuxtv.org/downloads/v4l-dvb-apis-new/userspace-api/v4l/vidioc-queryctrl.html

Regards,

	Hans
