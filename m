Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942727FB3E
	for <linux-media@vger.kernel.org>; Thu,  6 Nov 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439297; cv=none; b=U7zbgpGWq0sB29iSgUq6uzGs8PuPB321wNtPrjwzMxtj+bRPz/LPapDgLe5V+aXGsoGVchySTc2aAIULo25eM6hzZRJ1/mEouBlrjTOtPdA54onUAhNqb0u/TJ7+Zyy6M++wrXmytU7fBjIRymyw/z+BxU9DgVqCibxNE79CO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439297; c=relaxed/simple;
	bh=YFSvTEM0weAk7k1TUzn9ChA0+UrZ0SO+5dshb3TMt5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mrAUjNbXqpUo2ks7O2Gt2bFk77Siu/kwNoBgELOQqXujb0m58G3WTZ+ShBVNxG8Yw8lOp2yLcdr8VPQgpcyFPQ/qO3e93wWpv5dpOP11U2VbH9oABJkvsGfgKXrXQnD+iQiLkvD7ZpQWqWxNl3W6a+xUIchIh9NdXT2BL9L+OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=JEif9uE6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="JEif9uE6"
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id BEAF940777B7;
	Thu,  6 Nov 2025 14:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BEAF940777B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762439284;
	bh=HvMDKMDjG9t4xW4JtrdvUV4yz43xrO7Tnk4prgjHhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JEif9uE6I1gIHvAGXnYUrWy19P9oF6zGyArai3ty5x818HBj3XqgY2K136qhsbN2y
	 w2umRmwh+r6y6TpQYIrobaQdi/cI9gZ8vGhhi4rcmFBwQO3YRTZKv014ugHceLoZN0
	 Wokhn5SN+xWoSBNBPciaicZC4fa2W2RC2wI8sIck=
Date: Thu, 6 Nov 2025 17:28:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Pavel Skripkin <paskripkin@gmail.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Maximilian =?utf-8?B?QsO2aG0=?= <maximilian.boehm@elbmurf.de>
Cc: linux-media@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Robert Schlabbach <Robert.Schlabbach@gmx.net>
Subject: Re: On https://syzkaller.appspot.com/bug?extid=a6969ef522a36d3344c9
 again
Message-ID: <20251106120003-277b4dd327729ae204d0ad19-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c3ee140-69f7-4927-aaaa-6002f47253ec@gmail.com>

Pavel Skripkin wrote:
> Dmitry Antipov <dmantipov@yandex.ru> says:
> > On 10/31/25 5:25 PM, Pavel Skripkin wrote:
> > 
> >> I barely remember details about this bug. IIRC fix caused failure of some real HW and I had to revert it.
> > 
> > This confuses syzbot which seems knows nothing about revert and thinks that the bug
> > is fixed. This means that it doesn't even try to reproduce it. But, as of upstream
> > d127176862a93c4b3216bda533d2bee170af5e71, it can be reproduced manually:
> > 
> 
> If it reproduces, then bug is indeed active not fixed. You can try to 
> re-apply my original patch and see if it breaks something.
> 
> On the other hand, the thing that I broke is quite old, IIRC, so you 
> likely won't be able to debug that failure.
> 
> So I don't really know what to suggest...

Hi,

I suspect the patch actually may introduce a refcount underflow situation.
It's been briefly discussed at original bug-report thread [1] with a final
conclusion that every ->fini() callback guards against double-free.  This
doesn't look right as there is a subtle difference in handling devices
which have ->is_audio_only == true.

TLDR: new proposed solution for "BUG: corrupted list in em28xx_init_extension"
and "KASAN: use-after-free Read in em28xx_init_extension (2)" reported by
Syzkaller is at the bottom of the current email.

