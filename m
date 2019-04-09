Return-Path: <SRS0=ytLV=SL=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C3C10F0E
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0402133D
	for <linux-media@archiver.kernel.org>; Tue,  9 Apr 2019 15:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIPpk (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:45:40 -0400
Received: from gofer.mess.org ([88.97.38.141]:53351 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIPpj (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Tue, 9 Apr 2019 11:45:39 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 797E160442; Tue,  9 Apr 2019 16:45:38 +0100 (BST)
Date:   Tue, 9 Apr 2019 16:45:38 +0100
From:   Sean Young <sean@mess.org>
To:     Gregor Jasny <gjasny@googlemail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: missing patch on v4l-utils-1.14 / 1.16
Message-ID: <20190409154538.etstkfczzfsspmvz@gofer.mess.org>
References: <24ef8046-1b38-6c87-4437-fe0187f98a0a@googlemail.com>
 <cc7fce0b-8db0-ce2c-e7f0-c6d39f7690c9@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7fce0b-8db0-ce2c-e7f0-c6d39f7690c9@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Mon, Apr 08, 2019 at 09:04:56PM +0200, Gregor Jasny wrote:
> Hello,
> 
> It seems that commit 6e21f6f34c1d7c3a7a059062e1ddd9705c984e2c is also
> missing on 1.16 (in addition to 1.14). Otherwise the return paths are still
> messed up:
> 
> > 	ret = dvb_fe_open_fname(parms, dvb_dev->path, flags);
> > 	if (ret < 0) {
> > 		free(parms);   <--- double free if returned via FE_GET_INFO error path
> > 		return NULL;
> > 	}
> > 
> > 	return &parms->p;
> > }
> > 
> > int dvb_fe_open_fname(struct dvb_v5_fe_parms_priv *parms, char *fname,
> > 		      int flags)
> > {
> > 	...
> > 
> > 	if (xioctl(fd, FE_GET_INFO, &parms->p.info) == -1) {
> > 		dvb_perror("FE_GET_INFO");
> > 		dvb_v5_free(parms);
> > 		close(fd);
> > 		free(fname);
> > 		return -errno;
> > 	}
> 
> For 1.16 I was first fooled by the commit date of August 7th which should be
> before 1.16 branch off. But the commit was only applied in November and
> missed 1.16.
> 
> If you agree that the pathc is missing, please cherry-pick it to the two
> branches.

You're right, good spot. I've pushed the missing commit to stable-1.14 and
stable-1.16.


Thanks,

Sean
