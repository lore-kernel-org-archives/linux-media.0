Return-Path: <SRS0=djxu=SF=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD18C4360F
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD93A206DD
	for <linux-media@archiver.kernel.org>; Wed,  3 Apr 2019 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfDCJzM (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:55:12 -0400
Received: from gofer.mess.org ([88.97.38.141]:33959 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDCJzM (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Wed, 3 Apr 2019 05:55:12 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 5806D6020F; Wed,  3 Apr 2019 10:55:10 +0100 (BST)
Date:   Wed, 3 Apr 2019 10:55:10 +0100
From:   Sean Young <sean@mess.org>
To:     Matthias Reichl <hias@horus.com>
Cc:     Benjamin Valentin <benpicco@googlemail.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: rc: xbox_remote: add protocol and set timeout
Message-ID: <20190403095509.y5yobx2dkqhimv6q@gofer.mess.org>
References: <20190324094351.5584-1-hias@horus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324094351.5584-1-hias@horus.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Sun, Mar 24, 2019 at 10:43:51AM +0100, Matthias Reichl wrote:
> The timestamps in ir-keytable -t output showed that the Xbox DVD
> IR dongle decodes scancodes every 64ms. The last scancode of a
> longer button press is decodes 64ms after the last-but-one which
> indicates the decoder doesn't use a timeout but decodes on the last
> edge of the signal.
> 
> 267.042629: lirc protocol(unknown): scancode = 0xace
> 267.042665: event type EV_MSC(0x04): scancode = 0xace
> 267.042665: event type EV_KEY(0x01) key_down: KEY_1(0x0002)
> 267.042665: event type EV_SYN(0x00).
> 267.106625: lirc protocol(unknown): scancode = 0xace
> 267.106643: event type EV_MSC(0x04): scancode = 0xace
> 267.106643: event type EV_SYN(0x00).
> 267.170623: lirc protocol(unknown): scancode = 0xace
> 267.170638: event type EV_MSC(0x04): scancode = 0xace
> 267.170638: event type EV_SYN(0x00).
> 267.234621: lirc protocol(unknown): scancode = 0xace
> 267.234636: event type EV_MSC(0x04): scancode = 0xace
> 267.234636: event type EV_SYN(0x00).
> 267.298623: lirc protocol(unknown): scancode = 0xace
> 267.298638: event type EV_MSC(0x04): scancode = 0xace
> 267.298638: event type EV_SYN(0x00).
> 267.543345: event type EV_KEY(0x01) key_down: KEY_1(0x0002)
> 267.543345: event type EV_SYN(0x00).
> 267.570015: event type EV_KEY(0x01) key_up: KEY_1(0x0002)
> 267.570015: event type EV_SYN(0x00).
> 
> Add a protocol with the repeat value and set the timeout in the
> driver to 10ms (to have a bit of headroom for delays) so the Xbox
> DVD remote performs more responsive.
> 
> Signed-off-by: Matthias Reichl <hias@horus.com>
> ---
> Bug report about sluggish response of the Xbox DVD remote and test
> results can be found in this thread:
> https://forum.libreelec.tv/thread/14861-the-adventures-of-libreelec-and-a-really-old-ir-remote/
> 
> We tried to capture some more protocol details with an mceusb receiver
> but this didn't work well - could be that the Xbox DVD remote uses a
> different carrier frequency and/or the IR receiver can't cope well with
> it's burst lengths.

Not sure what was happening there. When I try with my topseed mceusb device
it works. The remote repeats the IR signal every 64ms exactly, so I think
your patch is spot on.

Thanks

Sean

> 
> 
>  Documentation/media/lirc.h.rst.exceptions | 1 +
>  drivers/media/rc/keymaps/rc-xbox-dvd.c    | 2 +-
>  drivers/media/rc/rc-main.c                | 2 ++
>  drivers/media/rc/xbox_remote.c            | 4 +++-
>  include/media/rc-map.h                    | 4 +++-
>  include/uapi/linux/lirc.h                 | 2 ++
>  6 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/media/lirc.h.rst.exceptions b/Documentation/media/lirc.h.rst.exceptions
> index 7a8b8ff4f076..ac768d769113 100644
> --- a/Documentation/media/lirc.h.rst.exceptions
> +++ b/Documentation/media/lirc.h.rst.exceptions
> @@ -63,6 +63,7 @@ ignore symbol RC_PROTO_IMON
>  ignore symbol RC_PROTO_RCMM12
>  ignore symbol RC_PROTO_RCMM24
>  ignore symbol RC_PROTO_RCMM32
> +ignore symbol RC_PROTO_XBOX_DVD
>  
>  # Undocumented macros
>  
> diff --git a/drivers/media/rc/keymaps/rc-xbox-dvd.c b/drivers/media/rc/keymaps/rc-xbox-dvd.c
> index af387244636b..42815ab57bff 100644
> --- a/drivers/media/rc/keymaps/rc-xbox-dvd.c
> +++ b/drivers/media/rc/keymaps/rc-xbox-dvd.c
> @@ -42,7 +42,7 @@ static struct rc_map_list xbox_dvd_map = {
>  	.map = {
>  		.scan     = xbox_dvd,
>  		.size     = ARRAY_SIZE(xbox_dvd),
> -		.rc_proto = RC_PROTO_UNKNOWN,
> +		.rc_proto = RC_PROTO_XBOX_DVD,
>  		.name     = RC_MAP_XBOX_DVD,
>  	}
>  };
> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> index e8fa28e20192..be5fd129d728 100644
> --- a/drivers/media/rc/rc-main.c
> +++ b/drivers/media/rc/rc-main.c
> @@ -76,6 +76,7 @@ static const struct {
>  		.scancode_bits = 0x00ffffff, .repeat_period = 114 },
>  	[RC_PROTO_RCMM32] = { .name = "rc-mm-32",
>  		.scancode_bits = 0xffffffff, .repeat_period = 114 },
> +	[RC_PROTO_XBOX_DVD] = { .name = "xbox-dvd", .repeat_period = 64 },
>  };
>  
>  /* Used to keep track of known keymaps */
> @@ -1027,6 +1028,7 @@ static const struct {
>  	{ RC_PROTO_BIT_RCMM12 |
>  	  RC_PROTO_BIT_RCMM24 |
>  	  RC_PROTO_BIT_RCMM32,	"rc-mm",	"ir-rcmm-decoder"	},
> +	{ RC_PROTO_BIT_XBOX_DVD, "xbox-dvd",	NULL			},
>  };
>  
>  /**
> diff --git a/drivers/media/rc/xbox_remote.c b/drivers/media/rc/xbox_remote.c
> index f959cbb94744..79470c09989e 100644
> --- a/drivers/media/rc/xbox_remote.c
> +++ b/drivers/media/rc/xbox_remote.c
> @@ -148,7 +148,7 @@ static void xbox_remote_rc_init(struct xbox_remote *xbox_remote)
>  	struct rc_dev *rdev = xbox_remote->rdev;
>  
>  	rdev->priv = xbox_remote;
> -	rdev->allowed_protocols = RC_PROTO_BIT_UNKNOWN;
> +	rdev->allowed_protocols = RC_PROTO_BIT_XBOX_DVD;
>  	rdev->driver_name = "xbox_remote";
>  
>  	rdev->open = xbox_remote_rc_open;
> @@ -157,6 +157,8 @@ static void xbox_remote_rc_init(struct xbox_remote *xbox_remote)
>  	rdev->device_name = xbox_remote->rc_name;
>  	rdev->input_phys = xbox_remote->rc_phys;
>  
> +	rdev->timeout = MS_TO_NS(10);
> +
>  	usb_to_input_id(xbox_remote->udev, &rdev->input_id);
>  	rdev->dev.parent = &xbox_remote->interface->dev;
>  }
> diff --git a/include/media/rc-map.h b/include/media/rc-map.h
> index 5e684bb0d64c..367d983188f7 100644
> --- a/include/media/rc-map.h
> +++ b/include/media/rc-map.h
> @@ -40,6 +40,7 @@
>  #define RC_PROTO_BIT_RCMM12		BIT_ULL(RC_PROTO_RCMM12)
>  #define RC_PROTO_BIT_RCMM24		BIT_ULL(RC_PROTO_RCMM24)
>  #define RC_PROTO_BIT_RCMM32		BIT_ULL(RC_PROTO_RCMM32)
> +#define RC_PROTO_BIT_XBOX_DVD		BIT_ULL(RC_PROTO_XBOX_DVD)
>  
>  #define RC_PROTO_BIT_ALL \
>  			(RC_PROTO_BIT_UNKNOWN | RC_PROTO_BIT_OTHER | \
> @@ -55,7 +56,8 @@
>  			 RC_PROTO_BIT_RC6_MCE | RC_PROTO_BIT_SHARP | \
>  			 RC_PROTO_BIT_XMP | RC_PROTO_BIT_CEC | \
>  			 RC_PROTO_BIT_IMON | RC_PROTO_BIT_RCMM12 | \
> -			 RC_PROTO_BIT_RCMM24 | RC_PROTO_BIT_RCMM32)
> +			 RC_PROTO_BIT_RCMM24 | RC_PROTO_BIT_RCMM32 | \
> +			 RC_PROTO_BIT_XBOX_DVD)
>  /* All rc protocols for which we have decoders */
>  #define RC_PROTO_BIT_ALL_IR_DECODER \
>  			(RC_PROTO_BIT_RC5 | RC_PROTO_BIT_RC5X_20 | \
> diff --git a/include/uapi/linux/lirc.h b/include/uapi/linux/lirc.h
> index 45fcbf99d72e..f99d9dcae667 100644
> --- a/include/uapi/linux/lirc.h
> +++ b/include/uapi/linux/lirc.h
> @@ -195,6 +195,7 @@ struct lirc_scancode {
>   * @RC_PROTO_RCMM12: RC-MM protocol 12 bits
>   * @RC_PROTO_RCMM24: RC-MM protocol 24 bits
>   * @RC_PROTO_RCMM32: RC-MM protocol 32 bits
> + * @RC_PROTO_XBOX_DVD: Xbox DVD Movie Playback Kit protocol
>   */
>  enum rc_proto {
>  	RC_PROTO_UNKNOWN	= 0,
> @@ -224,6 +225,7 @@ enum rc_proto {
>  	RC_PROTO_RCMM12		= 24,
>  	RC_PROTO_RCMM24		= 25,
>  	RC_PROTO_RCMM32		= 26,
> +	RC_PROTO_XBOX_DVD	= 27,
>  };
>  
>  #endif
> -- 
> 2.20.1
