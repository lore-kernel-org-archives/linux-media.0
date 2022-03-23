Return-Path: <linux-media-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC2C433F5
	for <linux-media@archiver.kernel.org>; Wed, 23 Mar 2022 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiCWPhB (ORCPT <rfc822;linux-media@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiCWPhA (ORCPT
        <rfc822;linux-media@vger.kernel.org>);
        Wed, 23 Mar 2022 11:37:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AC6245;
        Wed, 23 Mar 2022 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648049730; x=1679585730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ylqztKKbbywsbskWbNL8sKbu7OUZS/bD/0ueK0z8ruU=;
  b=eqYX1JWiBAXUGB5VTNPPStZx1KnwYkxRR0eFzY8Nbpohek8MGLUzylNu
   lNlGGFeWwlSLinBWL7+9Upvm1gnUvVAOqRlXLesoxkiqPYAUzhSfrP0Yz
   FfCoabbeOji1rff06KlH19l3TBNlxJfsx45qLBDuyd++D2lLlQ3iwYQwI
   hTECHJi+r5aJnqPs07X7Lv6SydVXuJJ/FtNK2HXB8ZQimpiYpyDI5qyrI
   gLrjCMP/HyYExkWYkm4kH51Llm/J4C3L2YmL7CZ0EalfnkQir1NBEQPdO
   5GP0Fz+b30tgBAasoB9IEUMWixHvxhLQDZ63A2qREk0j3vc36tiNI/o04
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240299177"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="240299177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="692981159"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:35:27 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 81022204A8;
        Wed, 23 Mar 2022 17:35:25 +0200 (EET)
Date:   Wed, 23 Mar 2022 17:35:25 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Convert Dongwoon dw9807-vcm bindings to
 json-schema
Message-ID: <Yjs+PUKLqJI05NfP@paasikivi.fi.intel.com>
References: <20220318165119.12191-1-sakari.ailus@linux.intel.com>
 <20220318165119.12191-2-sakari.ailus@linux.intel.com>
 <035a1501-4a40-2f1a-2220-1a35a4419876@kernel.org>
 <Yjs0jjNMeqVl2HPj@paasikivi.fi.intel.com>
 <eac26181-3e59-f915-e310-4b1679b416cd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac26181-3e59-f915-e310-4b1679b416cd@kernel.org>
Precedence: bulk
List-ID: <linux-media.vger.kernel.org>
X-Mailing-List: linux-media@vger.kernel.org

On Wed, Mar 23, 2022 at 03:55:50PM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2022 15:54, Sakari Ailus wrote:
> > Hi Krzysztof,
> > 
> > On Sun, Mar 20, 2022 at 12:56:48PM +0100, Krzysztof Kozlowski wrote:
> >> On 18/03/2022 17:51, Sakari Ailus wrote:
> >>> +$id: http://devicetree.org/schemas/media/i2c/dongwoon,dw9807-vcm.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Dongwoon Anatech DW9807 voice coil lens driver
> >>> +
> >>> +maintainers:
> >>> +  - Sakari Ailus <sakari.ailus@linux.intel.com>
> >>> +
> >>> +description: |
> >>> +  DW9807 is a 10-bit DAC with current sink capability. It is intended for
> >>> +  controlling voice coil lenses.
> >>> +
> >>> +properties:
> >>> +
> >>
> >> No blank line.
> >>
> >>> +  compatible:
> >>> +    const: "dongwoon,dw9807-vcm"
> >>
> >> No quotes.
> > 
> > Hmm. Strings generally need to be quoted, including the compatible
> > strings.
> 
> No, not in dtschema. Almost none of strings are ever quoted. If you need
> reference - you example-schema.yaml.

Good point. I suppose it's because YAML doesn't require that.

I'll drop the quotes in v2.

-- 
Sakari Ailus
