Return-Path: <SRS0=ExWS=S5=vger.kernel.org=linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD2C43218
	for <linux-media@archiver.kernel.org>; Sat, 27 Apr 2019 05:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AFE208C2
	for <linux-media@archiver.kernel.org>; Sat, 27 Apr 2019 05:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD0F5l (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Sat, 27 Apr 2019 01:57:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:48504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfD0F5k (ORCPT <rfc822;linux-media@vger.kernel.org>);
        Sat, 27 Apr 2019 01:57:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 22:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,400,1549958400"; 
   d="gz'50?scan'50,208,50";a="165526278"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Apr 2019 22:57:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hKGKv-0007hW-41; Sat, 27 Apr 2019 13:57:21 +0800
Date:   Sat, 27 Apr 2019 13:56:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     kbuild-all@01.org, linux-media@vger.kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, helen.koike@collabora.com,
        kernel@collabora.com, lucmaga@gmail.com,
        lkcamp@lists.libreplanetbr.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH v4 04/14] media: Move sp2mp functions to v4l2-common
Message-ID: <201904271342.jXkqLyC6%lkp@intel.com>
References: <20190426012223.17826-5-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426012223.17826-5-andrealmeid@collabora.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-media-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "André,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on next-20190426]
[cannot apply to v5.1-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andr-Almeida/media-vimc-Add-support-for-multiplanar-formats/20190427-091644
base:   git://linuxtv.org/media_tree.git master
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:374: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:375: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:866: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3105: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:375: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj_lock' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/scheduler/sched_main.c:376: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:377: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:420: warning: Function parameter or member 'full_recovery' not described in 'drm_sched_start'
   drivers/gpu/drm/i915/i915_vma.h:50: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'hw_id' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'max_active_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'supported_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:142: warning: Function parameter or member 'output_port' not described in 'komeda_component_output'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'component' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'crtc' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'plane' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'wb_conn' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'changed_active_inputs' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'affected_inputs' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_layers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'layers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'n_scalers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'scalers' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'compiz' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'wb_layer' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'improc' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'ctrlr' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:300: warning: Function parameter or member 'funcs' not described in 'komeda_pipeline'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:321: warning: Function parameter or member 'pipe' not described in 'komeda_pipeline_state'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'dev' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'reg_base' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'chip' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'mclk' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'n_pipelines' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_dev.h:97: warning: Function parameter or member 'pipelines' not described in 'komeda_dev'
   drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_plane.c:1: warning: no structured comments found
   include/linux/interconnect.h:1: warning: no structured comments found
>> include/media/v4l2-common.h:439: warning: Function parameter or member 'v4l2_fmtfunc' not described in 'int'
   include/media/v4l2-common.h:439: warning: Excess function parameter 'file' description in 'int'
   include/media/v4l2-common.h:439: warning: Excess function parameter 'priv' description in 'int'
   include/media/v4l2-common.h:439: warning: Excess function parameter 'f' description in 'int'
   include/linux/skbuff.h:899: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:899: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:513: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:513: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2064: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'task_setioprio' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'task_getioprio' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'task_movememory' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'secmark_refcount_inc' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1802: warning: Function parameter or member 'secmark_refcount_dec' not described in 'security_list_options'
   Documentation/core-api/index.rst:11: WARNING: toctree contains reference to nonexisting document u'core-api/flexible-arrays'
   include/linux/list.h:211: WARNING: Inline strong start-string without end-string.
   include/linux/xarray.h:232: ERROR: Unexpected indentation.
   include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:113: ERROR: Unexpected indentation.
   include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1120: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:346: WARNING: Inline literal start-string without end-string.
   include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
   drivers/ata/libata-core.c:5960: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1958: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/mtd/rawnand.h:1184: WARNING: Inline strong start-string without end-string.
   include/linux/mtd/rawnand.h:1186: WARNING: Inline strong start-string without end-string.
   include/linux/regulator/driver.h:289: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   Documentation/driver-api/soundwire/locking.rst:50: ERROR: Inconsistent literal block quoting.
   Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
   Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
   Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
   include/linux/spi/spi.h:376: ERROR: Unexpected indentation.
   fs/posix_acl.c:635: WARNING: Inline emphasis start-string without end-string.
   fs/debugfs/inode.c:386: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:465: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:497: WARNING: Inline literal start-string without end-string.
   fs/debugfs/inode.c:584: WARNING: Inline literal start-string without end-string.
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1856: WARNING: Inline emphasis start-string without end-string.
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1858: WARNING: Inline emphasis start-string without end-string.
   Documentation/networking/af_xdp.rst:319: WARNING: Literal block expected; none found.
   Documentation/networking/af_xdp.rst:326: WARNING: Literal block expected; none found.
   Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:43: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:63: ERROR: Unexpected indentation.

vim +439 include/media/v4l2-common.h

   422	
   423	int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, int pixelformat,
   424			     int width, int height);
   425	int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt, int pixelformat,
   426				int width, int height);
   427	
   428	/**
   429	 * v4l2_fmtfunc - function pointer for v4l2_fmt_sp2mp()
   430	 *
   431	 * @file: device's descriptor file
   432	 * @priv: private data pointer
   433	 * @f: format that holds a mp pixel format
   434	 *
   435	 * Function type used by v4l2_fmt_sp2mp_func(). Please, see v4l2_fmt_sp2mp_func
   436	 * for more details.
   437	 */
   438	typedef int (*v4l2_fmtfunc)(struct file *file, void *priv,
 > 439				    struct v4l2_format *f);
   440	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--fdj2RfSjLxBAspz7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--fdj2RfSjLxBAspz7--
