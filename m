Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D1C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD0B21850
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFLu01Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfC2DXe (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:23:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43875 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbfC2DXe (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 23:23:34 -0400
Received: by mail-oi1-f194.google.com with SMTP id t81so575200oig.10
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkNeV8QOGdaC9OTmx6HRZu6MrUNOIo+jV8BDpbVuLzk=;
        b=gFLu01Dwq89Uwq4Jc2H+JlYEpG7Ulxw9jLf3wXTTbwLqVrWFiiozItzqSkxHc8iYbW
         a/n91236xQRyuWLv9sFXYoGzgBaXWll8AtNfZJeU2tBCPkOXwFJpd5LhSXyICu/dLOsz
         tuBzw7rK8M0ScCJY7CTiPHR49hAr8DI/aaZXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkNeV8QOGdaC9OTmx6HRZu6MrUNOIo+jV8BDpbVuLzk=;
        b=nQr1xaN7smkgAnoedu8IHZbah1jRFzGxoUR9y2AZFCs6LuViNgpp+EZnd4G6fC60jh
         q0/61bH6Wsi1xzKPvKDzSElQ60CM5q04jnT4FQYkD5Am/vr+UiI1wZZLx6hHcn5XsTJH
         GFZIsFviooK22j+nDAGpfYrRgEXQiPURtrYgvhlykYpZAliOFLGiFdiArWICXWC3xZDy
         XNrvTeCAqYk05dwX9n3FqvbDDCfFNhoqgo3dDH+fIwiD0lTJBv/yi4g1xECcrH8aHVKf
         p7M8mdlB7xpwgIyyKehrId4uIM900T0DxKGlGQITZU1uQ29HVYag7Gu6p6vxJfM5+Cyl
         pVwA==
X-Gm-Message-State: APjAAAVyw8K7gyzcjRM0ZqbeqPgR3CGRIjq1/0n8Wyu0SPXyHc1wanY3
        aN+06x9imUPJYI4XRQL+970QHNc1lnf1dw==
X-Google-Smtp-Source: APXvYqw09GkTWBPL3kjZih6sZ6aSkOhz9RBIvniTK7NQQPIP6o0aeZboM69upOQkbT/jO24ZhGCLNA==
X-Received: by 2002:aca:d8d5:: with SMTP id p204mr2377560oig.26.1553829812777;
        Thu, 28 Mar 2019 20:23:32 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id p1sm327506otl.75.2019.03.28.20.23.31
        for <linux-media@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 20:23:32 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id v7so585200oie.8
        for <linux-media@vger.kernel.org>; Thu, 28 Mar 2019 20:23:31 -0700 (PDT)
X-Received: by 2002:aca:edc7:: with SMTP id l190mr2314381oih.92.1553829811381;
 Thu, 28 Mar 2019 20:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190304192529.14200-1-ezequiel@collabora.com>
 <20190304192529.14200-9-ezequiel@collabora.com> <CAAFQd5C5zo=03-mLh4OztKS+dCjVMUe1Za25ff+dWjxQDLFLng@mail.gmail.com>
 <0618322f-ac2b-fbcd-47f2-68173318f8d7@xs4all.nl>
In-Reply-To: <0618322f-ac2b-fbcd-47f2-68173318f8d7@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 29 Mar 2019 12:23:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ct7ECe53DvAyELWsA=PCD8Bp28NzMHP5cSzDakmk3=HQ@mail.gmail.com>
Message-ID: <CAAFQd5Ct7ECe53DvAyELWsA=PCD8Bp28NzMHP5cSzDakmk3=HQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] rockchip/vpu: Support the Request API
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Thu, Mar 28, 2019 at 10:59 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 3/28/19 8:20 AM, Tomasz Figa wrote:
>
> <snip>
>
> >> +static int rockchip_vpu_buf_out_validate(struct vb2_buffer *vb)
> >> +{
> >> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> >> +
> >> +       vbuf->field = V4L2_FIELD_NONE;
> >
> > Hmm, "validate" in the name of this callback would suggest that we
> > should just check the contents, not change them. Hans, what was the
> > intention when adding this callback? Are we missing the const
> > specifier in the argument?
>
> See the original commit log:
>
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg143163.html
>
> It is allowed to either just validate and return an error if wrong,
> or change it to something known to be valid. In particular, userspace
> can set this to FIELD_ANY, and in that case the driver must replace
> it with something valid.
>
> Most drivers just support FIELD_NONE, and just set it.
>
> That said, I think we should tighten the spec for this as this is
> not well documented.
>
> I propose that if vbuf->field == FIELD_ANY, then replace it with something
> sane. Otherwise validate it and return an error if the field value
> is not supported.
>
> And FIELD_ALTERNATE is never allowed here, that's always wrong.

Thanks for clarifying. Makes sense.

Best regards,
Tomasz
