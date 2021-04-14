Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F9C433ED
	for <linux-media@archiver.kernel.org>; Wed, 14 Apr 2021 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D7B61249
	for <linux-media@archiver.kernel.org>; Wed, 14 Apr 2021 09:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhDNJlH (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 14 Apr 2021 05:41:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33722 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231782AbhDNJlE (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 14 Apr 2021 05:41:04 -0400
X-UUID: a398c42e233e4202baf3660b517f74ad-20210414
X-UUID: a398c42e233e4202baf3660b517f74ad-20210414
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yp.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1186024364; Wed, 14 Apr 2021 17:40:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 17:40:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 17:40:36 +0800
From:   YP WU <yp.wu@mediatek.com>
To:     <yp.wu@mediatek.com>, <leo.hsiao@mediatek.com>,
        <mchehab@kernel.org>, <gustavoars@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Jason-BF.Huang@mediatek.com>, <francis.lee@mediatek.com>
Subject: How to use "DTV_FE_CAPABILITY" command for Frontend.h of Linux DVB 
Date:   Wed, 14 Apr 2021 17:40:37 +0800
Message-ID: <20210414094037.1489-1-yp.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hello STI maintainer,
	I work at mediatek company. Currently I develop TV with Linux DVB system.    
	I would like to ask the following questions about "DTV_FE_CAPABILITY" in Frontend.h:
1. The use case for DTV_FE_CAPABILITY in DVB property command.
2. Does it have any restriction for using this command?
3. What’s your suggestion for using this command?

File path: include/uapi/linux/dvb/Frontend.h
#define DTV_FE_CAPABILITY	16

Thanks for your help.
BRs,
YP
