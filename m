Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7B30AD0A;
	Mon,  2 Feb 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023435; cv=none; b=BAvrZmzrD/aZE3qN/D6wFqkhkquKf5Oid9qTcWwMZYP5eamjPM8LC1sx6PYbNB376HjnUp5HttLFc6faUZL5tKbBHVG+E4V4fMuAPezw5f5Qo98678cn5I3qdhtm11VjFzPWk2FYemSuPASpR/OTCcALsP1AlR1qGPM79so2SFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023435; c=relaxed/simple;
	bh=HFahzBvI4s0DLBvDSXtqrGpTlXPH052EoDAjWuSau2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBm4wDkh688DnBGinXFM4qtVFyJbgJPN5djVWKjrPnK9t4ct4wnHaXYiBdpBG/Ss5iIOMj71HDORMr+9pPsPKjcJbzLJj1U19nBuiFZbJ3fsDa6HygyZJDG2oNrkWZ4CqT7fGEEjIShDxMzduGoJ7j3jBewgY11UzKs+4U1Squo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9hpKDUS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9hpKDUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770023433; x=1801559433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HFahzBvI4s0DLBvDSXtqrGpTlXPH052EoDAjWuSau2o=;
  b=W9hpKDUSKw5x+suGE/X55OTM8YRloZRl5rQH5rCuEsrQpVOumRl41fo1
   w07lVuAgNbh0BLczZhHFAVoyDNj1G2tisZVpuk/ytRi0J6DMFzSUKroUv
   E5VbeUYt9Yq3PK9/dxqW74OCqY8wPCtcIcOI5m7q1lGmaToLyCwLSv8av
   bT1FawoxydlL5hNnIFhgcIBvwytOLG9lSNQpK3IAASdbyNZnrXa+IasI9
   Nv/dIRjmIT5H3G2CPX8Q33U1vCXS9j68jIPIZ7BEmMXrfbkyB+v1+gj+f
   yzYGEyEakN3OHemN6yYf0Cvt9cZKsn0i9htPA8B6QFUoZ+iPpSC++vKSk
   A==;
X-CSE-ConnectionGUID: sw9riG9lQPi7fEO8o4iUBQ==
X-CSE-MsgGUID: 14PEuVIFTxmGvLKOHqyzJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71262301"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="71262301"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 01:10:32 -0800
X-CSE-ConnectionGUID: 20o+JmtbT9yYGFtuhJT1Dg==
X-CSE-MsgGUID: MCqPE8SERUy5Ko7xZn8umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209540225"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.172])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 01:10:29 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 125CE121D5E;
	Mon, 02 Feb 2026 11:10:38 +0200 (EET)
Date: Mon, 2 Feb 2026 11:10:38 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	sultan@kerneltoast.com, pratap.nirujogi@amd.com,
	benjamin.chan@amd.com, king.li@amd.com, gjorgji.rosikopulos@amd.com,
	Phil.Jawich@amd.com, Dominic.Antony@amd.com,
	mario.limonciello@amd.com, richard.gong@amd.com, anson.tsao@amd.com,
	Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH v7 3/7] media: platform: amd: Add isp4 fw and hw interface
Message-ID: <aYBqDp1mqj7bnfLy@kekkonen.localdomain>
References: <20251216091326.111977-1-Bin.Du@amd.com>
 <20251216091326.111977-4-Bin.Du@amd.com>
 <aUkRQEeAWDeQknP6@kekkonen.localdomain>
 <92ccb38a-5c62-4730-8a41-fa80d2f523a7@amd.com>
 <b95118d9-7186-4ec8-8760-ecf6345ce875@amd.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b95118d9-7186-4ec8-8760-ecf6345ce875@amd.com>

Hi Bin,

On Tue, Jan 20, 2026 at 05:22:41PM +0800, Du, Bin wrote:
> Hi Sakari, there's still one left. Could you please help check it?
> 
> On 1/7/2026 4:44 PM, Du, Bin wrote:
> > Thank you, Sakari for the feedback.
> > 
> > On 12/22/2025 5:37 PM, Sakari Ailus wrote:
> > > Hi Bin,
> > > 
> > > On Tue, Dec 16, 2025 at 05:13:22PM +0800, Bin Du wrote:
> 
> [snip]
> 
> > > > +enum isp4fw_buffer_source {
> > > > +    /* The buffer is from the stream buffer queue */
> > > > +    BUFFER_SOURCE_STREAM,
> > > > +};
> > > 
> > > Could you also use the ISP4 (or ISP4IF) prefix for these, please?
> > > Many look
> > > rather generic.
> > > 
> > 
> > Thank you for highlighting this matter, since these definitions are
> > located in isp4_fw_cmd_resp.h, ISP4_FW may be a more appropriate prefix.
> > Just to confirm: are you suggesting that we should add this prefix to
> > all macros and enums? For example, changing CMD_ID_SET_STREAM_CONFIG to
> > ISP4_FW_CMD_ID_SET_STREAM_CONFIG, and BUFFER_SOURCE_STREAM to ISP4_FW
> > _BUFFER_SOURCE_STREAM? Our initial thought was that these would only be
> > used within ISP and shouldn't lead to any confusion.
> > 
> 
> Hi Sakari, would you please help to confirm so we can decide if further
> modification is needed.

I'd prefer to use a specific prefix, indeed. See e.g.
drivers/media/platform/ti/omap3isp/isp.h . This was the first supported ISP
driver so some prefixes are just "isp_". The shorter names you have, the
larger is the probability of clashing with something generic. It also makes
it obvious to the reader this is specific to the driver.

-- 
Kind regards,

Sakari Ailus
