Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B6C4360F
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564F021473
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554206336;
	bh=kPVb4JSbXLycX0VOr7YAyRYc91BWudvWpqxq2tSag58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ag+JnmXNFX/UJp/jGAg0Xhyl5/4Q5WojpUoYyAzVJlndh0zyluM++GsZmjmo9SYSK
	 cil/FLgc/dlMLEJkHjigJ0/zICBXZNFbsH6rHq/KMMqKPcUVr6sfL61PRUln+yzWPL
	 dkR1OxbxxIGZqV3Za87Wf0lKUN+clCO06+xn1VBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfDBL6z (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBL6z (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 2 Apr 2019 07:58:55 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6A42147C
        for <linux-media@vger.kernel.org>; Tue,  2 Apr 2019 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554206334;
        bh=kPVb4JSbXLycX0VOr7YAyRYc91BWudvWpqxq2tSag58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XpWMN+y1P6tUbPGuzTIF3gvAQD5ChoW9JPgZD7REdxl1d8+TGh1nd3Ig/AH6GksIZ
         CTzMcchLO9msdzLRqc50itn26UtPvDIh1sP9jqfy4l2TyIchw4mPY+CfOj24w9L9pL
         nVNSDqPgRnlX2QHJyZUo3+KbVZaASohyFzWNb2FA=
Received: by mail-qk1-f169.google.com with SMTP id z76so7645165qkb.12
        for <linux-media@vger.kernel.org>; Tue, 02 Apr 2019 04:58:54 -0700 (PDT)
X-Gm-Message-State: APjAAAVO3ras3gTZrjYrtsFckmwSQu1n7XosMIXHuS0pOu43IdLBJ5pg
        D5J7wMJwYkQnr1w666+asbPJ/OsGaB1GZL95DcQ=
X-Google-Smtp-Source: APXvYqyYCazrPf973X2eLChq2ryuhYzfS3TGWYgV1SFbSQp4wONoOejcYgL8R9OOnGmAsF260n85MVTp50QBGV5nOwQ=
X-Received: by 2002:a37:6546:: with SMTP id z67mr51398348qkb.254.1554206333612;
 Tue, 02 Apr 2019 04:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <1554170701-10210-1-git-send-email-yunfei.dong@mediatek.com>
In-Reply-To: <1554170701-10210-1-git-send-email-yunfei.dong@mediatek.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Tue, 2 Apr 2019 07:58:42 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5abZmBe1QxzL5C76jB=fYH7N0KQo3XXE1uC6qHY=uaGg@mail.gmail.com>
Message-ID: <CA+5PVA5abZmBe1QxzL5C76jB=fYH7N0KQo3XXE1uC6qHY=uaGg@mail.gmail.com>
Subject: Re: pull request: linux-firmware: Update Mediatek MT8173 VPU firmware
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 1, 2019 at 10:05 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> Hi linux-firmware maintainers,
>
> The following changes since commit 7bc246451318b3536d9bfd3c4e46d541a9831b33:
>
>   Merge branch 'for-upstream' of git://git.chelsio.net/pub/git/linux-firmware (2019-03-14 08:22:39 -0400)
>
> are available in the git repository at:
>
>   https://github.com/yunfei-dong/linux_fw_vpu_v1.1.2.git v1.1.2
>
> for you to fetch changes up to c1b685587a6ffd651e900eff4e945619487f91bc:
>
>   mediatek: update MT8173 VPU firmware to v1.1.2 (2019-04-01 16:02:08 +0800)
>
>  ----------------------------------------------------------------
> Yunfei Dong (1):
>     mediatek: update MT8173 VPU firmware to v1.1.2
>
> vpu_d.bin |  Bin 2977008 -> 2977008 bytes vpu_p.bin |  Bin 131168 -> 131180 bytes
> 2 files changed, 0 insertions(+), 0 deletions(-)

Pulled and pushed out.  Thanks.

josh
