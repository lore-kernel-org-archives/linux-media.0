Return-Path: <SRS0=EBti=R7=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB63C10F06
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBF220811
	for <linux-media@archiver.kernel.org>; Thu, 28 Mar 2019 20:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfC1UGE (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:06:04 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58187 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfC1UGD (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Thu, 28 Mar 2019 16:06:03 -0400
X-Originating-IP: 2.224.242.101
Received: from uno.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A2B7BE0008;
        Thu, 28 Mar 2019 20:06:00 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, luca@lucaceresoli.net,
        ian.arkver.dev@gmail.com, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 13/31] media: entity: Add only connected pads to the pipeline
Date:   Thu, 28 Mar 2019 21:05:50 +0100
Message-Id: <20190328200608.9463-14-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
References: <20190328200608.9463-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

A single entity may contain multiple pipelines. Only add pads that were
connected to the pad through which the entity was reached to the pipeline.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/media-entity.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
index 5f6744732ed9..290083c445eb 100644
--- a/drivers/media/media-entity.c
+++ b/drivers/media/media-entity.c
@@ -465,7 +465,7 @@ __must_check int __media_pipeline_start(struct media_pad *pad,
 		DECLARE_BITMAP(active, MEDIA_ENTITY_MAX_PADS);
 		DECLARE_BITMAP(has_no_links, MEDIA_ENTITY_MAX_PADS);
 
-		media_entity_for_each_pad(entity, iter) {
+		media_entity_for_each_routed_pad(pad, iter) {
 			if (iter->pipe && iter->pipe != pipe) {
 				pr_err("Pipe active for %s. Can't start for %s\n",
 				       entity->name, iter->entity->name);
@@ -554,10 +554,9 @@ __must_check int __media_pipeline_start(struct media_pad *pad,
 	media_graph_walk_start(graph, pad_err);
 
 	while ((pad_err = media_graph_walk_next(graph))) {
-		struct media_entity *entity = pad->entity;
 		struct media_pad *iter;
 
-		media_entity_for_each_pad(entity, iter) {
+		media_entity_for_each_routed_pad(pad, iter) {
 			/* Sanity check for negative stream_count */
 			if (!WARN_ON_ONCE(iter->stream_count <= 0)) {
 				--iter->stream_count;
@@ -610,10 +609,9 @@ void __media_pipeline_stop(struct media_pad *pad)
 	media_graph_walk_start(graph, pad);
 
 	while ((pad = media_graph_walk_next(graph))) {
-		struct media_entity *entity = pad->entity;
 		struct media_pad *iter;
 
-		media_entity_for_each_pad(entity, iter) {
+		media_entity_for_each_routed_pad(pad, iter) {
 			/* Sanity check for negative stream_count */
 			if (!WARN_ON_ONCE(iter->stream_count <= 0)) {
 				iter->stream_count--;
-- 
2.21.0

