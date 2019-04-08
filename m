Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B1AC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE922084C
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b="AmegVkbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDHSRI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:17:08 -0400
Received: from bonobo.maple.relay.mailchannels.net ([23.83.214.22]:2277 "EHLO
        bonobo.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfDHSRI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 14:17:08 -0400
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 640E9141C75;
        Mon,  8 Apr 2019 18:17:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (100-96-4-125.trex.outbound.svc.cluster.local [100.96.4.125])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B991E1424C4;
        Mon,  8 Apr 2019 18:17:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from pdx1-sub0-mail-a61.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Mon, 08 Apr 2019 18:17:05 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|brad@b-rad.cc
X-MailChannels-Auth-Id: dreamhost
X-Rock-Tangy: 4c9f368f63f42787_1554747425132_704406845
X-MC-Loop-Signature: 1554747425132:1579745078
X-MC-Ingress-Time: 1554747425132
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTP id 1DA8D80437;
        Mon,  8 Apr 2019 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=nextdimension.cc; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        nextdimension.cc; bh=F1PkWGF4uQIN4bn2TT5q99mR26M=; b=AmegVkbMPc2
        cdWJW1IR5bUcrHloDLx26jKiVTG9QfKecI1BY3EuxPZb64k45dg20m/ni5q+K9nb
        Im1iLdL/Qqt2y1cnqXt3vdjfzgQeY9uPBBrEftESC8immit9l1S0PyPb0LPPaspu
        n7AL7JYjSF8jXUjZkZwQrwd/eUFiudP0=
Received: from [192.168.0.21] (66-90-189-166.dyn.grandenetworks.net [66.90.189.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: brad@b-rad.cc)
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTPSA id 710CC80438;
        Mon,  8 Apr 2019 11:17:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] pvrusb2: Add multiple dvb frontend support
To:     Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org
References: <1545421223-3577-1-git-send-email-brad@nextdimension.cc>
 <1551294966-12564-1-git-send-email-brad@nextdimension.cc>
 <1551294966-12564-3-git-send-email-brad@nextdimension.cc>
 <20190405100051.tfarb3rpy6cf7dvt@gofer.mess.org>
X-DH-BACKEND: pdx1-sub0-mail-a61
From:   Brad Love <brad@nextdimension.cc>
Openpgp: preference=signencrypt
Autocrypt: addr=brad@nextdimension.cc; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8ed77b40-2776-2f57-4e8e-1f56d01a82cf@nextdimension.cc>
Date:   Mon, 8 Apr 2019 13:16:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405100051.tfarb3rpy6cf7dvt@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -70
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqnecukfhppeeiiedrledtrddukeelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegludelvddrudeikedrtddrvddungdpihhnvghtpeeiiedrledtrddukeelrdduieeipdhrvghtuhhrnhdqphgrthhhpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqpdhmrghilhhfrhhomhepsghrrggusehnvgigthguihhmvghnshhiohhnrdgttgdpnhhrtghpthhtohepshgvrghnsehmvghsshdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 05/04/2019 05.00, Sean Young wrote:
> On Wed, Feb 27, 2019 at 01:16:04PM -0600, Brad Love wrote:
>> All changes are equivalent and backwards compatible.
>> All current devices have been changed to use fe[0]
>> Cleanup has been added to dvb init to support cleanup after failure.
> Just very minor note. Here you are adding suppport for 2 frontends, but
> you're not explaining why. I would add something like "This is to add support
> for Hauppauge HVR1955/1975 devices which will be done in a later commit",
> to the commit message. Alternatively you could merge the two commits.

Hi Sean,

I'll add a note to the commit message. Combining the commits seems
bizarre and contrary to "one issue in a commit."

Regards,

Brad



>
> Sean
>
>> Signed-off-by: Brad Love <brad@nextdimension.cc>
>> ---
>> No changes
>>
>>  drivers/media/usb/pvrusb2/pvrusb2-devattr.c | 36 +++++++-------
>>  drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 77 ++++++++++++++++++++++-------
>>  drivers/media/usb/pvrusb2/pvrusb2-dvb.h     |  2 +-
>>  3 files changed, 77 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-devattr.c b/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
>> index 06de1c8..ef36b62 100644
>> --- a/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
>> +++ b/drivers/media/usb/pvrusb2/pvrusb2-devattr.c
>> @@ -188,10 +188,10 @@ static struct lgdt330x_config pvr2_lgdt3303_config = {
>>  
>>  static int pvr2_lgdt3303_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	adap->fe = dvb_attach(lgdt330x_attach, &pvr2_lgdt3303_config,
>> -			      0x0e,
>> -			      &adap->channel.hdw->i2c_adap);
>> -	if (adap->fe)
>> +	adap->fe[0] = dvb_attach(lgdt330x_attach, &pvr2_lgdt3303_config,
>> +				 0x0e,
>> +				 &adap->channel.hdw->i2c_adap);
>> +	if (adap->fe[0])
>>  		return 0;
>>  
>>  	return -EIO;
>> @@ -199,7 +199,7 @@ static int pvr2_lgdt3303_attach(struct pvr2_dvb_adapter *adap)
>>  
>>  static int pvr2_lgh06xf_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	dvb_attach(simple_tuner_attach, adap->fe,
>> +	dvb_attach(simple_tuner_attach, adap->fe[0],
>>  		   &adap->channel.hdw->i2c_adap, 0x61,
>>  		   TUNER_LG_TDVS_H06XF);
>>  
>> @@ -248,10 +248,10 @@ static struct lgdt330x_config pvr2_lgdt3302_config = {
>>  
>>  static int pvr2_lgdt3302_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	adap->fe = dvb_attach(lgdt330x_attach, &pvr2_lgdt3302_config,
>> +	adap->fe[0] = dvb_attach(lgdt330x_attach, &pvr2_lgdt3302_config,
>>  			      0x0e,
>>  			      &adap->channel.hdw->i2c_adap);
>> -	if (adap->fe)
>> +	if (adap->fe[0])
>>  		return 0;
>>  
>>  	return -EIO;
>> @@ -259,7 +259,7 @@ static int pvr2_lgdt3302_attach(struct pvr2_dvb_adapter *adap)
>>  
>>  static int pvr2_fcv1236d_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	dvb_attach(simple_tuner_attach, adap->fe,
>> +	dvb_attach(simple_tuner_attach, adap->fe[0],
>>  		   &adap->channel.hdw->i2c_adap, 0x61,
>>  		   TUNER_PHILIPS_FCV1236D);
>>  
>> @@ -335,9 +335,9 @@ static struct tda18271_config hauppauge_tda18271_dvb_config = {
>>  
>>  static int pvr2_tda10048_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	adap->fe = dvb_attach(tda10048_attach, &hauppauge_tda10048_config,
>> +	adap->fe[0] = dvb_attach(tda10048_attach, &hauppauge_tda10048_config,
>>  			      &adap->channel.hdw->i2c_adap);
>> -	if (adap->fe)
>> +	if (adap->fe[0])
>>  		return 0;
>>  
>>  	return -EIO;
>> @@ -345,10 +345,10 @@ static int pvr2_tda10048_attach(struct pvr2_dvb_adapter *adap)
>>  
>>  static int pvr2_73xxx_tda18271_8295_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	dvb_attach(tda829x_attach, adap->fe,
>> +	dvb_attach(tda829x_attach, adap->fe[0],
>>  		   &adap->channel.hdw->i2c_adap, 0x42,
>>  		   &tda829x_no_probe);
>> -	dvb_attach(tda18271_attach, adap->fe, 0x60,
>> +	dvb_attach(tda18271_attach, adap->fe[0], 0x60,
>>  		   &adap->channel.hdw->i2c_adap,
>>  		   &hauppauge_tda18271_dvb_config);
>>  
>> @@ -433,9 +433,9 @@ static struct tda18271_config hauppauge_tda18271_config = {
>>  
>>  static int pvr2_s5h1409_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	adap->fe = dvb_attach(s5h1409_attach, &pvr2_s5h1409_config,
>> +	adap->fe[0] = dvb_attach(s5h1409_attach, &pvr2_s5h1409_config,
>>  			      &adap->channel.hdw->i2c_adap);
>> -	if (adap->fe)
>> +	if (adap->fe[0])
>>  		return 0;
>>  
>>  	return -EIO;
>> @@ -443,9 +443,9 @@ static int pvr2_s5h1409_attach(struct pvr2_dvb_adapter *adap)
>>  
>>  static int pvr2_s5h1411_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	adap->fe = dvb_attach(s5h1411_attach, &pvr2_s5h1411_config,
>> +	adap->fe[0] = dvb_attach(s5h1411_attach, &pvr2_s5h1411_config,
>>  			      &adap->channel.hdw->i2c_adap);
>> -	if (adap->fe)
>> +	if (adap->fe[0])
>>  		return 0;
>>  
>>  	return -EIO;
>> @@ -453,10 +453,10 @@ static int pvr2_s5h1411_attach(struct pvr2_dvb_adapter *adap)
>>  
>>  static int pvr2_tda18271_8295_attach(struct pvr2_dvb_adapter *adap)
>>  {
>> -	dvb_attach(tda829x_attach, adap->fe,
>> +	dvb_attach(tda829x_attach, adap->fe[0],
>>  		   &adap->channel.hdw->i2c_adap, 0x42,
>>  		   &tda829x_no_probe);
>> -	dvb_attach(tda18271_attach, adap->fe, 0x60,
>> +	dvb_attach(tda18271_attach, adap->fe[0], 0x60,
>>  		   &adap->channel.hdw->i2c_adap,
>>  		   &hauppauge_tda18271_config);
>>  
>> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
>> index 4b32b21..cb5586b 100644
>> --- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
>> +++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
>> @@ -343,26 +343,19 @@ static int pvr2_dvb_frontend_init(struct pvr2_dvb_adapter *adap)
>>  		goto done;
>>  	}
>>  
>> -	if ((dvb_props->frontend_attach(adap) == 0) && (adap->fe)) {
>> -
>> -		if (dvb_register_frontend(&adap->dvb_adap, adap->fe)) {
>> +	if (dvb_props->frontend_attach(adap) == 0 && adap->fe[0]) {
>> +		if (dvb_register_frontend(&adap->dvb_adap, adap->fe[0])) {
>>  			pvr2_trace(PVR2_TRACE_ERROR_LEGS,
>>  				   "frontend registration failed!");
>> -			dvb_frontend_detach(adap->fe);
>> -			adap->fe = NULL;
>>  			ret = -ENODEV;
>> -			goto done;
>> +			goto fail_frontend0;
>>  		}
>> +		if (adap->fe[0]->ops.analog_ops.standby)
>> +			adap->fe[0]->ops.analog_ops.standby(adap->fe[0]);
>>  
>> -		if (dvb_props->tuner_attach)
>> -			dvb_props->tuner_attach(adap);
>> -
>> -		if (adap->fe->ops.analog_ops.standby)
>> -			adap->fe->ops.analog_ops.standby(adap->fe);
>> -
>> -		/* Ensure all frontends negotiate bus access */
>> -		adap->fe->ops.ts_bus_ctrl = pvr2_dvb_bus_ctrl;
>> -
>> +		pvr2_trace(PVR2_TRACE_INFO, "transferring fe[%d] ts_bus_ctrl() to pvr2_dvb_bus_ctrl()",
>> +				adap->fe[0]->id);
>> +		adap->fe[0]->ops.ts_bus_ctrl = pvr2_dvb_bus_ctrl;
>>  	} else {
>>  		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
>>  			   "no frontend was attached!");
>> @@ -370,16 +363,62 @@ static int pvr2_dvb_frontend_init(struct pvr2_dvb_adapter *adap)
>>  		return ret;
>>  	}
>>  
>> - done:
>> +	if (dvb_props->tuner_attach && dvb_props->tuner_attach(adap)) {
>> +		pvr2_trace(PVR2_TRACE_ERROR_LEGS, "tuner attach failed");
>> +		ret = -ENODEV;
>> +		goto fail_tuner;
>> +	}
>> +
>> +	if (adap->fe[1]) {
>> +		adap->fe[1]->id = 1;
>> +		adap->fe[1]->tuner_priv = adap->fe[0]->tuner_priv;
>> +		memcpy(&adap->fe[1]->ops.tuner_ops,
>> +			&adap->fe[0]->ops.tuner_ops,
>> +			sizeof(struct dvb_tuner_ops));
>> +
>> +		if (dvb_register_frontend(&adap->dvb_adap, adap->fe[1])) {
>> +			pvr2_trace(PVR2_TRACE_ERROR_LEGS,
>> +				   "frontend registration failed!");
>> +			ret = -ENODEV;
>> +			goto fail_frontend1;
>> +		}
>> +		/* MFE lock */
>> +		adap->dvb_adap.mfe_shared = 1;
>> +
>> +		if (adap->fe[1]->ops.analog_ops.standby)
>> +			adap->fe[1]->ops.analog_ops.standby(adap->fe[1]);
>> +
>> +		pvr2_trace(PVR2_TRACE_INFO, "transferring fe[%d] ts_bus_ctrl() to pvr2_dvb_bus_ctrl()",
>> +				adap->fe[1]->id);
>> +		adap->fe[1]->ops.ts_bus_ctrl = pvr2_dvb_bus_ctrl;
>> +	}
>> +done:
>>  	pvr2_channel_limit_inputs(&adap->channel, 0);
>>  	return ret;
>> +
>> +fail_frontend1:
>> +	dvb_frontend_detach(adap->fe[1]);
>> +	adap->fe[1] = NULL;
>> +fail_tuner:
>> +	dvb_unregister_frontend(adap->fe[0]);
>> +fail_frontend0:
>> +	dvb_frontend_detach(adap->fe[0]);
>> +	adap->fe[0] = NULL;
>> +
>> +	return ret;
>>  }
>>  
>>  static int pvr2_dvb_frontend_exit(struct pvr2_dvb_adapter *adap)
>>  {
>> -	if (adap->fe != NULL) {
>> -		dvb_unregister_frontend(adap->fe);
>> -		dvb_frontend_detach(adap->fe);
>> +	if (adap->fe[1]) {
>> +		dvb_unregister_frontend(adap->fe[1]);
>> +		dvb_frontend_detach(adap->fe[1]);
>> +		adap->fe[1] = NULL;
>> +	}
>> +	if (adap->fe[0]) {
>> +		dvb_unregister_frontend(adap->fe[0]);
>> +		dvb_frontend_detach(adap->fe[0]);
>> +		adap->fe[0] = NULL;
>>  	}
>>  	return 0;
>>  }
>> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.h b/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
>> index e7f71fb..91bff57 100644
>> --- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
>> +++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.h
>> @@ -18,7 +18,7 @@ struct pvr2_dvb_adapter {
>>  	struct dmxdev		dmxdev;
>>  	struct dvb_demux	demux;
>>  	struct dvb_net		dvb_net;
>> -	struct dvb_frontend	*fe;
>> +	struct dvb_frontend	*fe[2];
>>  
>>  	int			feedcount;
>>  	int			max_feed_count;
>> -- 
>> 2.7.4
