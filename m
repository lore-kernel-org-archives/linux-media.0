Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B6C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0B820880
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClpryB+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDHGRC (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:17:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDHGRC (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 02:17:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so10045001ljk.13
        for <linux-media@vger.kernel.org>; Sun, 07 Apr 2019 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=POXtVBy5BSbnfnKmYq80Yc2/k/FX8u0JjI+SD6G5V0U=;
        b=ClpryB+zz/ldY28/hjRyTYvkiU3pZtp40QbASAkv8q9Pw6FiXt7ADFfk+ItFZSkl4k
         HTWipVgt/mKPEatTBNhQ5OvGdoxkLOXGwu+ZALei9WIfQkczyFM4z8cNf1FxUf/YPAhC
         XVMFv7Ua9+6gVmNsYqvVmsynDYuS9hEp1Ua6laZ6IR0/C4oOUJ0d68rDZHKf6Hnwgg3C
         9YTynpSa6RcN0W609aFfPfRqwQvrQTKDiWfeMFTOtS0888wleByFeRR066zW4IAtUI1a
         UDO9NQOKhdD1VyHsJD7Oz6R4sRq1jg+yKRfDivYoN35YbwYfGj46Hz5xloOg6Jy6GHKV
         iWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=POXtVBy5BSbnfnKmYq80Yc2/k/FX8u0JjI+SD6G5V0U=;
        b=ApsKLPDs1wG5BiowpCL05Go5k6vnUxOCYWKe/y2E60VtCbjuGV3/PtTqrBlguoNP7M
         7tY17rWjj5Q7AZElSSB+9RYq+2HdcStnFLnupBSbHMNTObaaNofFmcyhoraITE9cKK38
         bXlAXU1jmV6Ep888oLEBex5Jq9AWPYzhmpFnSOTzh0TfjcXah0G6UqkvyphLOUeeMfmD
         I3aYGARN/0vEyJBR2VemNaJBy7GUvS9bJH/ONz6SS6lFlG8+6KqZuwNjSw0rEIu+zF7C
         E0SmIQrrAXKieNysdUt3vpRJnMJW52V9u3B+k0++Ke/GsUDFA2V2uqVqTodbbdbUWlLq
         Okgg==
X-Gm-Message-State: APjAAAVr/TCXm/Iev9aT9b09KsQjnv/hTrwzr/4UZHSJx9377VpdPLf6
        ZrsKhhjBTOuSdnHZMkTXDBE=
X-Google-Smtp-Source: APXvYqwV6LVKUYHETjj8q8nXCTatAVp4XTK0JFt8L3y/4Bl2/FAM4SeBlpqUHyP6dlndK7gIGGoMtg==
X-Received: by 2002:a2e:74f:: with SMTP id i15mr9539553ljd.156.1554704219160;
        Sun, 07 Apr 2019 23:16:59 -0700 (PDT)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id b14sm6329289ljf.53.2019.04.07.23.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 23:16:58 -0700 (PDT)
Subject: Re: [Xen-devel][PATCH v6 1/1] cameraif: add ABI for para-virtual
 camera
To:     "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
        koji.matsuoka.xm@renesas.com, hverkuil@xs4all.nl
References: <20190322073742.14639-1-andr2000@gmail.com>
 <20190322073742.14639-2-andr2000@gmail.com>
 <aa30b072-2ed2-beb6-39a2-94c1220f5d43@suse.com>
 <05d63963-e433-4e3b-5313-37befe4a572f@gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <4fe07393-ad09-a2eb-474c-7b52bc188859@gmail.com>
Date:   Mon, 8 Apr 2019 09:16:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <05d63963-e433-4e3b-5313-37befe4a572f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 4/2/19 8:37 AM, Oleksandr Andrushchenko wrote:
> On 4/1/19 9:35 AM, Juergen Gross wrote:
>> On 22/03/2019 08:37, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> This is the ABI for the two halves of a para-virtualized
>>> camera driver which extends Xen's reach multimedia capabilities even
>>> farther enabling it for video conferencing, In-Vehicle Infotainment,
>>> high definition maps etc.
>>>
>>> The initial goal is to support most needed functionality with the
>>> final idea to make it possible to extend the protocol if need be:
>>>
>>> 1. Provide means for base virtual device configuration:
>>>   - pixel formats
>>>   - resolutions
>>>   - frame rates
>>> 2. Support basic camera controls:
>>>   - contrast
>>>   - brightness
>>>   - hue
>>>   - saturation
>>> 3. Support streaming control
>>>
>>> Signed-off-by: Oleksandr Andrushchenko 
>>> <oleksandr_andrushchenko@epam.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
> Thank you, is it good for inclusion in Xen?
ping
>>
>> Juergen
>>
>

