Return-Path: <SRS0=bmC7=SM=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BIGNUM_EMAILS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D3C10F11
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2F20818
	for <linux-media@archiver.kernel.org>; Wed, 10 Apr 2019 11:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfDJLYs (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:24:48 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:34899 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbfDJLYr (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 10 Apr 2019 07:24:47 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EBLQhYG9kiLOmEBLRh6x6y; Wed, 10 Apr 2019 13:24:45 +0200
Subject: Re: [bug report] [media] mxb: fix audio handling
To:     Dan Carpenter <dan.carpenter@oracle.com>, hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org
References: <20190410110934.GA3459@kadam>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <9b5791ce-6de7-c769-ac14-2b155a44a438@xs4all.nl>
Date:   Wed, 10 Apr 2019 13:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190410110934.GA3459@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE8sEVQZBxQLfn1gCuwmkxJCgN9RF3U8Xu1oB3DdbSDZ7ZSjlyGasXIuG3JsA3OCB+0PslcqgP9FXTJ3PJ/L36iG5Xoj0g6tM8+CYNwObcAIkBrK0p+O
 epkTQb/6XJrkzHCuM7yjzfPdKw5PJa91aRje0N0EM0+q8EhUWpnfl2LmUkrS3NKOb0pepW0HON0alZfWNkjRHd1t+fjwqMbPso/G6ztTU+VdWY0UsU1/4msW
 yaG77Qvv7hOhZhLipxx50rW+HNckH2oE5nUSRy06SJLHI9oIdTzQivSji/aZYfIiVAX7q+drLotkAfVU376hbqUlYdCiqxXa/OscuG1S33fprp/5eGDTss9K
 WeLIyEhO
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On 4/10/19 1:09 PM, Dan Carpenter wrote:
> [ Hi Hans,
> 
>   This might not really be your bug, but I just respect you a lot and
>   so I always come to you with questions and for advice.  -dan ]

Hmm, in other words, I'm too nice!

> 
> Hello Hans Verkuil,
> 
> The patch 6680427791c9: "[media] mxb: fix audio handling" from Apr
> 30, 2012, leads to the following static checker warning:
> 
> 	drivers/media/pci/saa7146/mxb.c:196 tea6420_route()
> 	warn: uncapped user index 'TEA6420_cd[idx]'
> 
> drivers/media/pci/saa7146/mxb.c
>     194 static inline void tea6420_route(struct mxb *mxb, int idx)
>     195 {
> --> 196 	v4l2_subdev_call(mxb->tea6420_1, audio, s_routing,
>     197 		TEA6420_cd[idx][0].input, TEA6420_cd[idx][0].output, 0);
>                                    ^^^
> Index overflow.  The TEA6420_cd[] array has MXB_AUDIOS + 1 (which is 7
> altogether) elements.
> 
>     198 	v4l2_subdev_call(mxb->tea6420_2, audio, s_routing,
>     199 		TEA6420_cd[idx][1].input, TEA6420_cd[idx][1].output, 0);
>     200 	v4l2_subdev_call(mxb->tea6420_1, audio, s_routing,
>     201 		TEA6420_line[idx][0].input, TEA6420_line[idx][0].output, 0);
>     202 	v4l2_subdev_call(mxb->tea6420_2, audio, s_routing,
>     203 		TEA6420_line[idx][1].input, TEA6420_line[idx][1].output, 0);
>     204 }
> 
> [ snip ]
> 
>     650  static int vidioc_s_audio(struct file *file, void *fh, const struct v4l2_audio *a)
>     651  {
>     652          struct saa7146_dev *dev = ((struct saa7146_fh *)fh)->dev;
>     653          struct mxb *mxb = (struct mxb *)dev->ext_priv;
>     654  
>     655          DEB_D("VIDIOC_S_AUDIO %d\n", a->index);
>     656          if (mxb_inputs[mxb->cur_input].audioset & (1 << a->index)) {
> 
> This a->index comes from the ioctl and it's a u32 so the shift can wrap.
> The .audioset variable is always 0x3f.  In other words BIT(6) is the
> highest valid bit so we could add a check:
> 
> 		if (a->index > MXB_AUDIOS)
> 			return;

That's correct.

> 
>     657                  if (mxb->cur_audinput != a->index) {
>     658                          mxb->cur_audinput = a->index;
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Now here's the complication.  We also use a->index as an index into the
> mxb_inputs[] array which only has MXB_INPUTS (4) elements, so just

We do? Where does that happen? I don't see that in the code. That would be
a bug since mxb_inputs are the video inputs, whereas s_audio deals with
audio inputs.

Regards,

	Hans

> adding the limit would still lead to a different array out of bounds
> later...
> 
>     659                          tea6420_route(mxb, a->index);
>     660                          if (mxb->cur_audinput == 0)
>     661                                  mxb_update_audmode(mxb);
>     662                  }
>     663                  return 0;
>     664          }
>     665          return -EINVAL;
>     666  }
> 
> regards,
> dan carpenter
> 

