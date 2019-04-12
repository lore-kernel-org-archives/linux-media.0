Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A44C282CE
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045ED2171F
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 15:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="mWqYcy3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDLPLA (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:11:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37171 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLPLA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 11:11:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id v13so9201920ljk.4
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6tPhpVm+zVP7MzgwZTlE3YX7FYOBAJAcqIh0hncQ+Mg=;
        b=mWqYcy3JEkcMDfmzr41EEUiswkzGiA0Eh/NMVYQcUt2vEx+Kw71n40g/embrDpOW1F
         tMdhkZ+NYcC5ogJ0pc9JiukObiVAoW2Yrhp0Ui9+Udu1O0UutK4lOySI0oHXdiZHEStS
         mFtEN+1UoQIE0OTFkLHiFuosW1OCrbUk0imB8V5Ns5pLPFPxFRWASNr05ZWkvoTcI+Ab
         R2cyrZC0kZcNVBVkserIodbPui9XjovqDoXPIug63jcL+K6ude5VF2mpuDtEeqW8yrPs
         Y77wnNxsrWTRIjqdkMkim+aYkl11ft7wx0tCT0Yye3ZhIVWJOAL/+V2smrPr+dV6cYeI
         tXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6tPhpVm+zVP7MzgwZTlE3YX7FYOBAJAcqIh0hncQ+Mg=;
        b=ZXitRQYT5XQSI0FwNAv6vLgNhjjKEW8NhiPuVyG7BGV029QhpbmmwE93P7kchFVd7r
         h+uA9AqYqhgW3ncsAPvssxcNJUzmQqUonEJNsShvSzTK8wSRc5pdNFzIiSuCidl8Gy13
         WewUsq2qeO4mLkVhN3FxM3uiy3k0Q1/Zm0uwtnUVjKL8cvofTvMyYg/WBC13WvQzD+RG
         H9cJN3uP4u/05YyWIYlW9MYrwF4VAG0PnuJxr1Em03khbYxiu+JwohCW/Os2CPdou6X2
         IoVBEprPVNYAu4BpSDbXwEkhjtXWTo3V0wwbG4Ww3qCGAN8bFPvleRPJAAROK7v8qwJj
         DxPg==
X-Gm-Message-State: APjAAAW+/HaKVTomIrYkI7oA4ohnbYREpvmyg6cSG5R5usr4wAkZvRef
        LSBO5x8ZutA4GkSZxVdvxeiekw==
X-Google-Smtp-Source: APXvYqy97cUzl7uqBRg3PiaCLFBMGdwvHOvGO/YhPwUU+UxMAvaxw5TXii1R8MF8Fc1x8Od4PJNO1Q==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr30688054lji.130.1555081857652;
        Fri, 12 Apr 2019 08:10:57 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id z15sm8152416ljz.55.2019.04.12.08.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:10:56 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:10:56 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "George G. Davis" <george_davis@mentor.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        harsha.manjulamallikarjun@in.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3 3/9] media: rcar-vin: Create a group notifier
Message-ID: <20190412151056.GD1980@bigcity.dyn.berto.se>
References: <25dc2668-d270-ebf8-b014-88bbb7a6f243@gmail.com>
 <20190408111241.GF15350@bigcity.dyn.berto.se>
 <df6fa3bf-bf21-50b0-2cad-a613e2a43ce0@gmail.com>
 <20190409205745.GB9750@pendragon.ideasonboard.com>
 <3c2c2d04-8028-3511-aba0-0ea6dd5bdc50@mentor.com>
 <20190409225948.GD9750@pendragon.ideasonboard.com>
 <69091709-a63f-6a11-4b4b-13fcf8d3e40a@gmail.com>
 <20190411202819.GA8006@vmlxhi-102.adit-jv.com>
 <20190411204237.GH30887@bigcity.dyn.berto.se>
 <20190412141205.GA17075@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190412141205.GA17075@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Eugeniu,

