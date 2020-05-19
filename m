Return-Path: <SRS0=hmUh=7B=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9381CC433E0
	for <linux-media@archiver.kernel.org>; Tue, 19 May 2020 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBBB20708
	for <linux-media@archiver.kernel.org>; Tue, 19 May 2020 11:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESLZN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 19 May 2020 07:25:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:15477 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgESLZM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 19 May 2020 07:25:12 -0400
IronPort-SDR: K4dfbNArHqOzyoUZhPPHPkTFy7NpwPyRgEZ/aO9df4LEPUcsA+J8G0GGLw2wyLGgesbpQqlU9l
 78Ol5OOx7tVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 04:25:12 -0700
IronPort-SDR: 9nyzWw96Ht9HgVs+FIaBB/ib8ZHFnTmvOEKZhRtmNVXpwo2Eb8N9URJGfutCvVjT+c7YVlObUS
 8G5efdz+hKWA==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="282293485"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 04:25:11 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 5720220CEF; Tue, 19 May 2020 14:25:09 +0300 (EEST)
Date:   Tue, 19 May 2020 14:25:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v3 1/1] Documentation: media: Refer to mbus format
 documentation from CSI-2 docs
Message-ID: <20200519112509.GH20066@paasikivi.fi.intel.com>
References: <20200519112136.6122-1-sakari.ailus@linux.intel.com>
 <e5efc462-ff47-e6d4-8395-8786a68ac794@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5efc462-ff47-e6d4-8395-8786a68ac794@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, May 19, 2020 at 01:23:51PM +0200, Hans Verkuil wrote:
> On 19/05/2020 13:21, Sakari Ailus wrote:
> > The media bus formats to be used on serial busses are documented but there
> > was no reference from CSI-2 documentation. Add that now.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

-- 
Sakari Ailus
