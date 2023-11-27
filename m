Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AC119;
	Sun, 26 Nov 2023 17:00:03 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vx7XZlQ_1701046800;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vx7XZlQ_1701046800)
          by smtp.aliyun-inc.com;
          Mon, 27 Nov 2023 09:00:01 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: nas.chung@chipsnmedia.com,
	jackson.lee@chipsnmedia.com,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] media: chips-media: wave5: Remove unneeded semicolon
Date: Mon, 27 Nov 2023 08:59:58 +0800
Message-Id: <20231127005959.108764-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c:95:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7633
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..8bbf9d10b467 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -92,7 +92,7 @@ static int switch_state(struct vpu_instance *inst, enum vpu_instance_state state
 		break;
 	case VPU_INST_STATE_STOP:
 		break;
-	};
+	}
 
 	dev_dbg(inst->dev->dev, "Switch state from %s to %s.\n",
 		state_to_str(inst->state), state_to_str(state));
-- 
2.20.1.7.g153144c

