Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VprCKMsq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C7610C1
	for <linux-media@vger.kernel.org>; Tue, 28 Nov 2023 12:20:17 -0800 (PST)
Received: from umang.jain (unknown [103.238.109.11])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE172BEB;
	Tue, 28 Nov 2023 21:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701202780;
	bh=V86/cbCbHiagWTupbqgzreO3inz+r/czMmxJcGbc2mM=;
	h=From:To:Cc:Subject:Date:From;
	b=VprCKMsqvT63+6msl38ZysoN4X/EfMIyq9TBEG3Ew/jUNxMKDH5p45EURCHjs0zkQ
	 EXKDkJWkMv8AIwGzi2BSuXVZQOiLfE4ghoewDSUupwNCLcv7RDatMOG1ihjkpkkLEZ
	 qwBuOb0rDy+zyRpT/8uxGDef18wIQi8AGtvNoMbE=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	"Ricardo B . Marliere" <ricardo@marliere.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/2] staging: vc04_services: Use %p to log pointer
Date: Wed, 29 Nov 2023 01:50:05 +0530
Message-ID: <20231128202007.489294-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

%lx is used to print the unmodified pointer address for debugging.
%p will print the hashed pointer address to avoid leaking information
about kernel memory layout to userspace. But when `no_hash_pointers`
is passed as kernel parameter, unmodified pointer address will be
printed.

Hence, drop %lx in favour of %p. For debugging purposes, one can
easily depend on `no_hash_pointers`.

This also solves the following smatch warnings:
service_callback() warn: argument 7 to %lx specifier is cast from pointer
service_callback() warn: argument 11 to %lx specifier is cast from pointer
service_callback() warn: argument 12 to %lx specifier is cast from pointer
service_callback() warn: argument 13 to %lx specifier is cast from pointer
vchiq_release() warn: argument 7 to %lx specifier is cast from pointer

Changes in v2:
- Built/Rebased on top of:
  [PATCH v2 0/5] staging: vc04_services: Drop custom logging

Umang Jain (2):
  staging: vc04_services: Use %p to log pointer address
  staging: vc04_services: Use %p to log pointer address

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 +++----
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.41.0

