Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5313A25D
	for <linux-media@vger.kernel.org>; Thu, 13 Jun 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311085; cv=none; b=jFJKl2T7IbiEubMr2rry+/ec7Xsy7P0epkoQofOr++PlWoClUuq4ZkfklRGngK8vvTc1ff+fXcoX8yYx0fvORjmFIIY8zTqk2hNWbno46+3wJdB6MOmcWqpmJKEXJ1Ne14z1yzpp5a62SSA3WcgFs4uxyZu9iMe2aywiaOkDSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311085; c=relaxed/simple;
	bh=wT976lkXOTdWJrX6DzXArSEMtpfDIq21lnU7M4pDXZ8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=C4jX7TfJiFil7mkKUN0B5gdwF+wCcoFvVegL9lMq8RWzOOkfvGrLjcXoRXXZQ9ER5dQwG9d+hHccbFkcnkcj1ekawgEWrTowpQxPtQneC9dcFw0Oe1j3PgcsIMOCW00uQl7KiKIJLovGgUv7AT+GBtUYNaG/dYBognEDhkqZnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtv.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from builder.linuxtv.org ([140.211.167.10])
	by linuxtv.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1sHrCp-0005Tw-0P;
	Thu, 13 Jun 2024 20:37:59 +0000
Received: from localhost ([127.0.0.1] helo=builder.linuxtv.org)
	by builder.linuxtv.org with esmtp (Exim 4.96)
	(envelope-from <jenkins@linuxtv.org>)
	id 1sHrCo-00Dmnd-0Y;
	Thu, 13 Jun 2024 20:37:58 +0000
Date: Thu, 13 Jun 2024 20:37:58 +0000 (UTC)
From: Jenkins Builder Robot <jenkins@linuxtv.org>
Reply-To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org
To: mchehab@kernel.org, media-committers@linuxtv.org,
	linux-media@vger.kernel.org, hverkuil@xs4all.nl, mchehab@linuxtv.org
Message-ID: <1071766308.4.1718311078962@builder.linuxtv.org>
In-Reply-To: <1416197571.2.1718286734360@builder.linuxtv.org>
References: <1416197571.2.1718286734360@builder.linuxtv.org>
Subject: [Jenkins] stage-drivers-build #206: build failed for clang15
 allmodconfig
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3_1284217024.1718311078796"
X-Jenkins-Job: stage-drivers-build

------=_Part_3_1284217024.1718311078796
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some tests failed:
	PASS: arm32 allmodconfig
	PASS: arm32 allyesconfig
	PASS: x86_64 allyesconfig
	PASS: x86_64 allmodconfig
	PASS: x86_64 no PM
	PASS: arm64 allyesconfig
	PASS: arm64 allmodconfig
	FAIL: clang15 allmodconfig

GENERAL INFO

BUILD SUCCESSFUL
Build URL: https://builder.linuxtv.org/job/stage-drivers-build/206/
Project: stage-drivers-build
Date of build: Thu, 13 Jun 2024 20:00:08 GMT
Build duration: 37 min and counting


CHANGE SET

  	 Revision  by mchehab: (media: atomisp: Switch to new Intel CPU model defines)

	 change: edit drivers/staging/media/atomisp/include/linux/atomisp_platform.h
------=_Part_3_1284217024.1718311078796--
