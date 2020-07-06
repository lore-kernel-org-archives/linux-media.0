Return-Path: <SRS0=iZD8=AR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF18C433E1
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD49206E9
	for <linux-media@archiver.kernel.org>; Mon,  6 Jul 2020 18:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkiB0iet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgGFS2v (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgGFS2v (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Jul 2020 14:28:51 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AEBC061755
        for <linux-media@vger.kernel.org>; Mon,  6 Jul 2020 11:28:51 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 187so19410531ybq.2
        for <linux-media@vger.kernel.org>; Mon, 06 Jul 2020 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc1eobGkBG0LfrmIA8F/omWKPRs9OPzS9PtwTncDCio=;
        b=lkiB0iet4A7NoqcA5oXP9qmuH+bhzljxF7Ags3GHHhJGRUrKfD8yqwz2kidFGMhP1f
         fhZ66BhBcRivO6XXv9eoyyzSngp177HbNssYFPzYNxW26bEHVxQfEXmb0pu/tG/qFREN
         +QreEMqxYub+zw5QGJJU0kIucfmzmtPsDg1fp/Khf4Mn1D6Y9OJkPSmSjC7twKJ0cIQH
         YAatRD7IOqs+e22Qw4+WOlP2lrYpzQtfsMj4OzoIRcUUacyj6unhYRPxXF00rywzJB2H
         DvyqRmLEWtQS3LFPGq9wNEM8BjHftSOwe3Lym1kwSAf6HvDdaqb38YhHagYmXtmQ5INP
         qbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc1eobGkBG0LfrmIA8F/omWKPRs9OPzS9PtwTncDCio=;
        b=JLkPy1t2pezAifRSUqWLpc9LvQTPmbIsvenIxkQ1uEE2ve1bLF1A+AWigBB6haNi22
         /2uGBv9TPY0mizpmVyoGo8tiwIbYtMU3q1BWFv7fH7IV84/FcFHSSRVL2IFhP8bNi7m+
         NmfjXKyuLtsx/kFvKHnSUk+RgEqybJQZScHw/WFQqaVS3tovFjZhkZP2mX2Pu0UqLzLE
         ZuPjkY7yiDyUzU41N5+VsxMDIx29YZAoqrHe7PYHWXqSYCfQ+aUSlTGn0EnT8D+QE1d4
         InHDu/j5Rg8L4/ZCBaDOTXfLK47unUYokWx7SMxTJrM1dlet5gZMp7cQIXskLmpCN1HZ
         djRA==
X-Gm-Message-State: AOAM532SJaoccqqAWQaSFQVRnWWZjmMSi3lhFQvIl0gpKNOLyCqUsZ3p
        a+Vi9/yS7zX18FHc04o0ssbuSmfUYUo5yAhOBPqUgA==
X-Google-Smtp-Source: ABdhPJycPKnm1SHI3nIY2MqxnRDhdIXGF6R+WCPW780X94mszgAHRiNGVOLgKdr8gSQvtPh7ppX2ciAVAegt5u+FMvs=
X-Received: by 2002:a25:b90e:: with SMTP id x14mr82241403ybj.8.1594060130357;
 Mon, 06 Jul 2020 11:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200424053651.61226-1-agoode@google.com>
In-Reply-To: <20200424053651.61226-1-agoode@google.com>
From:   Adam Goode <agoode@google.com>
Date:   Mon, 6 Jul 2020 14:28:13 -0400
Message-ID: <CAOf41Nkv+GV7xGM3Mrfw+XTDUQbDhQ=RmTSML3omHATUQpff+g@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Ensure all probed info is returned to v4l2
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Fri, Apr 24, 2020 at 1:37 AM Adam Goode <agoode@google.com> wrote:
>
> bFrameIndex and bFormatIndex can be negotiated by the camera during
> probing, resulting in the camera choosing a different format than
> expected. v4l2 can already accommodate such changes, but the code was
> not updating the proper fields.
>
> Without such a change, v4l2 would potentially interpret the payload
> incorrectly, causing corrupted output. This was happening on the
> Elgato HD60 S+, which currently always renegotiates to format 1.
>
> As an aside, the Elgato firmware is buggy and should not be renegotating,
> but it is still a valid thing for the camera to do. Both macOS and Windows
> will properly probe and read uncorrupted images from this camera.
>
> With this change, both qv4l2 and chromium can now read uncorrupted video
> from the Elgato HD60 S+.
>
> Signed-off-by: Adam Goode <agoode@google.com>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 0335e69b70ab..7f14096cb44d 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -247,11 +247,37 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>         if (ret < 0)
>                 goto done;
>
> +       /* After the probe, update fmt with the values returned from
> +        * negotiation with the device.
> +        */
> +       for (i = 0; i < stream->nformats; ++i) {
> +               if (probe->bFormatIndex == stream->format[i].index) {
> +                       format = &stream->format[i];
> +                       break;
> +               }
> +       }
> +       if (i == stream->nformats) {
> +               uvc_trace(UVC_TRACE_FORMAT, "Unknown bFormatIndex %u.\n",
> +                         probe->bFormatIndex);
> +               return -EINVAL;
> +       }
> +       for (i = 0; i < format->nframes; ++i) {
> +               if (probe->bFrameIndex == format->frame[i].bFrameIndex) {
> +                       frame = &format->frame[i];
> +                       break;
> +               }
> +       }
> +       if (i == format->nframes) {
> +               uvc_trace(UVC_TRACE_FORMAT, "Unknown bFrameIndex %u.\n",
> +                         probe->bFrameIndex);
> +               return -EINVAL;
> +       }
>         fmt->fmt.pix.width = frame->wWidth;
>         fmt->fmt.pix.height = frame->wHeight;
>         fmt->fmt.pix.field = V4L2_FIELD_NONE;
>         fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(format, frame);
>         fmt->fmt.pix.sizeimage = probe->dwMaxVideoFrameSize;
> +       fmt->fmt.pix.pixelformat = format->fcc;
>         fmt->fmt.pix.colorspace = format->colorspace;
>
>         if (uvc_format != NULL)
> --
> 2.25.3
>

Hi,

Could someone please take a look at this patch? Is there another
process I should follow to have this reviewed?


Thanks,

Adam
