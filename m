Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF5C10F03
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F992173C
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 09:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfC1J5p (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:57:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbfC1J5p (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 05:57:45 -0400
X-UUID: afeca2f3349342cd99d4413634b56aa9-20190328
X-UUID: afeca2f3349342cd99d4413634b56aa9-20190328
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <jungo.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 299356511; Thu, 28 Mar 2019 17:57:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 17:57:30 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 17:57:30 +0800
From:   Jungo Lin <jungo.lin@mediatek.com>
To:     <tfiga@chromium.org>, <hans.verkuil@cisco.com>,
        <laurent.pinchart+renesas@ideasonboard.com>,
        <matthias.bgg@gmail.com>, <mchehab@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <Sean.Cheng@mediatek.com>,
        <sj.huang@mediatek.com>, <christie.yu@mediatek.com>,
        <holmes.chiou@mediatek.com>, <frederic.chen@mediatek.com>,
        <Jerry-ch.Chen@mediatek.com>, <jungo.lin@mediatek.com>,
        <frankie.chiu@mediatek.com>, <seraph.huang@mediatek.com>,
        <ryan.yu@mediatek.com>, <Rynn.Wu@mediatek.com>,
        <yuzhao@chromium.org>, <zwisler@chromium.org>,
        <srv_heupstream@mediatek.com>
Subject: [RFC V1 12/12] media: platform: Add Mediatek ISP P1 shared memory driver
Date:   Thu, 28 Mar 2019 17:56:47 +0800
Message-ID: <1553767007-11909-13-git-send-email-jungo.lin@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
References: <jungo.lin@mediatek.com>
 <1553767007-11909-1-git-send-email-jungo.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

The purpose of this driver is to provide shared memory management
for exchanging tuning data between co-processor and the
Pass 1 unit of the camera ISP system.

Signed-off-by: Jungo Lin <jungo.lin@mediatek.com>
---
 .../platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c | 398 +++++++++++++++++++++
 .../platform/mtk-isp/isp_50/cam/mtk_cam-smem.h     |  25 ++
 2 files changed, 423 insertions(+)
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c
 create mode 100644 drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem.h

diff --git a/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c b/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c
new file mode 100644
index 0000000..9a92080
--- /dev/null
+++ b/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem-drv.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Frederic Chen <frederic.chen@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/dma-contiguous.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/iommu.h>
+#include <asm/cacheflush.h>
+
+#define MTK_CAM_SMEM_DEV_NAME "MTK-CAM-SMEM"
+
+struct mtk_cam_smem_drv {
+	struct platform_device *pdev;
+	struct sg_table sgt;
+	struct page **smem_pages;
+	int num_smem_pages;
+	dma_addr_t smem_base;
+	dma_addr_t smem_dma_base;
+	unsigned int smem_size;
+};
+
+/*
+ * MTK CAM SMEM DMA ops
+ */
+struct dma_coherent_mem {
+	void		*virt_base;
+	dma_addr_t	device_base;
+	unsigned long	pfn_base;
+	int		size;
+	int		flags;
+	unsigned long	*bitmap;
+	spinlock_t	spinlock; /* dma_coherent_mem attributes protection */
+	bool		use_dev_dma_pfn_offset;
+};
+
+static struct reserved_mem *isp_reserved_smem;
+
+dma_addr_t mtk_cam_smem_iova_to_scp_addr(struct device *dev,
+					 dma_addr_t iova)
+{
+		struct iommu_domain *smem_dom;
+		dma_addr_t addr;
+		dma_addr_t limit;
+		struct mtk_cam_smem_drv *smem_dev =
+			dev_get_drvdata(dev);
+
+		smem_dom = iommu_get_domain_for_dev(dev);
+		if (!smem_dom) {
+			dev_warn(dev, "No iommu group domain");
+			return 0;
+		}
+
+		addr = iommu_iova_to_phys(smem_dom, iova);
+
+		limit = smem_dev->smem_base + smem_dev->smem_size;
+		if (addr < smem_dev->smem_base || addr >= limit) {
+			dev_err(dev,
+				"Unexpected scp_addr %pa (must >= %pa and <%pa)\n",
+				&addr, &smem_dev->smem_base, &limit);
+			return 0;
+		}
+		dev_dbg(dev, "Pa verifcation pass: %pa(>=%pa, <%pa)\n",
+			&addr, &smem_dev->smem_base, &limit);
+		return addr;
+}
+
+static int mtk_cam_smem_get_sgtable(struct device *dev,
+				    struct sg_table *sgt,
+	void *cpu_addr, dma_addr_t dma_addr,
+	size_t size, unsigned long attrs)
+{
+	struct mtk_cam_smem_drv *smem_dev = dev_get_drvdata(dev);
+	int n_pages_align = 0;
+	int size_align = 0;
+	int page_start = 0;
+	unsigned long long offset_p = 0;
+
+	dma_addr_t scp_addr = mtk_cam_smem_iova_to_scp_addr(dev, dma_addr);
+
+	offset_p = (unsigned long long)scp_addr -
+		(unsigned long long)smem_dev->smem_base;
+
+	size_align = round_up(size, PAGE_SIZE);
+	n_pages_align = size_align >> PAGE_SHIFT;
+	page_start = offset_p >> PAGE_SHIFT;
+	dev_dbg(dev,
+		"%s:page idx:%d,page pa:0x%llx,pa:0x%llx, aligned size:%d pages:%d\n",
+		__func__,
+		page_start,
+		(unsigned long long)page_to_phys(*(smem_dev->smem_pages
+			+ page_start)),
+		(unsigned long long)scp_addr,
+		size_align,
+		n_pages_align
+		);
+
+	return sg_alloc_table_from_pages(sgt,
+		smem_dev->smem_pages + page_start,
+		n_pages_align,
+		0, size_align, GFP_KERNEL);
+}
+
+static void *mtk_cam_smem_get_cpu_addr(struct mtk_cam_smem_drv *smem_dev,
+				       struct scatterlist *sg)
+{
+	struct device *dev = &smem_dev->pdev->dev;
+	struct dma_coherent_mem *dma_mem = dev->dma_mem;
+
+	dma_addr_t addr = (phys_addr_t)sg_phys(sg);
+
+	if (addr < smem_dev->smem_base ||
+	    addr > smem_dev->smem_base + smem_dev->smem_size) {
+		dev_err(dev, "Invalid scp_addr 0x%llx from sg\n", addr);
+		return NULL;
+	}
+
+	return dma_mem->virt_base + (addr - smem_dev->smem_base);
+}
+
+static void mtk_cam_smem_sync_sg_for_cpu(struct device *dev,
+					 struct scatterlist *sgl, int nelems,
+					 enum dma_data_direction dir)
+{
+	struct mtk_cam_smem_drv *smem_dev =
+		dev_get_drvdata(dev);
+	void *cpu_addr;
+
+	cpu_addr = mtk_cam_smem_get_cpu_addr(smem_dev, sgl);
+	dev_dbg(dev,
+		"__dma_unmap_area:scp_addr(0x%llx),vaddr(0x%llx),size(%d),dir(%d)\n",
+		(unsigned long long)sg_phys(sgl),
+		(unsigned long long)cpu_addr,
+		sgl->length,
+		dir);
+	__dma_unmap_area(cpu_addr, sgl->length, dir);
+}
+
+static void mtk_cam_smem_sync_sg_for_device(struct device *dev,
+					    struct scatterlist *sgl,
+					    int nelems,
+					    enum dma_data_direction dir)
+{
+	struct mtk_cam_smem_drv *smem_dev =
+			dev_get_drvdata(dev);
+	void *cpu_addr;
+
+	cpu_addr = mtk_cam_smem_get_cpu_addr(smem_dev, sgl);
+	flush_cache_vmap((unsigned long long)cpu_addr,
+			 (unsigned long long)cpu_addr + sgl->length);
+	__dma_flush_area(cpu_addr, sgl->length);
+	dev_dbg(dev,
+		"__dma_map_area:scp_addr(0x%llx),vaddr(0x%llx),size(%d),dir(%d)\n",
+		(unsigned long long)sg_phys(sgl),
+		(unsigned long long)cpu_addr,
+		sgl->length,
+		dir);
+	__dma_map_area(cpu_addr, sgl->length, dir);
+}
+
+static int mtk_cam_smem_setup_dma_ops(struct device *dev,
+				      const struct dma_map_ops *smem_ops)
+{
+	if (!dev->dma_ops)
+		return -EINVAL;
+
+	memcpy((void *)smem_ops, dev->dma_ops, sizeof(*smem_ops));
+	((struct dma_map_ops *)smem_ops)->get_sgtable =
+		mtk_cam_smem_get_sgtable;
+	((struct dma_map_ops *)smem_ops)->sync_sg_for_device =
+		mtk_cam_smem_sync_sg_for_device;
+	((struct dma_map_ops *)smem_ops)->sync_sg_for_cpu =
+		mtk_cam_smem_sync_sg_for_cpu;
+	dev->dma_ops = smem_ops;
+
+	return 0;
+}
+
+static const struct dma_map_ops smem_dma_ops = {
+	.get_sgtable = mtk_cam_smem_get_sgtable,
+};
+
+static int mtk_cam_smem_init(struct mtk_cam_smem_drv **mtk_cam_smem_drv_out,
+			     struct platform_device *pdev)
+{
+	struct mtk_cam_smem_drv *isp_sys;
+	struct device *dev = &pdev->dev;
+
+	isp_sys = devm_kzalloc(dev,
+			       sizeof(*isp_sys), GFP_KERNEL);
+	isp_sys->pdev = pdev;
+	*mtk_cam_smem_drv_out = isp_sys;
+
+	return 0;
+}
+
+static int mtk_cam_smem_drv_probe(struct platform_device *pdev)
+{
+	struct mtk_cam_smem_drv *smem_drv;
+	int r = 0;
+	struct device *dev = &pdev->dev;
+
+	dev_dbg(dev, "probe mtk_cam_smem_drv\n");
+
+	r = mtk_cam_smem_init(&smem_drv, pdev);
+
+	if (!smem_drv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, smem_drv);
+
+	if (isp_reserved_smem) {
+		dma_addr_t dma_addr;
+		dma_addr_t addr;
+		struct iommu_domain *smem_dom;
+		unsigned int i;
+		int size_align;
+		struct page **pages;
+		int n_pages;
+		struct sg_table *sgt = &smem_drv->sgt;
+
+		size_align = round_down(isp_reserved_smem->size,
+					PAGE_SIZE);
+		n_pages = size_align >> PAGE_SHIFT;
+
+		pages = kmalloc_array(n_pages, sizeof(struct page *),
+				      GFP_KERNEL);
+
+		if (!pages)
+			return -ENOMEM;
+
+		for (i = 0; i < n_pages; i++)
+			pages[i] = phys_to_page(isp_reserved_smem->base
+						+ i * PAGE_SIZE);
+
+		r = sg_alloc_table_from_pages(sgt, pages, n_pages, 0,
+					      size_align, GFP_KERNEL);
+
+		if (r) {
+			dev_err(dev, "failed to get alloca sg table\n");
+			return -ENOMEM;
+		}
+
+		dma_map_sg_attrs(dev, sgt->sgl, sgt->nents,
+				 DMA_BIDIRECTIONAL,
+				 DMA_ATTR_SKIP_CPU_SYNC);
+
+		dma_addr = sg_dma_address(sgt->sgl);
+		smem_dom = iommu_get_domain_for_dev(dev);
+		addr = iommu_iova_to_phys(smem_dom, dma_addr);
+
+		if (addr != isp_reserved_smem->base)
+			dev_err(dev,
+				"incorrect pa(0x%llx) should be 0x%llx\n",
+			(unsigned long long)addr,
+			(unsigned long long)isp_reserved_smem->base);
+
+		r = dma_declare_coherent_memory(dev,
+						isp_reserved_smem->base,
+			dma_addr, size_align, DMA_MEMORY_EXCLUSIVE);
+
+		dev_dbg(dev,
+			"Coherent mem base(0x%llx,%llx),size(%lx),ret(%d)\n",
+			isp_reserved_smem->base,
+			dma_addr, size_align, r);
+
+		smem_drv->smem_base = isp_reserved_smem->base;
+		smem_drv->smem_size = size_align;
+		smem_drv->smem_pages = pages;
+		smem_drv->num_smem_pages = n_pages;
+		smem_drv->smem_dma_base = dma_addr;
+
+		dev_dbg(dev, "smem_drv setting (0x%llx,%lx,0x%llx,%d)\n",
+			smem_drv->smem_base, smem_drv->smem_size,
+			(unsigned long long)smem_drv->smem_pages,
+			smem_drv->num_smem_pages);
+	}
+
+	r = mtk_cam_smem_setup_dma_ops(dev, &smem_dma_ops);
+
+	return r;
+}
+
+static int mtk_cam_smem_drv_remove(struct platform_device *pdev)
+{
+	struct mtk_cam_smem_drv *smem_drv =
+		dev_get_drvdata(&pdev->dev);
+
+	kfree(smem_drv->smem_pages);
+	return 0;
+}
+
+static int mtk_cam_smem_drv_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int mtk_cam_smem_drv_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int mtk_cam_smem_drv_dummy_cb(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_cam_smem_drv_pm_ops = {
+	SET_RUNTIME_PM_OPS(&mtk_cam_smem_drv_dummy_cb,
+			   &mtk_cam_smem_drv_dummy_cb, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS
+		(&mtk_cam_smem_drv_suspend, &mtk_cam_smem_drv_resume)
+};
+
+static const struct of_device_id mtk_cam_smem_drv_of_match[] = {
+	{
+		.compatible = "mediatek,mt8183-cam_smem",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mtk_cam_smem_drv_of_match);
+
+static struct platform_driver mtk_cam_smem_driver = {
+	.probe = mtk_cam_smem_drv_probe,
+	.remove = mtk_cam_smem_drv_remove,
+	.driver = {
+		.name = MTK_CAM_SMEM_DEV_NAME,
+		.of_match_table =
+			of_match_ptr(mtk_cam_smem_drv_of_match),
+		.pm = &mtk_cam_smem_drv_pm_ops,
+	},
+};
+
+static int __init mtk_cam_smem_dma_setup(struct reserved_mem
+					 *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL))
+		return -EINVAL;
+
+	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
+		pr_err("Reserved memory: regions without no-map are not yet supported\n");
+		return -EINVAL;
+	}
+
+	isp_reserved_smem = rmem;
+
+	pr_err("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
+	       &rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(mtk_cam_smem,
+		       "mediatek,reserve-memory-cam_smem",
+		       mtk_cam_smem_dma_setup);
+
+int __init mtk_cam_smem_drv_init(void)
+{
+	int ret;
+
+	pr_debug("platform_driver_register: mtk_cam_smem_driver\n");
+	ret = platform_driver_register(&mtk_cam_smem_driver);
+	if (ret)
+		pr_warn("isp smem drv init failed, driver didn't probe\n");
+
+	return ret;
+}
+subsys_initcall(mtk_cam_smem_drv_init);
+
+void __exit mtk_cam_smem_drv_ext(void)
+{
+	platform_driver_unregister(&mtk_cam_smem_driver);
+}
+module_exit(mtk_cam_smem_drv_ext);
+MODULE_AUTHOR("Frederic Chen <frederic.chen@mediatek.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek CAM shared memory driver");
diff --git a/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem.h b/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem.h
new file mode 100644
index 0000000..719ec02
--- /dev/null
+++ b/drivers/media/platform/mtk-isp/isp_50/cam/mtk_cam-smem.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Frederic Chen <frederic.chen@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __MTK_CAM_SMEM_H__
+#define __MTK_CAM_SMEM_H__
+
+#include <linux/dma-mapping.h>
+
+dma_addr_t mtk_cam_smem_iova_to_scp_addr(struct device *smem_dev,
+					 dma_addr_t iova);
+
+#endif /*__MTK_CAM_SMEM_H__*/
+
-- 
1.9.1

