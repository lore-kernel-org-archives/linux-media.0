Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114AC433FE
	for <linux-media@archiver.kernel.org>; Sun, 20 Mar 2022 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiCTSjN (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sun, 20 Mar 2022 14:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiCTSjN (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Sun, 20 Mar 2022 14:39:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56828123429
        for <linux-media@vger.kernel.org>; Sun, 20 Mar 2022 11:37:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bi12so26075298ejb.3
        for <linux-media@vger.kernel.org>; Sun, 20 Mar 2022 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:from:subject
         :content-transfer-encoding;
        bh=Xp3VtL5HEaUj334iYHdWAwd/x/QfY9vdE2MLsr2ReRM=;
        b=eR31TVhN17/38r2RZ3mUSVzeYUyZQ4n2WdK8eyXINhPnWfqGhgAWpoSoNcO6/lStyq
         K3p/y2muyHhL8EIcMYsPwvDWjA06KywoQMtsD+Coj1rFSvrPiwBuO1DAWvTcBoORhTVK
         MGzO7CAaUiJxwPWZ+3MXJ2+erRz3fMcrusivfVDZgF8WbRS2i2/eBeHU2KCXYz9yueMx
         KRvmPDV1TmtFREis2xuro+G6H5iAxY6PIkrJzhgOmsQWDQDt5jMtwQpYbHk1nut9XqK9
         td0e8GiT+W93EogyHQuMA334seI1q2RGR+Ui79s0+rNyvOxYSL34UBWcoq2taMfSyUbu
         7KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:from
         :subject:content-transfer-encoding;
        bh=Xp3VtL5HEaUj334iYHdWAwd/x/QfY9vdE2MLsr2ReRM=;
        b=Nk0iaOmZqtQoM0elPrP5Nh4F/E100iSm2ypXhMeRAnV7kAnOizIGPLyoLDdYpQeJMZ
         RFhfymYXdQ8kxi07ST2d0Xx+7/5vMXcQXOcrNGk5VhetaMQ3S+vqamdRqmdODP9fOBN5
         jzS1xNtd/eqJsAXBIoQeLUTA+cxDdJPIECGrP1fqBdvvzKHDT252HxrBkUJ0lj1z5WZE
         PSUYXWwROLxTIhn1zj0JZo18if3fcZHV2yN9tHhxJWmpeltcCOr3Lc+O75F3bpQIYfjQ
         hDab9GhUW/dSZUJZhIgmW2pC9SyaZGnL4V+qsJiV7SgD3Jsii9xx2Far7U7QEnqaKRpu
         0vzQ==
X-Gm-Message-State: AOAM5333E6XlRK3t3XmBhbOhFWMrn2u8fICny4MUOXlMKVj8LNryFN4s
        mQu/b7L0svWpxY9BOXIb0f7I2iUc/sk=
X-Google-Smtp-Source: ABdhPJxV2u2NQHQQtNvPeMWKIgNZ0p41HZuYkUkZ+9Pvn8Oh2qjNWF0t5PoHEQ+jYCWwIzULMG4mpg==
X-Received: by 2002:a17:907:6e89:b0:6df:d819:dc9c with SMTP id sh9-20020a1709076e8900b006dfd819dc9cmr6936855ejc.158.1647801465399;
        Sun, 20 Mar 2022 11:37:45 -0700 (PDT)
Received: from [192.168.2.11] (host-82-63-51-35.business.telecomitalia.it. [82.63.51.35])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd7dee980sm1946923ejc.30.2022.03.20.11.37.44
        for <linux-media@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 11:37:44 -0700 (PDT)
Message-ID: <89adbfa0-5b0a-b55f-5e49-872eb03ca48a@gmail.com>
Date:   Sun, 20 Mar 2022 19:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     linux-media@vger.kernel.org
From:   Andrea Bianchini <andrebia1984@gmail.com>
Subject: v4l2-ctl set priority
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Hi All,

I'm in trouble using v4l2-ctl to set access priority to /dev/video0:

user@COMP:~$ v4l2-ctl -d /dev/video1 --get-priority
Priority: 2

user@COMP:~$ v4l2-ctl -d /dev/video1 --set-priority 3
Priority set: 3

*** then I immediately check for priority ***

user@COMP:~$ v4l2-ctl -d /dev/video1 --get-priority
Priority: 2

priority did'n change.

how to solve??

regards.

Andrea Bianchini


