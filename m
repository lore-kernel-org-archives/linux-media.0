Return-Path: <SRS0=xNSo=XT=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C69C432C2
	for <linux-media@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BAB20872
	for <linux-media@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504826AbfIXMCB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:02:01 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:47513 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395363AbfIXMCB (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 24 Sep 2019 08:02:01 -0400
Received: from [IPv6:2001:420:44c1:2577:813c:89fd:7ccb:168c] ([IPv6:2001:420:44c1:2577:813c:89fd:7ccb:168c])
        by smtp-cloud7.xs4all.net with ESMTPA
        id CjVziyTPN9D4hCjW2iuwdK; Tue, 24 Sep 2019 14:01:58 +0200
Subject: Re: [PATCH] v4l2-compliance: Verify metadata formats
To:     Vandana BN <bnvandana@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20190924092530.17749-1-bnvandana@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <49ffdb33-39a7-aa44-fb0c-302e963972b1@xs4all.nl>
Date:   Tue, 24 Sep 2019 14:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924092530.17749-1-bnvandana@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI9C3wFse1SUWb/GXWaNRvMQ/yvo8nXnuAmZ6WiLJSLXDz0GjVWX8+yv0ApBiF21qXElMHT/OJLzv3ADz4dGRVfFY1QfYz7gNHUlaqGVTYDBFSuu3yOZ
 jlElughXP6Hjvrzu96xqSVPPgFc8R6Dj4wjD788YFM8AMBUC4Y03DoZmurAkaY47p3+9n62HpIAFFHNM9jZzPTn45xRM4ueFXD/in7B3gWrQJcReGr1FahUi
 SCvQweuv9YqaLr7aFj2Mov+PYM0NI+zhTPT8EeoNQ3S70UDaBhzwxAHiSWg8FNVdbWBXDjTnk7MFiZcobGxJDNRI9VeiNh0DSR0ukm/xLUbq0/8ozJWMLu81
 KYoT64Al+hkauOfr3u8dkDwRXu0n5Q==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 9/24/19 11:25 AM, Vandana BN wrote:
> changes to testEnumFormats() and testGetFormats() to verify METADATA type.
> G_FMT sets node->valid_buftypes, so TRY/S_FMT does not get called for
> other input types, hence did not modify them.

This is a very confusing commit log.

The core problem is that for a given input or output there may not be any
metadata formats defined. And that is what is fixed here.

> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> ---
>  utils/v4l2-compliance/v4l2-test-formats.cpp | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/utils/v4l2-compliance/v4l2-test-formats.cpp b/utils/v4l2-compliance/v4l2-test-formats.cpp
> index 525dfafa..604ea921 100644
> --- a/utils/v4l2-compliance/v4l2-test-formats.cpp
> +++ b/utils/v4l2-compliance/v4l2-test-formats.cpp
> @@ -305,8 +305,6 @@ int testEnumFormats(struct node *node)
>  		case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>  		case V4L2_BUF_TYPE_SDR_CAPTURE:
>  		case V4L2_BUF_TYPE_SDR_OUTPUT:
> -		case V4L2_BUF_TYPE_META_CAPTURE:
> -		case V4L2_BUF_TYPE_META_OUTPUT:
>  			if (ret && (node->g_caps() & buftype2cap[type]))
>  				return fail("%s cap set, but no %s formats defined\n",
>  						buftype2s(type).c_str(), buftype2s(type).c_str());
> @@ -314,6 +312,10 @@ int testEnumFormats(struct node *node)
>  				return fail("%s cap not set, but %s formats defined\n",
>  						buftype2s(type).c_str(), buftype2s(type).c_str());
>  			break;
> +		case V4L2_BUF_TYPE_META_CAPTURE:
> +		case V4L2_BUF_TYPE_META_OUTPUT:
> +			/* Metadata formats need not be present for all input types */

for all input types -> for the current input/output

> +			break;
>  		default:
>  			if (!ret)
>  				return fail("Buffer type %s not allowed!\n", buftype2s(type).c_str());
> @@ -599,8 +601,6 @@ int testGetFormats(struct node *node)
>  		case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>  		case V4L2_BUF_TYPE_SDR_CAPTURE:
>  		case V4L2_BUF_TYPE_SDR_OUTPUT:
> -		case V4L2_BUF_TYPE_META_CAPTURE:
> -		case V4L2_BUF_TYPE_META_OUTPUT:
>  			if (ret && (node->g_caps() & buftype2cap[type]))
>  				return fail("%s cap set, but no %s formats defined\n",
>  					buftype2s(type).c_str(), buftype2s(type).c_str());
> @@ -608,6 +608,15 @@ int testGetFormats(struct node *node)
>  				return fail("%s cap not set, but %s formats defined\n",
>  					buftype2s(type).c_str(), buftype2s(type).c_str());
>  			break;
> +		case V4L2_BUF_TYPE_META_CAPTURE:
> +		case V4L2_BUF_TYPE_META_OUTPUT:
> +			if(ret && !node->buftype_pixfmts[type].empty())

Space after 'if'.

> +				return fail("%s Get_format failed, but %s formats defined\n",

Get_format -> G_FMT

> +					buftype2s(type).c_str(), buftype2s(type).c_str());
> +			if(!ret && node->buftype_pixfmts[type].empty())

Space after 'if'.

> +				return fail("%s Get_format success, but no  %s formats defined\n",

G_FMT, 'no  %s' -> 'no %s' (space too many.

> +					buftype2s(type).c_str(), buftype2s(type).c_str());
> +			break;
>  		default:
>  			/* ENUMFMT doesn't support other buftypes */
>  			break;
> 

Regards,

	Hans
