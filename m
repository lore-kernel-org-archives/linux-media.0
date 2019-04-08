Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2EC10F13
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B886B20857
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554739866;
	bh=KFuW3wZtEUF+Kfmq2sAPrT5xFxi0QqV5JkFtrAHJNIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UZpppIRnJcezThwVu8QjpgwR3u0cmV6e4i0krD7+LbXB/vP3EHFAj53urX7ZWqut5
	 jEwjiMAMbZ+BlVZPJ8ykbXzoAP3U6imk2aougMOtNA682k9xB0O9R0lbDaS3B5rZrx
	 3pviu7J0d+V6ZDsvlpHCUo1yCZXZnVnjZD2etFFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfDHQLF (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:11:05 -0400
Received: from casper.infradead.org ([85.118.1.10]:35068 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDHQLF (ORCPT
        <rfc822;linux-media@vger.kernel.org>); Mon, 8 Apr 2019 12:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sEtEJcNsF/lj96Che6Xle0hNYxgOKKQ4yjhVFS3uPJ8=; b=qyXST9pmms67PPATkWrv9N+U9h
        TnDRubmFOhgzdOb2MIk/5wlB3SuldRsrpkPjsvt6Y/GRR7eNVt1Mqi6Rs8LMgmAnVTXj4qGvBDr5O
        ogd9dzQPmq303DOI9jQIcnBkkUrHblaMxyreDxGlSYf0Iqc46YgPULhziGlHIyISb6nM9DzpY5nM1
        L4hpHXI/2G90uK3r5PYCiJr+JK6ovvNLTO2vfK5LKDZY9y53hkdHVx0w4PPin0B1cHdnyvqx5VgGT
        ID6lfp+UrDlXNClWOB1GJPW9xOBfYkERwSFlzlUmhaI6viudF3TEIXGvhP7h9pSb0gD90+3KOIpxP
        Bw4V2DGQ==;
Received: from [179.95.33.162] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDWrM-00054T-5j; Mon, 08 Apr 2019 16:11:00 +0000
Date:   Mon, 8 Apr 2019 13:10:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Subject: Re: [PATCH v4l-utils 0/2] v4l2-compliance colors
Message-ID: <20190408131055.22eb3a46@coco.lan>
In-Reply-To: <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
References: <20190408084558.2979-1-p.zabel@pengutronix.de>
        <3aaaa269-191f-678c-df60-69500042c875@xs4all.nl>
        <20190408072854.13077345@coco.lan>
        <c832377b-b074-9840-d531-51a3143a167e@xs4all.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

Em Mon, 8 Apr 2019 12:44:18 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> On 4/8/19 12:28 PM, Mauro Carvalho Chehab wrote:
> > Em Mon, 8 Apr 2019 11:05:20 +0200
> > Hans Verkuil <hverkuil@xs4all.nl> escreveu:
> >   
> >> Hi Philipp,
> >>
> >> On 4/8/19 10:45 AM, Philipp Zabel wrote:  
> >>> Hi,
> >>>
> >>> not sure if anybody finds this as useful as I do to spot compliance
> >>> failures and warnings in a sea of OKs more easily, but this patch adds
> >>> some color escape codes to the output of v4l2-compliance. It marks "OK"
> >>> green, "warn" bold, and "fail" / "FAIL" bright red if the output is a
> >>> terminal. I would have preferred to mark warnings yellow, but that
> >>> doesn't work well on black-on-white terminals.    
> >>
> >> Hmm, I hate colors myself :-)
> >>
> >> So I would prefer if an option is added to explicitly enable colors. And the
> >> check for stdout can be replaced by a check for this new option.
> >>
> >> Also, the same option and behavior should be added to cec-compliance as well.
> >>
> >> I propose the option -C, --show-colors.  
> > 
> > Just my two cents here: I guess most people love colors for warnings
> > (I do), and this has becoming more popular on gcc - and it is already
> > a default for dvb tools, with is part of v4l2-utils.
> > 
> > So, IMHO, it would make more sense to have colors enabled by default,
> > and provide, instead, either an option to disable or to have an env
> > var that would control it.  
> 
> If we do that then it needs to be the same for all utils. I could live
> with a env variable.

Fully agreed on that. We should handle it the same way on all apps.

> I just tried to run dvb-fe-tool (no arguments), and I get a warning
> in a brown/orange color, but after that my cursor turns the same color.
> Does it properly go back to black?

Hmm... good point. It should, but this is something that I usually don't
really test here, as my prompt is colored:

	PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

so if it doesn't reset the terminal, I wouldn't notice.

Just did a quick test here. Colors are being reset with Mate terminal:

<colored prompt> $ PS1="\w \$ "
~ $ dvb-fe-tool 
Device Montage Technology M88DS3103 (/dev/dvb/adapter0/frontend0) capabilities:
     CAN_2G_MODULATION
     CAN_FEC_1_2
     CAN_FEC_2_3
     CAN_FEC_3_4
     CAN_FEC_4_5
     CAN_FEC_5_6
     CAN_FEC_6_7
     CAN_FEC_7_8
     CAN_FEC_8_9
     CAN_FEC_AUTO
     CAN_INVERSION_AUTO
     CAN_QPSK
     CAN_RECOVER
DVB API Version 5.11, Current v5 delivery system: DVBS
Supported delivery systems: 
    [DVBS]
     DVBS2
Frequency range for the current standard: 
From:             950 MHz
To:              2.15 GHz
Tolerance:       5.00 MHz
Symbol rate ranges for the current standard: 
From:            1.00 MBauds
To:              45.0 MBauds
SEC: set voltage to OFF
ERROR    FE_SET_VOLTAGE: Operation not permitted	# printed in RED

~ $ dvb-fe-tool -a 2
WARNING  device dvb2.frontend0 not found		# printed in YELLOW
~ $ 

With both the above cases, the prompt return to black and white.

Perhaps the terminal you're using are not properly handling the
color reset command. I saw in the past some broken terminal emulations
where resetting the colors only work if it also prints something after
the color reset command with a "\n" at the end.

Thanks,
Mauro
