Return-Path: <SRS0=7dE9=CR=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4586CC433E2
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045ED206DB
	for <linux-media@archiver.kernel.org>; Tue,  8 Sep 2020 10:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="W/b+yFgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgIHKuo (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:50:44 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:51551 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729209AbgIHKuO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 8 Sep 2020 06:50:14 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id FbCVkX7pNMeQuFbCWkfhvZ; Tue, 08 Sep 2020 12:50:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599562212; bh=jUHi9XjCniVYnoorFU7gq32upLHo1LDIn3+uf1RwUaA=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=W/b+yFgGVHQuPVGB8vF/urksF1ZXQFwnrIndFKAWpcrA+gUlR/kDtLjEB2ls9qfBo
         PO1fZg57fGnXnKqeDDajG0dv45irXGQTxutIpfEgyCYPL4SyWLHfPi3oVMskUWHIlY
         HVS0jBTlVUaqsq0L4xRE14icdFnoPup5zlvmVLYhrK+47WmqUA03LTv9Y7QpkzHELx
         /ERD08VMV5glr95tok4wS/qynNDssGcYUbkD21ZLfVQ6bSkNdwzRIEgd4sC7CsS43v
         7bFZwbRPuDj22Xw1pEy4+NhwFvZ2zQDr/e8vTN3ahV9FB4/pb797kj8COy2Sf4WliT
         Dq5EjCfFsUGgg==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT FIXES FOR v5.9] cec-adap.c: don't use flush_scheduled_work()
Message-ID: <eb47954f-c916-f4c5-d255-a74b3ab0bdce@xs4all.nl>
Date:   Tue, 8 Sep 2020 12:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAnNpzmVviURAFFm9KtZcwkkGLbmO03p1lBsyyiErwML4JaKnA2iv2T+OuE95TvmTpkzB2IvjxVl+FgTdDvnpYMyWGsZ339Bc4WvVeSW96P6+m7CATBq
 i/PonYGHMPHN+mN8rtCjh5hMP6tmBFv7ceAK1sFM0OEr0829JV+WIJp+Q8jbjQ9zQ5015FAVupjPBSn1fv9UGmfFz5QWWBmuoComw+6YmnD2C66pTOSBb8tn
 F9JUct1aeaWWUDOpM27E+Cwuh0zkYKX/19yGH54L8To=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Note: this is a bug ever since the first implementation in 4.8.

The patch only applies to 5.8 and up, so once it is merged I'll prepare
patches for older kernels.

Regards,

	Hans

The following changes since commit d13ee586e026e8166231e03e5345718ebf625c02:

  Merge tag 'v5.9-rc4' into patchwork (2020-09-07 16:13:06 +0200)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.9-cec

for you to fetch changes up to 5d3d83232aa1f44655fbba3db76a0f61f5f30010:

  cec-adap.c: don't use flush_scheduled_work() (2020-09-08 12:46:28 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      cec-adap.c: don't use flush_scheduled_work()

 drivers/media/cec/core/cec-adap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
