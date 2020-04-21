Return-Path: <SRS0=yO7E=6F=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C8C54FC9
	for <linux-media@archiver.kernel.org>; Tue, 21 Apr 2020 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23FB2098B
	for <linux-media@archiver.kernel.org>; Tue, 21 Apr 2020 08:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="G1zzEvW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUIlt (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:41:49 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:56227 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUIls (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 21 Apr 2020 04:41:48 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id QoTPj6EzB7xncQoTSjJgbN; Tue, 21 Apr 2020 10:41:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1587458506; bh=OG3Mtfrwz8C74Ez2yygdJKThLJzSGAG3ac+KFhQ3L3E=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=G1zzEvW/dchicNQUFWLRU+sgCR8wwLb3w519+Mp9kGJKia9sug+5uRZMn5hPstXim
         x/9ZhhQEklKhCfX49fTZSEgcE11wTZYaGqndrAnKFoAgCzGp0vHZ4jJAhWmU4I3tsA
         by4pfk+esZp1mgjhWJOLuzcFMZsg5kVujUQ/evuZhoZj/IQR5fFEp6KEeiSZ0TtuWs
         RsMQauGG4VHaeqappTbd2Uj2mfleZ9jX58XxSTKazceqf+9TV1PsQohIgfxUK8fLF7
         i7nr7TZy0AYhdX0xMZM8Dg1en0R1cgrV3jmxEBhqASBoihVGmQP1zps2iSTpbdO7EN
         tp/tS82MYOKyA==
Subject: Re: [PATCH 5/7] media-info: fix NULL check
To:     Rosen Penev <rosenp@gmail.com>, linux-media@vger.kernel.org
References: <20200420184649.4202-1-rosenp@gmail.com>
 <20200420184649.4202-5-rosenp@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <37de944c-e773-afd1-c376-313cb0220b76@xs4all.nl>
Date:   Tue, 21 Apr 2020 10:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420184649.4202-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFtkWQGn6lZ+Bb8aUslfBfPpjvxeJRPHjFS7EKpMJI24/ZVZbscW43ePgnH5pnv3tbEO0IryqwucdPD+asi3hSIy3miLCrhNXYsN2iiGMkYH2xpDkxW+
 wPgSAfoljV3RrRHyAsZuu968rr/OQc32r8s5qVqnm73BYjQTNTavm5MTN2v/2ZZ+g9QxCAwOYVy8x6nHaRKTGS+RO7ZqsvDIjQ0=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 20/04/2020 20:46, Rosen Penev wrote:
> Found with clang-tidy's bugprone-bool-pointer-implicit-conversion
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  utils/common/media-info.cpp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/utils/common/media-info.cpp b/utils/common/media-info.cpp
> index b0f0bc41..cb48d0df 100644
> --- a/utils/common/media-info.cpp
> +++ b/utils/common/media-info.cpp
> @@ -357,7 +357,7 @@ std::string mi_entfunction2s(__u32 function, bool *is_invalid)
>  			return fail ? entity_functions_def[i].str + 6 : entity_functions_def[i].str;
>  		}
>  	}
> -	if (is_invalid)
> +	if (is_invalid != NULL)
>  		return "WARNING: Unknown Function (" + num2s(function) + "), is v4l2-compliance out-of-date?";
>  	return "Unknown Function (" + num2s(function) + ")";
>  }
> 

This makes no sense: why just this instance when there are a lot more
'if (is_invalid)' checks in this function?

In any case, this is also normal idiom and I don't want to apply this patch.

Regards,

	Hans
