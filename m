Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AF26ACC;
	Mon, 29 Sep 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147129; cv=none; b=pCAL7YS02weOifXJnZrXg58iRtcynBKLDMcEKiq0ouvy+jYVWc/ftMkCw8vSFNoih55DbzA52P9l+QAoE1szYClSP9zSrAhpzhD4/knV7gRYSrSrKsApq3qrMBk0Hzsxzh4djEZE9D0izOcNRP9PF2Dx4Aq6FlMVY9Ric0aTsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147129; c=relaxed/simple;
	bh=vB6DH5lW/JnzTtRAaGR/BEajnGlIY8sKr52TVjPAVqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGoK0SJAicGGeAMJhufqIH7O+o2u95Evmo/xhKfwCnBowRacBLGXkKccOaRLN/DKbhH+jGH3w+Dtuepe88OGDdpRefmdbVGmPBzizIcQXhah0uTx+vDdLjuB1+v2j9Qu1MDmpPJcoDZN/MhBcVsdHJLAEkYNMLaEVG5egKutkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KqijPWQj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KqijPWQj"
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 419A8236;
	Mon, 29 Sep 2025 13:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759147031;
	bh=vB6DH5lW/JnzTtRAaGR/BEajnGlIY8sKr52TVjPAVqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqijPWQjQ6SPVMsfCB58ZxTv/HjZq/3GiDKGWsyYCBvvtRd5W1kDHKnZggm8F0Vtn
	 MgPDUXHhbXliaiQfhoHYebooWP5cyIGb5Z2FpuQPvFDbxYlQY4qREaDXRTDgiE9XwM
	 nHKMYzv6ne8UIcWXdQwvNklmmEc3prAQNF25tUOM=
Date: Mon, 29 Sep 2025 14:58:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Gladysz WojciechX <wojciechx.gladysz@realsenseai.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kontra.wojciech.gladysz@gmail.com" <kontra.wojciech.gladysz@gmail.com>
Subject: Re: Realsense camera patch
Message-ID: <20250929115835.GD4646@pendragon.ideasonboard.com>
References: <CO1PR18MB463349680603EC2C284B7FEFF71BA@CO1PR18MB4633.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO1PR18MB463349680603EC2C284B7FEFF71BA@CO1PR18MB4633.namprd18.prod.outlook.com>

Hello Wojciech,

Please see https://docs.kernel.org/process/submitting-patches.html for
the description of the procedure to submit patches to the Linux kernel.
The document is also available in the kernel source tree in
Documentation/process/submitting-patches.rst.

-- 
Regards,

Laurent Pinchart
