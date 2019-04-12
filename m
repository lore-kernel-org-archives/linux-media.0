Return-Path: <SRS0=qnBx=SO=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62851C10F0E
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3BE2186A
	for <linux-media@archiver.kernel.org>; Fri, 12 Apr 2019 14:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLOdj (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:33:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfDLOdj (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Fri, 12 Apr 2019 10:33:39 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CEXZnO145936
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 10:33:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtuydsnws-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-media@vger.kernel.org>; Fri, 12 Apr 2019 10:33:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-media@vger.kernel.org> from <eajames@linux.ibm.com>;
        Fri, 12 Apr 2019 15:33:36 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 15:33:32 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CEXV2q33751194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 14:33:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0F7128058;
        Fri, 12 Apr 2019 14:33:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ACBB28059;
        Fri, 12 Apr 2019 14:33:31 +0000 (GMT)
Received: from [9.80.204.35] (unknown [9.80.204.35])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 14:33:30 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v2] media: platform: fix a kernel warning on clk control
To:     "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
References: <20190329212710.5378-1-jae.hyun.yoo@linux.intel.com>
 <09113211-ef61-2168-cf78-37c76f21edba@xs4all.nl>
 <9aa895a5184ddd30eb5750e4ec223fd5a5df4a54.camel@amazon.com>
Date:   Fri, 12 Apr 2019 09:33:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9aa895a5184ddd30eb5750e4ec223fd5a5df4a54.camel@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19041214-2213-0000-0000-0000037626AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010914; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01188044; UDB=6.00622356; IPR=6.00968811;
 MB=3.00026410; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 14:33:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041214-2214-0000-0000-00005DFFFAD9
Message-Id: <e8b18722-7ced-54ec-3a0a-4d8170eca0d4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120096
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


On 4/12/19 7:17 AM, Herrenschmidt, Benjamin wrote:
> On Fri, 2019-04-12 at 13:00 +0200, Hans Verkuil wrote:
>> Eddie, can you review this?


Yes, this looks good.

Thanks,

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>>
>> Jae Hyun Yoo, for future reference: please add the driver name in the
>> subject.
>> I.e. something like this: [PATCH v2] media: aspeed: fix a kernel
>> warning on clk control
>>
>> That helps maintainers figuring out who should look at which patch.
> test_bit/clear_bit/set_bit are atomic. The way they are used here is
> either a waste of cycles (there's already a lock) or racy. Not too sure


Yes, it's conceivable that this could be done locklessly, but I'm fine 
with being cautious. I asked Jae to use the bit functions and flag for 
code cleanliness instead of an additional bool... are the additional 
cycles that bad here?


> :)
>
> Cheers,
> Ben.
>
>> Regards,
>>
>> 	Hans
>>
>> On 3/29/19 10:27 PM, Jae Hyun Yoo wrote:
>>> video_on and video_off functions in the Aspeed video engine driver
>>> are
>>> being called from multiple contexts without any protection so video
>>> clocks
>>> can be disabled twice and eventually it causes a kernel warning
>>> with stack
>>> dump printing out like below:
>>>
>>> [  120.034729] WARNING: CPU: 0 PID: 1334 at drivers/clk/clk.c:684
>>> clk_core_unprepare+0x13c/0x170
>>> [  120.043252] eclk-gate already unprepared
>>> [  120.047283] CPU: 0 PID: 1334 Comm: obmc-ikvm Tainted:
>>> G        W         5.0.3-b94b74e8b52db91fe4e99e0bb481ec8bf2b5b47c
>>> #1
>>> [  120.058417] Hardware name: Generic DT based system
>>> [  120.063219] Backtrace:
>>> [  120.065787] [<80107cdc>] (dump_backtrace) from [<80107f10>]
>>> (show_stack+0x20/0x24)
>>> [  120.073371]  r7:803a4ff0 r6:00000009 r5:00000000 r4:96197e1c
>>> [  120.079152] [<80107ef0>] (show_stack) from [<8068f7d8>]
>>> (dump_stack+0x20/0x28)
>>> [  120.086479] [<8068f7b8>] (dump_stack) from [<8011604c>]
>>> (__warn.part.3+0xb4/0xdc)
>>> [  120.094068] [<80115f98>] (__warn.part.3) from [<801160e0>]
>>> (warn_slowpath_fmt+0x6c/0x90)
>>> [  120.102164]  r6:000002ac r5:8080c0b8 r4:80a07008
>>> [  120.106893] [<80116078>] (warn_slowpath_fmt) from [<803a4ff0>]
>>> (clk_core_unprepare+0x13c/0x170)
>>> [  120.115686]  r3:8080cf8c r2:8080c17c
>>> [  120.119276]  r7:97d68e58 r6:9df23200 r5:9668c260 r4:96459260
>>> [  120.125046] [<803a4eb4>] (clk_core_unprepare) from [<803a707c>]
>>> (clk_unprepare+0x34/0x3c)
>>> [  120.133226]  r5:9668c260 r4:96459260
>>> [  120.136932] [<803a7048>] (clk_unprepare) from [<804f34bc>]
>>> (aspeed_video_off+0x44/0x48)
>>> [  120.145031]  r5:9668c260 r4:9668cbc0
>>> [  120.148647] [<804f3478>] (aspeed_video_off) from [<804f3fd0>]
>>> (aspeed_video_release+0x94/0x118)
>>> [  120.157435]  r5:966a0cb8 r4:966a0800
>>> [  120.161049] [<804f3f3c>] (aspeed_video_release) from
>>> [<804d2c58>] (v4l2_release+0xd4/0xe8)
>>> [  120.169404]  r7:97d68e58 r6:9d087810 r5:9df23200 r4:966a0b20
>>> [  120.175168] [<804d2b84>] (v4l2_release) from [<80236224>]
>>> (__fput+0x98/0x1c4)
>>> [  120.182316]  r5:96698e78 r4:9df23200
>>> [  120.185994] [<8023618c>] (__fput) from [<802363b8>]
>>> (____fput+0x18/0x1c)
>>> [  120.192712]  r9:80a0700c r8:801011e4 r7:00000000 r6:80a64bbc
>>> r5:961dd560 r4:961dd89c
>>> [  120.200562] [<802363a0>] (____fput) from [<80131c08>]
>>> (task_work_run+0x7c/0xa4)
>>> [  120.207994] [<80131b8c>] (task_work_run) from [<80106884>]
>>> (do_work_pending+0x4a8/0x578)
>>> [  120.216163]  r7:801011e4 r6:80a07008 r5:96197fb0 r4:ffffe000
>>> [  120.221856] [<801063dc>] (do_work_pending) from [<8010106c>]
>>> (slow_work_pending+0xc/0x20)
>>> [  120.230116] Exception stack(0x96197fb0 to 0x96197ff8)
>>> [  120.235254] 7fa0:                                     00000000
>>> 76ccf094 00000000 00000000
>>> [  120.243438] 7fc0: 00000008 00a11978 7eab3c30 00000006 00000000
>>> 00000000 475b0fa4 00000000
>>> [  120.251692] 7fe0: 00000002 7eab3a40 00000000 47720e38 80000010
>>> 00000008
>>> [  120.258396]  r10:00000000 r9:96196000 r8:801011e4 r7:00000006
>>> r6:7eab3c30 r5:00a11978
>>> [  120.266291]  r4:00000008
>>>
>>> To prevent this issue, this commit adds spinlock protection and
>>> clock
>>> status checking logic into the Aspeed video engine driver.
>>>
>>> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine
>>> driver")
>>> Signed-off-by: Jae Hyun Yoo<jae.hyun.yoo@linux.intel.com>
>>> Cc: Eddie James<eajames@linux.ibm.com>
>>> Cc: Mauro Carvalho Chehab<mchehab@kernel.org>
>>> Cc: Joel Stanley<joel@jms.id.au>
>>> Cc: Andrew Jeffery<andrew@aj.id.au>
>>> ---
>>>   drivers/media/platform/aspeed-video.c | 32
>>> ++++++++++++++++++++++++---
>>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/aspeed-video.c
>>> b/drivers/media/platform/aspeed-video.c
>>> index 692e08ef38c0..744d22ecc620 100644
>>> --- a/drivers/media/platform/aspeed-video.c
>>> +++ b/drivers/media/platform/aspeed-video.c
>>> @@ -188,6 +188,7 @@ enum {
>>>   	VIDEO_STREAMING,
>>>   	VIDEO_FRAME_INPRG,
>>>   	VIDEO_STOPPED,
>>> +	VIDEO_CLOCKS_ON,
>>>   };
>>>   
>>>   struct aspeed_video_addr {
>>> @@ -495,20 +496,30 @@ static void aspeed_video_reset(struct
>>> aspeed_video *video)
>>>   
>>>   static void aspeed_video_off(struct aspeed_video *video)
>>>   {
>>> +	if (!test_bit(VIDEO_CLOCKS_ON, &video->flags))
>>> +		return;
>>> +
>>>   	aspeed_video_reset(video);
>>>   
>>>   	/* Turn off the relevant clocks */
>>>   	clk_disable_unprepare(video->vclk);
>>>   	clk_disable_unprepare(video->eclk);
>>> +
>>> +	clear_bit(VIDEO_CLOCKS_ON, &video->flags);
>>>   }
>>>   
>>>   static void aspeed_video_on(struct aspeed_video *video)
>>>   {
>>> +	if (test_bit(VIDEO_CLOCKS_ON, &video->flags))
>>> +		return;
>>> +
>>>   	/* Turn on the relevant clocks */
>>>   	clk_prepare_enable(video->eclk);
>>>   	clk_prepare_enable(video->vclk);
>>>   
>>>   	aspeed_video_reset(video);
>>> +
>>> +	set_bit(VIDEO_CLOCKS_ON, &video->flags);
>>>   }
>>>   
>>>   static void aspeed_video_bufs_done(struct aspeed_video *video,
>>> @@ -526,12 +537,14 @@ static void aspeed_video_bufs_done(struct
>>> aspeed_video *video,
>>>   
>>>   static void aspeed_video_irq_res_change(struct aspeed_video
>>> *video)
>>>   {
>>> +	spin_lock(&video->lock);
>>>   	dev_dbg(video->dev, "Resolution changed; resetting\n");
>>>   
>>>   	set_bit(VIDEO_RES_CHANGE, &video->flags);
>>>   	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
>>>   
>>>   	aspeed_video_off(video);
>>> +	spin_unlock(&video->lock);
>>>   	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>>>   
>>>   	schedule_delayed_work(&video->res_work,
>>> RESOLUTION_CHANGE_DELAY);
>>> @@ -951,9 +964,13 @@ static void aspeed_video_init_regs(struct
>>> aspeed_video *video)
>>>   
>>>   static void aspeed_video_start(struct aspeed_video *video)
>>>   {
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&video->lock, flags);
>>>   	aspeed_video_on(video);
>>>   
>>>   	aspeed_video_init_regs(video);
>>> +	spin_unlock_irqrestore(&video->lock, flags);
>>>   
>>>   	/* Resolution set to 640x480 if no signal found */
>>>   	aspeed_video_get_resolution(video);
>>> @@ -969,6 +986,9 @@ static void aspeed_video_start(struct
>>> aspeed_video *video)
>>>   
>>>   static void aspeed_video_stop(struct aspeed_video *video)
>>>   {
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&video->lock, flags);
>>>   	set_bit(VIDEO_STOPPED, &video->flags);
>>>   	cancel_delayed_work_sync(&video->res_work);
>>>   
>>> @@ -982,6 +1002,7 @@ static void aspeed_video_stop(struct
>>> aspeed_video *video)
>>>   
>>>   	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
>>>   	video->flags = 0;
>>> +	spin_unlock_irqrestore(&video->lock, flags);
>>>   }
>>>   
>>>   static int aspeed_video_querycap(struct file *file, void *fh,
>>> @@ -1319,16 +1340,21 @@ static void
>>> aspeed_video_resolution_work(struct work_struct *work)
>>>   	struct delayed_work *dwork = to_delayed_work(work);
>>>   	struct aspeed_video *video = container_of(dwork, struct
>>> aspeed_video,
>>>   						  res_work);
>>> -	u32 input_status = video->v4l2_input_status;
>>> +	unsigned long flags;
>>> +	u32 input_status;
>>>   
>>> +	spin_lock_irqsave(&video->lock, flags);
>>> +	input_status = video->v4l2_input_status;
>>>   	aspeed_video_on(video);
>>>   
>>>   	/* Exit early in case no clients remain */
>>> -	if (test_bit(VIDEO_STOPPED, &video->flags))
>>> +	if (test_bit(VIDEO_STOPPED, &video->flags)) {
>>> +		spin_unlock_irqrestore(&video->lock, flags);
>>>   		goto done;
>>> +	}
>>>   
>>>   	aspeed_video_init_regs(video);
>>> -
>>> +	spin_unlock_irqrestore(&video->lock, flags);
>>>   	aspeed_video_get_resolution(video);
>>>   
>>>   	if (video->detected_timings.width != video-
>>>> active_timings.width ||