On 2019-04-12 16:12:05 +0200, Eugeniu Rosca wrote:
> Hi Niklas,
> 
> On Thu, Apr 11, 2019 at 10:42:37PM +0200, Niklas Söderlund wrote:
> > Hi Eugenie,
> > 
> > On 2019-04-11 22:28:19 +0200, Eugeniu Rosca wrote:
> > > Hi Niklas,
> > > 
> > > Two simple questions:
> > >  - I can only clone git://git.ragnatech.se/linux, but can't access it on
> > >    the web, does it have some web interface?
> > 
> > There should be a gitweb instance running at https://git.ragnatech.se/ 
> > if not let me know since then something is wrong ;-)
> 
> Yes, I am able to access the gitweb instance too :)
> 
> > 
> > >  - Browsing through your v4l2/next/csi2/upport branch, it looks to be
> > >    targeted for upstream. Could we rely on those commits already or
> > >    they are still in development/testing?
> > 
> > The patches in that branch are target for upstreaming but sometime 
> > changes due to review comments. Best check the media-tree of what have 
> > accepted and the patchwork instance if you want day fresh statuses. I 
> > also rebase the branch from time to time on-top of the media-tree so you 
> > should not depend on it much I'm afraid.
> > 
> > If you plan to do some work on the rcar-csi2 driver you can always reach 
> > out and check what the status is if you are unsure.
> 
> Understood. Thanks. Since I've gone off-topic quite a bit already, may I
> have your feedback on below questions sitting in the back of my mind for
> some time:

Off topic is good ;-)

> 
>  - There seem to be quite a number of non-mainlined rcar-vin patches
>    sitting on top of v4.14.75-ltsi and part of rcar-3.9.x release. With
>    some false positives, around 35-40 such commits can be identified as
>    shown in [1]. Based on my checks, only a small subset of them are
>    (actively) discussed in linux-media/linux-renesas-soc ML and for most
>    of them I can't find any trace. I am just curious if there is any
>    background force driving the upstreaming of those patches or the
>    submissions/discussions happen rather by accident?

Yes I'm driving the upstreaming of most of those out of tree patches.  
Currently a lot of them are blocked on the organic growth of the 
addition of Gen3 and my lack of understanding of v4l2 at the time. Now I 
know better and I'm in the process of cleaning up the driver to prepare 
upstreaming most of them. I will send out the first cleanup patch later 
today.

I have in the past tried to upstream all patches and then cleanup the 
feature complete driver but it's gotten to a point where that is more 
painful then doing the right thing (tm).

If there is any particular patch that would be helpful for you to have 
upstream earlier then others let me know and I can try to put it first 
in the queue.

> 
>  - I am seeing two sets of rcar-vin tests [2-3] and I think there is a
>    parent/fork relationship between them, but now they appear to be
>    diverged. Which one would you recommend? What's the test coverage
>    provided by these suites? Do you see room/chance for something like
>    drivers/gpu/drm/selftests in rcar-vin in future (maybe using
>    the upcoming kunit [4] approach?). BTW, we've been using the
>    vsp-tests for quite some time and they've been extremely useful in
>    pointing out regressions in our own patches. So, many thanks for
>    sharing those too.

The vin-tests at ragnatech.se is the parent one. It's not as nice as the 
vsp-tests and I would like to add more tests and rewrite it in python3.  
If you have additional tests pleas send me patches and I will be happy 
to include them.

One idea I would really like to do is a HDMI loopback test. Connecting 
the DU and VIN and running tests on that to allow automatic testing of 
multiple resolutions and in the future scaling. As it is now all 
vin-tests depends on external video sources. An alternate idea to this 
is to create a remote "video server" on a RPi as it can deliver both 
HDMI and CVBS video...

I see no issue with using a kernel test framework but I have little 
experience in that area and it's not something I'm planing on worknig on 
at the moment.

> 
> > 
> > -- 
> > Regards,
> > Niklas Söderlund
> 
> [1] git log --oneline --cherry-pick --right-only \
>     torvalds/master...rcar-3.9.4 -- drivers/media/platform/rcar-vin/
> [2] https://git.ragnatech.se/vin-tests/
> [3] http://jmondi.org/git/vin-tests/
> [4] https://patchwork.kernel.org/cover/10704157/
> 
> Best regards,
> Eugeniu.

-- 
Regards,
Niklas Söderlund
