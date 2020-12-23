Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D390C433E0
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 21:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ABA2247F
	for <linux-media@archiver.kernel.org>; Wed, 23 Dec 2020 21:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgLWVpu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWVpu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Dec 2020 16:45:50 -0500
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABDC061794;
        Wed, 23 Dec 2020 13:45:10 -0800 (PST)
Received: from sas1-5f1844c300c3.qloud-c.yandex.net (sas1-5f1844c300c3.qloud-c.yandex.net [IPv6:2a02:6b8:c14:5781:0:640:5f18:44c3])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 9033F1BE1E4E;
        Thu, 24 Dec 2020 00:44:21 +0300 (MSK)
Received: from sas1-27140bb19246.qloud-c.yandex.net (sas1-27140bb19246.qloud-c.yandex.net [2a02:6b8:c08:1803:0:640:2714:bb1])
        by sas1-5f1844c300c3.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 8kemtlyCIz-iLDWx5Gc;
        Thu, 24 Dec 2020 00:44:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ratijas.tk; s=mail; t=1608759861;
        bh=n/dXyJJw7mCQBI3d4McZaIP0NhBiZjVhtgiiYPQafFo=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=rglMsujWDeD6N/OfRPCAg8MZBYHvY701ZIhSN7J+RLsOOXdWsfmFDiVsJTdgT5cJl
         QanXr3OyhUh7jEkMn0rltXoVlT5t+DzWOgROwVlWTOcJUzRIjxs0oMSYXV5iHbQ3/8
         IlJeqhl//HyXmX6K8kIzDpzMeQgXZVa0J8SuE7oU=
Authentication-Results: sas1-5f1844c300c3.qloud-c.yandex.net; dkim=pass header.i=@ratijas.tk
Received: by sas1-27140bb19246.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PYqbrm6b1O-iKHO3fF0;
        Thu, 24 Dec 2020 00:44:20 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   ivan tkachenko <me@ratijas.tk>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ivan tkachenko <me@ratijas.tk>
Subject: [PATCH 1/1] media: hdmi: cec: replace broken link to HDMI specs
Date:   Thu, 24 Dec 2020 00:43:54 +0300
Message-Id: <20201223214354.588382-2-me@ratijas.tk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223214354.588382-1-me@ratijas.tk>
References: <20201223214354.588382-1-me@ratijas.tk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Current link died, according to Wayback Machine, back in 2017. And the
website is completely down since 2019. Moreover, there was a custom
cover on that PDF, i.e. it was modified.

According to HDMI licence agreement (LA), HDMI specification and technical
information are supposed to be hosted on www.hdmi.org exclusively, and not
redistributed by third-parties.

Sure, there are still many more or less reliable "mirrors" out there with
a direct download straight from a search engine's page. However, for
example, from FPGA4fun[1] website it was removed "per HDMI LA request".

Unfortunately, the official download page is protected by email CAPTCHA,
but that seems to be the only legit way to obtain a copy.

[1] https://www.fpga4fun.com/HDMI.html

Signed-off-by: ivan tkachenko <me@ratijas.tk>
---
 Documentation/driver-api/media/cec-core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/cec-core.rst b/Documentation/driver-api/media/cec-core.rst
index bc42982ac21e..eede201caa21 100644
--- a/Documentation/driver-api/media/cec-core.rst
+++ b/Documentation/driver-api/media/cec-core.rst
@@ -26,7 +26,7 @@ It is documented in the HDMI 1.4 specification with the new 2.0 bits documented
 in the HDMI 2.0 specification. But for most of the features the freely available
 HDMI 1.3a specification is sufficient:
 
-http://www.microprocessor.org/HDMISpecification13a.pdf
+https://www.hdmi.org/spec/index
 
 
 CEC Adapter Interface
-- 
2.29.2

