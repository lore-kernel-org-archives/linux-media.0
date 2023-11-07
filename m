Return-Path: <linux-media-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83265C4332F
	for <linux-media@archiver.kernel.org>; Tue,  7 Nov 2023 03:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjKGD1h (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 6 Nov 2023 22:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGD1h (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 6 Nov 2023 22:27:37 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7AF101;
        Mon,  6 Nov 2023 19:27:31 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DF75324E208;
        Tue,  7 Nov 2023 11:27:28 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 11:27:28 +0800
Received: from [192.168.1.218] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Nov
 2023 11:27:28 +0800
Message-ID: <a3a2c179-2cbe-5a55-a21e-b45abfb6d494@starfivetech.com>
Date:   Tue, 7 Nov 2023 11:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v11 0/9] Add StarFive Camera Subsystem driver
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <changhuang.liang@starfivetech.com>
References: <20231025031422.3695-1-jack.zhu@starfivetech.com>
 <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
Content-Language: en-US
In-Reply-To: <15ef0a70-734e-280a-f014-41914a55d8cf@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 2023/10/31 9:09, Jack Zhu wrote:
> 
> 
> On 2023/10/25 11:14, Jack Zhu wrote:
>> Hi,
>> 
>> This series is the v11 series that attempts to support the Camera Subsystem
>> found on StarFive JH7110 SoC.
> 
> Hi Hans and Laurent,
> 
> Could you please help review the code?
> Thank you for your time!
> 

Hi,

Could you please take some time to help review the code? Thank you so much!

-- 
Regards,

Jack Zhu
