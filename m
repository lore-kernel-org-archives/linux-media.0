Return-Path: <SRS0=swNA=SK=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E74C282CE
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2620883
	for <linux-media@archiver.kernel.org>; Mon,  8 Apr 2019 06:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfDHG27 (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:28:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:58673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfDHG26 (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Mon, 8 Apr 2019 02:28:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 23:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="159642887"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.171]) ([10.238.232.171])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2019 23:28:54 -0700
Subject: Re: [PATCH v7 00/16] Intel IPU3 ImgU patchset
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Hu, Jerry W" <jerry.w.hu@intel.com>,
        "Toivonen, Tuukka" <tuukka.toivonen@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        libcamera-devel@lists.libcamera.org
References: <1540851790-1777-1-git-send-email-yong.zhi@intel.com>
 <1609628.n3aCoxV5Mp@avalon>
 <b7380656-13bd-884d-366f-87d690090be8@linux.intel.com>
 <4147983.Vfm2iTi9Nh@avalon>
 <c7578347-c1ac-664c-4407-40b968daf377@linux.intel.com>
 <20190323130221.xr4bvraqnfjdfezk@uno.localdomain>
 <ad0fa0d9-b89b-1c6e-9085-fe361832e9e1@linux.intel.com>
 <20190325040630.GE12029@pendragon.ideasonboard.com>
 <20190325081105.njjpvvlj6n5rxnsb@uno.localdomain>
 <83e79e5a-6503-51a6-2c45-0fbd1cbfbdaa@linux.intel.com>
 <20190326111628.5hninfqhtxpxqqu4@uno.localdomain>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <56288a5b-a6d5-2529-0ef5-c5e65d5c557c@linux.intel.com>
Date:   Mon, 8 Apr 2019 14:35:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326111628.5hninfqhtxpxqqu4@uno.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org



