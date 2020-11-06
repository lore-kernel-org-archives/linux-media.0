Return-Path: <SRS0=vajg=EM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E4C2D0A3
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 05:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4666A2078B
	for <linux-media@archiver.kernel.org>; Fri,  6 Nov 2020 05:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qVWo7F2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgKFFKn (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 6 Nov 2020 00:10:43 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:53741 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKFFKn (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 6 Nov 2020 00:10:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604639442; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=4UR8D5/5hBJVI24Xm9gMBoDEqojzX5OtDodI21zNGEU=; b=qVWo7F2ACw5jitA8YsRhjd60cNUzqZ6TI0W42p5MG5Y4jctg0NFwF3lsHEoEBNnj5EevF/4r
 56CalyQ4y1kwseGd4Q/Ys0PxetWk4/5iiigMiGzkfawk9oV0LdgPwm3qYGJAIn1UB3NKAKiB
 cfh9tx6+m3AftpnPgV3xC+wzuPw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3ZjU0NiIsICJsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa4dac41f7506a997b09064 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 05:10:28
 GMT
Sender: asitshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06704C433FF; Fri,  6 Nov 2020 05:10:28 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asitshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A664C433C8;
        Fri,  6 Nov 2020 05:10:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Nov 2020 10:40:27 +0530
From:   asitshah@codeaurora.org
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org, linux-arm-kernel@lists.infradead.org,
        mchehab@infradead.org, linux-media@vger.kernel.org,
        stanimir.varbanov@linaro.org, linux-media-owner@vger.kernel.org
Cc:     vgarodia@codeaurora.org, dikshita@codeaurora.org
Subject: Update venus firmware files for v5.4
Message-ID: <c1bcb5eedc160e99d65576d431816a41@codeaurora.org>
X-Sender: asitshah@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi Team,

Please include updated Venus Firmware bins for v5.4.

Snapshot of pull request is as below, let me know if anything is 
missing.

>>>>>> 

The following changes since commit 
dae4b4cd084102cd49c37aa8b579b208028ab025:

   Merge branch 'v1.1.5' of 
https://github.com/irui-wang/linux_fw_vpu_v1.1.5 into main (2020-10-23 
08:10:37 -0400)

are available in the git repository at:

   https://github.com/shahasit/video-linux-firmware/tree/master

for you to fetch changes up to 8a46c32a26b3f22835543b158877aa0b0e01e8d6:

   qcom : updated venus firmware files for v5.4 (2020-11-06 10:33:37 
+0530)

----------------------------------------------------------------
Asit Shah (1):
       qcom : updated venus firmware files for v5.4

  qcom/venus-5.4/venus.b00 | Bin 212 -> 212 bytes
  qcom/venus-5.4/venus.b01 | Bin 6808 -> 6808 bytes
  qcom/venus-5.4/venus.b02 | Bin 873100 -> 873680 bytes
  qcom/venus-5.4/venus.b03 | Bin 33792 -> 33792 bytes
  qcom/venus-5.4/venus.mbn | Bin 919212 -> 919792 bytes
  qcom/venus-5.4/venus.mdt | Bin 7020 -> 7020 bytes
  6 files changed, 0 insertions(+), 0 deletions(-)

<<<<<<

Regards,
Asit
