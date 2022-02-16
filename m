Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C228CC433F5
	for <linux-media@archiver.kernel.org>; Wed, 16 Feb 2022 09:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiBPJEY (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:04:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPJEX (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 16 Feb 2022 04:04:23 -0500
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 01:04:11 PST
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E84C2AD671
        for <linux-media@vger.kernel.org>; Wed, 16 Feb 2022 01:04:11 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id C8285BF424C; Wed, 16 Feb 2022 09:58:41 +0100 (CET)
Date:   Wed, 16 Feb 2022 09:58:41 +0100
From:   Philippe De Muyter <phdm@macq.eu>
To:     linux-media@vger.kernel.org
Subject: FAILURE of git clone http://git.linuxtv.org/v4l-utils.git
Message-ID: <20220216085841.GA27156@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello

I just noticed that cloning the v4l-utils git repo at linuxtv.org
doesn't work anymore :

Here are different views of the problem :

on ubuntu-18 :
nvidia@cam5-jp43-1:~$ git clone http://git.linuxtv.org/v4l-utils.git
Cloning into 'v4l-utils'...
fatal: unable to access 'http://git.linuxtv.org/v4l-utils.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none
nvidia@cam5-jp43-1:~$

on opensuse 13.1 :
phdm@dyn223:~> git clone http://git.linuxtv.org/v4l-utils.git
Cloning into 'v4l-utils'...
fatal: unable to access 'https://git.linuxtv.org/v4l-utils.git/': SSL certificate problem: certificate has expired
phdm@dyn223:~>

Best regards

Philippe