On 3/26/19 7:16 PM, Jacopo Mondi wrote:
> Hi Bingbu,
> 
> On Mon, Mar 25, 2019 at 06:07:58PM +0800, Bingbu Cao wrote:
>>
>>
>> On 3/25/19 4:11 PM, Jacopo Mondi wrote:
>>> Hi Laurent, Bingbu
>>>
>>> On Mon, Mar 25, 2019 at 06:06:30AM +0200, Laurent Pinchart wrote:
>>>> Hi Bingbu,
>>>>
>>> [snip]
>>>
>>>>>>>>>>
>>>>>>>>>> Thank you for the information. This will need to be captured in the
>>>>>>>>>> documentation, along with information related to how each block in the
>>>>>>>>>> hardware pipeline interacts with the image size. It should be possible for
>>>>>>>>>> a developer to compute the output and viewfinder resolutions based on the
>>>>>>>>>> parameters of the image processing algorithms just with the information
>>>>>>>>>> contained in the driver documentation.
>>>>>>
>>>>>> In libcamera development we're now at the point of having to calculate
>>>>>> the sizes to apply to all intermediate pipeline stages based on the
>>>>>> following informations:
>>>>>>
>>>>>> 1) Main output resolution
>>>>>> 2) Secondary output resolution (optional)
>>>>>> 3) Image sensor's available resolutions
>>>>>>
>>>>>> Right now that informations are captured in the xml file you linked
>>>>>> here above, but we need a programmatic way to do the calculation,
>>>>>> without going through an XML file, that refers to two specific sensors
>>>>>> only.
>>>>>>
>>>>>> As Laurent said here, this should come as part of the documentation
>>>>>> for driver users and would unblock libcamera IPU3 support
>>>>>> development.
>>>>>>
>>>>>> Could you provide documentation on how to calculate each
>>>>>> intermediate step resolutions?
>>>>>
>>>>> All the intermediate step resolutions are generated by the specific tool
>>>>> with sensor input and outputs resolutions.
>>>>>
>>>>> The tool try to keep maximum fov and has the knowledge of all the
>>>>> limitations of each intermediate hardware components(mainly BDS and GDC).
>>>>
>>>> That's exactly what we want to do in software in libcamera :-) And
>>>> that's why we need more infirmation about the limitations of each
>>>> intermediate hardware component. Eventually those limitations should be
>>>> documented in the IPU3 driver documentation in the kernel sources, but
>>>> for now we can move forward if they're just communicated by e-mail (if
>>>> time permits we may be able to submit a kernel patch to integrate that
>>>> in the documentation).
>>>>
>>>>> Currently, there is not a very simple calculation to get the
>>>>> intermediate resolutions.
>>>>> Let's take some effort to try find a programmatic way to do calculation
>>>>> instead of the tool.
>>>
>>> Thank you for your effort.
>>>
>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>>>>>>>>> 3. The ImgU V4L2 subdev composing should be set by using the
>>>>>>>>>>>>>> VIDIOC_SUBDEV_S_SELECTION on pad 0, with V4L2_SEL_TGT_COMPOSE as the
>>>>>>>>>>>>>> target, using the BDS height and width.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Once these 2 steps are done, the raw bayer frames can be input to the
>>>>>>>>>>>>>> ImgU V4L2 subdev for processing.
>>>>>>>>>>>>> Do I need to capture from both the output and viewfinder nodes ? How
>>>>>>>>>>>>> are they related to the IF -> BDS -> GDC pipeline, are they both fed
>>>>>>>>>>>>> from the GDC output ? If so, how does the viewfinder scaler fit in that
>>>>>>>>>>>>> picture ?
>>>>>>>>>>> The output capture should be set, the viewfinder can be disabled.
>>>>>>>>>>> The IF and BDS are seen as crop and compose of the imgu input video
>>>>>>>>>>> device. The GDC is seen as the subdev sink pad and OUTPUT/VF are source
>>>>>>>>>>> pads.
>>>>>>
>>>>>> This is another point that we would like to have clarified:
>>>>>> 1) which outputs are mandatory and which one are not
>>>>>> 2) which operations are mandatory on un-used outputs
>>>>>> 3) does the 'ipu_pipe_mode' control impact this
>>>>>>
>>>>>> As you mentioned here, "output" seems to be mandatory, while
>>>>>> "viewfinder" and "stat" are optional. We have tried using the "output"
>>>>>> video node only but the system hangs to an un-recoverable state.
>>>>>
>>>>> Yes, main output is mandatory, 'vf' and 'stat' are optional.
>>>>
>>>> I will let Jacopo confirm this, but unless I'm mistaken, when he tried
>>>> to use the main output only (with the links between the ImgU subdev and
>>>> the vf and stat video nodes disabled), the driver would hang without
>>>> processing any frame. I believe this was a complete system hang,
>>>> requiring a hard reboot to recover.
>>>>
>>>
>>> Yes, that's what I have noticed.
>>>
>>> On the other hand, if I link, configure, prepare buffers and start the
>>> 'vf' and 'stat' nodes, but never queue buffers there, I can capture
>>> from output only.
>>>
>>>>>> What I have noticed is instead that the viewfinder and stat nodes
>>>>>> needs to be:
>>>>>> 1) Linked to the respective "ImgU" subdevice pads
>>>>>> 2) Format configured
>>>>>> 3) Memory reserved
>>>>>> 4) video device nodes started
>>>>>>
>>>>>> It it not required to queue/dequeue buffers from viewfinder and stat,
>>>>>> but steps 1-4 have to be performed.
>>>>>>
>>>>>> Can you confirm this is intended?
>>>>>
>>>>> viewfinder and stats are enabled when the link for respective subdev
>>>>> pads enabled, and then driver can use these input conditions to find the
>>>>> binary to run.
>>>>>
>>>
>>> As Laurent reported above, if I leave the the 'vf' and 'stat' links
>>> disabled, the system hangs.
>>>
>>>>>> Could you please list all the steps that have to be applied to the
>>>>>> ImgU's capture video nodes, and which ones are mandatory and which ones
>>>>>> are optional, for the following use cases:
>>>>>> 1) Main output capture only
>>>>>> 2) Main + secondary output capture
>>>>>> 3) Secondary capture only.
>>>>>
>>>>> I think the 3) is not supported.
>>>>>
>>>>> The steps are:
>>>>> 1). link necessary the respective subdevices
>>>>> input --> imgu -->output
>>>>>             |  -->vf
>>>>>             |  -->3a stats
>>>
>>> For which use case, in the above reported list?
>>>
>>>  1) Main output capture only
>>>         Does 'vf' and 'stat' links needs to be enabled?
>>>
>>>  2) Main + secondary output capture
>>>         Does 'stat' link need to be enabled?
>>>
>>>  3) Secondary capture only.
>>>         not supported
>>
>> The list above is a typical use, all outputs enabled, you can setup link
>> for main output only.
> 
> I think we should clarify better what you mean by 'enabled'.
> 
> From my testing what I see is that in order to operate the main
> output I have to:
> - link the stat and vf nodes (as well as input and output of course)
> - reserve memory buffers on stat and vf video nodes, even if not used
> - set format on all device ndoes
> - start the all video devices
> 
> If one of these steps is not performed, the ImgU processing stalls and
> I need to hard reboot the device to have it operational again.
> 
> On the other hand, I see that there is no need to queue any buffer to
> any of the output capture devices to have frames processed by the
> ImgU.
> 
> IF links are setup as explained above, format configured and all the video
> device node started, I can queue all the frames I want to the ImgU input
> and never queue anything on its outputs, and they will get processed and
> returned to userspace nicely from the ImgU input device node. As soon
> as I queue a buffer to the ImgU main output video device, I see it
> returned filled with the processed data. This is good, as it doesen't
> stall the pipeline if there are no capture buffers to queue to the
> ImgU output, but now I wonder what you meant with "main output is
> mandatory"
Hi, Mondi

