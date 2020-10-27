Return-Path: <SRS0=Zg/f=EC=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19FC4363A
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 17:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5475E21D42
	for <linux-media@archiver.kernel.org>; Tue, 27 Oct 2020 17:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816649AbgJ0RIQ (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:08:16 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:47840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1816629AbgJ0RIO (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Tue, 27 Oct 2020 13:08:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 45489182CED2A;
        Tue, 27 Oct 2020 17:08:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake71_590ddfb2727d
X-Filterd-Recvd-Size: 4916
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Oct 2020 17:08:04 +0000 (UTC)
Message-ID: <2767969b94fd66db1fb0fc13b5783ae65b7deb2f.camel@perches.com>
Subject: Re: [PATCH 3/8] vhost: vringh: use krealloc_array()
From:   Joe Perches <joe@perches.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-drm <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>, linux-mm@kvack.org,
        Linux-ALSA <alsa-devel@alsa-project.org>
Date:   Tue, 27 Oct 2020 10:08:02 -0700
In-Reply-To: <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
References: <20201027121725.24660-1-brgl@bgdev.pl>
         <20201027121725.24660-4-brgl@bgdev.pl>
         <20201027112607-mutt-send-email-mst@kernel.org>
         <685d850347a1191bba8ba7766fc409b140d18f03.camel@perches.com>
         <CAMpxmJU0C84DjPmqmWvPgv0zwgGLhkpKLRDuKkZHAa=wi+LvBA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Tue, 2020-10-27 at 17:58 +0100, Bartosz Golaszewski wrote:
> On Tue, Oct 27, 2020 at 5:50 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2020-10-27 at 11:28 -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 27, 2020 at 01:17:20PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > 
> > > > Use the helper that checks for overflows internally instead of manually
> > > > calculating the size of the new array.
> > > > 
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > 
> > > No problem with the patch, it does introduce some symmetry in the code.
> > 
> > Perhaps more symmetry by using kmemdup
> > ---
> >  drivers/vhost/vringh.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 8bd8b403f087..99222a3651cd 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -191,26 +191,23 @@ static int move_to_indirect(const struct vringh *vrh,
> >  static int resize_iovec(struct vringh_kiov *iov, gfp_t gfp)
> >  {
> >         struct kvec *new;
> > -       unsigned int flag, new_num = (iov->max_num & ~VRINGH_IOV_ALLOCATED) * 2;
> > +       size_t new_num = (iov->max_num & ~VRINGH_IOV_ALLOCATED) * 2;
> > +       size_t size;
> > 
> >         if (new_num < 8)
> >                 new_num = 8;
> > 
> > -       flag = (iov->max_num & VRINGH_IOV_ALLOCATED);
> > -       if (flag)
> > -               new = krealloc(iov->iov, new_num * sizeof(struct iovec), gfp);
> > -       else {
> > -               new = kmalloc_array(new_num, sizeof(struct iovec), gfp);
> > -               if (new) {
> > -                       memcpy(new, iov->iov,
> > -                              iov->max_num * sizeof(struct iovec));
> > -                       flag = VRINGH_IOV_ALLOCATED;
> > -               }
> > -       }
> > +       if (unlikely(check_mul_overflow(new_num, sizeof(struct iovec), &size)))
> > +               return -ENOMEM;
> > +
> 
> The whole point of using helpers such as kmalloc_array() is not doing
> these checks manually.

Tradeoffs for in readability for overflow and not mistyping or doing
the multiplication of iov->max_num * sizeof(struct iovec) twice.

Just fyi:

the realloc doesn't do a multiplication overflow test as written so the
suggestion is slightly more resistant to defect.

   

