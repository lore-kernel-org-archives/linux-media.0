Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D117C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5786C2133D
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554331189;
	bh=XJugx+pDb+E22hFL8JSurNh3NLROV0jc03dkpURev1M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=f4myx8Qd2khTxsAnVArm8YVvKNF2Gz6rpafbVuSU7gulv68qco86S9OYbm66QsFuV
	 NMe5FiNhwIH+4vs8kOuTXcIM9YMWEOxxWxmYRlUgPtMhQAJ5dxVTc7gacKgOJ8R/Im
	 DWpl4Ongw/L6/Gh+eLVtd+Gf1v+vGHbieLVX8+q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDCWjs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCWjs (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 18:39:48 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18FA206BA;
        Wed,  3 Apr 2019 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554331188;
        bh=XJugx+pDb+E22hFL8JSurNh3NLROV0jc03dkpURev1M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ufH89qPbfQfxJnp4bJuH/mb8wDXIOuMI4BLvXl8T7LDWd8JcBEDtI5zA7jE4mAI/n
         XaSoa/nSM5LzYTGeQeSlszAzH+HEQtRNWrDExHyXPf68psTrXWgn/qFeColzvgL9z7
         jSKuXlffNXlXSFfWL4OsVDBiWuQh287V1Q70GDxQ=
Subject: Re: [GIT PULL FOR v5.2] Media Device Allocator API
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        shuah <shuah@kernel.org>
References: <30de419f-5dac-71a1-9255-d334d6025a0d@xs4all.nl>
From:   shuah <shuah@kernel.org>
Message-ID: <98129d19-792b-fedf-6807-2bcd9bb066c4@kernel.org>
Date:   Wed, 3 Apr 2019 16:39:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <30de419f-5dac-71a1-9255-d334d6025a0d@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/3/19 1:32 AM, Hans Verkuil wrote:
> Hi Mauro,
> 
> After five (!) years of work, this is finally ready to go in.
> 
> Thank you Shuah for your perseverance!
> 

Awesome. I am glad that this work is finally getting in.

thanks,
-- Shuah

