Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B578C64E7A
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD565206F9
	for <linux-media@archiver.kernel.org>; Tue,  1 Dec 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qNxlGHJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgLANsf (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 1 Dec 2020 08:48:35 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42790 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgLANsf (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 1 Dec 2020 08:48:35 -0500
Received: from [IPv6:2a01:e0a:169:7140:52f6:d361:b833:6455] (unknown [IPv6:2a01:e0a:169:7140:52f6:d361:b833:6455])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52763538;
        Tue,  1 Dec 2020 14:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1606830473;
        bh=IBhLYMg/vRl9krO1b2F6ul6AxG3rHTgXqtn6okzDcHo=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=qNxlGHJASfZqfB9f4njlF46ZD1Q3k3lDioSya3bIzdgrtB3cd9TX24CNLeKJUOeUo
         cAi74vSqdU4Nc5/fOb6RUGf+zLq1jqXM8qiVhZorzb0HpPL+wqJVQ+UXqJwq6Cy2ov
         Oc+aN5qFump2fsFxZgrAnEFcTIPwRdk1sWGzj36s=
Subject: Re: Intel IPU3: can't retrieve 3A Auto Exposure (AE) statistics
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     sakari.ailus@linux.intel.com
Cc:     linux-media@vger.kernel.org, libcamera-devel@lists.libcamera.org
References: <ae23247b-64cf-aecd-7d71-46581e0f9b1e@ideasonboard.com>
Message-ID: <a9a17ed5-3794-569a-8782-df360a94906a@ideasonboard.com>
Date:   Tue, 1 Dec 2020 14:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ae23247b-64cf-aecd-7d71-46581e0f9b1e@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi all,

On 30/11/2020 16:23, Jean-Michel Hautbois wrote:
> Hi Sakari, all,
> 
> I am currently working with libcamera and trying to make it work on a
> IPU3 pipeline (MS Surface Go 2)...
> I can set the buffer parameters, thanks to Niklas work, but can't get
> the 3A statistics buffer back.
> More precisely, the buffers are queued/dequeued but the 'ae_en' bit is
> never set to 1, and all the raw buffers are set to '0' values.
> 
> I suppose I have missed to set one parameter somewhere, but according to
> https://www.kernel.org/doc/html/v5.6/media/uapi/v4l/pixfmt-meta-intel-ipu3.html#c.ipu3_uapi_ae_grid_config
> setting the 'ae_en' bit in the ipu3_uapi_ae_grid_config structure should
> be enough to trigger ?
> 
> I have pushed my (very work in progress) work here:
> https://github.com/jhautbois/libcamera/tree/test-fake-ipu3-ipa
> 
> I would appreciate feedback on this stuff, as I can't see anything
> missing from a user-space perspective right now... :-)

I have made some progress, as I now set the V4L2_CID_IPU3_PIPE_MODE
properly... I now have the awb_en, af_en and awb_fr_en set to 'true'.
But ae_en is always 'false'...

JM
