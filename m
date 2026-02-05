Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C53ACA7B
	for <linux-media@vger.kernel.org>; Thu,  5 Feb 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291475; cv=none; b=QkyRDcaXvuTEuSYmSWJr5gqleukqPjkVk6KrAyEV4f0Kl+gfd9aupEIMqSR9xhSsfYDA/nH1a8h+ZTgGp3zyE/Tr+ngvXRIUnQMjkz5CTzhTMhVZ1n23cdaRvRdgmS5DXqxrt1lTtPxxPPc9wWtsufDDlVI7U2LoNmMYfd5sV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291475; c=relaxed/simple;
	bh=d0py0J00XsY15aA6BrR2atAtm2m/AkaCLrm13Mt8AJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCpF/UL6fYp0xuhkyolLFFqLhsSAP4AK4QKKwImGzClDImQq5JcH9ZhdOSTPmUGAXujeAmOLAmdm50DR5l57gKROC77fx6u2V81lHpzlXxUXr97yKmI5MQzgf1ynejB6txNcn+kv37HjJk3XEQl7APuEPQg5M9dl0mxCKFrR2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlWDbUsX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlWDbUsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36F5C4CEF7;
	Thu,  5 Feb 2026 11:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291474;
	bh=d0py0J00XsY15aA6BrR2atAtm2m/AkaCLrm13Mt8AJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XlWDbUsXaKsGGT4Aa0V5d7ikFEppouwwXZYjNuMQfP0xrgAVE0zIZhVaRbdaQ2h3U
	 GXvN/biBBA3smdpfiDYNT3BcZ4ZLcOl15CGzBtrtPzS1wQjKbiz8b1tu54lqW6vKCF
	 LJpOQYx3Y1yWSsgmDeL5gxS6CCDJ/ZLoqIhDX1P4NC3R180j0MyFEJBREJm6UEg8fi
	 UHvgIHs3q+ppz1WB0B7hljoq5j1sHW/uiDr2Wdo+RRqh6pP9M9Qo67+b4lflE2VEN6
	 j8oj4SmlqHko8jxxE+atx6yybxd9XmJJZXV4+S3wWjkj/0zC7G5PkH0iHhDLKODqam
	 esdQ/mEicqOXg==
Message-ID: <1f97b1d5-472c-4c34-a809-9ded930be93e@kernel.org>
Date: Thu, 5 Feb 2026 11:37:50 +0000
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 1/3] docs: media: update maintainer-entry-profile for
 multi-committers
To: Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sean Young <sean@mess.org>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Ricardo Ribalda <ribalda@chromium.org>
References: <cover.1769511207.git.hverkuil+cisco@kernel.org>
 <4478ae7ad952117a76b648ee2db7f8f92775ddf7.1769511207.git.hverkuil+cisco@kernel.org>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <4478ae7ad952117a76b648ee2db7f8f92775ddf7.1769511207.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2026 10:53, Hans Verkuil wrote:
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> As the media subsystem will experiment with a multi-committers model,
> update the Maintainer's entry profile to the new rules.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Sean Young <sean@mess.org>
> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>

---
bod
