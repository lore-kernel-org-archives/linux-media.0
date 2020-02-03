Return-Path: <SRS0=LvLg=3X=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA500C3524D
	for <linux-media@archiver.kernel.org>; Mon,  3 Feb 2020 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A718F20658
	for <linux-media@archiver.kernel.org>; Mon,  3 Feb 2020 11:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Uu7FsMz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBCLl0 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:41:26 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:39585 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbgBCLlZ (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Mon, 3 Feb 2020 06:41:25 -0500
Received: from tschai.fritz.box ([46.9.235.248])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ya6RiS69Jn7E5ya6Wi3UGv; Mon, 03 Feb 2020 12:41:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1580730084; bh=RzoblhVgemTQ++qD155dlEe1LD3OMFVWWrKL6XmjYHY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=Uu7FsMz2TfUbEoVL5kS61fXMDmm63aTSJjffotwEBKPNs3hoixOapmRbBzndfyJd9
         fcg3IcFoYHfjTJnPGHjRKGuynK3P1gbqn2aHeYOngX/capPlzgFD0DqkKGR286l2hp
         ZJRE5RLPDMl+kp2q/Pmfocx8fzaV6ZkLjf9be6wUVkUOW7p29hjyHu8I4ScSlJB8SR
         B8jLm6dr8GC+eyXTvkXsG1ThmG0e6cEcN8RlnOS23+soLIzmz9E17h5qQIVe6kH3vl
         U/YGYKyp9qOTpAyPBkzBCmXg++Y1+8ZYngFJDdQiq1dyQIGPjwI22Lkbr7LxTKJwpb
         ncAokUBhw2kew==
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/11] bcm2835-camera: rename VFL_TYPE_GRABBER to _VIDEO
Date:   Mon,  3 Feb 2020 12:41:11 +0100
Message-Id: <20200203114119.1177490-4-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200203114119.1177490-1-hverkuil-cisco@xs4all.nl>
References: <20200203114119.1177490-1-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMYQBx7nC6D3KGDzpS6tqLjATMx7ndUsOT+3rfJyigb0kZdy8hcF589QdhH4omKlqR2++UDGVQ5yWi+dvGWwGhrBql31kNTuqlpDuC13BeeVqJB1Sd+Q
 5yfkH6xFxvFGEuiOz7zEKIO0y5zvg86eGhXtfDAUqK6tvT2jM6DCE3V4duULYT5UKAc1CjgDaQLcXEOngLvI6Ky58teA8hz2R194m4sHnTR6m5OIewolSKAD
 mQrHpjj4MMQNgLzSrK3XL0TH0ULieDDiMvrLqFXkfgASZU9eUnsrakK2Gn70duQKm428k8HeWd1rTw/7mPPMVg==
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

'GRABBER' is a weird name, all other types map to the /dev
device names. Rename to 'VIDEO' to be consistent with the
other types.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index beb6a0063bb8..5f32d856efc9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1773,7 +1773,7 @@ static int bm2835_mmal_init_device(struct bm2835_mmal_dev *dev,
 	video_set_drvdata(vfd, dev);
 
 	ret = video_register_device(vfd,
-				    VFL_TYPE_GRABBER,
+				    VFL_TYPE_VIDEO,
 				    video_nr[dev->camera_num]);
 	if (ret < 0)
 		return ret;
-- 
2.24.0

