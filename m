Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337FD65
	for <linux-media@vger.kernel.org>; Tue, 12 Dec 2023 07:28:08 -0800 (PST)
From: James Le Cuirot <chewi@gentoo.org>
To: linux-media@vger.kernel.org
Cc: James Le Cuirot <chewi@gentoo.org>
Subject: [PATCH 1/2] meson: Fix building with -Dv4l-utils=false
Date: Tue, 12 Dec 2023 15:24:05 +0000
Message-ID: <20231212152418.20584-1-chewi@gentoo.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ir_bpf_enabled was referenced without being defined.
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 03508bc8..d9689d35 100644
--- a/meson.build
+++ b/meson.build
@@ -382,6 +382,8 @@ subdir('lib')
 if get_option('v4l-utils')
     subdir('utils')
     subdir('contrib')
+else
+    ir_bpf_enabled = false
 endif
 
 subdir('doc')
-- 
2.42.1

