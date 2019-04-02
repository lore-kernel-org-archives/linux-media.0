Return-Path: <SRS0=Nq74=SE=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4825C43381
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 05:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF5720840
	for <linux-media@archiver.kernel.org>; Tue,  2 Apr 2019 05:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU5DwjQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDBFhs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:37:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBFhs (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Tue, 2 Apr 2019 01:37:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id v71so3167077lfa.11
        for <linux-media@vger.kernel.org>; Mon, 01 Apr 2019 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6EAGtYeqCKpb+lyAh4wNxk3R+RNVvPPsjI49B/7jbxY=;
        b=RU5DwjQeAQZ793rPSuon7SBOXOGMwgVtS1jNteuF2aPvmch93EYh0pBBprsstG5sCo
         y2lNs2506EOWD4lLYWOZVv4uSvGqBjZGNX8yabpm30Ok6WJYlOjd3nr12IpDwrc4Y4AW
         DTLCCgZdQWEDq9DFoUWud7AXmIeDTtOHJvppY1zNXKA70d7N7sAbh6smToCvISG2vOI4
         /vCzXjGjTkr8eSY/KRWG+hT/Kdxni4nWYdot/AnUOzrNq+V5jyisfkpXYtWZ6cFJWNLa
         BzdBSjmYup1CQEfBQ4lWr7ak6zjD0F/xiOSIMC/Cr52pbCOE01eOyHYIQPVBnQnpPXOC
         Nb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6EAGtYeqCKpb+lyAh4wNxk3R+RNVvPPsjI49B/7jbxY=;
        b=QLWXw+iKcyAUqmckyfg2ByWN3LXfDeiRv+zO8lnDSn0Xl0OouFc6MFyNmeUt84Xjt4
         kVcwKm3kRJeX0jHyNP5olAwU+cNvP6fvAwn4Iiio8WI6RGiVDTzbpZMyy9ZgV5HApTQO
         OeTGcn4dOKwe0NcAcUmP7nd2qlGzE/rMsSTgnWx/9oMachz50JD2LZq54yQVRQdLVXzh
         Swygzoiox1nUqqiR4jdDzOnCI26OUNtGakmWuSWH3NBRsZFXEfa5/M0nNKbL90uMLaCf
         oEqodzyeYhAAbImPZA/xnZzgFTi9SZ+nbQI1NfgoK0RXnnyAGMj/x3++9lkBZqxfPSLo
         LvzQ==
X-Gm-Message-State: APjAAAV46b/zLGppqnwPLXIIaJRRe3jBlmN/hVFUVlEHUU7T8Y4rjyAo
        UknbTFJN4IFikLWfsRWTr6E=
X-Google-Smtp-Source: APXvYqzcMORrL4nbU53gqMLpjjc905qdsmfh6wbqckNNpRRi3pgT742e7vY6YCVur93AfsDXLRYxWg==
X-Received: by 2002:a19:740e:: with SMTP id v14mr34603323lfe.94.1554183465859;
        Mon, 01 Apr 2019 22:37:45 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id a24sm2571275ljd.32.2019.04.01.22.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 22:37:45 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH v6 1/1] cameraif: add ABI for para-virtual
 camera
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        sakari.ailus@linux.intel.com, koji.matsuoka.xm@renesas.com,
        hverkuil@xs4all.nl
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20190322073742.14639-1-andr2000@gmail.com>
 <20190322073742.14639-2-andr2000@gmail.com>
 <aa30b072-2ed2-beb6-39a2-94c1220f5d43@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <05d63963-e433-4e3b-5313-37befe4a572f@gmail.com>
Date:   Tue, 2 Apr 2019 08:37:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <aa30b072-2ed2-beb6-39a2-94c1220f5d43@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/1/19 9:35 AM, Juergen Gross wrote:
> On 22/03/2019 08:37, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This is the ABI for the two halves of a para-virtualized
>> camera driver which extends Xen's reach multimedia capabilities even
>> farther enabling it for video conferencing, In-Vehicle Infotainment,
>> high definition maps etc.
>>
>> The initial goal is to support most needed functionality with the
>> final idea to make it possible to extend the protocol if need be:
>>
>> 1. Provide means for base virtual device configuration:
>>   - pixel formats
>>   - resolutions
>>   - frame rates
>> 2. Support basic camera controls:
>>   - contrast
>>   - brightness
>>   - hue
>>   - saturation
>> 3. Support streaming control
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
Thank you, is it good for inclusion in Xen?
>
> Juergen
>

