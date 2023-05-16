Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8AC77B7A
	for <linux-media@archiver.kernel.org>; Tue, 16 May 2023 08:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjEPIL5 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 16 May 2023 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjEPIL4 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 16 May 2023 04:11:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E010EF;
        Tue, 16 May 2023 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684224715; x=1715760715;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4PmBifolSayMyjTDCnehOHENnUmjyS1+9ipEjl7yTUA=;
  b=f/oHd5HciG8h24RZBMLPQiJzEWQEdh+DB0IhsPVj/zjI1dIM0ujf/4dy
   +/lqTY5T+N1cP9725v31CWFI6yE3QFG6+8UcR0Y51PbtRNAINLOc4Ly1w
   qX7dKlqeirr9rMVah47gDTZwMwWwhosCHXekP+tIBw0ZjiL6yYUtyIw8N
   EpLG6IbvJ2hehWyjFFzVebu0oLb2rbeiFKUcDYWQ0kI/zfQ62SgiKUOue
   a1+u2gH29ME/tqrOAl6vRHMqTCHw919WKXw3qHEbB0jZ7iY6gGK7WChrC
   iqoffNrhzZ7UBGh6Top4ebGVWqq/LrQkexG5qtaJN4v+H+huHZVRmHnAo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="335960725"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="335960725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="1031208455"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="1031208455"
Received: from dperchan-mobl1.ger.corp.intel.com (HELO terminus) ([143.185.115.141])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:11:52 -0700
Message-ID: <1d425030407e11d776070e8ef12ce51dac3e0147.camel@intel.com>
Subject: Re: [PATCH v3] media: uapi: v4l: Intel metadata format update
From:   Dmitry Perchanov <dmitry.perchanov@intel.com>
To:     Sakari Ailus <sakari.ailus@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        evgeni.raikhel@intel.com, demisrael@gmail.com
Date:   Tue, 16 May 2023 11:11:49 +0300
In-Reply-To: <ZGIp7E94eAW7UFSP@valkosipuli.retiisi.eu>
References: <7e0e6a37eee28185ec2fbd4f1d42569c8da6726d.camel@intel.com>
         <ZGIp7E94eAW7UFSP@valkosipuli.retiisi.eu>
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, 2023-05-15 at 15:47 +0300, Sakari Ailus wrote:
> Hi Dmitry,
> =

> On Sun, May 14, 2023 at 12:36:50PM +0300, Dmitry Perchanov wrote:
> > Update metadata structure for Intel RealSense UVC/MIPI cameras.
> > Compliant to Intel Configuration version 3.
> > =

> > Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> =

> Could you reply my comments on v2 and use my @intel.com address going
> forward?
It's done.
Thanks.
> =

> Thanks.
> =


---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

