Return-Path: <SRS0=qz7C=SA=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA22C43381
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4370E218A5
	for <linux-media@archiver.kernel.org>; Fri, 29 Mar 2019 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfC2UIh (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:08:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730069AbfC2UIh (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 29 Mar 2019 16:08:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TJwVpR083867
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 16:08:36 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rhqed7py8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-media@vger.kernel.org>; Fri, 29 Mar 2019 16:08:35 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-media@vger.kernel.org> from <eajames@linux.ibm.com>;
        Fri, 29 Mar 2019 20:08:35 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 20:08:32 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TK8VYY62718096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 20:08:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52AE4BE04F;
        Fri, 29 Mar 2019 20:08:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D0BBE054;
        Fri, 29 Mar 2019 20:08:30 +0000 (GMT)
Received: from [9.85.198.59] (unknown [9.85.198.59])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 20:08:29 +0000 (GMT)
Subject: Re: [PATCH] media: platform: Fix a kernel warning on clk control
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, linux-media@vger.kernel.org
References: <20190328212537.29511-1-jae.hyun.yoo@linux.intel.com>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Fri, 29 Mar 2019 15:08:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190328212537.29511-1-jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19032920-0004-0000-0000-000014F4F5A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010836; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181504; UDB=6.00618399; IPR=6.00962224;
 MB=3.00026213; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-29 20:08:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032920-0005-0000-0000-00008B12B98B
Message-Id: <db524edd-0c6c-2bb7-848d-2261286b4b21@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290137
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 3/28/19 4:25 PM, Jae Hyun Yoo wrote:
> Video engine clock control functions in the Aspeed video engine driver are
> being called from multiple context without any protection so video clocks
> can be disabled twice and eventually it causes a kernel warning with stack
> dump printing out like below:
>
> [  120.034729] WARNING: CPU: 0 PID: 1334 at drivers/clk/clk.c:684 clk_core_unprepare+0x13c/0x170
> [  120.043252] eclk-gate already unprepared
> [  120.047283] CPU: 0 PID: 1334 Comm: obmc-ikvm Tainted: G        W         5.0.3-b94b74e8b52db91fe4e99e0bb481ec8bf2b5b47c #1
> [  120.058417] Hardware name: Generic DT based system
> [  120.063219] Backtrace:
> [  120.065787] [<80107cdc>] (dump_backtrace) from [<80107f10>] (show_stack+0x20/0x24)
> [  120.073371]  r7:803a4ff0 r6:00000009 r5:00000000 r4:96197e1c
> [  120.079152] [<80107ef0>] (show_stack) from [<8068f7d8>] (dump_stack+0x20/0x28)
> [  120.086479] [<8068f7b8>] (dump_stack) from [<8011604c>] (__warn.part.3+0xb4/0xdc)
> [  120.094068] [<80115f98>] (__warn.part.3) from [<801160e0>] (warn_slowpath_fmt+0x6c/0x90)
> [  120.102164]  r6:000002ac r5:8080c0b8 r4:80a07008
> [  120.106893] [<80116078>] (warn_slowpath_fmt) from [<803a4ff0>] (clk_core_unprepare+0x13c/0x170)
> [  120.115686]  r3:8080cf8c r2:8080c17c
> [  120.119276]  r7:97d68e58 r6:9df23200 r5:9668c260 r4:96459260
> [  120.125046] [<803a4eb4>] (clk_core_unprepare) from [<803a707c>] (clk_unprepare+0x34/0x3c)
> [  120.133226]  r5:9668c260 r4:96459260
> [  120.136932] [<803a7048>] (clk_unprepare) from [<804f34bc>] (aspeed_video_off+0x44/0x48)
> [  120.145031]  r5:9668c260 r4:9668cbc0
> [  120.148647] [<804f3478>] (aspeed_video_off) from [<804f3fd0>] (aspeed_video_release+0x94/0x118)
> [  120.157435]  r5:966a0cb8 r4:966a0800
> [  120.161049] [<804f3f3c>] (aspeed_video_release) from [<804d2c58>] (v4l2_release+0xd4/0xe8)
> [  120.169404]  r7:97d68e58 r6:9d087810 r5:9df23200 r4:966a0b20
> [  120.175168] [<804d2b84>] (v4l2_release) from [<80236224>] (__fput+0x98/0x1c4)
> [  120.182316]  r5:96698e78 r4:9df23200
> [  120.185994] [<8023618c>] (__fput) from [<802363b8>] (____fput+0x18/0x1c)
> [  120.192712]  r9:80a0700c r8:801011e4 r7:00000000 r6:80a64bbc r5:961dd560 r4:961dd89c
> [  120.200562] [<802363a0>] (____fput) from [<80131c08>] (task_work_run+0x7c/0xa4)
> [  120.207994] [<80131b8c>] (task_work_run) from [<80106884>] (do_work_pending+0x4a8/0x578)
> [  120.216163]  r7:801011e4 r6:80a07008 r5:96197fb0 r4:ffffe000
> [  120.221856] [<801063dc>] (do_work_pending) from [<8010106c>] (slow_work_pending+0xc/0x20)
> [  120.230116] Exception stack(0x96197fb0 to 0x96197ff8)
> [  120.235254] 7fa0:                                     00000000 76ccf094 00000000 00000000
> [  120.243438] 7fc0: 00000008 00a11978 7eab3c30 00000006 00000000 00000000 475b0fa4 00000000
> [  120.251692] 7fe0: 00000002 7eab3a40 00000000 47720e38 80000010 00000008
> [  120.258396]  r10:00000000 r9:96196000 r8:801011e4 r7:00000006 r6:7eab3c30 r5:00a11978
> [  120.266291]  r4:00000008
>
> To prevent this issue, this commit adds spinlock protection and clock
> status checking logic into the Aspeed video engine driver.

Thanks Jae. Do you have a reliable way to reproduce this? Haven't seen 
it myself.

>
> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Eddie James <eajames@linux.ibm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> ---
>   drivers/media/platform/aspeed-video.c | 46 ++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 692e08ef38c0..9663ba4281a8 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -227,6 +227,7 @@ struct aspeed_video {
>   	struct list_head buffers;
>   	unsigned long flags;
>   	unsigned int sequence;
> +	bool is_video_on;

This can probably be a flag, like VIDEO_CLOCKS_ON, not a new boolean.

>   
>   	unsigned int max_compressed_size;
>   	struct aspeed_video_addr srcs[2];
> @@ -495,20 +496,28 @@ static void aspeed_video_reset(struct aspeed_video *video)
>   
>   static void aspeed_video_off(struct aspeed_video *video)
>   {
> -	aspeed_video_reset(video);
> +	if (video->is_video_on) {
> +		aspeed_video_reset(video);
I'm working on a patch to remove the use of the reset line too.
> +
> +		/* Turn off the relevant clocks */
> +		clk_disable_unprepare(video->vclk);
> +		clk_disable_unprepare(video->eclk);
>   
> -	/* Turn off the relevant clocks */
> -	clk_disable_unprepare(video->vclk);
> -	clk_disable_unprepare(video->eclk);
> +		video->is_video_on = false;
> +	}
>   }
>   
>   static void aspeed_video_on(struct aspeed_video *video)
>   {
> -	/* Turn on the relevant clocks */
> -	clk_prepare_enable(video->eclk);
> -	clk_prepare_enable(video->vclk);
> +	if (!video->is_video_on) {
> +		/* Turn on the relevant clocks */
> +		clk_prepare_enable(video->eclk);
> +		clk_prepare_enable(video->vclk);
> +
> +		aspeed_video_reset(video);
>   
> -	aspeed_video_reset(video);
> +		video->is_video_on = true;
> +	}
>   }
>   
>   static void aspeed_video_bufs_done(struct aspeed_video *video,
> @@ -526,12 +535,14 @@ static void aspeed_video_bufs_done(struct aspeed_video *video,
>   
>   static void aspeed_video_irq_res_change(struct aspeed_video *video)
>   {
> +	spin_lock(&video->lock);

Is there a reason you're locking extra code? Why not put the lock in the 
aspeed_video_on/off functions?

>   	dev_dbg(video->dev, "Resolution changed; resetting\n");
>   
>   	set_bit(VIDEO_RES_CHANGE, &video->flags);
>   	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
>   
>   	aspeed_video_off(video);
> +	spin_unlock(&video->lock);
>   	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>   
>   	schedule_delayed_work(&video->res_work, RESOLUTION_CHANGE_DELAY);
> @@ -951,9 +962,13 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>   
>   static void aspeed_video_start(struct aspeed_video *video)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&video->lock, flags);
>   	aspeed_video_on(video);
>   
>   	aspeed_video_init_regs(video);
> +	spin_unlock_irqrestore(&video->lock, flags);
>   
>   	/* Resolution set to 640x480 if no signal found */
>   	aspeed_video_get_resolution(video);
> @@ -969,6 +984,9 @@ static void aspeed_video_start(struct aspeed_video *video)
>   
>   static void aspeed_video_stop(struct aspeed_video *video)
>   {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&video->lock, flags);
>   	set_bit(VIDEO_STOPPED, &video->flags);
>   	cancel_delayed_work_sync(&video->res_work);
>   
> @@ -982,6 +1000,7 @@ static void aspeed_video_stop(struct aspeed_video *video)
>   
>   	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
>   	video->flags = 0;
> +	spin_unlock_irqrestore(&video->lock, flags);
>   }
>   
>   static int aspeed_video_querycap(struct file *file, void *fh,
> @@ -1319,16 +1338,21 @@ static void aspeed_video_resolution_work(struct work_struct *work)
>   	struct delayed_work *dwork = to_delayed_work(work);
>   	struct aspeed_video *video = container_of(dwork, struct aspeed_video,
>   						  res_work);
> -	u32 input_status = video->v4l2_input_status;
> +	unsigned long flags;
> +	u32 input_status;
>   
> +	spin_lock_irqsave(&video->lock, flags);
> +	input_status = video->v4l2_input_status;
>   	aspeed_video_on(video);
>   
>   	/* Exit early in case no clients remain */
> -	if (test_bit(VIDEO_STOPPED, &video->flags))
> +	if (test_bit(VIDEO_STOPPED, &video->flags)) {
> +		spin_unlock_irqrestore(&video->lock, flags);
>   		goto done;
> +	}
>   
>   	aspeed_video_init_regs(video);
> -
> +	spin_unlock_irqrestore(&video->lock, flags);
>   	aspeed_video_get_resolution(video);
>   
>   	if (video->detected_timings.width != video->active_timings.width ||

