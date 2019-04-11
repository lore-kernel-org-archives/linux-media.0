Return-Path: <SRS0=hW3k=SN=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691DC10F11
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED0A2075B
	for <linux-media@archiver.kernel.org>; Thu, 11 Apr 2019 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDKBgI (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:36:08 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:51138 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKBgI (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 21:36:08 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Apr 2019 21:36:03 EDT
Received: from randy.li?rock-chips.com (unknown [192.168.167.97])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5EC615710E;
        Thu, 11 Apr 2019 09:29:25 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 0
X-SKE-CHECKED: 0
X-ANTISPAM-LEVEL: 2
Received: from [192.168.10.130] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10893T140178807060224S1554946162179779_;
        Thu, 11 Apr 2019 09:29:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <da5a512d69aef8f8260d91cb8f99dc99>
X-RL-SENDER: randy.li@rock-chips.com
X-SENDER: randy.li@rock-chips.com
X-LOGIN-NAME: randy.li@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v3 1/9] staging: video: rockchip: add v4l2 decoder
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     ayaka <ayaka@soulik.info>, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, maxime.ripard@bootlin.com, joro@8bytes.org,
        jernej.skrabec@gmail.com, paul.kocialkowski@bootlin.com,
        thomas.petazzoni@bootlin.com, mchehab@kernel.org,
        ezequiel@collabora.com, posciak@chromium.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org
References: <20190410124226.8612-1-ayaka@soulik.info>
 <20190410124226.8612-2-ayaka@soulik.info>
 <2b225e07b03359311c21ab2b3c41096a97beb338.camel@ndufresne.ca>
From:   Randy Li <randy.li@rock-chips.com>
Message-ID: <cc5816d8-43cb-aedc-e496-f92baf37e6b3@rock-chips.com>
Date:   Thu, 11 Apr 2019 09:29:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2b225e07b03359311c21ab2b3c41096a97beb338.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 4/10/19 11:57 PM, Nicolas Dufresne wrote:
> Le mercredi 10 avril 2019 à 20:42 +0800, ayaka a écrit :
>> From: Randy Li <ayaka@soulik.info>
>>
>> TODO:
>> task finish
>> finish a task before it would be dequeued
>> iommu attach won't reload buffers
>>
>> Signed-off-by: Randy Li <randy.li@rock-chips.com>
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>>   drivers/staging/Kconfig                       |    2 +
>>   drivers/staging/Makefile                      |    1 +
>>   drivers/staging/rockchip-mpp/Kconfig          |   33 +
>>   drivers/staging/rockchip-mpp/Makefile         |   10 +
>>   drivers/staging/rockchip-mpp/mpp_debug.h      |   87 +
>>   drivers/staging/rockchip-mpp/mpp_dev_common.c | 1391 +++++++
>>   drivers/staging/rockchip-mpp/mpp_dev_common.h |  212 +
>>   drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c |  919 +++++
>>   drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c  |  601 +++
>>   drivers/staging/rockchip-mpp/mpp_service.c    |  197 +
>>   drivers/staging/rockchip-mpp/mpp_service.h    |   38 +
>>   drivers/staging/rockchip-mpp/rkvdec/avc.c     |  202 +
>>   drivers/staging/rockchip-mpp/rkvdec/cabac.h   | 3614 +++++++++++++++++
>>   drivers/staging/rockchip-mpp/rkvdec/hal.h     |   70 +
>>   drivers/staging/rockchip-mpp/rkvdec/hevc.c    |  167 +
>>   drivers/staging/rockchip-mpp/rkvdec/regs.h    |  377 ++
>>   drivers/staging/rockchip-mpp/vdpu2/hal.h      |   52 +
>>   drivers/staging/rockchip-mpp/vdpu2/mpeg2.c    |  270 ++
>>   drivers/staging/rockchip-mpp/vdpu2/regs.h     |  670 +++
>>   include/uapi/video/rk_vpu_service.h           |  101 +
>>   20 files changed, 9014 insertions(+)
>>   create mode 100644 drivers/staging/rockchip-mpp/Kconfig
>>   create mode 100644 drivers/staging/rockchip-mpp/Makefile
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_debug.h
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.c
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_common.h
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_dev_vdpu2.c
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_service.c
>>   create mode 100644 drivers/staging/rockchip-mpp/mpp_service.h
>>   create mode 100644 drivers/staging/rockchip-mpp/rkvdec/avc.c
>>   create mode 100644 drivers/staging/rockchip-mpp/rkvdec/cabac.h
>>   create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hal.h
>>   create mode 100644 drivers/staging/rockchip-mpp/rkvdec/hevc.c
>>   create mode 100644 drivers/staging/rockchip-mpp/rkvdec/regs.h
>>   create mode 100644 drivers/staging/rockchip-mpp/vdpu2/hal.h
>>   create mode 100644 drivers/staging/rockchip-mpp/vdpu2/mpeg2.c
>>   create mode 100644 drivers/staging/rockchip-mpp/vdpu2/regs.h
>>   create mode 100644 include/uapi/video/rk_vpu_service.h
>>
>>
>> diff --git a/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
>> new file mode 100644
>> index 000000000000..756821dbf829
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/mpp_dev_rkvdec.c
>> @@ -0,0 +1,919 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <asm/cacheflush.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <soc/rockchip/pm_domains.h>
>> +#include <soc/rockchip/rockchip_sip.h>
>> +
>> +#include <linux/videodev2.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <media/v4l2-mem2mem.h>
>> +
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "mpp_debug.h"
>> +#include "mpp_dev_common.h"
>> +#include "rkvdec/cabac.h"
>> +#include "rkvdec/hal.h"
>> +
>> +#define RKVDEC_DRIVER_NAME		"mpp_rkvdec"
>> +
>> +#define RKVDEC_VER_RK3328_BIT		BIT(1)
>> +#define IOMMU_GET_BUS_ID(x)		(((x) >> 6) & 0x1f)
>> +#define IOMMU_PAGE_SIZE			SZ_4K
>> +
>> +#define RKVDEC_NODE_NAME		"rkvdec"
>> +#define RK_HEVCDEC_NODE_NAME		"hevc-service"
>> +
>> +#define to_rkvdec_task(ctx)		\
>> +		container_of(ctx, struct rkvdec_task, mpp_task)
>> +#define to_rkvdec_dev(dev)		\
>> +		container_of(dev, struct rockchip_rkvdec_dev, mpp_dev)
>> +
>> +#define RKVDEC_ERROR_INFO_SIZE			(144 * 4)
>> +#define RKVDEC_ERROR_INFO_MAX_SIZE		(RKVDEC_ERROR_INFO_SIZE * 256)
>> +
>> +static int debug;
>> +module_param(debug, int, 0644);
>> +MODULE_PARM_DESC(debug, "bit switch for rkvdec debug information");
>> +
>> +enum RKVDEC_STATE {
>> +	RKVDEC_STATE_NORMAL,
>> +	RKVDEC_STATE_LT_START,
>> +	RKVDEC_STATE_LT_RUN,
>> +};
>> +
>> +struct rockchip_rkvdec_dev {
>> +	struct rockchip_mpp_dev mpp_dev;
>> +
>> +	struct reset_control *rst_a;
>> +	struct reset_control *rst_h;
>> +	struct reset_control *rst_niu_a;
>> +	struct reset_control *rst_niu_h;
>> +	struct reset_control *rst_core;
>> +	struct reset_control *rst_cabac;
>> +
>> +	enum RKVDEC_STATE state;
>> +
>> +	unsigned long aux_iova;
>> +	struct page *aux_page;
>> +
>> +	dma_addr_t cabac_avc_addr;
>> +	void *cabac_avc_vaddr;
>> +
>> +	dma_addr_t cabac_hevc_addr;
>> +	void *cabac_hevc_vaddr;
>> +
>> +	dma_addr_t errorinfo_addr;
>> +	void *errorinfo_vaddr;
>> +
>> +	void *current_task;
>> +};
>> +
>> +struct rkvdec_task {
>> +	struct mpp_task mpp_task;
>> +
>> +	u32 reg[ROCKCHIP_RKVDEC_REG_NUM];
>> +	u32 idx;
>> +
>> +	u32 irq_status;
>> +};
>> +
>> +static struct rockchip_mpp_control hevc_controls[] = {
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC_SLICE,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_SPS,
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_sps),
>> +	 },
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_PPS,diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
>> index c0901b96cfe4..5f84035e2a89 100644
>> --- a/drivers/staging/Kconfig
>> +++ b/drivers/staging/Kconfig
>> @@ -124,4 +124,6 @@ source "drivers/staging/axis-fifo/Kconfig"
>>   
>>   source "drivers/staging/erofs/Kconfig"
>>   
>> +source "drivers/staging/rockchip-mpp/Kconfig"
>> +
>>   endif # STAGING
>> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
>> index 57c6bce13ff4..fc3ed97a0eab 100644
>> --- a/drivers/staging/Makefile
>> +++ b/drivers/staging/Makefile
>> @@ -52,3 +52,4 @@ obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
>>   obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
>>   obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
>>   obj-$(CONFIG_EROFS_FS)		+= erofs/
>> +obj-$(CONFIG_ROCKCHIP_MPP_SERVICE)	+= rockchip-mpp/
>> diff --git a/drivers/staging/rockchip-mpp/Kconfig b/drivers/staging/rockchip-mpp/Kconfig
>> new file mode 100644
>> index 000000000000..17e079a77203
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/Kconfig
>> @@ -0,0 +1,33 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +menu "ROCKCHIP_MPP"
>> +	depends on ARCH_ROCKCHIP
>> +
>> +config ROCKCHIP_MPP_SERVICE
>> +	tristate "mpp service scheduler"
>> +	default n
>> +	help
>> +	  rockchip mpp service.
>> +
>> +config ROCKCHIP_MPP_DEVICE
>> +	tristate "mpp device framework"
>> +	depends on ROCKCHIP_MPP_SERVICE
>> +	select V4L2_MEM2MEM_DEV
>> +	select VIDEOBUF2_DMA_CONTIG
>> +	default n
>> +	help
>> +	  rockchip mpp device framework.
>> +
>> +config ROCKCHIP_MPP_VDEC_DEVICE
>> +	tristate "video decoder device driver"
>> +	depends on ROCKCHIP_MPP_DEVICE
>> +	default n
>> +	help
>> +	  rockchip mpp video decoder and hevc decoder.
>> +
>> +config ROCKCHIP_MPP_VDPU2_DEVICE
>> +	tristate "VPU decoder v2 device driver"
>> +	depends on ROCKCHIP_MPP_DEVICE
>> +	default n
>> +	help
>> +	  rockchip mpp vpu decoder v2.
>> +endmenu
>> diff --git a/drivers/staging/rockchip-mpp/Makefile b/drivers/staging/rockchip-mpp/Makefile
>> new file mode 100644
>> index 000000000000..9722b0059563
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/Makefile
>> @@ -0,0 +1,10 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +rk-mpp-service-objs := mpp_service.o
>> +rk-mpp-device-objs := mpp_dev_common.o
>> +rk-mpp-vdec-objs := mpp_dev_rkvdec.o rkvdec/hevc.o rkvdec/avc.o
>> +rk-mpp-vdpu2-objs := mpp_dev_vdpu2.o vdpu2/mpeg2.o
>> +
>> +obj-$(CONFIG_ROCKCHIP_MPP_SERVICE) += rk-mpp-service.o
>> +obj-$(CONFIG_ROCKCHIP_MPP_DEVICE) += rk-mpp-device.o
>> +obj-$(CONFIG_ROCKCHIP_MPP_VDEC_DEVICE) += rk-mpp-vdec.o
>> +obj-$(CONFIG_ROCKCHIP_MPP_VDPU2_DEVICE) += rk-mpp-vdpu2.o
>> diff --git a/drivers/staging/rockchip-mpp/mpp_debug.h b/drivers/staging/rockchip-mpp/mpp_debug.h
>> new file mode 100644
>> index 000000000000..bd6c0e594da3
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/mpp_debug.h
>> @@ -0,0 +1,87 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2016 - 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef _ROCKCHIP_MPP_DEBUG_H_
>> +#define _ROCKCHIP_MPP_DEBUG_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * debug flag usage:
>> + * +------+-------------------+
>> + * | 8bit |      24bit        |
>> + * +------+-------------------+
>> + *  0~23 bit is for different information type
>> + * 24~31 bit is for information print format
>> + */
>> +
>> +#define DEBUG_POWER				0x00000001
>> +#define DEBUG_CLOCK				0x00000002
>> +#define DEBUG_IRQ_STATUS			0x00000004
>> +#define DEBUG_IOMMU				0x00000008
>> +#define DEBUG_IOCTL				0x00000010
>> +#define DEBUG_FUNCTION				0x00000020
>> +#define DEBUG_REGISTER				0x00000040
>> +#define DEBUG_EXTRA_INFO			0x00000080
>> +#define DEBUG_TIMING				0x00000100
>> +#define DEBUG_TASK_INFO				0x00000200
>> +#define DEBUG_DUMP_ERR_REG			0x00000400
>> +#define DEBUG_LINK_TABLE			0x00000800
>> +
>> +#define DEBUG_SET_REG				0x00001000
>> +#define DEBUG_GET_REG				0x00002000
>> +#define DEBUG_PPS_FILL				0x00004000
>> +#define DEBUG_IRQ_CHECK				0x00008000
>> +#define DEBUG_CACHE_32B				0x00010000
>> +
>> +#define DEBUG_RESET				0x00020000
>> +
>> +#define PRINT_FUNCTION				0x80000000
>> +#define PRINT_LINE				0x40000000
>> +
>> +#define mpp_debug_func(type, fmt, args...)			\
>> +	do {							\
>> +		if (unlikely(debug & type)) {			\
>> +			pr_info("%s:%d: " fmt,			\
>> +				 __func__, __LINE__, ##args);	\
>> +		}						\
>> +	} while (0)
>> +#define mpp_debug(type, fmt, args...)				\
>> +	do {							\
>> +		if (unlikely(debug & type)) {			\
>> +			pr_info(fmt, ##args);			\
>> +		}						\
>> +	} while (0)
>> +
>> +#define mpp_debug_enter()					\
>> +	do {							\
>> +		if (unlikely(debug & DEBUG_FUNCTION)) {		\
>> +			pr_info("%s:%d: enter\n",		\
>> +				 __func__, __LINE__);		\
>> +		}						\
>> +	} while (0)
>> +
>> +#define mpp_debug_leave()					\
>> +	do {							\
>> +		if (unlikely(debug & DEBUG_FUNCTION)) {		\
>> +			pr_info("%s:%d: leave\n",		\
>> +				 __func__, __LINE__);		\
>> +		}						\
>> +	} while (0)
>> +
>> +#define mpp_err(fmt, args...)					\
>> +		pr_err("%s:%d: " fmt, __func__, __LINE__, ##args)
>> +
>> +#endif
>> diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.c b/drivers/staging/rockchip-mpp/mpp_dev_common.c
>> new file mode 100644
>> index 000000000000..21816ad8a43b
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/mpp_dev_common.c
>> @@ -0,0 +1,1391 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2016 - 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *		Randy Li, <ayaka@soulik.info>
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iommu.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +
>> +#include <linux/videodev2.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-event.h>
>> +#include <media/v4l2-mem2mem.h>
>> +#include <media/videobuf2-core.h>
>> +#include <media/videobuf2-dma-contig.h>
>> +
>> +#include "mpp_debug.h"
>> +#include "mpp_dev_common.h"
>> +#include "mpp_service.h"
>> +
>> +#define MPP_TIMEOUT_DELAY		(2000)
>> +#include "mpp_dev_common.h"
>> +
>> +#define MPP_SESSION_MAX_DONE_TASK	(20)
>> +
>> +static int debug;
>> +module_param(debug, int, 0644);
>> +MODULE_PARM_DESC(debug, "bit switch for mpp device debug information");
>> +
>> +static struct class *mpp_device_class;
>> +static const struct v4l2_file_operations mpp_v4l2_default_fops;
>> +
>> +static int rockchip_mpp_result(struct rockchip_mpp_dev *mpp_dev,
>> +			       struct mpp_task *task);
>> +
>> +static const struct media_device_ops mpp_m2m_media_ops = {
>> +	.req_validate   = vb2_request_validate,
>> +	.req_queue      = v4l2_m2m_request_queue,
>> +};
>> +
>> +static void mpp_session_push_pending(struct mpp_session *session,
>> +				     struct mpp_task *task)
>> +{
>> +	mutex_lock(&session->lock);
>> +	list_add_tail(&task->session_link, &session->pending);
>> +	mutex_unlock(&session->lock);
>> +}
>> +
>> +static void mpp_session_push_done(struct mpp_task *task)
>> +{
>> +	struct mpp_session *session = NULL;
>> +
>> +	session = task->session;
>> +
>> +	mutex_lock(&session->lock);
>> +	list_del_init(&task->session_link);
>> +	mutex_unlock(&session->lock);
>> +
>> +	//kfifo_in(&session->done_fifo, &task, 1);
>> +	rockchip_mpp_result(session->mpp_dev, task);
>> +}
>> +
>> +static struct mpp_task *mpp_session_pull_done(struct mpp_session *session)
>> +{
>> +	struct mpp_task *task = NULL;
>> +
>> +	if (kfifo_out(&session->done_fifo, &task, 1))
>> +		return task;
>> +	return NULL;
>> +}
>> +
>> +static void mpp_dev_sched_irq(struct work_struct *work)
>> +{
>> +	struct mpp_task *task = container_of(work, struct mpp_task, work);
>> +	struct rockchip_mpp_dev *mpp_dev = NULL;
>> +
>> +	mpp_dev = task->session->mpp_dev;
>> +
>> +	mpp_debug_time_diff(task);
>> +
>> +	if (mpp_dev->ops->finish)
>> +		mpp_dev->ops->finish(mpp_dev, task);
>> +
>> +	atomic_dec(&task->session->task_running);
>> +	pm_runtime_mark_last_busy(mpp_dev->dev);
>> +	pm_runtime_put_autosuspend(mpp_dev->dev);
>> +	/*
>> +	 * TODO: unlock the reader locker of the device resource locker
>> +	 * here
>> +	 */
>> +	mpp_srv_done(mpp_dev->srv, task);
>> +	/* Wake up the GET thread */
>> +	mpp_session_push_done(task);
>> +}
>> +
>> +static void *mpp_dev_alloc_task(struct rockchip_mpp_dev *mpp_dev,
>> +				struct mpp_session *session, void __user *src,
>> +				u32 size)
>> +{
>> +	if (mpp_dev->ops->alloc_task)
>> +		return mpp_dev->ops->alloc_task(session, src, size);
>> +	return NULL;
>> +}
>> +
>> +static int mpp_dev_free_task(struct mpp_session *session, struct mpp_task *task)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = session->mpp_dev;
>> +
>> +	if (mpp_dev->ops->free_task)
>> +		mpp_dev->ops->free_task(session, task);
>> +	return 0;
>> +}
>> +
>> +int mpp_dev_task_init(struct mpp_session *session, struct mpp_task *task)
>> +{
>> +	INIT_LIST_HEAD(&task->session_link);
>> +	INIT_LIST_HEAD(&task->service_link);
>> +	INIT_WORK(&task->work, mpp_dev_sched_irq);
>> +
>> +	task->session = session;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_task_init);
>> +
>> +void mpp_dev_task_finish(struct mpp_session *session, struct mpp_task *task)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = NULL;
>> +
>> +	mpp_dev = session->mpp_dev;
>> +	queue_work(mpp_dev->irq_workq, &task->work);
>> +}
>> +EXPORT_SYMBOL(mpp_dev_task_finish);
>> +
>> +void mpp_dev_task_finalize(struct mpp_session *session, struct mpp_task *task)
>> +{
>> +#if 0
>> +	struct vb2_v4l2_buffer *src, *dst;
>> +
>> +	src = v4l2_m2m_src_buf_remove(session->fh.m2m_ctx);
>> +	dst = v4l2_m2m_dst_buf_remove(session->fh.m2m_ctx);
>> +	if (WARN_ON(!src))
>> +		return -EINVAL;
>> +
>> +	if (WARN_ON(!dst))
>> +		return -EINVAL;
>> +
>> +	src->sequence = session->sequence_out++;
>> +	dst->sequence = session->sequence_cap++;
>> +
>> +	v4l2_m2m_buf_copy_data(src, dst, true);
>> +
>> +	v4l2_m2m_buf_done(src, result);
>> +	v4l2_m2m_buf_done(dst, result);
>> +#endif
>> +}
>> +EXPORT_SYMBOL(mpp_dev_task_finalize);
>> +
>> +static void mpp_dev_session_clear(struct rockchip_mpp_dev *mpp,
>> +				  struct mpp_session *session)
>> +{
>> +	struct mpp_task *task, *n;
>> +
>> +	list_for_each_entry_safe(task, n, &session->pending, session_link) {
>> +		list_del(&task->session_link);
>> +		mpp_dev_free_task(session, task);
>> +	}
>> +	while (kfifo_out(&session->done_fifo, &task, 1))
>> +		mpp_dev_free_task(session, task);
>> +}
>> +
>> +#if 0
>> +void *mpp_dev_alloc_session(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	struct mpp_session *session = NULL;
>> +	int error = 0;
>> +
>> +	session = kzalloc(sizeof(*session), GFP_KERNEL);
>> +	if (!session)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	session->pid = current->pid;
>> +	session->mpp_dev = mpp_dev;
>> +	mutex_init(&session->lock);
>> +	INIT_LIST_HEAD(&session->pending);
>> +	init_waitqueue_head(&session->wait);
>> +	error = kfifo_alloc(&session->done_fifo, MPP_SESSION_MAX_DONE_TASK,
>> +			    GFP_KERNEL);
>> +	if (error < 0) {
>> +		kfree(session);
>> +		return ERR_PTR(error);
>> +	}
>> +
>> +	atomic_set(&session->task_running, 0);
>> +	INIT_LIST_HEAD(&session->list_session);
>> +	
>> +	return session;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_alloc_session);
>> +
>> +#endif
>> +
>> +static void mpp_dev_reset(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	mpp_debug_enter();
>> +
>> +	/* FIXME lock resource lock of the other devices in combo */
>> +	write_lock(&mpp_dev->resource_rwlock);
>> +	atomic_set(&mpp_dev->reset_request, 0);
>> +
>> +	iommu_detach_device(mpp_dev->domain, mpp_dev->dev);
>> +	mpp_dev->ops->reset(mpp_dev);
>> +	iommu_attach_device(mpp_dev->domain, mpp_dev->dev);
>> +
>> +	write_unlock(&mpp_dev->resource_rwlock);
>> +	mpp_debug_leave();
>> +}
>> +
>> +static void mpp_dev_abort(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	int ret = 0;
>> +
>> +	mpp_debug_enter();
>> +
>> +	/* destroy the current task after hardware reset */
>> +	ret = mpp_srv_is_running(mpp_dev->srv);
>> +
>> +	mpp_dev_reset(mpp_dev);
>> +
>> +	if (ret) {
>> +		struct mpp_task *task = NULL;
>> +
>> +		task = mpp_srv_get_cur_task(mpp_dev->srv);
>> +		cancel_work_sync(&task->work);
>> +		list_del(&task->session_link);
>> +		mpp_srv_abort(mpp_dev->srv, task);
>> +		mpp_dev_free_task(task->session, task);
>> +		atomic_dec(&task->session->task_running);
>> +	} else {
>> +		mpp_srv_abort(mpp_dev->srv, NULL);
>> +	}
>> +
>> +	mpp_debug_leave();
>> +}
>> +
>> +void mpp_dev_power_on(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	pm_runtime_get_sync(mpp_dev->dev);
>> +	pm_stay_awake(mpp_dev->dev);
>> +}
>> +
>> +void mpp_dev_power_off(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	pm_runtime_put_sync(mpp_dev->dev);
>> +	pm_relax(mpp_dev->dev);
>> +}
>> +
>> +static void rockchip_mpp_run(struct rockchip_mpp_dev *mpp_dev,
>> +			     struct mpp_task *task)
>> +{
>> +	mpp_debug_enter();
>> +	/*
>> +	 * As I got the global lock from the mpp service here,
>> +	 * I am the very task to be run, the device is ready
>> +	 * for me. Wait a gap in the other is operating with the IOMMU.
>> +	 */
>> +	if (atomic_read(&mpp_dev->reset_request))
>> +		mpp_dev_reset(mpp_dev);
>> +
>> +	mpp_debug_time_record(task);
>> +
>> +	mpp_debug(DEBUG_TASK_INFO, "pid %d, start hw %s\n",
>> +		  task->session->pid, dev_name(mpp_dev->dev));
>> +
>> +	if (unlikely(debug & DEBUG_REGISTER))
>> +		mpp_debug_dump_reg(mpp_dev->reg_base,
>> +				   mpp_dev->variant->reg_len);
>> +
>> +	/*
>> +	 * TODO: Lock the reader locker of the device resource lock here,
>> +	 * release at the finish operation
>> +	 */
>> +	if (mpp_dev->ops->run)
>> +		mpp_dev->ops->run(mpp_dev, task);
>> +
>> +	mpp_debug_leave();
>> +}
>> +
>> +static void rockchip_mpp_try_run(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	int ret = 0;
>> +	struct mpp_task *task;
>> +
>> +	mpp_debug_enter();
>> +
>> +	task = mpp_srv_get_pending_task(mpp_dev->srv);
>> +
>> +	if (mpp_dev->ops->prepare)
>> +		ret = mpp_dev->ops->prepare(mpp_dev, task);
>> +
>> +	mpp_srv_wait_to_run(mpp_dev->srv, task);
>> +	/*
>> +	 * FIXME if the hardware supports task query, but we still need to lock
>> +	 * the running list and lock the mpp service in the current state.
>> +	 */
>> +	/* Push a pending task to running queue */
>> +	rockchip_mpp_run(mpp_dev, task);
>> +
>> +	mpp_debug_leave();
>> +}
>> +
>> +static int rockchip_mpp_result(struct rockchip_mpp_dev *mpp_dev,
>> +			       struct mpp_task *task)
>> +{
>> +	struct mpp_session *session = NULL;
>> +	struct vb2_v4l2_buffer *src, *dst;
>> +	enum vb2_buffer_state result = VB2_BUF_STATE_DONE;
>> +
>> +	mpp_debug_enter();
>> +
>> +	if (!mpp_dev || !task)
>> +		return -EINVAL;
>> +
>> +	session = task->session;
>> +
>> +	if (mpp_dev->ops->result)
>> +		result = mpp_dev->ops->result(mpp_dev, task, NULL, 0);
>> +
>> +	mpp_dev_free_task(session, task);
>> +
>> +	src = v4l2_m2m_src_buf_remove(session->fh.m2m_ctx);
>> +	dst = v4l2_m2m_dst_buf_remove(session->fh.m2m_ctx);
>> +	if (WARN_ON(!src))
>> +		return -EINVAL;
>> +
>> +	if (WARN_ON(!dst))
>> +		return -EINVAL;
>> +
>> +	src->sequence = session->sequence_out++;
>> +	dst->sequence = session->sequence_cap++;
>> +
>> +	v4l2_m2m_buf_copy_metadata(src, dst, true);
>> +
>> +	v4l2_m2m_buf_done(src, result);
>> +	v4l2_m2m_buf_done(dst, result);
>> +
>> +	v4l2_m2m_job_finish(mpp_dev->m2m_dev, session->fh.m2m_ctx);
>> +
>> +	mpp_debug_leave();
>> +	return 0;
>> +}
>> +
>> +#if 0
>> +static int rockchip_mpp_wait_result(struct mpp_session *session,
>> +				    struct rockchip_mpp_dev *mpp,
>> +				    struct vpu_request req)
>> +{
>> +	struct mpp_task *task;
>> +	int ret;
>> +
>> +	ret = wait_event_timeout(session->wait,
>> +				 !kfifo_is_empty(&session->done_fifo),
>> +				 msecs_to_jiffies(MPP_TIMEOUT_DELAY));
>> +	if (ret == 0) {
>> +		mpp_err("error: pid %d wait %d task done timeout\n",
>> +			session->pid, atomic_read(&session->task_running));
>> +		ret = -ETIMEDOUT;
>> +
>> +		if (unlikely(debug & DEBUG_REGISTER))
>> +			mpp_debug_dump_reg(mpp->reg_base,
>> +					   mpp->variant->reg_len);
>> +		mpp_dev_abort(mpp);
>> +
>> +		return ret;
>> +	}
>> +
>> +	task = mpp_session_pull_done(session);
>> +	rockchip_mpp_result(mpp, task, req.req, req.size);
>> +
>> +	return 0;
>> +}
>> +
>> +long mpp_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>> +	struct mpp_session *session = (struct mpp_session *)filp->private_data;
>> +	struct rockchip_mpp_dev *mpp = NULL;
>> +
>> +	mpp_debug_enter();
>> +	if (!session)
>> +		return -EINVAL;
>> +
>> +	mpp = session->mpp_dev;
>> +
>> +	switch (cmd) {
>> +	case VPU_IOC_SET_CLIENT_TYPE:
>> +		break;
>> +	case VPU_IOC_SET_REG: {
>> +		struct vpu_request req;
>> +		struct mpp_task *task;
>> +
>> +		mpp_debug(DEBUG_IOCTL, "pid %d set reg\n",
>> +			  session->pid);
>> +		if (copy_from_user(&req, (void __user *)arg,
>> +				   sizeof(struct vpu_request))) {
>> +			mpp_err("error: set reg copy_from_user failed\n");
>> +			return -EFAULT;
>> +		}
>> +
>> +		task = mpp_dev_alloc_task(mpp, session, (void __user *)req.req,
>> +					  req.size);
>> +		if (IS_ERR_OR_NULL(task))
>> +			return -EFAULT;
>> +		mpp_srv_push_pending(mpp->srv, task);
>> +		mpp_session_push_pending(session, task);
>> +		atomic_inc(&session->task_running);
>> +
>> +		/* TODO: processing the current task */
>> +		rockchip_mpp_try_run(mpp);
>> +	} break;
>> +	case VPU_IOC_GET_REG: {
>> +		struct vpu_request req;
>> +
>> +		mpp_debug(DEBUG_IOCTL, "pid %d get reg\n",
>> +			  session->pid);
>> +		if (copy_from_user(&req, (void __user *)arg,
>> +				   sizeof(struct vpu_request))) {
>> +			mpp_err("error: get reg copy_from_user failed\n");
>> +			return -EFAULT;
>> +		}
>> +
>> +		return rockchip_mpp_wait_result(session, mpp, req);
>> +	} break;
>> +	case VPU_IOC_PROBE_IOMMU_STATUS: {
>> +		int iommu_enable = 1;
>> +
>> +		mpp_debug(DEBUG_IOCTL, "VPU_IOC_PROBE_IOMMU_STATUS\n");
>> +
>> +		if (put_user(iommu_enable, ((u32 __user *)arg))) {
>> +			mpp_err("error: iommu status copy_to_user failed\n");
>> +			return -EFAULT;
>> +		}
>> +		break;
>> +	}
>> +	default: {
>> +		dev_err(mpp->dev, "unknown mpp ioctl cmd %x\n", cmd);
>> +		return -ENOIOCTLCMD;
>> +	} break;
>> +	}
>> +
>> +	mpp_debug_leave();
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_ioctl);
>> +
>> +static unsigned int mpp_dev_poll(struct file *filp, poll_table *wait)
>> +{
>> +	struct mpp_session *session = (struct mpp_session *)filp->private_data;
>> +	unsigned int mask = 0;
>> +
>> +	poll_wait(filp, &session->wait, wait);
>> +	if (kfifo_len(&session->done_fifo))
>> +		mask |= POLLIN | POLLRDNORM;
>> +
>> +	return mask;
>> +}
>> +
>> +static int mpp_dev_open(struct file *filp)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(flip);
>> +	struct video_device *vdev = video_devdata(filp);
>> +	struct mpp_session *session = NULL;
>> +	int error = 0;
>> +
>> +	mpp_debug_enter();
>> +
>> +	session = kzalloc(sizeof(*session), GFP_KERNEL);
>> +	if (!session)
>> +		return -ENOMEM;
>> +
>> +	session->pid = current->pid;
>> +	session->mpp_dev = mpp_dev;
>> +	mutex_init(&session->lock);
>> +	INIT_LIST_HEAD(&session->pending);
>> +	init_waitqueue_head(&session->wait);
>> +	error = kfifo_alloc(&session->done_fifo, MPP_SESSION_MAX_DONE_TASK,
>> +			    GFP_KERNEL);
>> +	if (error < 0)
>> +		goto fail;
>> +
>> +	atomic_set(&session->task_running, 0);
>> +	INIT_LIST_HEAD(&session->list_session);
>> +#if 0
>> +	session->fh.m2m_ctx = v4l2_m2m_ctx_init(mpp_dev->m2m_dev, session,
>> +						default_queue_init);
>> +	if (IS_ERR(session->fh.m2m_ctx)) {
>> +		error = PTR_ERR(session->fb.m2m_ctx);
>> +		goto fail;
>> +	}
>> +	v4l2_fh_init(&session->fh, vdev);
>> +	filp->private_data = &session->fh;
>> +	v4l2_fh_add(&session->fh);
>> +
>> +	/* TODO: setup default formats */
>> +
>> +	/* TODO: install v4l2 ctrl */
>> +	if (error) {
>> +		dev_err(mpp_dev->dev, "Failed to set up controls\n");
>> +		goto err_fh;
>> +	}
>> +
>> +	session->fb.ctrl_handler = mpp_dev->ctrl_handler;
>> +#endif
>> +
>> +	mpp_dev_power_on(mpp);
>> +	mpp_debug_leave();
>> +
>> +	return 0;
>> +
>> +err_fh:
>> +	v4l2_fh_del(&session->fh);
>> +	v4l2_fh_exit(&session->fh);
>> +fail:
>> +	kfree(session);
>> +	return error;
>> +}
>> +
>> +static int mpp_dev_release(struct file *filp)
>> +{
>> +	struct mpp_session *session = container_of(filp->private_data,
>> +						   struct mpp_session, fh);
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(flip);
>> +	int task_running;
>> +
>> +	mpp_debug_enter();
>> +	if (!session)
>> +		return -EINVAL;
>> +
>> +	/* TODO: is it necessary for v4l2? */
>> +	task_running = atomic_read(&session->task_running);
>> +	if (task_running) {
>> +		pr_err("session %d still has %d task running when closing\n",
>> +		       session->pid, task_running);
>> +		msleep(50);
>> +	}
>> +	wake_up(&session->wait);
>> +
>> +#if 0
>> +	v4l2_m2m_ctx_release(session->fh.m2m_ctx);
>> +	v4l2_fh_del(&seesion->>fh);
>> +	v4l2_fh_exit(&session->fh);
>> +	v4l2_ctrl_handler_free(&session->ctrl_handler);
>> +#endif
>> +	mpp_dev_session_clear(mpp, session);
>> +
>> +#if 0
>> +	read_lock(&mpp->resource_rwlock);
>> +	read_unlock(&mpp->resource_rwlock);
>> +#endif
>> +	kfifo_free(&session->done_fifo);
>> +	filp->private_data = NULL;
>> +
>> +	mpp_dev_power_off(mpp);
>> +	kfree(session);
>> +
>> +	dev_dbg(mpp->dev, "closed\n");
>> +	mpp_debug_leave();
>> +	return 0;
>> +}
>> +
>> +static const struct v4l2_file_operations mpp_v4l2_default_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = mpp_dev_open,
>> +	.release = mpp_dev_release,
>> +	.poll = v4l2_m2m_fop_poll,
>> +	.unlocked_ioctl = video_ioctl2,
>> +	.mmap = v4l2_m2m_fop_mmap,
>> +};
>> +#endif
>> +
>> +static int rockchip_mpp_dev_open(struct file *filp)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(filp);
>> +	struct video_device *vdev = video_devdata(filp);
>> +	struct mpp_session *session = NULL;
>> +
>> +	mpp_debug_enter();
>> +
>> +	session = rockchip_mpp_alloc_session(mpp_dev, vdev);
>> +	if (IS_ERR_OR_NULL(session))
>> +		return PTR_ERR(session);
>> +
>> +	filp->private_data = &session->fh;
>> +	pm_runtime_get_sync(mpp_dev->dev);
>> +
>> +	mpp_debug_leave();
>> +	return 0;
>> +}
>> +
>> +static struct mpp_service_node *mpp_dev_load_srv(struct platform_device *p)
>> +{
>> +	struct mpp_service *srv = NULL;
>> +	struct device_node *np = NULL;
>> +	struct platform_device *pdev = NULL;
>> +	struct mpp_service_node *client = NULL;
>> +
>> +	np = of_parse_phandle(p->dev.of_node, "rockchip,srv", 0);
>> +	if (!np || !of_device_is_available(np)) {
>> +		dev_err(&p->dev,
>> +			"failed to get the mpp service node\n");
>> +		return NULL;
>> +	}
>> +
>> +	pdev = of_find_device_by_node(np);
>> +	if (!pdev) {
>> +		of_node_put(np);
>> +		dev_err(&p->dev,
>> +			"failed to get mpp service from node\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	device_lock(&pdev->dev);
>> +
>> +	srv = platform_get_drvdata(pdev);
>> +	if (srv) {
>> +		client = mpp_srv_attach(srv, NULL);
>> +	} else {
>> +		dev_info(&pdev->dev, "defer probe\n");
>> +		client = ERR_PTR(-EPROBE_DEFER);
>> +	}
>> +	device_unlock(&pdev->dev);
>> +
>> +	put_device(&pdev->dev);
>> +	of_node_put(np);
>> +
>> +	return client;
>> +}
>> +
>> +static void mpp_device_run(void *priv)
>> +{
>> +	struct mpp_session *session = (struct mpp_session *)priv;
>> +	struct rockchip_mpp_dev *mpp_dev = NULL;
>> +	struct mpp_task *task;
>> +
>> +	mpp_debug_enter();
>> +	if (!session)
>> +		return;
>> +
>> +	mpp_dev = session->mpp_dev;
>> +
>> +	mpp_debug(DEBUG_IOCTL, "pid %d set reg\n", session->pid);
>> +	/* power on here */
>> +	if (pm_runtime_get_if_in_use(mpp_dev->dev) <= 0) {
>> +		/* TODO: destroy the session and report more error */
>> +		dev_err(mpp_dev->dev, "can't power on device\n");
>> +		return;
>> +	}
>> +
>> +	task = mpp_dev_alloc_task(mpp_dev, session, NULL, 0);
>> +	if (IS_ERR_OR_NULL(task))
>> +		return;
>> +
>> +	mpp_srv_push_pending(mpp_dev->srv, task);
>> +	mpp_session_push_pending(session, task);
>> +	atomic_inc(&session->task_running);
>> +
>> +	/* TODO: processing the current task */
>> +	rockchip_mpp_try_run(mpp_dev);
>> +
>> +	mpp_debug_leave();
>> +}
>> +
>> +#if 0
>> +void mpp_job_abort(void *priv)
>> +{
>> +	struct mpp_session *session = (struct mpp_session *)priv;
>> +
>> +	/* TODO: invoke v4l2_m2m_job_finish */
>> +	mpp_dev_abort(session->mpp_dev);
>> +}
>> +#endif
>> +
>> +static const struct v4l2_m2m_ops mpp_m2m_ops = {
>> +	.device_run = mpp_device_run,
>> +#if 0
>> +	.job_abort = mpp_job_abort,
>> +#endif
>> +};
>> +
>> +/* The device will do more probing work after this */
>> +int mpp_dev_common_probe(struct rockchip_mpp_dev *mpp_dev,
>> +			 struct platform_device *pdev, struct mpp_dev_ops *ops)
>> +{
>> +	struct device *dev = NULL;
>> +	struct resource *res = NULL;
>> +	int err;
>> +
>> +	/* Get and register to MPP service */
>> +	mpp_dev->srv = mpp_dev_load_srv(pdev);
>> +	if (IS_ERR_OR_NULL(mpp_dev->srv))
>> +		return PTR_ERR(mpp_dev->srv);
>> +
>> +	dev = &pdev->dev;
>> +	mpp_dev->dev = dev;
>> +	mpp_dev->ops = ops;
>> +
>> +	rwlock_init(&mpp_dev->resource_rwlock);
>> +
>> +	device_init_wakeup(mpp_dev->dev, true);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_idle(dev);
>> +
>> +	mpp_dev->irq_workq = alloc_ordered_workqueue("%s_irq_wq",
>> +						     WQ_MEM_RECLAIM
>> +						     | WQ_FREEZABLE,
>> +						     dev_name(mpp_dev->dev));
>> +	if (!mpp_dev->irq_workq) {
>> +		dev_err(dev, "failed to create irq workqueue\n");
>> +		err = -EINVAL;
>> +		goto failed_irq_workq;
>> +	}
>> +
>> +	mpp_dev->irq = platform_get_irq(pdev, 0);
>> +	if (mpp_dev->irq < 0) {
>> +		dev_err(dev, "No interrupt resource found\n");
>> +		err = -ENODEV;
>> +		goto failed;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "no memory resource defined\n");
>> +		err = -ENODEV;
>> +		goto failed;
>> +	}
>> +	mpp_dev->reg_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(mpp_dev->reg_base)) {
>> +		err = PTR_ERR(mpp_dev->reg_base);
>> +		goto failed;
>> +	}
>> +
>> +	/* V4l2 part */
>> +	mutex_init(&mpp_dev->dev_lock);
>> +
>> +	err = v4l2_device_register(dev, &mpp_dev->v4l2_dev);
>> +	if (err) {
>> +		dev_err(dev, "Failed to register v4l2 device\n");
>> +		goto failed;
>> +	}
>> +
>> +	/* TODO */
>> +	mpp_dev->m2m_dev = v4l2_m2m_init(&mpp_m2m_ops);
>> +	if (IS_ERR(mpp_dev->m2m_dev)) {
>> +		v4l2_err(&mpp_dev->v4l2_dev, "Failed to init mem2mem device\n");
>> +		err = PTR_ERR(mpp_dev->m2m_dev);
>> +		goto err_v4l2_unreg;
>> +	}
>> +
>> +	mpp_dev->mdev.dev = dev;
>> +	strlcpy(mpp_dev->mdev.model, MPP_MODULE_NAME,
>> +		sizeof(mpp_dev->mdev.model));
>> +	media_device_init(&mpp_dev->mdev);
>> +	mpp_dev->mdev.ops = &mpp_m2m_media_ops;
>> +	mpp_dev->v4l2_dev.mdev = &mpp_dev->mdev;
>> +
>> +	mpp_dev->domain = iommu_get_domain_for_dev(dev);
>> +
>> +	return 0;
>> +
>> +err_v4l2_unreg:
>> +	v4l2_device_unregister(&mpp_dev->v4l2_dev);
>> +failed_irq_workq:
>> +	destroy_workqueue(mpp_dev->irq_workq);
>> +failed:
>> +	pm_runtime_disable(dev);
>> +	return err;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_common_probe);
>> +
>> +/* Remember to set the platform data after this */
>> +int mpp_dev_register_node(struct rockchip_mpp_dev *mpp_dev,
>> +			  const char *node_name, const void *v4l2_fops,
>> +			  const void *v4l2_ioctl_ops)
>> +{
>> +	struct video_device *vfd;
>> +	int ret = 0;
>> +
>> +	/* create a device node */
>> +	vfd = video_device_alloc();
>> +	if (!vfd) {
>> +		v4l2_err(&mpp_dev->v4l2_dev,
>> +			 "Failed to allocate video device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (v4l2_fops)
>> +		vfd->fops = v4l2_fops;
>> +	else
>> +		vfd->fops = &mpp_v4l2_default_fops;
>> +
>> +	vfd->release = video_device_release;
>> +	vfd->lock = &mpp_dev->dev_lock;
>> +	vfd->v4l2_dev = &mpp_dev->v4l2_dev;
>> +	vfd->vfl_dir = VFL_DIR_M2M;
>> +	vfd->device_caps = V4L2_CAP_STREAMING;
>> +	vfd->ioctl_ops = v4l2_ioctl_ops;
>> +
>> +	strlcpy(vfd->name, node_name, sizeof(vfd->name));
>> +	video_set_drvdata(vfd, mpp_dev);
>> +
>> +	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
>> +	if (ret) {
>> +		v4l2_err(&mpp_dev->v4l2_dev,
>> +			 "Failed to register video device\n");
>> +		goto err_m2m_rel;
>> +	}
>> +	v4l2_info(&mpp_dev->v4l2_dev, "registered as /dev/video%d\n", vfd->num);
>> +
>> +	ret = v4l2_m2m_register_media_controller(mpp_dev->m2m_dev, vfd,
>> +						 mpp_dev->variant->vfd_func);
>> +	if (ret) {
>> +		v4l2_err(&mpp_dev->v4l2_dev,
>> +			 "Failed to init mem2mem media controller\n");
>> +		goto err_unreg_video;
>> +	}
>> +
>> +	mpp_dev->vfd = vfd;
>> +
>> +	ret = media_device_register(&mpp_dev->mdev);
>> +	if (ret) {
>> +		v4l2_err(&mpp_dev->v4l2_dev,
>> +			 "Failed to register mem2mem media device\n");
>> +		goto err_unreg_video_dev;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_unreg_video:
>> +	video_unregister_device(mpp_dev->vfd);
>> +err_unreg_video_dev:
>> +	video_device_release(mpp_dev->vfd);
>> +err_m2m_rel:
>> +	v4l2_m2m_release(mpp_dev->m2m_dev);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_register_node);
>> +
>> +int mpp_dev_common_remove(struct rockchip_mpp_dev *mpp_dev)
>> +{
>> +	destroy_workqueue(mpp_dev->irq_workq);
>> +
>> +	media_device_unregister(&mpp_dev->mdev);
>> +	v4l2_m2m_unregister_media_controller(mpp_dev->m2m_dev);
>> +	media_device_cleanup(&mpp_dev->mdev);
>> +
>> +	video_unregister_device(mpp_dev->vfd);
>> +	video_device_release(mpp_dev->vfd);
>> +
>> +	mpp_srv_detach(mpp_dev->srv);
>> +
>> +	mpp_dev_power_off(mpp_dev);
>> +
>> +	device_init_wakeup(mpp_dev->dev, false);
>> +	pm_runtime_disable(mpp_dev->dev);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_common_remove);
>> +
>> +void mpp_debug_dump_reg(void __iomem *regs, int count)
>> +{
>> +	int i;
>> +
>> +	pr_info("dumping registers: %p\n", regs);
>> +
>> +	for (i = 0; i < count; i++)
>> +		pr_info("reg[%02d]: %08x\n", i, readl_relaxed(regs + i * 4));
>> +}
>> +EXPORT_SYMBOL(mpp_debug_dump_reg);
>> +
>> +void mpp_debug_dump_reg_mem(u32 *regs, int count)
>> +{
>> +	int i;
>> +
>> +	pr_info("Dumping registers: %p\n", regs);
>> +
>> +	for (i = 0; i < count; i++)
>> +		pr_info("reg[%03d]: %08x\n", i, regs[i]);
>> +}
>> +EXPORT_SYMBOL(mpp_debug_dump_reg_mem);
>> +
>> +void mpp_dev_write_seq(struct rockchip_mpp_dev *mpp_dev, unsigned long offset,
>> +		       void *buffer, unsigned long count)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		u32 *cur = (u32 *)buffer;
>> +		u32 pos = offset + i * 4;
>> +		u32 j = i + (u32)(offset / 4);
>> +
>> +		cur += i;
>> +		mpp_debug(DEBUG_SET_REG, "write reg[%03d]: %08x\n", j, *cur);
>> +		iowrite32(*cur, mpp_dev->reg_base + pos);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mpp_dev_write_seq);
>> +
>> +void mpp_dev_write(struct rockchip_mpp_dev *mpp, u32 reg, u32 val)
>> +{
>> +	mpp_debug(DEBUG_SET_REG, "write reg[%03d]: %08x\n", reg / 4, val);
>> +	iowrite32(val, mpp->reg_base + reg);
>> +}
>> +EXPORT_SYMBOL(mpp_dev_write);
>> +
>> +void mpp_dev_read_seq(struct rockchip_mpp_dev *mpp_dev,
>> +		      unsigned long offset, void *buffer,
>> +		      unsigned long count)
>> +{
>> +	int i = 0;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		u32 *cur = (u32 *)buffer;
>> +		u32 pos = offset / 4 + i;
>> +
>> +		cur += i;
>> +		*cur = ioread32(mpp_dev->reg_base + pos * 4);
>> +		mpp_debug(DEBUG_GET_REG, "get reg[%03d]: %08x\n", pos, *cur);
>> +	}
>> +}
>> +EXPORT_SYMBOL(mpp_dev_read_seq);
>> +
>> +u32 mpp_dev_read(struct rockchip_mpp_dev *mpp, u32 reg)
>> +{
>> +	u32 val = ioread32(mpp->reg_base + reg);
>> +
>> +	mpp_debug(DEBUG_GET_REG, "get reg[%03d] 0x%x: %08x\n", reg / 4,
>> +		  reg, val);
>> +	return val;
>> +}
>> +EXPORT_SYMBOL(mpp_dev_read);
>> +
>> +void mpp_debug_time_record(struct mpp_task *task)
>> +{
>> +	if (unlikely(debug & DEBUG_TIMING) && task)
>> +		getboottime64(&task->start);
>> +}
>> +EXPORT_SYMBOL(mpp_debug_time_record);
>> +
>> +void mpp_debug_time_diff(struct mpp_task *task)
>> +{
>> +	struct timespec64 end;
>> +
>> +	getboottime64(&end);
>> +	mpp_debug(DEBUG_TIMING, "time: %lld ms\n",
>> +		  (end.tv_sec  - task->start.tv_sec)  * 1000 +
>> +		  (end.tv_nsec - task->start.tv_nsec) / 1000000);
>> +}
>> +EXPORT_SYMBOL(mpp_debug_time_diff);
>> +
>> +static int mpp_m2m_querycap(struct file *filp, void *fh,
>> +			    struct v4l2_capability *cap)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(filp);
>> +
>> +	strscpy(cap->driver, MPP_MODULE_NAME, sizeof(cap->driver));
>> +	strscpy(cap->card, MPP_MODULE_NAME, sizeof(cap->card));
>> +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
>> +		 dev_name(mpp_dev->dev));
>> +
>> +	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
>> +	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mpp_g_fmt_mplane(struct file *filp, void *fh, struct v4l2_format *f)
>> +{
>> +	struct mpp_session *session = container_of(filp->private_data,
>> +						   struct mpp_session, fh);
>> +
>> +	struct v4l2_pix_format_mplane *pix_mp = &f->fmt.pix_mp;
>> +	struct v4l2_pix_format_mplane *fmt = NULL;
>> +
>> +	if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
>> +		fmt = &session->fmt_cap;
>> +	else if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>> +		fmt = &session->fmt_out;
>> +
>> +	*pix_mp = *fmt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mpp_enum_fmt_mplane(struct file *filp, void *priv,
>> +			       struct v4l2_fmtdesc *f)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(filp);
>> +	const struct v4l2_pix_format_mplane *formats;
>> +	unsigned int num_fmts;
>> +
>> +	switch (f->type) {
>> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +		num_fmts = ARRAY_SIZE(mpp_dev->fmt_out);
>> +		formats = mpp_dev->fmt_out;
>> +		break;
>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +		num_fmts = ARRAY_SIZE(mpp_dev->fmt_cap);
>> +		formats = mpp_dev->fmt_cap;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (f->index >= num_fmts)
>> +		return -EINVAL;
>> +
>> +	if (formats[f->index].pixelformat == 0)
>> +		return -EINVAL;
>> +
>> +	f->pixelformat = formats[f->index].pixelformat;
>> +
>> +	return 0;
>> +}
>> +
>> +static int mpp_try_fmt_mplane(struct file *filp, void *priv,
>> +			      struct v4l2_format *f)
>> +{
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(filp);
>> +	const struct v4l2_pix_format_mplane *formats;
>> +	unsigned int num_fmts;
>> +	int i;
>> +
>> +	switch (f->type) {
>> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +		num_fmts = ARRAY_SIZE(mpp_dev->fmt_out);
>> +		formats = mpp_dev->fmt_out;
>> +		break;
>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +		num_fmts = ARRAY_SIZE(mpp_dev->fmt_cap);
>> +		formats = mpp_dev->fmt_cap;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i = 0; i < num_fmts; i++) {
>> +		if (f->fmt.pix_mp.pixelformat == formats[i].pixelformat)
>> +			return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +const struct v4l2_ioctl_ops mpp_ioctl_ops_templ = {
>> +	.vidioc_querycap = mpp_m2m_querycap,
>> +#if 0
>> +	.vidioc_try_fmt_vid_cap = mpp_try_fmt_cap,
>> +	.vidioc_try_fmt_vid_out = mpp_try_fmt_out,
>> +	.vidioc_s_fmt_vid_out = mpp_s_fmt_out,
>> +	.vidioc_s_fmt_vid_cap = mpp_s_fmt_cap,
>> +#endif
>> +	.vidioc_try_fmt_vid_out_mplane = mpp_try_fmt_mplane,
>> +	.vidioc_try_fmt_vid_cap_mplane = mpp_try_fmt_mplane,
>> +	.vidioc_g_fmt_vid_out_mplane = mpp_g_fmt_mplane,
>> +	.vidioc_g_fmt_vid_cap_mplane = mpp_g_fmt_mplane,
>> +	.vidioc_enum_fmt_vid_out_mplane = mpp_enum_fmt_mplane,
>> +	.vidioc_enum_fmt_vid_cap_mplane = mpp_enum_fmt_mplane,
>> +
>> +	.vidioc_reqbufs = v4l2_m2m_ioctl_reqbufs,
>> +	.vidioc_querybuf = v4l2_m2m_ioctl_querybuf,
>> +	.vidioc_qbuf = v4l2_m2m_ioctl_qbuf,
>> +	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>> +	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>> +	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>> +	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>> +
>> +	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>> +	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
>> +
>> +	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
>> +	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
>> +};
>> +EXPORT_SYMBOL(mpp_ioctl_ops_templ);
>> +
>> +static int mpp_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
>> +			   unsigned int *num_planes, unsigned int sizes[],
>> +			   struct device *alloc_devs[])
>> +{
>> +	struct mpp_session *session = vb2_get_drv_priv(vq);
>> +	struct v4l2_pix_format_mplane *pixfmt;
>> +	int i;
>> +
>> +	switch (vq->type) {
>> +	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +		pixfmt = &session->fmt_out;
>> +		break;
>> +	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +		pixfmt = &session->fmt_cap;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (*num_planes) {
>> +		if (*num_planes != pixfmt->num_planes)
>> +			return -EINVAL;
>> +		for (i = 0; i < pixfmt->num_planes; ++i)
>> +			if (sizes[i] < pixfmt->plane_fmt[i].sizeimage)
>> +				return -EINVAL;
>> +
>> +		return 0;
>> +	}
>> +
>> +	*num_planes = pixfmt->num_planes;
>> +	for (i = 0; i < pixfmt->num_planes; i++)
>> +		sizes[i] = pixfmt->plane_fmt[i].sizeimage;
>> +
>> +	return 0;
>> +}
>> +
>> +/* I am sure what is used for */
>> +static int mpp_buf_out_validata(struct vb2_buffer *vb)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int mpp_start_streaming(struct vb2_queue *vq, unsigned int count)
>> +{
>> +	struct mpp_session *session = vb2_get_drv_priv(vq);
>> +
>> +	if (V4L2_TYPE_IS_OUTPUT(vq->type))
>> +		session->sequence_out = 0;
>> +	else
>> +		session->sequence_cap = 0;
>> +
>> +	return 0;
>> +}
>> +
>> +static void mpp_stop_streaming(struct vb2_queue *vq)
>> +{
>> +	struct mpp_session *session = vb2_get_drv_priv(vq);
>> +
>> +	for (;;) {
>> +		struct vb2_v4l2_buffer *vbuf;
>> +
>> +		if (V4L2_TYPE_IS_OUTPUT(vq->type))
>> +			vbuf = v4l2_m2m_src_buf_remove(session->fh.m2m_ctx);
>> +		else
>> +			vbuf = v4l2_m2m_dst_buf_remove(session->fh.m2m_ctx);
>> +
>> +		if (!vbuf)
>> +			break;
>> +
>> +		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
>> +					   &session->ctrl_handler);
>> +		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>> +	}
>> +}
>> +
>> +static void mpp_buf_queue(struct vb2_buffer *vb) {
>> +	struct mpp_session *session = vb2_get_drv_priv(vb->vb2_queue);
>> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +
>> +	/* TODO: may alloc registers table here */
>> +	v4l2_m2m_buf_queue(session->fh.m2m_ctx, vbuf);
>> +}
>> +
>> +static void mpp_buf_request_complete(struct vb2_buffer *vb) {
>> +	struct mpp_session *session = vb2_get_drv_priv(vb->vb2_queue);
>> +
>> +	v4l2_ctrl_request_complete(vb->req_obj.req, &session->ctrl_handler);
>> +}
>> +
>> +static const struct vb2_ops mpp_queue_ops = {
>> +	.queue_setup = mpp_queue_setup,
>> +	.wait_prepare = vb2_ops_wait_prepare,
>> +	.wait_finish = vb2_ops_wait_finish,
>> +	/*
>> +	 * TODO: may write back feedback to userspace .buf_finish for encoder,
>> +	 * not the slice header which the job of the userspace
>> +	 */
>> +	/* TODO: fill the INPUT buffer with device configure at .buf_prepare */
>> +	.buf_out_validate = mpp_buf_out_validata,
>> +	.start_streaming = mpp_start_streaming,
>> +	.stop_streaming = mpp_stop_streaming,
>> +	.buf_queue = mpp_buf_queue,
>> +	.buf_request_complete = mpp_buf_request_complete,
>> +};
>> +
>> +static int rockchip_mpp_queue_init(void *priv, struct vb2_queue *src_vq,
>> +				   struct vb2_queue *dst_vq)
>> +{
>> +	struct mpp_session *session = priv;
>> +	int ret;
>> +
>> +	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>> +	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
>> +	src_vq->drv_priv = session;
>> +	src_vq->mem_ops = &vb2_dma_contig_memops;
>> +	src_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES |
>> +			    DMA_ATTR_NO_KERNEL_MAPPING;
>> +	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
>> +	src_vq->min_buffers_needed = 1;
>> +	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>> +	src_vq->lock = &session->mpp_dev->dev_lock;
>> +	src_vq->ops = &mpp_queue_ops;
>> +	src_vq->dev = session->mpp_dev->v4l2_dev.dev;
>> +	src_vq->supports_requests = true;
>> +
>> +	ret = vb2_queue_init(src_vq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>> +	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
>> +	dst_vq->min_buffers_needed = 1;
>> +	dst_vq->drv_priv = session;
>> +	dst_vq->mem_ops = &vb2_dma_contig_memops;
>> +	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
>> +	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>> +	dst_vq->lock = &session->mpp_dev->dev_lock;
>> +	dst_vq->ops = &mpp_queue_ops;
>> +	dst_vq->dev = session->mpp_dev->v4l2_dev.dev;
>> +
>> +	ret = vb2_queue_init(dst_vq);
>> +
>> +	return ret;
>> +}
>> +
>> +void *rockchip_mpp_alloc_session(struct rockchip_mpp_dev *mpp_dev,
>> +				 struct video_device *vdev)
>> +{
>> +	struct mpp_session *session = NULL;
>> +	int error = 0;
>> +
>> +	mpp_debug_enter();
>> +
>> +	session = kzalloc(sizeof(*session), GFP_KERNEL);
>> +	if (!session)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	session->pid = current->pid;
>> +	session->mpp_dev = mpp_dev;
>> +	mutex_init(&session->lock);
>> +	INIT_LIST_HEAD(&session->pending);
>> +	init_waitqueue_head(&session->wait);
>> +	error = kfifo_alloc(&session->done_fifo, MPP_SESSION_MAX_DONE_TASK,
>> +			    GFP_KERNEL);
>> +	if (error < 0)
>> +		goto fail;
>> +
>> +	atomic_set(&session->task_running, 0);
>> +	INIT_LIST_HEAD(&session->list_session);
>> +
>> +	session->fh.m2m_ctx = v4l2_m2m_ctx_init(mpp_dev->m2m_dev, session,
>> +						rockchip_mpp_queue_init);
>> +	if (IS_ERR(session->fh.m2m_ctx)) {
>> +		error = PTR_ERR(session->fh.m2m_ctx);
>> +		goto fail;
>> +	}
>> +	v4l2_fh_init(&session->fh, vdev);
>> +	v4l2_fh_add(&session->fh);
>> +
>> +	mpp_debug_leave();
>> +
>> +	return session;
>> +
>> +fail:
>> +	kfree(session);
>> +	return ERR_PTR(error);
>> +}
>> +EXPORT_SYMBOL(rockchip_mpp_alloc_session);
>> +
>> +int rockchip_mpp_dev_release(struct file *filp)
>> +{
>> +	struct mpp_session *session = container_of(filp->private_data,
>> +						   struct mpp_session, fh);
>> +	struct rockchip_mpp_dev *mpp_dev = video_drvdata(filp);
>> +
>> +	mpp_debug_enter();
>> +	if (!session)
>> +		return -EINVAL;
>> +
>> +	/* TODO: is it necessary for v4l2? */
>> +#if 0
>> +	int task_running;
>> +	task_running = atomic_read(&session->task_running);
>> +	if (task_running) {
>> +		pr_err("session %d still has %d task running when closing\n",
>> +		       session->pid, task_running);
>> +		msleep(50);
>> +	}
>> +	wake_up(&session->wait);
>> +#endif
>> +
>> +	v4l2_m2m_ctx_release(session->fh.m2m_ctx);
>> +	v4l2_fh_del(&session->fh);
>> +	v4l2_fh_exit(&session->fh);
>> +	v4l2_ctrl_handler_free(&session->ctrl_handler);
>> +	mpp_dev_session_clear(mpp_dev, session);
>> +
>> +	kfifo_free(&session->done_fifo);
>> +	filp->private_data = NULL;
>> +
>> +	mpp_dev_power_off(mpp_dev);
>> +	kfree(session);
>> +
>> +	dev_dbg(mpp_dev->dev, "closed\n");
>> +	mpp_debug_leave();
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(rockchip_mpp_dev_release);
>> +
>> +void *rockchip_mpp_get_cur_ctrl(struct mpp_session *session, u32 id)
>> +{
>> +	struct v4l2_ctrl *ctrl;
>> +
>> +	ctrl = v4l2_ctrl_find(&session->ctrl_handler, id);
>> +	return ctrl ? ctrl->p_cur.p : NULL;
>> +}
>> +EXPORT_SYMBOL(rockchip_mpp_get_cur_ctrl);
>> +
>> +int rockchip_mpp_get_ref_idx(struct vb2_queue *queue,
>> +			     struct vb2_buffer *vb2_buf, u64 timestamp)
>> +{
>> +	/* FIXME: TODO: the timestamp is not copied yet before copy_data */
>> +	if (vb2_buf->timestamp == timestamp)
>> +		return vb2_buf->index;
>> +	else
>> +		return vb2_find_timestamp(queue, timestamp, 0);
>> +}
>> +EXPORT_SYMBOL(rockchip_mpp_get_ref_idx);
>> +
>> +dma_addr_t rockchip_mpp_find_addr(struct vb2_queue *queue,
>> +				  struct vb2_buffer *vb2_buf, u64 timestamp)
>> +{
>> +	int idx = -1;
>> +
>> +	idx = rockchip_mpp_get_ref_idx(queue, vb2_buf, timestamp);
>> +	if (idx < 0)
>> +		return 0;
>> +
>> +	return vb2_dma_contig_plane_dma_addr(queue->bufs[idx], 0);
>> +}
>> +EXPORT_SYMBOL(rockchip_mpp_find_addr);
>> +
>> +static const struct v4l2_file_operations mpp_v4l2_default_fops = {
>> +	.open = rockchip_mpp_dev_open,
>> +	.release = rockchip_mpp_dev_release,
>> +	.poll = v4l2_m2m_fop_poll,
>> +	.unlocked_ioctl = video_ioctl2,
>> +	.mmap = v4l2_m2m_fop_mmap,
>> +};
>> +
>> +static int __init mpp_device_init(void)
>> +{
>> +	mpp_device_class = class_create(THIS_MODULE, "mpp_device");
>> +	if (PTR_ERR_OR_ZERO(mpp_device_class))
>> +		return PTR_ERR(mpp_device_class);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit mpp_device_exit(void)
>> +{
>> +	class_destroy(mpp_device_class);
>> +}
>> +
>> +module_init(mpp_device_init);
>> +module_exit(mpp_device_exit);
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/rockchip-mpp/mpp_dev_common.h b/drivers/staging/rockchip-mpp/mpp_dev_common.h
>> new file mode 100644
>> index 000000000000..36770af53a95
>> --- /dev/null
>> +++ b/drivers/staging/rockchip-mpp/mpp_dev_common.h
>> @@ -0,0 +1,212 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2016 - 2017 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef _ROCKCHIP_MPP_DEV_COMMON_H_
>> +#define _ROCKCHIP_MPP_DEV_COMMON_H_
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/kfifo.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/reset.h>
>> +
>> +#include <linux/videodev2.h>
>> +#include <media/v4l2-ctrls.h>
>> +#include <media/v4l2-device.h>
>> +#include <media/v4l2-ioctl.h>
>> +#include <media/v4l2-subdev.h>
>> +#include <media/videobuf2-v4l2.h>
>> +
>> +#include "mpp_service.h"
>> +
>> +#define MPP_MODULE_NAME			"rk-mpp"
>> +
>> +extern const struct v4l2_ioctl_ops mpp_ioctl_ops_templ;
>> +
>> +struct mpp_dev_variant {
>> +	u32 reg_len;
>> +	const char *node_name;
>> +	u32 version_bit;
>> +	int vfd_func;
>> +};
>> +
>> +/* Definition in mpp service file */
>> +struct mpp_service;
>> +
>> +struct rockchip_mpp_dev {
>> +	struct device *dev;
>> +
>> +	const struct mpp_dev_variant *variant;
>> +	struct mpp_dev_ops *ops;
>> +	struct v4l2_pix_format_mplane fmt_out[16];
>> +	struct v4l2_pix_format_mplane fmt_cap[16];
>> +
>> +	void __iomem *reg_base;
>> +	int irq;
>> +	struct workqueue_struct *irq_workq;
>> +	struct iommu_domain *domain;
>> +
>> +	rwlock_t resource_rwlock;
>> +	atomic_t reset_request;
>> +
>> +	struct v4l2_device v4l2_dev;
>> +	struct v4l2_m2m_dev *m2m_dev;
>> +	struct media_device mdev;
>> +	struct video_device *vfd;
>> +	struct mutex dev_lock;
>> +
>> +	/* MPP Service */
>> +	struct mpp_service_node *srv;
>> +};
>> +
>> +struct mpp_task;
>> +
>> +struct mpp_session {
>> +	/* the session related device private data */
>> +	struct rockchip_mpp_dev *mpp_dev;
>> +	/* a linked list of data so we can access them for debugging */
>> +	struct list_head list_session;
>> +
>> +	/* session tasks list lock */
>> +	struct mutex lock;
>> +	struct list_head pending;
>> +
>> +	DECLARE_KFIFO_PTR(done_fifo, struct mpp_task *);
>> +
>> +	wait_queue_head_t wait;
>> +	pid_t pid;
>> +	atomic_t task_running;
>> +
>> +	struct v4l2_fh fh;
>> +	u32 sequence_cap;
>> +	u32 sequence_out;
>> +
>> +	struct v4l2_pix_format_mplane fmt_out;
>> +	struct v4l2_pix_format_mplane fmt_cap;
>> +	
>> +	struct v4l2_ctrl_handler ctrl_handler;
>> +	/* TODO: FIXME: slower than helper function ? */
>> +	struct v4l2_ctrl **ctrls;
>> +};
>> +
>> +/* The context for the a task */
>> +struct mpp_task {
>> +	/* context belong to */
>> +	struct mpp_session *session;
>> +
>> +	/* link to service session */
>> +	struct list_head session_link;
>> +	/* link to service list */
>> +	struct list_head service_link;
>> +	struct work_struct work;
>> +
>> +	/* record context running start time */
>> +	struct timespec64 start;
>> +};
>> +
>> +/*
>> + * struct mpp_dev_ops - context specific operations for a device
>> + * The task part
>> + * @alloc_task
>> + * @prepare	Check HW status for determining run next task or not.
>> + * @run		Start a single {en,de}coding run. Set registers to hardware.
>> + * @finish	Read back processing results and additional data from hardware.
>> + * @result	Read status to userspace.
>> + * @free_task	Release the resource allocate during init.
>> + * The device part
>> + * @reset
>> + */
>> +struct mpp_dev_ops {
>> +	/* size: in bytes, data sent from userspace, length in bytes */
>> +	void *(*alloc_task)(struct mpp_session *session,
>> +			    void __user *src, u32 size);
>> +	int (*prepare)(struct rockchip_mpp_dev *mpp_dev, struct mpp_task *task);
>> +	int (*run)(struct rockchip_mpp_dev *mpp_dev, struct mpp_task *task);
>> +	int (*finish)(struct rockchip_mpp_dev *mpp_dev, struct mpp_task *task);
>> +	int (*result)(struct rockchip_mpp_dev *mpp_dev, struct mpp_task *task,
>> +		      u32 __user *dst, u32 size);
>> +	int (*free_task)(struct mpp_session *session,
>> +			    struct mpp_task *task);
>> +	/* Hardware only operations */
>> +	int (*reset)(struct rockchip_mpp_dev *mpp_dev);
>> +};
>> +
>> +struct rockchip_mpp_control {
>> +	u32 codec;
>> +	u32 id;
>> +	u32 elem_size;
>> +};
>> +
>> +void *rockchip_mpp_alloc_session(struct rockchip_mpp_dev *mpp_dev,
>> +				 struct video_device *vdev);
>> +int rockchip_mpp_dev_release(struct file *filp);
>> +
>> +void *rockchip_mpp_get_cur_ctrl(struct mpp_session *session, u32 id);
>> +int rockchip_mpp_get_ref_idx(struct vb2_queue *queue,
>> +			     struct vb2_buffer *vb2_buf, u64 timestamp);
>> +dma_addr_t rockchip_mpp_find_addr(struct vb2_queue *queue,
>> +				  struct vb2_buffer *vb2_buf, u64 timestamp);
>> +
>> +int mpp_dev_task_init(struct mpp_session *session, struct mpp_task *task);
>> +void mpp_dev_task_finish(struct mpp_session *session, struct mpp_task *task);
>> +void mpp_dev_task_finalize(struct mpp_session *session, struct mpp_task *task);
>> +
>> +void mpp_dev_power_on(struct rockchip_mpp_dev *mpp);
>> +void mpp_dev_power_off(struct rockchip_mpp_dev *mpp);
>> +bool mpp_dev_is_power_on(struct rockchip_mpp_dev *mpp);
>> +
>> +void mpp_dump_reg(void __iomem *regs, int count);
>> +void mpp_dump_reg_mem(u32 *regs, int count);
>> +
>> +int mpp_dev_common_probe(struct rockchip_mpp_dev *mpp_dev,
>> +			 struct platform_device *pdev,
>> +			 struct mpp_dev_ops *ops);
>> +int mpp_dev_register_node(struct rockchip_mpp_dev *mpp_dev,
>> +			  const char *node_name, const void *v4l2_fops,
>> +			  const void *v4l2_ioctl_ops);
>> +int mpp_dev_common_remove(struct rockchip_mpp_dev *mpp_dev);
>> +
>> +static inline void safe_reset(struct reset_control *rst)
>> +{
>> +	if (rst)
>> +		reset_control_assert(rst);
>> +}
>> +
>> +static inline void safe_unreset(struct reset_control *rst)
>> +{
>> +	if (rst)
>> +		reset_control_deassert(rst);
>> +}
>> +
>> +void mpp_dev_write_seq(struct rockchip_mpp_dev *mpp_dev,
>> +		       unsigned long offset, void *buffer,
>> +		       unsigned long count);
>> +
>> +void mpp_dev_write(struct rockchip_mpp_dev *mpp, u32 val, u32 reg);
>> +
>> +void mpp_dev_read_seq(struct rockchip_mpp_dev *mpp_dev,
>> +		      unsigned long offset, void *buffer,
>> +		      unsigned long count);
>> +
>> +u32 mpp_dev_read(struct rockchip_mpp_dev *mpp, u32 reg);
>> +
>> +void mpp_debug_time_record(struct mpp_task *task);
>> +void mpp_debug_time_diff(struct mpp_task *task);
>> +
>> +void mpp_debug_dump_reg(void __iomem *regs, int count);
>> +void mpp_debug_dump_reg_mem(u32 *regs, int count);
>> +
>> +#endif
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_pps),
>> +	 },
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC_SLICE,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS,
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_slice_params),
>> +	 },
>> +};
>> +
>> +static struct rockchip_mpp_control rkvdec_controls[] = {
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC_SLICE,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_SPS,
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_sps),
>> +	 },
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC_SLICE,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_PPS,
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_pps),
>> +	 },
>> +	{
>> +	 .codec = V4L2_PIX_FMT_HEVC_SLICE,
>> +	 .id = V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS,
>> +	 .elem_size = sizeof(struct v4l2_ctrl_hevc_slice_params),
>> +	 },
>> +	{
>> +	 .codec = V4L2_PIX_FMT_H264_SLICE,
> We agreed with Maxime and Ezequiel that there will be two distinct
> format, V4L2_PIX_FMT_H264_SLICE_RAW and V4L2_PIX_FMT_H264_SLICE_ANNEXB.
> And user-pace will take care of providing the right information.

I have no idea on what does the SLICE_RAW mean here.

Annex B describe a byte stream format but it doesn't mean it should  
ship slice data with SPS or PPS

The problem of bootlin demo is it follows Annex B but withou a start 
code !!!!



