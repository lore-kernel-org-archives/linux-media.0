Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73968295516
	for <linux-media@vger.kernel.org>; Fri,  7 Nov 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505599; cv=none; b=YRazffIk3pQP1OMQj3ovYtu2fI8g/QPCMSkXHTSie3kImeenSUEcDSStapudkszWo1imAGERvr6JSW/wvM3wI9+aEIssUjZwiLv5sBUkg7MR3aXrM2khs3tNEO5eG52b0mQ41Li100mMELzy+Zyjj7zzPuKrMzKXtZsuLuF27VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505599; c=relaxed/simple;
	bh=zdIcHGN1cSCmyu+Bb00lYCqMoLDilbcLvxqesRO76TM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YHEIxVic1w5WSK/s8DwGNybQdPy/WZc+bCO+wDlTjdasAD5veorlCTp1THa+OANYtiE8hbGX0HQAil9Fx47Nd62SqgXmFOooGyWgh0jMHBMYqdqPLC/fceuiZdiOWipK93CPC0/KJU41wP7xkIFQ4hw09w7HgQLi7OeZVKjrY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org; spf=pass smtp.mailfrom=linuxtv.org; dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b=HXFkfJP7; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxtv.org header.i=@linuxtv.org header.b="HXFkfJP7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linuxtv.org
	; s=s1; h=List-ID:Content-Type:MIME-Version:Subject:References:In-Reply-To:
	Message-ID:To:Reply-To:From:Date:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m84HxZkaoHleaIbOz//bdPaw0ErcdNuCWLXvRL8/xiM=; b=HXFkfJP7wcaDDsxGwchM3Kr2lr
	KmHHsd/hgPhzF6rb24BVng1gHFWHe5j+zvY1SyoaZZn1o39P5KqNh1dT420NZ80JtW/7Hr3dUto35
	ihwcrSxBz/x5zjDEVxM+b4w2FVSH6jILaMRBvFQQ7igtY4jBP3k71ptsx+v8yRMujtJTeH2ez+RF1
	ZI0qESbFac+RNUp6yAS2ofDwxzW15kLFjCMQo/KbMUSrn4GOPwb0evXLL4djhjHevBcsGJ3Hk+D6m
	NV9/S+/ivJ3FH2GyO9ySNRBpfDkAtfQ5i6PVEWVoJAJfqqaUF7+zeuSHL7f7hBTCbcpxwLyl6yV7I
	uPcUPgTQ==;
Received: from builder.linuxtv.org ([140.211.167.10])
	by linuxtv.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vHIDc-0008Uw-0w;
	Fri, 07 Nov 2025 08:53:16 +0000
Received: from localhost ([127.0.0.1] helo=builder.linuxtv.org)
	by builder.linuxtv.org with esmtp (Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1vHIDc-002Glr-0g;
	Fri, 07 Nov 2025 08:53:16 +0000
Date: Fri, 7 Nov 2025 08:53:15 +0000 (UTC)
From: Jenkins Builder Robot <jenkins@linuxtv.org>
Reply-To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org
To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org, hverkuil@xs4all.nl
Message-ID: <1601783977.2.1762505596213@builder.linuxtv.org>
In-Reply-To: <410281543.2.1762467299182@builder.linuxtv.org>
References: <410281543.2.1762467299182@builder.linuxtv.org>
Subject: [Jenkins] media.git_drivers_build #445: build failed for x86_64
 allyesconfig x86_64 allmodconfig x86_64 no PM
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1_2031942062.1762505595920"
X-Jenkins-Job: media.git_drivers_build

------=_Part_1_2031942062.1762505595920
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some tests failed:
	PASS: arm32 allmodconfig
	PASS: arm32 allyesconfig
	FAIL: x86_64 allyesconfig
	FAIL: x86_64 allmodconfig
	FAIL: x86_64 no PM
	PASS: arm64 allyesconfig
	PASS: arm64 allmodconfig
	PASS: clang15 allmodconfig

GENERAL INFO

BUILD SUCCESSFUL
Build URL: https://builder.linuxtv.org/job/media.git_drivers_build/445/
Project: media.git_drivers_build
Date of build: Fri, 7 Nov 2025 08:50:09 GMT
Build duration: 3 min 5 sec and counting


CHANGE SET

  	 Revision  by hverkuil: (media: dvb-usb: pctv452e: move snd/rcv len check before kmalloc)

	 change: edit drivers/media/usb/dvb-usb/pctv452e.c
------=_Part_1_2031942062.1762505595920--
