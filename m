Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F85199E89
	for <linux-media@vger.kernel.org>; Thu,  5 Feb 2026 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315559; cv=none; b=UPBSxhohJB4SWDU5j5db9TKu4Gjo+qqxjyOZmTIT36+xiiJP/TNoYDukR6vlDvt87AzhthqpWvTkVd2X0NsPCl5mfqFsMS/SdS+kQMmizCMH1lLdpvVP8v1AWLPB5Cw/jPty7thtyRl8TEduItzeiPzmQd1XARohMj4u+5L5XSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315559; c=relaxed/simple;
	bh=bQ3Kc2edDAQcCOQC+xHi1tR74wG9jtEpxahIcS/jKfw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=WHuzIPBR5j/A22/Otfka86QgvhdFhFCNqrRqkFc9aHtCDejvPcDnpciyANH3h/TYNbsSxU5b4wKMwAwNjoeWdsOhZN42qXYX1oCA38w0F/oxwe2gEfccTz/Ho2WlObE9X0bEqJdQMOG0nrfzPD/qBor6TLrdsCzdinnU3oiiAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=k6aEXmNO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="k6aEXmNO"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BB1EC26F22;
	Thu,  5 Feb 2026 19:19:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvEJtwhCVvQj; Thu,  5 Feb 2026 19:19:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770315555; bh=bQ3Kc2edDAQcCOQC+xHi1tR74wG9jtEpxahIcS/jKfw=;
	h=Date:To:From:Subject:Cc;
	b=k6aEXmNOX0bJk06WP8IzP1DNYSQRgYWlF+ZN41wmGmSI/QbLTeUy0eay9KGbZuFK4
	 rTWjbkUctA+zU3iimP0yrIdnSIojdi3AB2/4wLGqOJRS4SVot1CptDnLQz2RqaosTp
	 Riod04xkafmBTt4K7sQfEmjVoKGzs7bnh1YesVt0O6D4akZzizSTF7nGC3BktwSlZb
	 QCbaq/4VGNzO5RChnGg+DYKe51qX6ErLLdYLIdUOuMm5mUidal/F5WNWKw8M1vtI0d
	 51vyxdZA/N1lQIIMEBrHWlMgYOjaiVP4hpHUD7pVvS/Abf8E/8v9ER0DdQd2O/Ddp5
	 XhxNDCRkk34EA==
Message-ID: <00333af8-f065-4106-bbd7-23bbea0bb7d1@disroot.org>
Date: Fri, 6 Feb 2026 02:19:12 +0800
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-media@vger.kernel.org
From: "Seele Volleri a.k.a. 33335" <33335@disroot.org>
Subject: [RFC] uvcvideo: IR camera support for Windows Hello devices
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm working on adding IR camera support to the uvcvideo driver for
a Windows Hello compliant camera, and there seems to be no support for 
IR camera in kernel.

Some devices (e.g. Dell 0JCXG0 Realtek 0bda:5767 from Inspiron 7xxx 
series, unknown sensor) have a combined RGB/IR camera. The device is 
fully UVC-compliant. Both RGB and IR modes use the same streaming 
interface with standard UVC video streaming. The only difference is that 
IR mode requires vendor-specific Extension Unit commands (on XU ID 0x04) 
before starting the stream.

I'm considering the following design questions:

1. Should the vendor-specific IR initialization be done in-kernel
(in uvcvideo, by vid pid) or in userspace like
https://github.com/EmixamPP/linux-enable-ir-emitter ?

2. Should the device appear as multiple /dev/videoX nodes (RGB and IR)
with mutual exclusion, or as a single device (RGB or IR) with a mode switch?

3. Should I directly add vendor commands in uvcvideo.c or
new file like uvc_ir.c and uvc_ir_realtek_0jcxg0.c ?

I have a working prototype and would appreciate feedback on the
approach before submitting patches.

Thanks!
Seele
