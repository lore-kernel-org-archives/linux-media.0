Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770E364023
	for <linux-media@vger.kernel.org>; Fri,  6 Feb 2026 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397768; cv=none; b=IcbpWFsMXQHd7PZpc/7wgPo/v6YavG0B0tNFPUxF8dyjruKl0CpghhG0qrPdqVmpgrw3qO69DWmFYio5VCoVDkEpQBTNttpxyPe+qe9R4lSwNV56qIloa8HtbOWajJCogAJbczWJseHfDuUb1AQ4HpMyEixNIcG0BDjdfpXtcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397768; c=relaxed/simple;
	bh=peNY96SQpjN+dcda2YyICUV8t/u6NAhduxoOMLRhjS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLiGtl6jBlMwYMs1mdmdPcNaIya0QWaZl83Q/WNscSXEhk8om9Cb8jOXg5WGNrmNhnMGxesjJLG93B2SA/Tgj2S9mjMYD8p3YiTxQ+aC8d8N37TMIZ+UG8wV8dIPGOmgTkyn64DWIG1B41mLaEhmUUsdwcBuC0dvJe54VmtvFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgEPUCms; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgEPUCms"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770397768; x=1801933768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=peNY96SQpjN+dcda2YyICUV8t/u6NAhduxoOMLRhjS4=;
  b=YgEPUCms00JC9pMAWzQ75JlnFjt80Ix3LWQ5oIWQoSBynzFWv5uK6dnQ
   Mut07SMu6yEAX9kTkXdGk/wpmA5nJPR7vbRSldVjVRzzkV9RBTwubm08d
   /hF2bu489JIRpmeiF+q55YsS/L0N4BOzRksrPGeqihZiMujHnne1Ksaqi
   x8iw+nZ+YRggwCnufHAQe1K7IAINECad/jku5mp07MX4DQ5DpA2Ui4guT
   SzcJq8GusAMn5+W2CaLw5aNop6/LrKfw+0F86exUtBBKMJFxF0Ub3gfK2
   u2i5Qp2S0XanNL2Whqip3Ra6NLQx9SqdNShosUnX2SuA8NENMpAnTe4di
   Q==;
X-CSE-ConnectionGUID: YGx9eoVaSWmarE9O+V9ZlQ==
X-CSE-MsgGUID: 60TRPYfYQmOR5wWAk0FHqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="59178284"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="59178284"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:09:27 -0800
X-CSE-ConnectionGUID: r/68HpIxS9m6b3i7xgIeig==
X-CSE-MsgGUID: bU5YS63gSOWMj3sVA+RYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210243450"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 09:09:25 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9991511F90E;
	Fri, 06 Feb 2026 19:09:36 +0200 (EET)
Date: Fri, 6 Feb 2026 19:09:36 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sean Young <sean@mess.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCHv8 0/3] docs: media: multicommitters model documentation
Message-ID: <aYYgUDtY5L87Bzqg@kekkonen.localdomain>
References: <cover.1770301974.git.hverkuil+cisco@kernel.org>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770301974.git.hverkuil+cisco@kernel.org>

Hi Hans,

On Thu, Feb 05, 2026 at 03:32:51PM +0100, Hans Verkuil wrote:
> Here is v8, based on Mauro's feedback.
> 
> The main changes since v7 are:
> 
> - rename media-committer.rst to media-committers.rst
> - the 'Note' at the start of media-committers.rst is now just a list
>   of additional responsibilies (it made no sense that it was a 'Note').
> - incorporated Mauro's suggestions
> 
> Patch 1/3 updates maintainer-entry-profile.rst: it introduces the
> three Media maintainer levels (Media Driver Maintainer, Media Core Maintainer
> and Media Subsystem Maintainer) and what the responsibilities are.
> 
> Patch 2/3 adds back and updates the list of Media Maintainers that
> disappeared in patch 1/3. Please verify this whether the email
> addresses are the correct ones, and verify that the areas of responsibility
> are correct and that nothing is missing.
> 
> Patch 3/3 adds media-committers.rst: that focusses on the additional
> commit rights that can be granted to a Media Maintainer.
> 
> I have uploaded the documentation with these patches here:
> 
> https://hverkuil.home.xs4all.nl/spec/driver-api/maintainer-entry-profile.html
> https://hverkuil.home.xs4all.nl/spec/driver-api/media-committers.html
> 
> Mauro's feedback for v7 is here:
> 
> https://patchwork.linuxtv.org/project/linux-media/list/?series=21550

Many thanks for your efforts on this!

For the set:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
