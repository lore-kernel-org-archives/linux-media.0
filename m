Received: from mailbnc203.isp.belgacom.be (mailbnc203.isp.belgacom.be [195.238.22.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D152FAC18
	for <linux-media@vger.kernel.org>; Wed,  5 Nov 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.238.22.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340042; cv=none; b=YijMUxdBLJ19hpB0ld22AXP5SXGVMWWGpXIQkvNDaCS7J+iwCH0siqDJXx+rZ+PFmYlXSDgFmeA9cWMkSpBBeIRQ5B1Bbh1X0HmHJKNrwOd0mycRFNfy4bVUEh+RqmloPTcS6Ge7Y8VoRn4cqKlswUxMkbSvCqui/K8piafTNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340042; c=relaxed/simple;
	bh=RPE9Bn3/BFqh3RQbnDcQETUu5sum5fwvQLo7RFTDAbU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0eMU5rg2ZujQMlTflqKw9xdMlR/fe23Riftnb3pkzv19n+4t2w5lW+eXUH6mH8p0IxfBjOIyWHsC3bKx6OhtfrtnpR4B0lnS2xLo+103/W+2sQCLRA/jt6BdxaNy8WIylX9OBpluhXePCtpmo6hHT7uoywIRW5GUJFqggFWuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skynet.be; spf=pass smtp.mailfrom=skynet.be; dkim=pass (2048-bit key) header.d=skynet.be header.i=@skynet.be header.b=e8iTWxs2; arc=none smtp.client-ip=195.238.22.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skynet.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skynet.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skynet.be header.i=@skynet.be header.b="e8iTWxs2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skynet.be; i=@skynet.be; q=dns/txt; s=rmail2;
  t=1762340039; x=1793876039;
  h=date:from:to:subject:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=RPE9Bn3/BFqh3RQbnDcQETUu5sum5fwvQLo7RFTDAbU=;
  b=e8iTWxs2cJgPKsfTju7JkkyQGMYWVdPTaTsdn+hOPau3jxkqnKZuqlL6
   93vRLdUYQlLyjCT76lnjEPqX4MCHVcqMStRWls/s7VAfSVB1ZB+Zn+ryQ
   oOwwcAqnC83JLEHvNfPQA6E8bGEWeaWjugGxxuRV7hVKCq6stc7HRdJKB
   /EanJMEjHtuxxQ6aFTszu0qd3Qy0MqbMaQSpXB8Vuo+TiAwG/BepqOAfw
   cZzFS6vOzBCe5lE/jzPLiEYfvqtoPP7Bqu/uySKNYPT16oHYhCe16xaFK
   WXVN7fc5tNF2iYXHuVvi5OYB7FvVKq8WUEGZzkQtLeB9o30qF98e76Cjg
   w==;
X-CSE-ConnectionGUID: fTGT8hKITT2YlbZXGQTg9A==
X-CSE-MsgGUID: BUKUUqGITDCTRZlODNum6A==
X-ExtLoop: 1
X-IPAS-Result: =?us-ascii?q?A2ESCQBsKwtp/47PEblaHgENLwwOCwkJgUmCFoEqgWkDl?=
 =?us-ascii?q?HwBAQEBAQEGgSEdhDGHRpI6DIFfDwEBAQEBAQEBAQk9FAQBAQMEhVERi3knO?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBAQYEAQICgR2GCUYNS?=
 =?us-ascii?q?QEQAYMsgSYBAQEBAQEBAQEBAQEdAg2BNgE1gQJfFIIWWYJzFLNygTSBAYRkG?=
 =?us-ascii?q?Nk9gW2BSohTAYVuhHhCfYEQgyCBXYQOARIBhmUEgiKBDoYngm+BOI5JBwdhW?=
 =?us-ascii?q?xwDWSwBVRMXCwcFgWMDUjluMh03bUEYcYEUg0khaA8GgRKDUQqJHQ+BB4I9a?=
 =?us-ascii?q?IEFgjg8gUYJAwttPTcIDBsGRUIdEpNmF4MXQyQJGAQeTx8BSTk3KwWTKZ10l?=
 =?us-ascii?q?ReEJowelVMzhASNE4ZJkwuZBoslgXhrmzmBf4EPcE0gGBqBYhhaATMJSRkPV?=
 =?us-ascii?q?gGWXccHdxAsAgcBCgEBAwmIb4p6AQE?=
IronPort-Data: A9a23:xoBCDayn0rk48Z0IWUh6t+dHxyrEfRIJ4+MujC+fZmUNrF6WrkVUz
 DcdUW+CPaqDYmr2e40lOY/ioE4PsZPUzoU1QQFsry00HyNBpOP7XtnIdU2Y0wF+jyHgZBs5s
 JpBMICeRCwQZiaE/n9B55C78CEUOZmgH+S6UKicfHgsGWeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTa+XuDgNyo4GlF5wVmOKgS1LPjvyB94Kw3dPnZw0TQH9E88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnVvukqTHKN0hXZ/011lrfgoo
 Dl+ncXYpTMSA0H5sL91vy9wSn8hYvIcoeGvzU+X6qR/x2WeG5flLm4H4EseZeX08c4vaY1CG
 GBxxJngoXlvisrvqI9XRNWAiewtEObXbIM8m01clwDdB8QWbqn/TPTjsIowMDcY3qiiHN7XY
 8AUcyYpaB3GC/FNEg5HVdRnw6Hy3ia5KmECwL6WjfNfD2z7yA17zpD2M8vTd8DMT8g9ckOw9
 j2dpT+gXE9y2Nq34wemz0+1qc7zsQjHYrAWM5Ge6/s0qQjGroAUIFhMPbehmtG9i0ijS5daJ
 kAV8wIwoqUosk+mVN/wW1u/unHsg/IHc9NeD/d/sVHQj/OLplzBWS1dEmQHZM0gvco3Tnov0
 FKV2tTvAT1pvfuZRBpx64upkN97AgBNRUdqWMPOZVFtDwXLyG34sv4DohuP3kJ4Yh0Z1AwcG
 wy3kRU=
IronPort-HdrOrdr: A9a23:aowtzKOjspFnn8BcT9P255DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE8Ar5K0tQ4uxoWZPwDE80kKQY3WB/B8bHYOCLggqVxcRZnPLfKl7bamHDH4xmpM
 BdmsFFYbWeY2SSz/yKhjVQeOxQo+VvhZrY4Ns2uE0dLz2CBZsB0y5JTiKgVmFmTghPApQ0UL
 CG4NBcmjamcXMLKuymG3gsRYH41pP2vaOjRSRDKw8s6QGIgz/twqX9CQKk0hAXVC4K6as+8F
 LCjxfy6syYwrCGI17npi/uBqZt6ZncI+h4dYmxYw8uW3HRYzOTFcdcsnu5zXcISa+UmRAXeZ
 L30m0d1oxImg7slyeO0FTQMkDboUgTwm6nw1mUjWb8p4jyQTI3DNdahYxfegbE8EZlvNZn3L
 lX02/xjespMTrQ2C766tTUSRdyjUy/rWA5neN7tQ0ibaIOLLBWtoAR50VTDdMJGz/78pkuFK
 10ANjb/+s+SyLTU5n1hBgY/DWXZAV7Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0OgmdL5dUYttQOMaBcenAG3ERhzBdGqUPFT8DakCf3bAsYT+7rk57PyjPJYI0Jwxkp
 LcV04wjx94R2v+TcmVmJFb+BHER2uwGTzr18FF/pB8/qbxQbL6WBfzP2zHuKOb0oQi6w3gKo
 KOEYMTB+WmIXrlGI5P0QG7QZhbMnUSVMUUv908ShaUpN7XKorlvuLWd+uWPaHqGzo/QG/za0
 FzKQQbCP8wnHxDAEWI8CQ5c0mdCXDCwQ==
X-Talos-CUID: 9a23:mx/JOWGjImAZGWoRqmJpyGEoSsAGU0HhlkbUKX2IJl9VR+y8HAo=
X-Talos-MUID: 9a23:+kMwSQtHY+F/IAagLc2nrgxBCfpxzIWSJGsxq6cCnOWiKCkuEmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from aftr-185-17-207-142.dynamic.mnet-online.de (HELO albert.lan) ([185.17.207.142])
  by relay.proximus.be with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Nov 2025 11:52:48 +0100
Received: from libv by albert.lan with local (Exim 4.94.2)
	(envelope-from <libv@skynet.be>)
	id 1vGb8C-000U0p-24
	for linux-media@vger.kernel.org; Wed, 05 Nov 2025 11:52:48 +0100
Date: Wed, 5 Nov 2025 11:52:48 +0100
From: Luc Verhaegen <libv@skynet.be>
To: linux-media@vger.kernel.org
Subject: Graphics DevRoom 26: Cfp.
Message-ID: <aQssgMr9zdKfqryI@skynet.be>
Reply-To: graphics-devroom-manager@fosdem.org
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

20 years after the first X.org DevRoom at FOSDEM 2006, there will be the 
16th Graphics DevRoom at FOSDEM on Sunday the 1st of February 2026.

The talk topics of the graphics devroom encompass:
* graphics drivers: display, 2d engines, 3d engines, at bootloader, 
kernel and userspace levels.
* media/video drivers: camera/capture engines, hardware media encoders 
and decoders on all levels.
* input drivers for bootloaders, kernels and userspace.
* windowing systems (X, wayland, surfaceflinger, others) and window 
managers.
* graphics toolkits (QT, GTK, others).
* 3D and Compute APIs (OpenGL, Vulkan, DirectX, others), and 3d and game 
engines.
* Virtual reality hardware and toolkits.
* Artificial Intelligence HW acceleration.
* Media encode and decode applications.
And the tools needed to help configure and run the above.

Submission deadline is the 7th of december, but do not count on this 
date, once the schedule has filled with enough solid talks, we will 
accept no more. Also, the best slots (afternoon) will be handed out on a 
first-come-first-serve basis.

You can submit your talk here: https://fosdem.org/submit

Since this an open source community event, please refrain from turning 
in a talk that is a pure corporate or product commercial. Also, this is 
a highly technical devroom on a conference aimed at developers and 
advanced users, so please only submit talks on a subject you actually 
worked on.

If you are unsure on whether you can come or not, perhaps you are unsure 
about corporate sponsorship of your travels (this is FOSDEM, why are you 
not there anyway?), wait with submitting your talk until you are certain 
that you can be present.

Please put some time and effort in your talk proposal, especially in the 
title and at least abstract, and your own background. While there is no 
more printed schedule, your description is what will get people to watch 
your talk, and will remain online forever next to the recording of your 
talk.

We have a full day at our disposal, which runs from from 9:00 til 17:00, 
so we can fit anywhere between 8 and 16 talks. With 5 minutes for setup 
time, and 5 minutes of Q&A, full hour talks are actually 50 minutes, and 
half hour talks are 20 minutes. Depending on the amount of proposals, we 
might need to switch to 20 minute talks for everyone.

All talks will be recorded and made available as CC-By-Sa or CC-By. The 
FOSDEM CoC will have to be agreed as well 
(https://fosdem.org/2026/practical/conduct/).

Submission tips:

When submitting at https://fosdem.org/submit, you can ignore the "You 
can enter proposals until 2025-11-16 22:00 (Europe/Brussels), 2 weeks 
from now." statement, as that is for Main track talks only, and not 
relevant for DevRooms.

Please put some time and effort in your talk proposal, especially in the 
title and at least abstract, and your own background. While there is no 
more printed schedule, your description is what will get people to watch 
your talk, and will remain online forever next to the recording of your 
talk.

On the first page, for track, select "Graphics". Please write your 
preferred slot length (20 or 50) in the submission notes. On page 2 you 
also need to provide a code license, this is a free-form field, so write 
what is appropriate.

If there are any issues, just email graphics-devroom-manager@fosdem.org, 
where you can reach the team of graphics devroom managers, Arek Hiler, 
Timur Kristóf and myself, who will also schedule and review your talk 
submissions.

We will be keeping a keen eye on submissions and scheduling, and hope to 
see you all at FOSDEM.

Thanks!

Luc Verhaegen.

