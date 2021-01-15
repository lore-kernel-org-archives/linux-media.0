Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B6C4332B
	for <linux-media@archiver.kernel.org>; Fri, 15 Jan 2021 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3E9222BB
	for <linux-media@archiver.kernel.org>; Fri, 15 Jan 2021 06:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbhAOG53 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG53 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972BC061575
        for <linux-media@vger.kernel.org>; Thu, 14 Jan 2021 22:56:48 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CE621527;
        Fri, 15 Jan 2021 07:56:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610693806;
        bh=TRb29cMNwqQw5i2fi+cG4XzHqKHneYtui64cJTaMR4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O47IYC43Nl+13HHA39oMsd8xeDWz1tcpj93/IJruPTT1nXAZP6yQ2MwJ250MIDRqi
         VRrfPQhEYlqKUQi2T+j3uOasdWNuQbMZYmfgWV9Y1CQMzhEmq9/oF/B6MbDbtpdrSx
         9pvtuIrWWWU6joeyj3XbkcbhQZHo9WBbVpPqQyOk=
Date:   Fri, 15 Jan 2021 08:56:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        kernel@collabora.com, Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 11/13] media: v4l2-async: Drop
 v4l2_fwnode_reference_parse_sensor_common mention
Message-ID: <YAE8nMMyK+3iEG+E@pendragon.ideasonboard.com>
References: <20210112132339.5621-1-ezequiel@collabora.com>
 <20210112132339.5621-12-ezequiel@collabora.com>
 <X/+o/P3DB+SBzieL@pendragon.ideasonboard.com>
 <1ff4e56a7f0bd551f97cf7c818d2de7b1a875f65.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ff4e56a7f0bd551f97cf7c818d2de7b1a875f65.camel@collabora.com>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Ezequiel,

On Thu, Jan 14, 2021 at 10:36:54AM -0300, Ezequiel Garcia wrote:
> On Thu, 2021-01-14 at 04:14 +0200, Laurent Pinchart wrote:
> > On Tue, Jan 12, 2021 at 10:23:37AM -0300, Ezequiel Garcia wrote:
> > > The v4l2_async_notifier_cleanup documentation mentions
> > > v4l2_fwnode_reference_parse_sensor_common, which doesn't exist.
> > > Drop it.
> > 
> > The function is actually called
> > v4l2_async_notifier_parse_fwnode_sensor_common(). It was introduced in
> > commit 7a9ec808ad46 ("media: v4l: fwnode: Add convenience function for
> > parsing common external refs") with an incorrect name in the
> > documentation. Commit b064945517ee ("media: fix kernel-doc markups")
> > fixed the kerneldoc header for the function, but forgot to address this
> > location.
> 
> OK, I'll fix the commit description.

I think it's more than the commit description, instead of dropping the
reference to v4l2_fwnode_reference_parse_sensor_common(), it should be
replaced with a reference to
v4l2_async_notifier_parse_fwnode_sensor_common().

-- 
Regards,

Laurent Pinchart
