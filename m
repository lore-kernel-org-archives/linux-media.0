Return-Path: <SRS0=xY1j=6U=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE38C28CBC
	for <linux-media@archiver.kernel.org>; Wed,  6 May 2020 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E364820575
	for <linux-media@archiver.kernel.org>; Wed,  6 May 2020 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588764541;
	bh=PvZ44KYA/h/oOalve4R/5e6qpafbuUk9Y5Pk7hzfND4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yvIiAO0q5opNPj02hYWZp86cDo8uxR9FwtAxrAIcW2C1qp01siNPlh4zDxc+FesaV
	 zvha/hR4sU+vLEaAJ1NhYtq3wQlR0hXYY8Xlci78y6PAH7np2/JxW1xj/hjjEt8eud
	 5hYXwQtFsQhP2JroTuSQgK/0rw9p4/nvj5FiSliU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgEFL3A (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 6 May 2020 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgEFL3A (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 6 May 2020 07:29:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5FC061A0F
        for <linux-media@vger.kernel.org>; Wed,  6 May 2020 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=dVhoKCrJYU8ynbHvWDZWWaj7USYLeiy+4xjGqbhr0P4=; b=XJmLHyy750kaWjLK5KGJEbzB8w
        tMZK5SRgk24msGKRrrVupuCfakUl+a+9WXtsH9aF9Efw8ni7uOnby62kLwzCnTud0KFL2j4FbOiBc
        cOwHD7W3NpiCG6QsgPqvtQKCHN/lLMt+vefzYtPTwR57hrnRSX05OJch2BjXl4LwN7VwCZAId8WCD
        ShzSW07Qbxj3nxwhUKlnHlKFKnMQJ0s7M11xQl82U6FuyrR12j/jmB4kahYShatNusxUlBtQS8ZYN
        mdmAC0RN3+qC3TQN6K/EPfdpBcn2odmpNQ3BH82fJlbIfCWPbfQaDvSlQJu4T/3PTNTZBzDxRU0ea
        LoVV9IGw==;
Received: from ip5f5ad5c5.dynamic.kabel-deutschland.de ([95.90.213.197] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWIEN-0002fb-3T; Wed, 06 May 2020 11:28:51 +0000
Date:   Wed, 6 May 2020 13:28:47 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        tfiga@google.com, pavel@ucw.cz,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>, libcamera-devel@lists.libcamera.org
Subject: Re: [PATCH v9 02/11] media: v4l2-ctrl: Document
 V4L2_CID_CAMERA_SENSOR_LOCATION
Message-ID: <20200506132847.03860fce@coco.lan>
In-Reply-To: <20200506110730.rvhxoh74u3rmemtw@uno.localdomain>
References: <20200417124110.72313-1-jacopo@jmondi.org>
        <20200417124110.72313-3-jacopo@jmondi.org>
        <20200505140206.589f54ae@coco.lan>
        <a5d77790-5f98-650e-cfb9-a97b8701454d@xs4all.nl>
        <20200505165826.1ce8bb0d@coco.lan>
        <b3e211da-b9f6-a65c-4453-c11b05bced45@xs4all.nl>
        <20200506113909.1489bd1e@coco.lan>
        <20200506110730.rvhxoh74u3rmemtw@uno.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Wed, 6 May 2020 13:07:30 +0200
Jacopo Mondi <jacopo@jmondi.org> escreveu:

> > So, if that would be ok for you, I can live with a
> >
> > V4L2_CID_CAMERA_VIEWING_ANGLE (or some similar name) that will
> > specify the angle where the sensor is mounted (for fixed sensors),
> > or the current angle, in case of movable ones, being RO for fixed
> > sensors and RW for movable ones.
> >
> > Let's postpone discussions for a LOCATION control once this
> > would be needed by some driver.  
> 
> Would V4L2_CID_CAMERA_ORIENTATION work ?

Yeah, either V4L2_CID_CAMERA_ORIENTATION or CID_LENS_FACING would
equally work (although I would prefer the one with a shorter name).

> 
> I could:
> 1) rename dt-proeprty and control to use orientation
> 2) specify multiple locations could be entered, the first one being
> the "default" (eg. device turned off) location
> 3) make am RW control if multiple entries have been specified, a RO
> otherwise.
> 
> Ack ?

Yeah, that would work for me. 

Thanks,
Mauro
