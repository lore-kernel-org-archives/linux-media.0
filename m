Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC3CC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0412084C
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nextdimension.cc header.i=@nextdimension.cc header.b="U6Kx76Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHSVW (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:21:22 -0400
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:44305
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbfDHSVW (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 14:21:22 -0400
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3AA8F2C27D5;
        Mon,  8 Apr 2019 18:14:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (100-96-7-60.trex.outbound.svc.cluster.local [100.96.7.60])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 62FA82C265B;
        Mon,  8 Apr 2019 18:14:17 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|brad@b-rad.cc
Received: from pdx1-sub0-mail-a61.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Mon, 08 Apr 2019 18:14:28 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|brad@b-rad.cc
X-MailChannels-Auth-Id: dreamhost
X-Little-Dime: 78d5ae5e6d870990_1554747268105_726607081
X-MC-Loop-Signature: 1554747268105:2296164928
X-MC-Ingress-Time: 1554747268104
Received: from pdx1-sub0-mail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTP id 629D18043C;
        Mon,  8 Apr 2019 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=nextdimension.cc; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        nextdimension.cc; bh=OWb+U4pnJA++fvSZQgVdUx6GN+c=; b=U6Kx76Lzzmc
        iXBYHDzNCFl4OkjjAcWyOq+fzqAQ6mIEobfSsDkxCs2QOABcdBgRirFkehjJs1V7
        xg+Dd6glHC2riks3QmDRrnvbOZiApCv2XMRslq5xMLHqwp+jRRRDYZjr9nds6L9V
        vztxlENN6YXu88AOnf0D8Qz62LMJxsw4=
Received: from [192.168.0.21] (66-90-189-166.dyn.grandenetworks.net [66.90.189.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: brad@b-rad.cc)
        by pdx1-sub0-mail-a61.g.dreamhost.com (Postfix) with ESMTPSA id 1D59A8041F;
        Mon,  8 Apr 2019 11:14:09 -0700 (PDT)
Subject: Re: [PATCH 07/13] si2157: Briefly wait for tuning operation to
 complete
To:     Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
References: <1546105882-15693-1-git-send-email-brad@nextdimension.cc>
 <1546105882-15693-8-git-send-email-brad@nextdimension.cc>
 <20190405102942.5igrs664bl46v2pg@gofer.mess.org>
X-DH-BACKEND: pdx1-sub0-mail-a61
From:   Brad Love <brad@nextdimension.cc>
Openpgp: preference=signencrypt
Autocrypt: addr=brad@nextdimension.cc; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7620f3b6-296b-411c-d082-573f783e82ac@nextdimension.cc>
Date:   Mon, 8 Apr 2019 13:14:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405102942.5igrs664bl46v2pg@gofer.mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -70
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtqhertddtfeejnecuhfhrohhmpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqnecukfhppeeiiedrledtrddukeelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegludelvddrudeikedrtddrvddungdpihhnvghtpeeiiedrledtrddukeelrdduieeipdhrvghtuhhrnhdqphgrthhhpeeurhgrugcunfhovhgvuceosghrrggusehnvgigthguihhmvghnshhiohhnrdgttgeqpdhmrghilhhfrhhomhepsghrrggusehnvgigthguihhmvghnshhiohhnrdgttgdpnhhrtghpthhtohepshgvrghnsehmvghsshdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 05/04/2019 05.29, Sean Young wrote:
> On Sat, Dec 29, 2018 at 11:51:16AM -0600, Brad Love wrote:
>> Some software reports no signal found on a frequency due to immediatel=
y
>> checking for lock as soon as set_params returns. This waits up 40ms fo=
r
>> tuning operation, then from 30-150ms (dig/analog) for signal lock befo=
re
>> returning from set_params and set_analog_params.
>>
>> Tuning typically completes in 20-30ms. Digital tuning will additionall=
y
>> wait depending on signal characteristics. Analog tuning will wait the
>> full timeout in case of no signal.
> This looks like a workaround for broken userspace. Very possibly this
> is software was tested on a different frontend which does wait for tuni=
ng
> to complete.
>
> This is a change in uapi and will have to be done for all frontends, an=
d
> documented. However I doubt such a change is acceptable.
>
> What software are you refering to?


Hi Sean,

I would have to check with support to find out the various software that
expect when a tune command returns for that tuning operation to have
actually completed. In the current state when you tune si2157 it
immediately returns, no care of the tuning operation completion, no care
of the pll lock success. This is correct? Not so according to Silicon
Labs documentation, which suggests a brief wait. I just took a look at
other drivers, sampling only those with set_analog_params, all but two
have similar code in place to actually allow the tune operation time to
complete (both digital and analog) before returning to userland. The
other drivers just insert arbitrary time delays to accommodate the
operations completion time. At least with my patch I am monitoring the
hardware to know when the operation actually completes.

I see in tuners (not frontends):

mt2063 - waits up to 100ms for lock status and return
r820t - sleep 100ms for pll lock status and return
tda827x - 170-500ms wait after tune before checking status and return
tda8290 - sleep 100ms up to 3x while checking tune status and return
tuner-xc2028 - sleep for 110ms awaiting lock status and return
xc4000 - 10ms sleep after tune, unless debug, then 100ms and return
xc5000 - 20ms sleep after tune,=C2=A0 if pll not locked, re-tune and slee=
p
again, repeat until success and return

There's also other arbitrary sleeps peppered throughout the operations.

Then you have si2157 that fires off the tuning commands and goes right
back to userland immediately, when with instrumented testing, the
operation takes time to complete and lock. The operation does not happen
instantaneously. Software that expects clocks to be locked when the
function returns determine this is an error. They query the tuner
immediately when tune returns and they output tuning failed.

Please explain why awaiting the hardware to say the "tuning operation
you requested is done and clocks are locked" is not ok. If it's not ok,
fine, but then a lot of other drivers are currently "not ok" as well.

Regards,

Brad


>
>
> Sean
>
>> Signed-off-by: Brad Love <brad@nextdimension.cc>
>> ---
>>  drivers/media/tuners/si2157.c | 87 ++++++++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 87 insertions(+)
>>
>> diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si21=
57.c
>> index ff462ba..1737007 100644
>> --- a/drivers/media/tuners/si2157.c
>> +++ b/drivers/media/tuners/si2157.c
>> @@ -318,6 +318,89 @@ static int si2157_sleep(struct dvb_frontend *fe)
>>  	return ret;
>>  }
>> =20
>> +static int si2157_tune_wait(struct i2c_client *client, u8 is_digital)=

>> +{
>> +#define TUN_TIMEOUT 40
>> +#define DIG_TIMEOUT 30
>> +#define ANALOG_TIMEOUT 150
>> +	struct si2157_dev *dev =3D i2c_get_clientdata(client);
>> +	int ret;
>> +	unsigned long timeout;
>> +	unsigned long start_time;
>> +	u8 wait_status;
>> +	u8  tune_lock_mask;
>> +
>> +	if (is_digital)
>> +		tune_lock_mask =3D 0x04;
>> +	else
>> +		tune_lock_mask =3D 0x02;
>> +
>> +	mutex_lock(&dev->i2c_mutex);
>> +
>> +	/* wait tuner command complete */
>> +	start_time =3D jiffies;
>> +	timeout =3D start_time + msecs_to_jiffies(TUN_TIMEOUT);
>> +	while (!time_after(jiffies, timeout)) {
>> +		ret =3D i2c_master_recv(client, &wait_status,
>> +					sizeof(wait_status));
>> +		if (ret < 0) {
>> +			goto err_mutex_unlock;
>> +		} else if (ret !=3D sizeof(wait_status)) {
>> +			ret =3D -EREMOTEIO;
>> +			goto err_mutex_unlock;
>> +		}
>> +
>> +		/* tuner done? */
>> +		if ((wait_status & 0x81) =3D=3D 0x81)
>> +			break;
>> +		usleep_range(5000, 10000);
>> +	}
>> +
>> +	dev_dbg(&client->dev, "tuning took %d ms, status=3D0x%x\n",
>> +		jiffies_to_msecs(jiffies) - jiffies_to_msecs(start_time),
>> +		wait_status);
>> +
>> +	/* if we tuned ok, wait a bit for tuner lock */
>> +	if ((wait_status & 0x81) =3D=3D 0x81) {
>> +		if (is_digital)
>> +			timeout =3D jiffies + msecs_to_jiffies(DIG_TIMEOUT);
>> +		else
>> +			timeout =3D jiffies + msecs_to_jiffies(ANALOG_TIMEOUT);
>> +		while (!time_after(jiffies, timeout)) {
>> +			ret =3D i2c_master_recv(client, &wait_status,
>> +						sizeof(wait_status));
>> +			if (ret < 0) {
>> +				goto err_mutex_unlock;
>> +			} else if (ret !=3D sizeof(wait_status)) {
>> +				ret =3D -EREMOTEIO;
>> +				goto err_mutex_unlock;
>> +			}
>> +
>> +			/* tuner locked? */
>> +			if (wait_status & tune_lock_mask)
>> +				break;
>> +			usleep_range(5000, 10000);
>> +		}
>> +	}
>> +
>> +	dev_dbg(&client->dev, "tuning+lock took %d ms, status=3D0x%x\n",
>> +		jiffies_to_msecs(jiffies) - jiffies_to_msecs(start_time),
>> +		wait_status);
>> +
>> +	if ((wait_status & 0xc0) !=3D 0x80) {
>> +		ret =3D -ETIMEDOUT;
>> +		goto err_mutex_unlock;
>> +	}
>> +
>> +	mutex_unlock(&dev->i2c_mutex);
>> +	return 0;
>> +
>> +err_mutex_unlock:
>> +	mutex_unlock(&dev->i2c_mutex);
>> +	dev_dbg(&client->dev, "failed=3D%d\n", ret);
>> +	return ret;
>> +}
>> +
>>  static int si2157_set_params(struct dvb_frontend *fe)
>>  {
>>  	struct i2c_client *client =3D fe->tuner_priv;
>> @@ -417,6 +500,8 @@ static int si2157_set_params(struct dvb_frontend *=
fe)
>>  	dev->bandwidth =3D bandwidth;
>>  	dev->frequency =3D c->frequency;
>> =20
>> +	si2157_tune_wait(client, 1); /* wait to complete, ignore any errors =
*/
>> +
>>  	return 0;
>>  err:
>>  	dev->bandwidth =3D 0;
>> @@ -626,6 +711,8 @@ static int si2157_set_analog_params(struct dvb_fro=
ntend *fe,
>>  #endif
>>  	dev->bandwidth =3D bandwidth;
>> =20
>> +	si2157_tune_wait(client, 0); /* wait to complete, ignore any errors =
*/
>> +
>>  	return 0;
>>  err:
>>  	dev->bandwidth =3D 0;
>> --=20
>> 2.7.4

