Return-Path: <SRS0=Gl4L=SD=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A0C43381
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03BD20828
	for <linux-media@archiver.kernel.org>; Mon,  1 Apr 2019 08:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIq1v7ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfDAILP (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:11:15 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54047 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDAILO (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 1 Apr 2019 04:11:14 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so13327791itf.3
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tS6hK79ekcVkoWHsFDJR5X9zQUmt+Em1imrNg7KTxfA=;
        b=HIq1v7ej8k4vOvuD4GNsH/sBC8kvt4Wj6s/AlqZe1c8XLivkTdu/zniypHRBLES68m
         B8Xl92Jte11rea4pT0SgBB+dpm49VZW0h0ShtmYFLiSNon1z2tJ7tYEK05vFehrDreUR
         SwnRCIMY4R2KRmtcE+nF2VD9A7KRpWdy2FaVt8M664MJ+raJh9C+ctcP0QiLfSDxKbs+
         NCZnx1OvJR1HFnSPQzbJi16RlYgvNm14D0hhdYqSjoTQE/e/Qx0RLkor9GWxRtWoJfeH
         nXxmm+YieLkrp2LxfB3Qzk1PT+qvK2ZJB2AtO9r3+a84YcMFhSOWz5GcpcW7JB7eKuQJ
         Sz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tS6hK79ekcVkoWHsFDJR5X9zQUmt+Em1imrNg7KTxfA=;
        b=PRon6WLiM/WFA168Um9FKLkZLN/VyjdPNxQ+f1PIYwD8fCidfFRqhYfZ6HjOYt5VU9
         RSbmj70X7aJkMgyasfJa308JbgdjVHcnTSrj4yLsfRziT2M/o8slNoR8W4X+ybXdNfaB
         j8R2np489zpGtb5LmElbRJasMpKwPEUiqvM4NNJW6kKDQCIll8IRurMf+nca4wdYQQov
         M28bAnfGci5W7+Bt+t8uRn6aY6dKTs0wjbxBpSZzpGrIDYemXt2abpdYIoOeJku5ZHZp
         bZXzKPe/Ih7wMhlJa3wL81AUfcXzudomLqwF0/nicEL+s3dYwp3AF/14DiN9vISQ154F
         rzzQ==
X-Gm-Message-State: APjAAAVp0/te8IsMITYoSDYNNdRWuW8AboY0xXA8wBdqa5P1A1KSciM0
        c5DoffBmkpxT/WOvZL+uKCXOlhc+HsLVr5ORDIuxVA==
X-Google-Smtp-Source: APXvYqyQLLa3QNRjkidmWcDRkqU41p9/GuD8VcgjWMHg9JuQZz48nIx4nvAl2p4FUL/h2DsObl9kpebAn37i6adzFE0=
X-Received: by 2002:a05:660c:685:: with SMTP id n5mr14630092itk.57.1554106274050;
 Mon, 01 Apr 2019 01:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <1552842085-3439-1-git-send-email-sergey.dorodnicov@intel.com>
In-Reply-To: <1552842085-3439-1-git-send-email-sergey.dorodnicov@intel.com>
From:   Sergey Dorodnic <dorodnic@gmail.com>
Date:   Mon, 1 Apr 2019 01:04:23 -0700
Message-ID: <CAPZdoaMwDJ5V9_KFTBgU4nuaVAPhTDsFTwKDF09tbXCh6W9USg@mail.gmail.com>
Subject: Re: [PATCH] [uvcvideo] Add "Auto" to power line frequency control
To:     linux-media@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com,
        Evgeni Raikhel <evgeni.raikhel@intel.com>,
        Sergey Dorodnicov <sergey.dorodnicov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello,
Any feedback on the patch?
Thank you,
Sergey


On Sun, Mar 17, 2019 at 9:51 AM <dorodnic@gmail.com> wrote:
>
> From: Sergey Dorodnicov <sergey.dorodnicov@intel.com>
>
> Based on section 4.2.2.3.6 of the USB Device Class Definition for Video Devices
> and inline with v4l2-ctrls.c, this patch is adding "Auto" to the list of valid
> values of the power line frequency control.
>
> Tested on 5.0.0-rc7 using Intel D415 and D435 USB cameras.
>
> Sergey Dorodnicov (1):
>   media: Add missing "Auto" option to the power line frequency control
>
>  drivers/media/usb/uvc/uvc_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> --
> 2.7.4
>
