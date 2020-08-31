Return-Path: <SRS0=P+oI=CJ=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576ECC433E7
	for <linux-media@archiver.kernel.org>; Mon, 31 Aug 2020 14:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179D720866
	for <linux-media@archiver.kernel.org>; Mon, 31 Aug 2020 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598883769;
	bh=pgacFH3zLkMQq+pq3zSvPUadQeunRUThFZbP0DHzo0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/BvUI768VjnDsSEwhl7A/8CkHByAa/hLtd0RM8AckutNciXkcojS+68K0OFX6kax
	 40yYRY5ajFcKne2QrLvqlcQ4JTnlEHkFyPMe6dzr+KpxLlex6qEdnSGrIaztlXMeHX
	 tKQvSvrpZ2ciWOZl6piXAq3kRT7XuEJYbIKd3u/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHaOWm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHaOWm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 31 Aug 2020 10:22:42 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D1120866;
        Mon, 31 Aug 2020 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598883762;
        bh=pgacFH3zLkMQq+pq3zSvPUadQeunRUThFZbP0DHzo0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C50VzbBFvYX9zLgqtMrJboj+FzxN+wRm/j/9qEmp6tPYLGegR2M0ekWTyB2Bxfped
         ijlESGqku/xQtZ2FYT9CIyKVKqCNc/ICSPEzBUd31e6OPCvDCn4liqmky7l7aXNvWB
         FhXQkfRXX4VVvy2TbFTLnQT5MormLqRakds4ZEK4=
Date:   Mon, 31 Aug 2020 09:28:48 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     dan.carpenter@oracle.com, andriy.shevchenko@linux.intel.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH v2] staging: atomisp: Remove unnecessary 'fallthrough'
Message-ID: <20200831142848.GF2671@embeddedor>
References: <20200831134021.GV8299@kadam>
 <20200831135103.93399-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831135103.93399-1-cengiz@kernel.wtf>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Aug 31, 2020 at 04:51:04PM +0300, Cengiz Can wrote:
> commit df561f6688fe ("treewide: Use fallthrough pseudo-keyword") from
> Gustavo A. R. Silva replaced and standardized /* fallthrough */ comments
> with 'fallthrough' pseudo-keyword.
> 
> However, in one of the switch-case statements, Coverity Static Analyzer
> throws a warning that 'fallthrough' is unreachable due to the adjacent
> 'return false' statement. (Coverity ID CID 1466511)
> 
> In order to fix the unreachable code warning, remove unnecessary
> fallthrough keyword.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> index 1b2b2c68025b..feb26c221e96 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
> @@ -711,7 +711,6 @@ static bool is_pipe_valid_to_current_run_mode(struct atomisp_sub_device *asd,
>  			return true;
>  
>  		return false;
> -		fallthrough;
>  	case ATOMISP_RUN_MODE_VIDEO:
>  		if (!asd->continuous_mode->val) {
>  			if (pipe_id == IA_CSS_PIPE_ID_VIDEO ||
> -- 
> 2.28.0
> 
