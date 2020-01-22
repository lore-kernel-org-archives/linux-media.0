Return-Path: <SRS0=cCoD=3L=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB0C32771
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 07:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDE124125
	for <linux-media@archiver.kernel.org>; Wed, 22 Jan 2020 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MOtlcrKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAVHQ1 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:16:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43359 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVHQ1 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 22 Jan 2020 02:16:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id j20so1454256qka.10
        for <linux-media@vger.kernel.org>; Tue, 21 Jan 2020 23:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=P+/iuiBLq7uPEhqosucYoZMfKA/Q86efqmkOl3g1vxw=;
        b=MOtlcrKZrIa1DTJluQPMB4fRQIwJQKBfMXdLR6nADM8B1B3JFs35mUIzLxizqV0NdT
         /hNRqBtvsY6YS9Quc2eO8QqOatiTWTL4GIwwLBw8r+o7g0yfNNBZ+MrWRQ0e93Thcy7f
         zVFIf+Eki+U30WramiUr7ZktZSGY3ED6shzRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P+/iuiBLq7uPEhqosucYoZMfKA/Q86efqmkOl3g1vxw=;
        b=VHE3Ko/yoi2gvmK6Jwez0sAV1/UjJ5lU8yVg0Ezx4rfnDbDaQ384I3uc8FlRObuuOb
         NR8tii065MdLCNmWNaXc+o/6wS9/F0bCIQHQPETAkvU16Qjbfvgp3wO788W9UzjXgQ+y
         EiOAqLNYGDf1LNfiVaXEzT5p37KiL+5Zrz1o+5h5xLnvMY9Ov0LBjReXJsGvOI0RX0J5
         hI0QHNzs2v9CMq9DT3PKKsK6D6NGxWE0cU5KbSZXZYhZQY9qdZCjgqraZbbKigA+ldS9
         B0xej3plgX3gOtM7zlOSqKpyRtU8wRKG2Yl9WeFai7tyno1fEVESxDurRQsByVZcnoiS
         l5zw==
X-Gm-Message-State: APjAAAUOMWTIgkrZ6JKV8vZxassF7GvPy3gPLoSGbdm+xuoWwwtC4B41
        dBgJwacm+zKsVPC6C/0ZFwTIeP3fZmbqkb3BNfCnaA==
X-Google-Smtp-Source: APXvYqwskXmK7PXdyj8x38TPmSf0hJIXr6CQd72S8gVTKQSPIFrsczXtzYTy6QpSZoAiHBABoFoO6EVE31PPbOp6ypI=
X-Received: by 2002:a05:620a:910:: with SMTP id v16mr8796636qkv.194.1579677386047;
 Tue, 21 Jan 2020 23:16:26 -0800 (PST)
MIME-Version: 1.0
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 22 Jan 2020 16:16:15 +0900
Message-ID: <CAD=HUj71Z_eQUj93LZYOAc+Prj9ohym1oJtiLWzCy5=T-cNxCQ@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v2 0/2] Cross-device resource sharing
To:     virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Alex Lau <alexlau@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Pawel Osciak <posciak@chromium.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

This RFC comes from the recent discussion on buffer sharing [1],
specifically about the need to share resources between different
virtio devices. For a concrete use case, this can be used to share
virtio-gpu allocated buffers with the recently proposed virtio video
device [2], without the need to memcpy decoded frames through the
guest.

[1] https://markmail.org/thread/jeh5xjjxvylyrbur
[2] https://markmail.org/thread/yb25fim2dqfuktgf

Changes v1 -> v2:
Rename exported resource to exported object
Rename the virtio-gpu export command

David Stevens (2):
  content: define what an exported object is
  virtio-gpu: add the ability to export resources

 content.tex    | 18 ++++++++++++++++++
 virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
