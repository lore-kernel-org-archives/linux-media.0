Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8311BC001DF
	for <linux-media@archiver.kernel.org>; Thu,  3 Aug 2023 20:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHCUbM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHCUbK (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 3 Aug 2023 16:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803510CA
        for <linux-media@vger.kernel.org>; Thu,  3 Aug 2023 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691094620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3CFgGOgP9O/o8Jr9VZXMJJ8J/clTiGmzIo1gFvhvOU=;
        b=K8TIHHmo3vHx7pSdJTrJNc0AzjUJaeE6cBS0uOgBRk72QIRfcCfWxLINvEuU9ndfrcmLMx
        9LiTO4Hh4Xx2/jU1l0hahdNYxGbRg6FRUJX42t2HqR/NWYyiNryp4amGxIRoScV58RienE
        m0hUp8m8K81Wxv4gPmVeh20oQLio+Tc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-eJva-A8RPFSzNzDEGJl8Wg-1; Thu, 03 Aug 2023 16:30:18 -0400
X-MC-Unique: eJva-A8RPFSzNzDEGJl8Wg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b00a80e9so13221031fa.1
        for <linux-media@vger.kernel.org>; Thu, 03 Aug 2023 13:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691094617; x=1691699417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3CFgGOgP9O/o8Jr9VZXMJJ8J/clTiGmzIo1gFvhvOU=;
        b=fneraYn6Adi7L5W1XcmNwJaJ/DNcqCneULApuyvyn5bRTWJLP6e7brrvCo8yToecpG
         9/4zshVV4v5Iseywn0r1uXrVkRNPDm8MXFwBPhFcUmGB/WcVYkBgvhO5iBAfnS712Ko0
         ejmkcWSfR6LObiKvcuMaJhcwdAXOnnOpMDN9u/+b0cSv/lxjCFZL0Dak2uX6E/D4fuVZ
         W56SZy3YJARcsLaN3fkg0oUOlM18QABAAeogp8QsvDsnWAOepcELjxmfaX/zzI5GiF7i
         kvKOGNVqyt94dqJG8ALKsm/kbC9+me5iZFMHf6+JDM0x6QiSpRuFLe+HR51jBg6W6Kqd
         /Ijw==
X-Gm-Message-State: ABy/qLabr/dry9783Uv5vt4nL7CUHiJWpvysinPn1/Kwlek0jqAZa9X6
        cCw90v9iCdK/pn2dOgB/Foewph3iItQh7QUqLW6Uq2vI5UPgnGkvvu4lBeGlrH1XltItWSd1x5C
        el6yNGg46v3c+YmoLE38tR8zqsWWyNaBT/BPpWkM=
X-Received: by 2002:a05:651c:201:b0:2b9:ee3e:2412 with SMTP id y1-20020a05651c020100b002b9ee3e2412mr9032197ljn.22.1691094616904;
        Thu, 03 Aug 2023 13:30:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM4juzjmI/t4LIfnWZp4pccCs9/wTL0bDPxsm4o+yqeKOP9b5fXamEn0GjXpG4q5lVC9pLiWFObW4UxjOMP80=
X-Received: by 2002:a05:651c:201:b0:2b9:ee3e:2412 with SMTP id
 y1-20020a05651c020100b002b9ee3e2412mr9032184ljn.22.1691094616597; Thu, 03 Aug
 2023 13:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210905122742.86029-1-daniels@collabora.com> <20230803154908.105124-2-daniels@collabora.com>
In-Reply-To: <20230803154908.105124-2-daniels@collabora.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Thu, 3 Aug 2023 22:30:05 +0200
Message-ID: <CA+hFU4yAb=kx18AQpSLQGV37vTt44rmzt+n5XzPee9uWCEg_fA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] doc: uapi: Document dma-buf interop design & semantics
To:     Daniel Stone <daniels@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

For what it's worth this series is

Reviewed-by: Sebastian Wick <sebastian.wick@redhat.com>

On Thu, Aug 3, 2023 at 5:49=E2=80=AFPM Daniel Stone <daniels@collabora.com>=
 wrote:
>
> Hi all,
> This is v2 to the linked patch series; thanks to everyone for reviewing
> the initial version. I've moved this out of a pure DRM scope and into
> the general userspace-API design section. Hopefully it helps others and
> answers a bunch of questions.
>
> I think it'd be great to have input/links/reflections from other
> subsystems as well here.
>
> Cheers,
> Daniel
>
>

