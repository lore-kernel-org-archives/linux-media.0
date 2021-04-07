Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0BDC433ED
	for <linux-media@archiver.kernel.org>; Wed,  7 Apr 2021 11:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48B8611EE
	for <linux-media@archiver.kernel.org>; Wed,  7 Apr 2021 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245438AbhDGLAO (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 7 Apr 2021 07:00:14 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:47379 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351775AbhDGK7s (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 7 Apr 2021 06:59:48 -0400
Date:   Wed, 07 Apr 2021 10:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1617793177;
        bh=KJECspWceKoa/duWfXXTOMcSU5xltHyQQjQgzOtcgd0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=m0my42GxxYDfe3qBBDjj+tEiqB2CrpYdDTMHVS3uR699qis4AM07aA4bB+L6uCsx4
         j7ESLhKddZmaOGFm9Xbr6GVIuapQc7CADiqj+wiAXy52HvZqGBmuuNpGbuc/eZ6lXp
         XQcclKfCSRrvvmeuHkEsbPT6Ksd3GW4dlrbv/znx8T1TWgBEQV7lQHYcigsdh8NrU6
         Z+qa2llJtSdKLHfrh5jv+h+mGN7BtBp0eoI8v3nCRkYTlgtujGyiWf/+WMDIjty9tK
         /FBzV5ow1F2ylj8X927YV41Np4z0Q3PMWRE1SQZqrwLKQnsRaqmJdHPObUFPyapsp2
         dY1z5wV0SZuOQ==
To:     Pekka Paalanen <ppaalanen@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org, xorg-devel@lists.x.org,
        linux-media@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Call for an EDID parsing library
Message-ID: <DJjftAG6WNev87c34XyXFLCHe49rJBCYdqENxfO3uHXUFJXmPerOg5LuQKAbd3D_pdO34vkWgfy9uggujNI12VE-ttglyarF5wAogYC8m3E=@emersion.fr>
In-Reply-To: <20210407114404.13b41822@eldfell>
References: <20210407114404.13b41822@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

FWIW, with my Sway/wlroots hat on I think this is a great idea and I'd
definitely be interested in using such as library. A C API with no
dependencies is pretty important from my point-of-view.

I'd prefer if C++ was not used at all (and could almost be baited into
doing the work if that were the case), but it seems that ship has
sailed already.

Simon