Original (reverted) patch for these bugs - 2c98b8a3458d ("media: em28xx:
add missing em28xx_close_extension") - seemingly introduces a refcount
underflow for 'dev->dev_next' when dev->is_audio_only is true.  Apparently
this is what was hit by Maximilian with his device at [2].  See:

em28xx_usb_probe()
  dev->dev_next = NULL;
  em28xx_init_dev(dev)
    if (dev->is_audio_only)
      em28xx_init_extension() // add basic 'dev' to &em28xx_devlist and
                              // call ->init() for 'dev';
                              //'dev_next' is still NULL so no ->init()
                              // for 'dev_next'

  if (... && em28xx_duplicate_dev())
    em28xx_init_dev(dev->dev_next)
      if (dev->is_audio_only)
        em28xx_init_extension()  // add 'dev_next' to &em28xx_devlist, call ->init()


em28xx_usb_disconnect()
  em28xx_close_extension(dev) // call ->fini() for 'dev' *and* 'dev->dev_next'
  if (dev->dev_next)
    em28xx_close_extension(dev->dev_next) // call uncompensated ->fini() for 'dev->dev_next'


So for 'dev->dev_next' we call ->init() once, while ->fini() is called
twice.

As it's audio_only, we deal with "Em28xx Audio Extension":

	static struct em28xx_ops audio_ops = {
		.id   = EM28XX_AUDIO,
		.name = "Em28xx Audio Extension",
		.init = em28xx_audio_init,
		.fini = em28xx_audio_fini,
		.suspend = em28xx_audio_suspend,
		.resume = em28xx_audio_resume,
	};


Have a look at em28xx_audio_fini().  The device structure corresponding to
the faked Syzkaller USB device doesn't have dev->usb_audio_type set to
EM28XX_USB_AUDIO_VENDOR, and the check at the beginning of the function
quickly exits and current Syzkaller repros can't hit the double-free bug.
If that check is passed, then a double refcount put might happen.

I've examined why dev->usb_audio_type is not set to EM28XX_USB_AUDIO_VENDOR
in case of Syzkaller repros I've seen - it's reset in "AC97 chip type
couldn't be determined\n" handling block inside em28xx_audio_setup().
That's purely a hardware configuration condition.

So the problem is that in '->is_audio_only == true' case we have
em28xx_init_extension() being called for basic 'dev' before it has an
assigned 'dev->dev_next'.  It's worth saying that with ->is_audio_only == false
em28xx_init_extension() for basic 'dev' is only called inside
request_module_async() worker function which is scheduled *after*
'dev->dev_next' is set.

is_audio_only stuff was introduced in commit 4f83e7b3ef93 ("[media] em28xx:
Add support for devices with a separate audio interface") and at that time
the usb-disconnect method handled is_audio_only with a separate logic.  It
was changed with 6582af4c018a ("[media] em28xx: Fix usb diconnect logic").


I believe we can put all em28xx_init_extension() calls inside
request_module_async() worker.  So that it'll be called only for the 'dev',
not 'dev->dev_next'.  It doesn't make sense to call it for 'dev->dev_next'
because this device is already managed via 'dev', and all the
em28xx_*_extension() routines already call extra callbacks for 'dev->dev_next'.

Thus 'dev->dev_next' won't be added to &em28xx_devlist at all and the
Syzkaller-reported problems will be gone, hopefully.

Now, looking at request_module_async() function, I wonder whether the
location of em28xx_init_extension() there does make sense, it was set by
commit 6ae5e0608405 ("em28xx: Make all em28xx extensions to be initialized
asynchronously").

Calling em28xx_init_extension() *before* requesting the modules looks
wrong because if these modules haven't been really loaded in advance then
em28xx_init_extension() just does nothing due to empty extensions list..?

[1]: https://lore.kernel.org/all/bcd3265f-9a63-ca40-bdf9-ef7bc671f5d1@gmail.com/
[2]: https://lore.kernel.org/all/6a72a37b-e972-187d-0322-16336e12bdc5@elbmurf.de/

I've come up with something like below:


[ Mauro, Maximilian, if you can test this with real hardware, it will be
  greatly appreciated.  I can send it as a standalone patch if needed ]


From d974515303c47fdab4722f968ab2ca438de67ab3 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Thu, 6 Nov 2025 16:48:11 +0300
Subject: [PATCH] media: em28xx: fix extensions handling

Calling em28xx_init_extension() from inside em28xx_init_dev() doesn't look
right as dev->dev_next is added to the global list then.  The driver
doesn't expect that and may crash further when touching the already freed
device in the list.  Since dev->dev_next is already managed via dev and
all the em28xx_*_extension() routines call extra callbacks for it, place
em28xx_init_extension() into worker function so that it would be called
only for basic dev.

Also em28xx_init_extension() requires the needed modules to be already
loaded, otherwise the extensions list would be empty and the function
will do nothing.  Thus move it after the corresponding modules are loaded.

Fixes: be7fd3c3a8c5 ("media: em28xx: Hauppauge DualHD second tuner functionality")
Fixes: 6ae5e0608405 ("em28xx: Make all em28xx extensions to be initialized asynchronously")
Reported-by: syzbot+a6969ef522a36d3344c9@syzkaller.appspotmail.com
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index a51cbcf429e1..76a07400ea92 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3445,17 +3445,16 @@ static void request_module_async(struct work_struct *work)
 
 	/*
 	 * Devices with an audio-only intf also have a V4L/DVB/RC
-	 * intf. Don't register extensions twice on those devices.
+	 * intf.
 	 */
 	if (dev->is_audio_only) {
 #if defined(CONFIG_MODULES) && defined(MODULE)
 		request_module("em28xx-alsa");
 #endif
+		em28xx_init_extension(dev);
 		return;
 	}
 
-	em28xx_init_extension(dev);
-
 #if defined(CONFIG_MODULES) && defined(MODULE)
 	if (dev->has_video)
 		request_module("em28xx-v4l");
@@ -3469,6 +3468,8 @@ static void request_module_async(struct work_struct *work)
 	    ((dev->board.ir_codes || dev->board.has_ir_i2c) && !disable_ir))
 		request_module("em28xx-rc");
 #endif /* CONFIG_MODULES */
+
+	em28xx_init_extension(dev);
 }
 
 static void request_modules(struct em28xx *dev)
@@ -3676,8 +3677,6 @@ static int em28xx_init_dev(struct em28xx *dev, struct usb_device *udev,
 			retval = -ENODEV;
 			goto err_deinit_media;
 		}
-		em28xx_init_extension(dev);
-
 		return 0;
 	}
 
-- 
2.51.0

