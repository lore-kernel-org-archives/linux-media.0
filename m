Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E74C64E8A
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 10:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F90207BC
	for <linux-media@archiver.kernel.org>; Mon, 30 Nov 2020 10:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="cuSv8Ya7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgK3Kln (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 30 Nov 2020 05:41:43 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:60963 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbgK3Kln (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 30 Nov 2020 05:41:43 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 05:41:40 EST
Received: from [192.168.0.3] (hst-221-92.medicom.bg [84.238.221.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 05962D0A7;
        Mon, 30 Nov 2020 12:34:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1606732456; bh=Y3kmBtJDunBAQtrIx3VvhZQtHBPVVJ1VC870yw0gzyE=;
        h=Subject:To:Cc:From:Date:From;
        b=cuSv8Ya70Tpk3tbAbiFda22GPoPTeR8sypm/zU/svTAex4ypO6zqO9pOsVo7oZQ9C
         gkbpvE5WeoiNX5u/qDHssPE+hPerCkr7TCBjaDJIscN8m1RXCNxvzEqUFJteCTL22y
         9OKScUyiQvMSmbT4VGdU9Kt8sba2KU5NCWdvVgr2PGjuU1gIM7GIZyKRL0XoTTy4DK
         0twQ6PtjYiwNnY/07Chf/Yk+AR2weYBVjq3Z//rJ+y20ll2Lq04DStw/o8PcxTn5Bv
         cOcZoNVCY6ytbJ8Ahfzu9GvDDqg+VN1jG/az9teP8mpkm2MAxnV3jVgOI5YKqJ6/5o
         mddJSbHamstqQ==
Subject: Re: [PATCH 15/17] arm64: dts: sdm845: Add interconnect properties for
 Venus
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org
References: <20201102113529.16152-1-stanimir.varbanov@linaro.org>
 <04afbbe2-0e31-1ca1-8215-504e64186969@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <cf5470a8-d810-6b08-9490-a9036eeef938@mm-sol.com>
Date:   Mon, 30 Nov 2020 12:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <04afbbe2-0e31-1ca1-8215-504e64186969@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Bjorn, could you take this for v5.11.

On 11/2/20 2:07 PM, Georgi Djakov wrote:
> Hi Stan,
> 
> On 11/2/20 13:35, Stanimir Varbanov wrote:
>> Populate Venus DT node with interconnect properties.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Thanks!
> Georgi
> 
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 40e8c11f23ab..aca7e9c954e0 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -3661,6 +3661,9 @@
>>  			iommus = <&apps_smmu 0x10a0 0x8>,
>>  				 <&apps_smmu 0x10b0 0x0>;
>>  			memory-region = <&venus_mem>;
>> +			interconnects = <&mmss_noc MASTER_VIDEO_P0 0 &mem_noc SLAVE_EBI1 0>,
>> +					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>;
>> +			interconnect-names = "video-mem", "cpu-cfg";
>>  
>>  			video-core0 {
>>  				compatible = "venus-decoder";
>>

-- 
regards,
Stan
