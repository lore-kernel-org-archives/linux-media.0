Return-Path: <SRS0=EP8b=2D=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11335C43603
	for <linux-media@archiver.kernel.org>; Fri, 13 Dec 2019 10:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0AA21655
	for <linux-media@archiver.kernel.org>; Fri, 13 Dec 2019 10:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="FEObwYF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMKvu (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:51:50 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:52383 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbfLMKvu (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 13 Dec 2019 05:51:50 -0500
Received: from [IPv6:2001:983:e9a7:1:c93c:45bd:1710:e478]
 ([IPv6:2001:983:e9a7:1:c93c:45bd:1710:e478])
        by smtp-cloud7.xs4all.net with ESMTPA
        id fiXyil52GapzpfiY0idwJe; Fri, 13 Dec 2019 11:51:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1576234308; bh=OIJzo8V1t3FgwgyR67re0iTrgOjmdzQNhHhIVooodAE=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=FEObwYF4lA99zfkEor74QypujPuvfBioJ+71g4lJxDo0IRZpfBsfxWA1xjUuYeIhV
         8ZQQ5HYmTOYH0dJag37q3u/EJmP/sp47n0Kyiuon3ACWQY8wleNbfEdn+If+BOEZ0/
         QPkdUWw9IwaTyHzuCoz6epetqSojmmQCzWIWC7JqtsOEIlv9D1fYFE2ZY3pg5VDDK9
         xoHESmJYgp/cwSUrpunI0+8oWh9gOEiKpZ/zdkO1xzIEhy0OBS+ozYHsw9C6XtyXhp
         MgtOYrRUKtLqRd75R2q1gsXdxREKRiALUsTkmUt5w0lxyFMfCcKXRNZg7dHmcBjQax
         ix8JKXUeYqqBw==
To:     Linux Media Mailing List <linux-media@vger.kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.6] pulse8-cec driver fixes
Message-ID: <7a0ba45d-6aa8-2bbb-e5df-7114d4b6a340@xs4all.nl>
Date:   Fri, 13 Dec 2019 11:51:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIaQNXVBYXZdNwm/UNzlkPiGzi9Vf4DL/ejGipqVyIqdY6NcwqSMSghFKkU04RnTBcJKXxduXP5Lp8+TIJm4FZBGbvGcFHj1PErQwvXsDd844UrFLE71
 lgiYMBf6jY+418GrWHx3IYXNK8A/TpCEc8IzYOUDp9prCJ5YUFewO56LJX8V8BD8WkbWS5g99o2NYhewktyT3nAMFm27yDtFB3fmJrigkRRiELZ0KkylpxLl
 SYtPy/CpMiYeLiHNHTG3pzzM687p9BW46SZLoKeNZAk=
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

See the cover letter for this series for more details:

https://patchwork.linuxtv.org/cover/60642/

Regards,

	Hans

The following changes since commit da090bf60370c9ad6ede4e76adbf37ce79b84791:

  media: Drop superfluous ioctl PCM ops (2019-12-13 09:33:22 +0100)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.6f

for you to fetch changes up to 99f84e8ce293287bbfd1948b02db439f0c61b4df:

  pulse8-cec: log when a CEC message is received (2019-12-13 11:42:06 +0100)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (10):
      pulse8-cec: improve debugging
      pulse8-cec: reorganize function order
      pulse8-cec: locking improvements
      pulse8-cec: add 2nd debug level
      pulse8-cec: set tx_done_status for transmit_done status
      pulse8-cec: move the transmit to a workqueue
      pulse8-cec: queue received messages in an array
      pulse8-cec: use adap_free callback
      pulse8-cec: schedule next ping after current ping finished
      pulse8-cec: log when a CEC message is received

 drivers/media/usb/pulse8-cec/pulse8-cec.c | 769 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 457 insertions(+), 312 deletions(-)
