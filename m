Return-Path: <SRS0=Yp04=2C=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278CC43603
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D3621655
	for <linux-media@archiver.kernel.org>; Thu, 12 Dec 2019 12:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JGEtqu+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLLMNs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:13:48 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:47711 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729004AbfLLMNs (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 12 Dec 2019 07:13:48 -0500
Received: from [IPv6:2001:983:e9a7:1:1c4a:480a:7ba1:9c65]
 ([IPv6:2001:983:e9a7:1:1c4a:480a:7ba1:9c65])
        by smtp-cloud9.xs4all.net with ESMTPA
        id fNLliZMcVGyJwfNLmiy3mk; Thu, 12 Dec 2019 13:13:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1576152826; bh=HaSaAJePIqE6f6tFF4A2GBGHvTYDxolXLEHNLjPMmkY=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=JGEtqu+r3C1ZrDOyEQpn0t/KjYnXk3p0VpwJbepOdJnzxBvHgzgl66IyC2q87OFdv
         WJY8Dvp3rUhg3Z66VXIKX1n/4pYf5aZr0/G4JQ2z16sGIRtpHgKrxBDAFeoAWo9SxQ
         GcCs1Lt4lu+FHEiDJbS1FeI9x0cv/TUYdtaovn9akt2jSIjr2+7lKlcJOEHx2h9kv6
         /71hT11/JiAF5ZNAvs+V/dfd/hqEWV8dHqsSnT/0WWJK1nuRoaU3bgWl+boCjeNUIY
         DMx/EmzkJDOyeu8ouRYz/UD/zOedNUSY01/IYcOGrloOD/lVgGyBy8bTs8BRVirpb+
         b37swlg+E+ynA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Test email, please ignore
Message-ID: <dca43c74-03d4-cb7f-7c8a-5ae0652a76db@xs4all.nl>
Date:   Thu, 12 Dec 2019 13:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD+JYW/8z36hIAEzdGMi8lKacq4qWWdsbyOxBsQXyWncTfANjnfdlZBFF+fKLSp0SueHQIY5V4VYxp74QT6e5uHreOX08MJjg5FPz3rmecp4DafrSEdG
 nrEulvrYlIMXHZUUcuQKgB87lVBFVznMhF7+QBeo7qqnueW3+etLK/rz5N0c9cHJcjsDvld5vsHwT1+bX879nTq/KfoEelN8JEzxuyFpWCsrKJSA0fl6Jgcj
 AZLIUhyU33tL+BqMkT5VxXNnBkitNfyv2VIk64VBusIsZXqBHWIrUGPs/q149svg
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Just ignore!

    Hans
