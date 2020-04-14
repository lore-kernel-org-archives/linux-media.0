Return-Path: <SRS0=F69p=56=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEEBC2BA19
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D782063A
	for <linux-media@archiver.kernel.org>; Tue, 14 Apr 2020 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586871476;
	bh=tlmqmHKmaX649mq4LfQYVQviPZWbi5VYr+ZvTYo/MXA=;
	h=Date:From:To:Subject:List-ID:From;
	b=vu+oJKhKMRu8FwMSSItOEa/RJQhAJt2r7SKo5ewF+0q5ExwNwOBmVoFdWXIA+8luS
	 l14/rm7tDTJ17z3YvAwUZO7BOIGPdw9OLHo1SA6GddnB/3B2DVubEQ0V0A5znElbC5
	 8j+eLnaK9vTQngMziwFiMzvnNL3tvUeaVPv6/BCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgDNNhu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732531AbgDNNho (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 14 Apr 2020 09:37:44 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C2F2063A
        for <linux-media@vger.kernel.org>; Tue, 14 Apr 2020 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586871462;
        bh=tlmqmHKmaX649mq4LfQYVQviPZWbi5VYr+ZvTYo/MXA=;
        h=Date:From:To:Subject:From;
        b=aYweTFvjujDbyDeaMnYxSzNTNOIMcbeAtezfY3nynIGs3ySil7xPp5InPW07U8SXr
         AZk3jDpKisdoptNZIZgvOMZFMQh0x8PyHitSo8+Z87x9X5iNrGq9AieAIV7OnsYUZY
         PWZylsqDn/bVmTvZS3ksCx5lUJWGC/FsAVlJUhhY=
Date:   Tue, 14 Apr 2020 15:37:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     linux-media@vger.kernel.org
Subject: Script to build the media documentation as if it were a single book
Message-ID: <20200414153739.30b58bdc@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi,

In order for the media documentation to match the upstream rules, it was
split for 5.7 into 3 different books. This makes total sense for upstream.

Yet, people may still want to see it as a single book. So, I wrote a small
script (see enclosed) that does that.

I'm using a variant of it to produce the documentation output available at:
	https://linuxtv.org/docs.php

(with is updated once per day).

Perhaps others could find this script useful. This script is under GPLv2,
but please notice that some media docs are under GFDL licensing.

Thanks,
Mauro


#!/bin/bash

git remote update
git reset --hard remotes/origin/$BRANCH

sed s,userspace-api/media,media/userspace-api, -i Documentation/Makefile

mkdir -p Documentation/media

cat <<END >Documentation/media/index.rst
.. SPDX-License-Identifier: GPL-2.0

.. include:: <isonum.txt>

**Copyright** |copy| 1991-: LinuxTV Developers

================================
Linux Kernel Media Documentation
================================

.. toctree::
	:maxdepth: 4

        admin-guide/index
        driver-api/index
        userspace-api/index
END

rsync -vuza --delete Documentation/admin-guide/media/ Documentation/media/admin-guide
rsync -vuza --delete Documentation/driver-api/media/ Documentation/media/driver-api
rsync -vuza --delete Documentation/userspace-api/media/ Documentation/media/userspace-api

make SPHINXDIRS="media" htmldocs
make SPHINXDIRS="media" pdfdocs
make SPHINXDIRS="media" epubdocs
