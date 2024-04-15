Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428236A005
	for <linux-media@vger.kernel.org>; Mon, 15 Apr 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182588; cv=none; b=kjdqHTO2H951GrzbEQYe5nCy7wYcnDSnQ+JSKg4ydZc6XHqhKDZ+7ulZ5qhaXXy2uOkF0UhyqVK8DwsPdk6ZLNt6eWQOcuLPcl+qYTonYnlZQ00R2J6Dz6ysqel3bYqASmEfV0MOJy5Lyw1XynPZb0F2ZNij7IkucQeY6IKnb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182588; c=relaxed/simple;
	bh=X2zszUGBEvyLh6pvdq9YYGejPi+fN+/vjf5f7dDh6JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeWGRthgkDOg0GzraGyxpuY/AJvykllisuieG020xKEko6Yutwizgm3hWauEue2tPJI3H4KXuUSVMw2FUcX/uCsYSAwV00pRtO2WT/CGjcbBtqViVtw/+Fxax9aWj8lW8yHHqWxXfa826RDIeYCHUbXQmMykDe569Tju2dEc8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1li+l6w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1li+l6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713182585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I0kj/gQOo/SKjO/SH+29fGHV3spCquGvHv/QsdfZM4=;
	b=Y1li+l6wnGh1UQMjKCZfJ/irGpADUR3UxJjNbsULHbt8toUv7qTPElqbV6ktZdnz6EM8+S
	o79kLpK683CTi3JVY/vHc8DI76f2mGAdx1Kj/djsBiDdEbGcczDodK426laUcqRA0/b2h0
	AtlmqUWvbX3m22oC9/jwwNrx77fmEd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-oPWsgqtnNWCUcqZCgMvlLw-1; Mon, 15 Apr 2024 08:03:02 -0400
X-MC-Unique: oPWsgqtnNWCUcqZCgMvlLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A7C80D678;
	Mon, 15 Apr 2024 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 700EAC13FA4;
	Mon, 15 Apr 2024 12:03:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Kate Hsuan <hpa@redhat.com>,
	Tsuchiya Yuto <kitakar@gmail.com>,
	Fabio Aiuto <fabioaiuto83@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 19/23] media: atomisp: Remove clearing of ISP crop / compose rectangles on file release
Date: Mon, 15 Apr 2024 14:02:16 +0200
Message-ID: <20240415120220.219480-20-hdegoede@redhat.com>
In-Reply-To: <20240415120220.219480-1-hdegoede@redhat.com>
References: <20240415120220.219480-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

There is no need to clear the ISP sink-pad crop and source-pad
compose rectangles  on release of the /dev/video# file.

Both will be reset by atomisp_set_fmt() which is guaranteed to
get called by atomisp_queue_setup() (if not called already)
before another stream starts and thus before these selections
are used again.

Also the file injection support the comment talks about has long
been dropped from the driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../staging/media/atomisp/pci/atomisp_fops.c  | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_fops.c b/drivers/staging/media/atomisp/pci/atomisp_fops.c
index 0d0c1649eaad..50c4123ba006 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_fops.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_fops.c
@@ -539,7 +539,6 @@ static int atomisp_release(struct file *file)
 	struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
 	struct atomisp_sub_device *asd = pipe->asd;
 	struct v4l2_subdev_fh fh;
-	struct v4l2_rect clear_compose = {0};
 
 	v4l2_fh_init(&fh.vfh, vdev);
 
@@ -552,21 +551,6 @@ static int atomisp_release(struct file *file)
 
 	pipe->users--;
 
-	/*
-	 * A little trick here:
-	 * file injection input resolution is recorded in the sink pad,
-	 * therefore can not be cleared when releaseing one device node.
-	 * The sink pad setting can only be cleared when all device nodes
-	 * get released.
-	 */
-	{
-		struct v4l2_mbus_framefmt isp_sink_fmt = { 0 };
-
-		atomisp_subdev_set_ffmt(&asd->subdev, fh.state,
-					V4L2_SUBDEV_FORMAT_ACTIVE,
-					ATOMISP_SUBDEV_PAD_SINK, &isp_sink_fmt);
-	}
-
 	atomisp_css_free_stat_buffers(asd);
 	atomisp_free_internal_buffers(asd);
 
@@ -577,11 +561,6 @@ static int atomisp_release(struct file *file)
 	if (pm_runtime_put_sync(vdev->v4l2_dev->dev) < 0)
 		dev_err(isp->dev, "Failed to power off device\n");
 
-	atomisp_subdev_set_selection(&asd->subdev, fh.state,
-				     V4L2_SUBDEV_FORMAT_ACTIVE,
-				     ATOMISP_SUBDEV_PAD_SOURCE,
-				     V4L2_SEL_TGT_COMPOSE, 0,
-				     &clear_compose);
 	mutex_unlock(&isp->mutex);
 	return 0;
 }
-- 
2.44.0

