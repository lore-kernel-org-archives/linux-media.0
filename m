Return-Path: <SRS0=Zegy=33=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268F7C352A2
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F4217BA
	for <linux-media@archiver.kernel.org>; Fri,  7 Feb 2020 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581067182;
	bh=TaY7DftIs9s0oIEZQOs26riRQjHMYHQdCxYaJ4GxTKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PAhQkKVpQHB9rUgCuZ/r0kpxU3foVYw881DcjvCseiwOegA9oz/c1EscSG/h7Y/bC
	 1TTZdANqiTpS8LlpjkyPMYOkAW6/+pgdtAOTcqHPQ3LEG4I/wtWGtDlvKSZCC4Q1rq
	 Pa8BDZsx4GNPCmczWNQ4IIiX3ioWVJoF5VD4VeNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgBGJTm (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGJTm (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 7 Feb 2020 04:19:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2356E214AF;
        Fri,  7 Feb 2020 09:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581067181;
        bh=TaY7DftIs9s0oIEZQOs26riRQjHMYHQdCxYaJ4GxTKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZiG5XMTNnUtcLH7P1U/64nubd4xTobOul0nm3OwL/FQA14KyUAwvCxDV+vZnWnQE
         AirtCr0vDh7LDQi0Hs+mOBamNbGeAx0hrci/hEu85KMvRTW3iLdzOTBwOrCvfMCxa8
         fXd3yaVg8IEL3hXXkT72vwZwbUtvnXun6CtzccTI=
Date:   Fri, 7 Feb 2020 10:19:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH 05/11] staging/most: rename VFL_TYPE_GRABBER to _VIDEO
Message-ID: <20200207091939.GA503347@kroah.com>
References: <20200203114119.1177490-1-hverkuil-cisco@xs4all.nl>
 <20200203114119.1177490-6-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203114119.1177490-6-hverkuil-cisco@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Feb 03, 2020 at 12:41:13PM +0100, Hans Verkuil wrote:
> 'GRABBER' is a weird name, all other types map to the /dev
> device names. Rename to 'VIDEO' to be consistent with the
> other types.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christian Gromm <christian.gromm@microchip.com>
> ---
>  drivers/staging/most/video/video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
