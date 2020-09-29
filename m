Return-Path: <SRS0=nxNx=DG=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBAC4741F
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA3E20C09
	for <linux-media@archiver.kernel.org>; Tue, 29 Sep 2020 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgI2Qm3 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:42:29 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:33332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728315AbgI2Qm3 (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 29 Sep 2020 12:42:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9294B1867;
        Tue, 29 Sep 2020 16:42:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coat61_400ebc52718b
X-Filterd-Recvd-Size: 2797
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Sep 2020 16:42:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 29 Sep 2020 09:42:27 -0700
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/20] media: lmedm04: use semicolons rather than commas
 to separate statements
In-Reply-To: <8d73748e-be82-4c30-4550-b5f4eecb3055@wanadoo.fr>
References: <1601385283-26144-1-git-send-email-Julia.Lawall@inria.fr>
 <1601385283-26144-11-git-send-email-Julia.Lawall@inria.fr>
 <8d73748e-be82-4c30-4550-b5f4eecb3055@wanadoo.fr>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <c79b36c12c978d38f3ad89b1c659871a@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [47.6.102.41]
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 2020-09-29 09:00, Christophe JAILLET wrote:
> Le 29/09/2020 à 15:14, Julia Lawall a écrit :
>> Replace commas with semicolons.  Commas introduce unnecessary
>> variability in the code structure and are hard to see.  What is done
>> is essentially described by the following Coccinelle semantic patch
>> (http://coccinelle.lip6.fr/):
>> 
>> // <smpl>
>> @@ expression e1,e2; @@
>> e1
>> -,
>> +;
>> e2
>> ... when any
>> // </smpl>
>> 
>> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>> 
>> ---
>>   drivers/media/usb/dvb-usb-v2/lmedm04.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c 
>> b/drivers/media/usb/dvb-usb-v2/lmedm04.c
>> index 5a7a9522d46d..9ddda8d68ee0 100644
>> --- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
>> +++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
>> @@ -391,7 +391,7 @@ static int lme2510_int_read(struct dvb_usb_adapter 
>> *adap)
>>   	ep = usb_pipe_endpoint(d->udev, lme_int->lme_urb->pipe);
>>     	if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)
>> -		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa),
>> +		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa);
>>     	usb_submit_urb(lme_int->lme_urb, GFP_ATOMIC);
>>   	info("INT Interrupt Service Started");
>> 
>> 
> Ouch!
> 
> This one looks like a real issue!


Julia?  Did you do this one by hand?  This actually changes logic which 
I did not expectthe cocci script to do.
> CJ
