Return-Path: <SRS0=8lr5=ED=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A59DC56201
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2658824724
	for <linux-media@archiver.kernel.org>; Wed, 28 Oct 2020 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603921598;
	bh=1Zr/TDzr4j2BczDujlTXbyp5JW0OQhhIvYde2eIq4oo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=PoueZhCRt5Vghj/4+EbaZGM+iIBOhjlpzy8xIAN4eJTl4IH6FjMaCPQpSw33vKGQT
	 NwKhaQiyn70ODYTkKpXvrzE6HXs82TBNqfUyVM4ILa0gJR5axRW3VHvpg1naTMlsZZ
	 puNVucaOq0RH0hUSK39yLwilJ02+7anfaScgvMfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgJ1VqJ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:46:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJ1VqH (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 28 Oct 2020 17:46:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n6so597416wrm.13;
        Wed, 28 Oct 2020 14:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYyqVjGxVBN3EBsp63KVaNu+q8t9Scw3HyfXR69i9jY=;
        b=gj9BuMa56Q2MqXIrfeWDdcQ8sdHi/l8Caq2UQfBLXWS4IDRloBEaLT5UGhmedz7Ca3
         /DhEZCeXB+XbOWX/VFtOat79GgHbLzjgXLG9XzXGeWJfHZx/zkOjQzhSNF9D8ZLzBybk
         z0mTGYhaHtHf+RJ6uOyCUqS2g4kEVF81KRpIEbjP7j7JUKa0++zWG4tqYy+SQW6huBd7
         p7OAVeQvg8T+pqkwRVVvZt4toNPcCTa/VZidEjAv1fAj5dlKqO95LxfitMnUEhMSPVEs
         dAxexBXkFc+bKqsa8a4y8cXKkoE0m8CT60TJP0ilKZ1fOyNhkyPJq6latytGTN8KffVu
         55Cw==
X-Gm-Message-State: AOAM530xdtfDw9TzNM5do5p3ShKTr2LqjJDU7vkGhSlqE6z11rPd+kRC
        71llujgiTIpZ9r8v+OP0FG0PhFpQE5FWIA==
X-Google-Smtp-Source: ABdhPJzDpghLl+3TD6eqjgXqttTTYOYYwYFz/QvwKAXHI2VfcG/Q6EcvM3sN1JHQc4hfW39DJGZF+w==
X-Received: by 2002:a17:906:a282:: with SMTP id i2mr6365239ejz.39.1603874330838;
        Wed, 28 Oct 2020 01:38:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id g8sm2472979ejp.73.2020.10.28.01.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 01:38:49 -0700 (PDT)
Date:   Wed, 28 Oct 2020 09:38:47 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: i2c: imx258: add HDR control
Message-ID: <20201028083847.GB32155@kozik-lap>
References: <20201005151559.12003-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005151559.12003-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Oct 05, 2020 at 05:15:58PM +0200, Krzysztof Kozlowski wrote:
> The IMX258 supports High Dynamic Range with 5 levels of low/high
> exposure ratio.  Add a V4L2 control for HDR (WIDE_DYNAMIC_RANGE).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/media/i2c/imx258.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Any comments here?

Best regards,
Krzysztof
