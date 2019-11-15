Return-Path: <SRS0=gaxT=ZH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E5C33C99
	for <linux-media@archiver.kernel.org>; Fri, 15 Nov 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF6C20730
	for <linux-media@archiver.kernel.org>; Fri, 15 Nov 2019 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="IfhmsQzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKOOwh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:52:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43507 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfKOOwh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 15 Nov 2019 09:52:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id z23so8255913qkj.10
        for <linux-media@vger.kernel.org>; Fri, 15 Nov 2019 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wrt9l0VhiI7A9nxAUAtQiAyKEvYLUb5mINXvDXSdW1k=;
        b=IfhmsQzubdKDRYiANhTU6sVG2dV6wdML8eKR6uxL5oYFWUd9SssZQ6Tf9n68XXr3sl
         nW7lQsmz/o1RL91gES1C8UBCFFVf4N1Me7qLALK78ovlrIV0VGZ4hHQg0zxI7P4HNGfu
         Fzqe4Uf5Z/R5lgyAuXRTf/Okf1YNODFt9sfZdmXppZ1kQFUmYuRVdnxbcmE6SZheHgOt
         uqCQfzfCB3X1Xc9CD3e4UAfocxhgrFDui6u9Ks2ykTOj1I23Auc5Vy56Ip/bgO/n1LPG
         AKPsvfD6AMcv6IaSuEFoYaV/2DZ3I6vsEDaks6AT5f5FDjyIKHKEAGqMhCG3UQWXfsO8
         97JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wrt9l0VhiI7A9nxAUAtQiAyKEvYLUb5mINXvDXSdW1k=;
        b=mzY1tUCAtb7zROxeyhh3CYE+DUZJRHpmbqfhpKvNdICMIMtnu9aG2/JqUHJtmgJRnx
         JfcwEq0MLdacg5wcPxAwMny1mXpHHUgGT5xTkWXirmBUlIFG7dWh9CC5HheH7nxcNdZR
         QBMhHjJcuiQkWxhrHRlyWM5hXIyfll0j8efZ/p12kYOIwjI01cedqj/v6qQegFSBJxZU
         MZbhyGqiUzuufD4cD8WZkbFx1zi+CDbMxQLXA9ffifeahfo/7sNY0mcsfLIyxxCluGIn
         ukpKG+LH8f6ULyclZVY82euNqq9sYvrhY8oQ+H1CBRzYF61Jj12TezeHdbiVs4RhHw2h
         LMHA==
X-Gm-Message-State: APjAAAXSB1JVa8ar0XCiabdwo99kEKc0sMfrW3lw2qIJwX7lZpyEUgK9
        r6BMKuw062kfWO4L9oOM4d9qZg==
X-Google-Smtp-Source: APXvYqxLjNh8ViASdUh5sCC13M3yjYD7B+CwC28yDm20fvSvspb0qQyGDGA8BYsQztsTVlyOWxQcdw==
X-Received: by 2002:a37:7705:: with SMTP id s5mr12928660qkc.145.1573829556190;
        Fri, 15 Nov 2019 06:52:36 -0800 (PST)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id f35sm5098124qtd.35.2019.11.15.06.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:52:35 -0800 (PST)
Message-ID: <4b0b35017d89b0caf989d69887ed939eb2f4a511.camel@ndufresne.ca>
Subject: Recap of: VP9 Stateless Support (follow up of [ANN] Report of Media
 Summit: Codecs)
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Daniel Gomez <daniel@qtec.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Helen Koike <helen.koike@collabora.com>,
        Jan Schmidt <jan@centricular.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Matthew Waters <matthew@centricular.com>
Date:   Fri, 15 Nov 2019 09:52:33 -0500
In-Reply-To: <f948c7918ea24ea2686fff72bcf813f340d55e45.camel@ndufresne.ca>
References: <311a152e-b773-76d6-a17e-86112b583179@xs4all.nl>
         <f948c7918ea24ea2686fff72bcf813f340d55e45.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi All,

So Hans, Boris and I participated to the chat. As consider that it's
important to get this CODEC stuff read in a realistic time frame, the
first and most realistic proposal was picked. So here's a summary of
that will be needed.

## Introduce a VIDIOC_DELETE_BUF

As discussed, this will create wholes in the indexes of the buffers in
the queue. VIDIOC_CREATE_BUFS has a start index, so it is left to
userspace to fill the wholes. We are not going to lift the 32 buffers
limit just yet, that's why it is important to make sure that wholes can
be filled. Typical strategy should be to first discard buffers before
creating new one.

## Workflow

Upon a resolution change, userspace can start allocating frames for the
new resolution at any time (that's the nature of CREATE_BUFS). It can
also discard no-longer referenced buffers using DELETE_BUFS. Assuming
userspace make use of DMABuf, that can happen independently. This could
benefit many other drivers, since it will reduce the number actions
that must be done during the STREAMOFF period.

In order to operate the resolution change, the process remains the
same. With the exception that REQBUFS is no longer needed. The
framework should already validate properly the buffer size (to be
verified please).

 - STREAMOFF(Capture)
 - S_FMT(Capture)
 - QBUF(Capture) *
 - STREAMON(Capture)

Stream ON/OFF operation must be made independent between CAPTURE and
OUTPUT queues if it's not already the case.

## Driver specific bits

Drivers that support mixed size references will likely extend the
structure that stores buffer in vb2, and save the format used at QBUF
time. This avoids the need for an extra control later. This also avoid
having a lot of per-driver validation.

regards,
Nicolas

