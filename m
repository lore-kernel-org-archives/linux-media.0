Return-Path: <SRS0=Dnes=SH=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D88BC4360F
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 10:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604AF21872
	for <linux-media@archiver.kernel.org>; Fri,  5 Apr 2019 10:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfDEK3o (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:29:44 -0400
Received: from gofer.mess.org ([88.97.38.141]:49117 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbfDEK3o (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Fri, 5 Apr 2019 06:29:44 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 30EED60247; Fri,  5 Apr 2019 11:29:43 +0100 (BST)
Date:   Fri, 5 Apr 2019 11:29:42 +0100
From:   Sean Young <sean@mess.org>
To:     Brad Love <brad@nextdimension.cc>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH 07/13] si2157: Briefly wait for tuning operation to
 complete
Message-ID: <20190405102942.5igrs664bl46v2pg@gofer.mess.org>
References: <1546105882-15693-1-git-send-email-brad@nextdimension.cc>
 <1546105882-15693-8-git-send-email-brad@nextdimension.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546105882-15693-8-git-send-email-brad@nextdimension.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sat, Dec 29, 2018 at 11:51:16AM -0600, Brad Love wrote:
> Some software reports no signal found on a frequency due to immediately
> checking for lock as soon as set_params returns. This waits up 40ms for
> tuning operation, then from 30-150ms (dig/analog) for signal lock before
> returning from set_params and set_analog_params.
> 
> Tuning typically completes in 20-30ms. Digital tuning will additionally
> wait depending on signal characteristics. Analog tuning will wait the
> full timeout in case of no signal.

This looks like a workaround for broken userspace. Very possibly this
is software was tested on a different frontend which does wait for tuning
to complete.

This is a change in uapi and will have to be done for all frontends, and
documented. However I doubt such a change is acceptable.

What software are you refering to?


Sean

> 
> Signed-off-by: Brad Love <brad@nextdimension.cc>
> ---
>  drivers/media/tuners/si2157.c | 87 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
> index ff462ba..1737007 100644
> --- a/drivers/media/tuners/si2157.c
> +++ b/drivers/media/tuners/si2157.c
> @@ -318,6 +318,89 @@ static int si2157_sleep(struct dvb_frontend *fe)
>  	return ret;
>  }
>  
> +static int si2157_tune_wait(struct i2c_client *client, u8 is_digital)
> +{
> +#define TUN_TIMEOUT 40
> +#define DIG_TIMEOUT 30
> +#define ANALOG_TIMEOUT 150
> +	struct si2157_dev *dev = i2c_get_clientdata(client);
> +	int ret;
> +	unsigned long timeout;
> +	unsigned long start_time;
> +	u8 wait_status;
> +	u8  tune_lock_mask;
> +
> +	if (is_digital)
> +		tune_lock_mask = 0x04;
> +	else
> +		tune_lock_mask = 0x02;
> +
> +	mutex_lock(&dev->i2c_mutex);
> +
> +	/* wait tuner command complete */
> +	start_time = jiffies;
> +	timeout = start_time + msecs_to_jiffies(TUN_TIMEOUT);
> +	while (!time_after(jiffies, timeout)) {
> +		ret = i2c_master_recv(client, &wait_status,
> +					sizeof(wait_status));
> +		if (ret < 0) {
> +			goto err_mutex_unlock;
> +		} else if (ret != sizeof(wait_status)) {
> +			ret = -EREMOTEIO;
> +			goto err_mutex_unlock;
> +		}
> +
> +		/* tuner done? */
> +		if ((wait_status & 0x81) == 0x81)
> +			break;
> +		usleep_range(5000, 10000);
> +	}
> +
> +	dev_dbg(&client->dev, "tuning took %d ms, status=0x%x\n",
> +		jiffies_to_msecs(jiffies) - jiffies_to_msecs(start_time),
> +		wait_status);
> +
> +	/* if we tuned ok, wait a bit for tuner lock */
> +	if ((wait_status & 0x81) == 0x81) {
> +		if (is_digital)
> +			timeout = jiffies + msecs_to_jiffies(DIG_TIMEOUT);
> +		else
> +			timeout = jiffies + msecs_to_jiffies(ANALOG_TIMEOUT);
> +		while (!time_after(jiffies, timeout)) {
> +			ret = i2c_master_recv(client, &wait_status,
> +						sizeof(wait_status));
> +			if (ret < 0) {
> +				goto err_mutex_unlock;
> +			} else if (ret != sizeof(wait_status)) {
> +				ret = -EREMOTEIO;
> +				goto err_mutex_unlock;
> +			}
> +
> +			/* tuner locked? */
> +			if (wait_status & tune_lock_mask)
> +				break;
> +			usleep_range(5000, 10000);
> +		}
> +	}
> +
> +	dev_dbg(&client->dev, "tuning+lock took %d ms, status=0x%x\n",
> +		jiffies_to_msecs(jiffies) - jiffies_to_msecs(start_time),
> +		wait_status);
> +
> +	if ((wait_status & 0xc0) != 0x80) {
> +		ret = -ETIMEDOUT;
> +		goto err_mutex_unlock;
> +	}
> +
> +	mutex_unlock(&dev->i2c_mutex);
> +	return 0;
> +
> +err_mutex_unlock:
> +	mutex_unlock(&dev->i2c_mutex);
> +	dev_dbg(&client->dev, "failed=%d\n", ret);
> +	return ret;
> +}
> +
>  static int si2157_set_params(struct dvb_frontend *fe)
>  {
>  	struct i2c_client *client = fe->tuner_priv;
> @@ -417,6 +500,8 @@ static int si2157_set_params(struct dvb_frontend *fe)
>  	dev->bandwidth = bandwidth;
>  	dev->frequency = c->frequency;
>  
> +	si2157_tune_wait(client, 1); /* wait to complete, ignore any errors */
> +
>  	return 0;
>  err:
>  	dev->bandwidth = 0;
> @@ -626,6 +711,8 @@ static int si2157_set_analog_params(struct dvb_frontend *fe,
>  #endif
>  	dev->bandwidth = bandwidth;
>  
> +	si2157_tune_wait(client, 0); /* wait to complete, ignore any errors */
> +
>  	return 0;
>  err:
>  	dev->bandwidth = 0;
> -- 
> 2.7.4