Sorry for late response.

I think you do not need setup link for vf and stat if you did not need
them. If you try setup link (enable) some queues (not input) and not
queue the buffers, driver will queue some dummy buffers to make the pipe
run.

It needs time for me to check all the cases and try to answer you. I am
a little busy on other work items recently, so forgive me late response
for your questions.

> 
>>>
>>>>>
>>>>> 2). set all the formats for input, output and intermediate resolutions.
>>>>> 3). start stream
>>>>>
>>>>> The ipu pipe_mode will not impact the whole pipe behavior. It just ask
>>>>> firmware to run different processing to generate same format outputs.
>>>>
>>>
>>> I would apreciate to have a better description of the pipe_mode
>>> control, in order to better understand when and if the library has to
>>> modify its value and which mode to use (0=video, 1=still_capture).
>>
>> In some application, it will request continuous viewfinder, that means
>> you must keep preview continuous when take capture. That means you can
>> not switch out pipeline (preview and still mode, back and force), so the
>> driver need create 2 pipelines to satisfy this usage, 1 video mode pipe
>> and another is still mode. Both 2 pipes are created at first, run the
>> pipe as you command. It also can support still during video usage.
>>
> 
> Thanks for the explanation, but it is still vague to me and it worries
> me a bit as in this typical usage scenario (viewfinder + sporadic
> capture) -both- ImgU pipes have to be used, preventing usage of two
> cameras at the same time (one camera assigned to one ImgU pipe
> instance).
> 
> Why would you use both the ImgU pipes in this case? Shouldn't you
> always capture from viewfinder (discarding main output frames
> if not required), and when requested by the application capture from
> both the main and secondary output from the same ImgU pipe? Why would I
> need to change the pipe_mode for doing this?
Each pipe has its own pipe_mode and outputs.
So you can run 2 parallel pipes with different pipe mode, different pipe
modes mean to run different pipe in firmware, typically, 1 is still pipe
which used to capture and 1 is video pipe which used for video or
preview. You can only enable the main output for still pipe, enable
viewfinder and main for video pipe, viewfinder for video preview and
main for video recording. It depends on the real use case and they are
not fixed.

> 
> Thank for your patience to answer all this questions :)
> 
> 
>>>
>>> Thanks
>>>    j
>>>
>>>> --
>>>> Regards,
>>>>
>>>> Laurent Pinchart
