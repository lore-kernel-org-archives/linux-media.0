Return-Path: <SRS0=MqeG=Z3=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ADFC43603
	for <linux-media@archiver.kernel.org>; Thu,  5 Dec 2019 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C2F22525
	for <linux-media@archiver.kernel.org>; Thu,  5 Dec 2019 14:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikdKhvaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfLEODW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:03:22 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:34856 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfLEODV (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Thu, 5 Dec 2019 09:03:21 -0500
Received: by mail-io1-f45.google.com with SMTP id v18so3728116iol.2
        for <linux-media@vger.kernel.org>; Thu, 05 Dec 2019 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GvTtkeSxwtg7bNOTW6mJhlP7ByhbdsxcU4N3KTqQ1NM=;
        b=ikdKhvaCIELDhhzZhNMcuuPCS+ZXJ/LIJFxq2ioH/U6qXcd6P3uh67nAfgVWR/pkOx
         0BUY1CnfJuAJCA9uvUz4p2wPuAaBTV4PjbPqMzlNiI7InyRqBxNjjJ2AafWvLxyq1uqv
         mTxW4b+md0PNJNDqiQb86o0ePElbcf27ztqTC9a+qgCLqf1CE9NHNLngFRvGswNYl3M4
         Th5R8j2bEU+NwGaPXs23IJ8Km6ArLPV7o7l0xSHNgYHvE9uw42vLzikdJ6nbXpYvEd8K
         o8Hv5omVQ1c+BNrg47dvun8fxE9PNhSb9JcLgWDUnHyzGVUYbwJWVB5l6us46xFIredk
         ls9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GvTtkeSxwtg7bNOTW6mJhlP7ByhbdsxcU4N3KTqQ1NM=;
        b=AWKVtf5OLvpk8LqP1n/sIpB1TPwvM6bElwctoAg1dHlmcWDQfqAr/X/PanxO60aeWn
         UzDzEc8omKzseLCp0dDUBi7inuXvwv67yFMeQL+ZV2y++LZLmqhAzsIHwvXfHiTlfN3d
         1ucBbXdDwN/VTw19p0j+0CdVNP3fLywcUHbJKGJL4T+xJivtyTyiMpWXJRa4nYPcHcKn
         o1b1LLLg+x4nLWxGIoJ+Iqx+4DoCzXb7EBdypLfkigZX5cuNlFRxbOEJAKQQZl3yYlYY
         73U2kGqBqhPa9dyXjudKoz5RAYUy3sY3K2ERRBiMqVgOmlmXjKEYcOLLHZsA5p9Z053I
         irUg==
X-Gm-Message-State: APjAAAWYCWi9rCSdWCl6nSi07Bpa/qV2j8blmmPpazbForWV/osFC95z
        n2/uo3eP4FRkM65ZfRqL0OiAX6XiP8b038jhlFM=
X-Google-Smtp-Source: APXvYqwvI4aruET6hhYcxvIKfxm7ykLJxXoG/G+JFd9Z02DUq/qXCJvolE8iZKXUT6wFj7TvIL3yooA6g7fdPTwcdeA=
X-Received: by 2002:a6b:c007:: with SMTP id q7mr4241985iof.58.1575554600715;
 Thu, 05 Dec 2019 06:03:20 -0800 (PST)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 5 Dec 2019 08:03:09 -0600
Message-ID: <CAHCN7xJwz_DXupkHzyaD5+s8NoTrb16-GwNU8JRgrqLTx7WHrg@mail.gmail.com>
Subject: i.XM8M Mini CSI and DSI drivers
To:     NXP Linux Team <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

NXP Linux Team,

I was just curious to know if any efforts have been made to take the
DSI and CSI drivers for the i.MX8M Mini that were provided in the NXP
distribution and push them upstream to the mainline kernel.

adam
