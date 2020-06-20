Return-Path: <SRS0=bfE/=AB=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED57C433E0
	for <linux-media@archiver.kernel.org>; Sat, 20 Jun 2020 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D6323A76
	for <linux-media@archiver.kernel.org>; Sat, 20 Jun 2020 09:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MXXAUTX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFTJdH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 20 Jun 2020 05:33:07 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:34061 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgFTJdH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sat, 20 Jun 2020 05:33:07 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id mZryjDNQIOn2BmZs1juCho; Sat, 20 Jun 2020 11:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1592645585; bh=IiksbXHZ1VlUFosttmQcci/gQ99X0XPRVX5U3fvReRo=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=MXXAUTX//qI5o34wL4u/OLF+cunGQSPC8/I+Gs6DPNVL3kO25BQl71sQvqq1lMIda
         wt89IddK1UhtXKAp1J9L8SHaYLpwx64+lfxN6e4u0gW5xSX72QXi3TPuGq0U2yi12N
         z1qduGMF0NHjRJvSPjrN3TeDObdoKCnCsqa9u+uOetcwF+d6ZpBoS+KSSltpmkfgCY
         sFSD2bXrD+u+5bgOT3d0/2OaHZ0XWx0yScNV35YbPVmCbKtfrsHsA4PigOp5kmrUd8
         b9Bn8gJIRNzRM1Q884uMPca71lEnEsjKOilQf7VNbQlZLLUIIYJq2m4RjuCpAnVMJD
         yczz+TC3ZfCiA==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] cec-ioc-adap-g-caps.rst: document available_log_addrs
Message-ID: <b211a750-bc2f-7a26-9701-7ae91281524f@xs4all.nl>
Date:   Sat, 20 Jun 2020 11:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMqYkkx272JhhSgOr12VkJVVZNglkQKdHMdee+FeKqCjxAHt37sez+4NMRGar+/6cLbeNcjUVkI8ETrzumjznBylYb1MHagc0syEo8gQ9QN2mRZOxHoP
 K/P8knDRcRvSBtt2/lyzuHcQkSjMdNXCtGNfdynbtHiwdKZ6SogDTdUj8a0x6t5Emr6v5hkbqkZypA==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The CEC_ADAP_G_CAPS documentation of the cec_caps struct was missing
the available_log_addrs field. Add this.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index 94e46a11d68d..436a882dfa31 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
@@ -57,6 +57,9 @@ returns the information to the application. The ioctl never fails.
       - ``name[32]``
       - The name of this CEC adapter. The combination ``driver`` and
 	``name`` must be unique.
+    * - __u32
+      - ``available_log_addrs``
+      - The maximum number of logical addresses that can be configured.
     * - __u32
       - ``capabilities``
       - The capabilities of the CEC adapter, see
