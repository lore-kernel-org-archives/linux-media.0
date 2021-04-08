Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB8C433B4
	for <linux-media@archiver.kernel.org>; Thu,  8 Apr 2021 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A24610F9
	for <linux-media@archiver.kernel.org>; Thu,  8 Apr 2021 15:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhDHPLF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:11:05 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:54087 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhDHPLE (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 8 Apr 2021 11:11:04 -0400
Date:   Thu, 08 Apr 2021 15:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1617894651;
        bh=w9Ll73lXc4jbHSDyvX8yN7Cj0kZoc2l9DiDSA0gWKfQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=m/35YXydKWQ01MVvB+QD/EZYy50RPVsltK4AvFbWTJPBAXsnwxxfJ+//d7QKk3RVn
         kSU5zsVMY6rmPVV0gVQn5q+kb0f0cG3cx8pMXN9mTVO5wXXgs99y3fokQ0Q6S8W865
         /5FWMbyUhkdOn39pkXAM1C3Wa+C90RM+HByHGL5kvN42oZyJjZW4CeVXhwGuNu1HGN
         fDvSP7kUiST/acmJ2W6qONFD/aPJTo4yAvGZ2E1VxDs22laX/iSJZ2y6QB4YuuQvzs
         qZgiof0stInYmoOI5IK/PqqTpXpa6TpKeFzHelslsaLkc2ksNn9YtYQoEW1I1eNk2T
         LQKPoOF50grzw==
To:     Jani Nikula <jani.nikula@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        xorg-devel@lists.x.org, dri-devel@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: Call for an EDID parsing library
Message-ID: <BIyXHmd9St1ss-z2I5n6mdZZFRRBj2zhTq4eMGjlN-mmPpp_7VC2HjUyF22htq84SlVwil4LBddopV6slVnJIKWd6VcFmzVZOxSTzTpt0BY=@emersion.fr>
In-Reply-To: <87o8eoj01m.fsf@intel.com>
References: <20210407114404.13b41822@eldfell> <7d8dc3ea-a935-5145-482c-42ea43dfd782@xs4all.nl> <87mtuajshc.fsf@intel.com> <33467672-b66a-7658-de04-7bc37153613f@xs4all.nl> <87r1jkj37y.fsf@intel.com> <20210408171311.61f433bd@eldfell> <87o8eoj01m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thursday, April 8th, 2021 at 4:58 PM, Jani Nikula <jani.nikula@linux.int=
el.com> wrote:

> Perhaps that should be the takeaway; try to minimize parsed data
> where the consumer needs to know whether it originated from DisplayID or
> EDID?

So an EDID/DisplayID abstraction layer?

It sounds like only an EDID and DisplayID expert could come up with a
sane API for that. Also some metadata will only be available in one
format and not the other.
