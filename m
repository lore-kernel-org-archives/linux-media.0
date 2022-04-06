Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F56C43217
	for <linux-media@archiver.kernel.org>; Wed,  6 Apr 2022 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiDFV3p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiDFV2T (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Wed, 6 Apr 2022 17:28:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9251DA45;
        Wed,  6 Apr 2022 13:25:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so6637377ejd.5;
        Wed, 06 Apr 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=truPn0s8Vvvmxvp+PkFZjk0sa6dM7vsj42Uw5AHqoas=;
        b=Ayxsy5fHNuTj9Hl92WgEWuKxiRx4jKxEUMRLg+y4Dp+Ea9K0wNNMbAfNY/k4WnB5fr
         M6sCwfb8fyIm7d1GleY9GbjSOkkg2i2kR4d/i1/HWsqikTP07y1jghXAP7EYtzfLpjzd
         2flM0TAWxxRme5r8+6NYQj4pbrbG9hvt7nHqMFDoQPqIgaHMwdWzekmfNnBn8Zi0zH95
         ApjjDNXaomSSm0gryVQrhymcmAbGsol1fM/BwHcLlmdlfBQaPN1OCsYCxfED0UL5LTeS
         gnjJrd6+dd0lTgysdhUXQADmDWB9NSPhVQ458NdDHgqtbO+nx+Jeiu84Zv69BrCxVnJJ
         nTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=truPn0s8Vvvmxvp+PkFZjk0sa6dM7vsj42Uw5AHqoas=;
        b=7YJDHBCcDtHqDhXNAT0XbxLKi4qgzeF5zXvCRPGizLlPZY6QZ+mSyj615MlE8USIJk
         iaBy5QBkdzC6vysHZKBkVr7JONz6OXYYx8zf5Kq/beVIo6W3e0g+1GoslPfbD30E/qAb
         H2DJMkqm4LeYEMXSCieFL4aWGN8j00vOhS9Bok+nNe4X9UohSGsLtyrhlWPCJuxXQXlg
         VJJcNcglvMqhb/OgBC86z4YLyTAd1MFOssLTewFd/bxbEt7HkaJDZ60cBmk8b4mRUcG0
         mE/K027UnY24GNhnO6tbHaSXERA6tNkw6SgoeaYnOmui5b2SQaz25VdenWBv/zHXjiPP
         C4DA==
X-Gm-Message-State: AOAM533qcX3qB0Bi0MT+euyRgM23S8GRwPh9hV9/9pxF++KB/Sz9MdAa
        ueoiXzCY9GEazn6pvVJ/W2NFNDMm99vokfyVHH0=
X-Google-Smtp-Source: ABdhPJznmIeMm7VUIZ7xQcowM7cqVayQQZEEyeJnhfomosgir4daqnye36bBN8Q7knoAikzY/CvM0z7d9RDeA2TrW5c=
X-Received: by 2002:a17:907:7b9d:b0:6df:fb8f:fe82 with SMTP id
 ne29-20020a1709077b9d00b006dffb8ffe82mr10014393ejc.652.1649276745204; Wed, 06
 Apr 2022 13:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220405135957.3580343-1-festevam@gmail.com> <20220405135957.3580343-2-festevam@gmail.com>
 <219003f3341412cc6241d8c6e73309a74836678d.camel@pengutronix.de>
In-Reply-To: <219003f3341412cc6241d8c6e73309a74836678d.camel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 6 Apr 2022 17:25:32 -0300
Message-ID: <CAOMZO5BmRjHzrxK-+=mH503aeUxDJrrNHzckCNd1xt1zw-Pjnw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: coda: Add more H264 levels for CODA960
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@iktek.de, linux-media <linux-media@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Philipp,

On Wed, Apr 6, 2022 at 11:59 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:

> I think you rebased the wrong version of this patch.

Oops, good catch!

I have sent v5 with the correct one, thanks.
