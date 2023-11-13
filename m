Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48E1C69C
	for <linux-media@vger.kernel.org>; Mon, 13 Nov 2023 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEDFC433C8;
	Mon, 13 Nov 2023 10:22:14 +0000 (UTC)
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: linux-media@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	alsa-devel@alsa-project.org,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5/8] libv4l2util: recognize V4L2_CAP_AUDIO_M2M
Date: Mon, 13 Nov 2023 11:18:46 +0100
Message-ID: <2bc531eda48302243dbebe70a229aae244aba930.1699870530.git.hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <7889c22b922214ebcc0e62feeeb167b40d5042ec.1699870530.git.hverkuil-cisco@xs4all.nl>
References: <7889c22b922214ebcc0e62feeeb167b40d5042ec.1699870530.git.hverkuil-cisco@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect the V4L2_CAP_AUDIO_M2M capability.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 utils/libv4l2util/v4l2_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/utils/libv4l2util/v4l2_driver.c b/utils/libv4l2util/v4l2_driver.c
index 6b6366fa..0c881b0c 100644
--- a/utils/libv4l2util/v4l2_driver.c
+++ b/utils/libv4l2util/v4l2_driver.c
@@ -164,6 +164,8 @@ static char *prt_caps(uint32_t caps)
 		strcat (s,"META_OUTPUT ");
 	if(V4L2_CAP_TOUCH & caps)
 		strcat (s,"TOUCH ");
+	if(V4L2_CAP_AUDIO_M2M & caps)
+		strcat (s,"AUDIO_M2M ");
 	if(V4L2_CAP_IO_MC & caps)
 		strcat (s,"IO_MC ");
 
-- 
2.42.0

