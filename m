Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VzlbqIF8"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575ED10F0
	for <linux-media@vger.kernel.org>; Thu, 30 Nov 2023 16:47:10 -0800 (PST)
Received: from mz550.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dbrouwer)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 641BC660738B;
	Fri,  1 Dec 2023 00:47:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701391629;
	bh=/h7AWDJb/3fCGWg8ghrRVRV0SW7CX+JZ25CLlUI8ySQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzlbqIF8BdDeipy6q+0l8CrM0Ol7X0+04wUVaEW8Ndi81/w/HpLaPMauBHjhjfIVu
	 uPEDujtIT0F04ostr6gY96uOmRQpriHZEikETiHtunZYOpAjcxKc1H+w1fgVsdDHQB
	 cD1/5eu2dEnlIvN2nWlS3jBilwb0DtyjlAbgVxK71jYeBFTc/gdYeREY/tvqOugpEf
	 OvW0OxJnJxIcXebbFbsWlhnacwKZ4OvdDqXk9+JX0NZlAkWsIT4SaZmLko06C2EX5Q
	 ISUHdw3z6Q+GHoiLx2FGDuqQc/WmMVlsZ9sN31JNbE4Rl2wUBF10KzBaaOZ6UzlNxb
	 UuUV2Izg2uBiA==
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: linux-media@vger.kernel.org
Cc: hverkuil-cisco@xs4all.nl,
	Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH 6/6] v4l2-tracer: use stat to verify that retrace file exists
Date: Thu, 30 Nov 2023 16:46:34 -0800
Message-ID: <b17f1feba82de0c7529525e3e35bc5e8a388a9d9.1701390439.git.deborah.brouwer@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701390439.git.deborah.brouwer@collabora.com>
References: <cover.1701390439.git.deborah.brouwer@collabora.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of opening and closing the file to see if it exists, just use
stat. This avoids cluttering a trace with extra opens/closes. Also change
the return value to give a better description of the failure to the
calling function.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 utils/v4l2-tracer/retrace.cpp          | 7 +++----
 utils/v4l2-tracer/v4l2-tracer-common.h | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/utils/v4l2-tracer/retrace.cpp b/utils/v4l2-tracer/retrace.cpp
index b8a1c8fb..60d64d8b 100644
--- a/utils/v4l2-tracer/retrace.cpp
+++ b/utils/v4l2-tracer/retrace.cpp
@@ -1537,12 +1537,11 @@ void retrace_array(json_object *root_array_obj)
 
 int retrace(std::string trace_filename)
 {
-	FILE *trace_file = fopen(trace_filename.c_str(), "r");
-	if (trace_file == nullptr) {
+	struct stat sb;
+	if (stat(trace_filename.c_str(), &sb) == -1) {
 		line_info("\n\tTrace file error: \'%s\'", trace_filename.c_str());
-		return 1;
+		return -EINVAL;
 	}
-	fclose(trace_file);
 
 	fprintf(stderr, "Retracing: %s\n", trace_filename.c_str());
 
diff --git a/utils/v4l2-tracer/v4l2-tracer-common.h b/utils/v4l2-tracer/v4l2-tracer-common.h
index c8b5dbd4..adb41218 100644
--- a/utils/v4l2-tracer/v4l2-tracer-common.h
+++ b/utils/v4l2-tracer/v4l2-tracer-common.h
@@ -26,6 +26,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <unordered_map>
 #include <vector>
-- 
2.41.0

